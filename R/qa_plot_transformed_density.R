#' Density of the Box-Cox/t-distribution transformed random effect in comparison with the density of the original (untransformed) random effect.
#' The rug below the densities indicates the empirical Bayes estimates for the transformed random effect.
#'
#' @param data_table the eta density dataframe with ETA_name, density, type and eta columns
#' @param eta_table a data frame with ETA_name and values columns where eta values are calculated based on the formula:
#' If have boxcox model: (exp(eta)^lambda -1)/lambda
#' If have tdist model: eta(1+((eta^2 + 1)/(4deg_of_freedom))+((5eta^4 + 16eta^2 + 3)/(96deg_of_freedom^2))+((3eta^6 + 19eta^4 + 17eta^2 - 15)/(384deg_of_freedom^3)))
#' @param param_model a character. Possible values: boxcox or tdist. Needed only for lables in the plots.
#'
#' @return A list of plots
#' @export
plot_transformed_density <- function(data_table,eta_table,param_model) {
  if(param_model=="boxcox") {
    labels=c("Untransformed density","Boxcox transformed density")
  }
  if(param_model=="tdist") {
    labels=c("Untransformed density","t-distribution transformed density")
  }
    data_table_new <- get_x_min_max(data_table,eta_table)

    #make shore that will not get only one plot in last page.
    n_pages <- ceiling(length(unique(data_table_new$ETA_name))/12)
    if(length(unique(data_table_new$ETA_name)) > 12) {
      plots_in_page <- length(unique(data_table_new$ETA_name))/n_pages
      if(plots_in_page < 9) {
        nrow <- 3
      } else {
        nrow <- 4
      }
    } else {
      nrow <- 4
    }
    #make a plot
    p <- list()
    for(i in seq_len(n_pages)) {
      p[[i]] <- ggplot(data_table_new,aes(x=eta,y=density,fill=type)) +
        geom_area(alpha=0.3) +
        theme_bw() +
        labs(x="",y="") +
        scale_fill_manual("",values=c("ETA"="black","ETAT"="blue"),labels=labels) +
        theme(legend.position = "top")

      if(length(unique(data_table_new$ETA_name)) > 4) {
        p[[i]] <- p[[i]] + ggforce::facet_wrap_paginate(~ETA_name,nrow=nrow,ncol=3,scales="free",page=i)
      } else {
        p[[i]] <- p[[i]] + ggforce::facet_wrap_paginate(~ETA_name,ncol=2,scales="free")
      }

      if(!missing(eta_table)) {
        if(nrow(eta_table)>0) {
          p[[i]] <- p[[i]] + geom_rug(data=eta_table,aes(x=value),sides="b",inherit.aes = F)
        }
      }
    }

  return(p)
}

get_x_min_max <- function(data_table,eta_table,y_pec=0.01) {
  for(i in unique(data_table$ETA_name)) {
    data_table_per_eta <- data_table %>% dplyr::filter(ETA_name %in% i)
    # 1 procent of the density values
    y_min_limit <- min(data_table_per_eta$density,na.rm=TRUE) + y_pec*abs(max(data_table_per_eta$density,na.rm=TRUE)-min(data_table_per_eta$density,na.rm=TRUE))
    spec <- data_table_per_eta %>% dplyr::filter(density>y_min_limit)
    x_max <- max(spec$eta,na.rm=TRUE)
    x_min <- min(spec$eta,na.rm=TRUE)

    # check if y_min_limit should be smaller because of the real eta values
    real_eta_values <- eta_table %>% dplyr::filter(!is.na(value)) %>% dplyr::select(value) %>% dplyr::pull(value)
    if(any(real_eta_values > x_max)) {
      x_max <- max(eta_table$value,na.rm=TRUE)
    }
    if(any(real_eta_values < x_min)) {
      x_min <- min(eta_table$value,na.rm=TRUE)
    }
    data_table_per_eta <- data_table_per_eta %>% dplyr::filter(eta>=x_min,eta<=x_max)

    if(i==unique(data_table$ETA_name)[1]) {
      data_table_new <- data_table_per_eta
    } else {
      data_table_new <- rbind(data_table_new,data_table_per_eta)
    }
  }
  return(data_table_new)
}