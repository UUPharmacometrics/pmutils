#' Agreement in individual OFV contribution (iOFV) plot between between two models.
#'
#' @param phi1 A string of the first model phi file name.
#' @param phi2 A string of the second model phi file name.
#' @param quiet A logical indicating whether function should not write the warning message if some file not found. By default quiet=FALSE.
#'
#' @return A list of two elements:
#' make_plot - logical argument indicating whether needed files exist.
#' plot - a ggplot plot object, scatter plot.
#' @export
iofv_vs_iofv <- function(phi1, phi2,quiet=F) {
  if(file.exists(phi1) && file.exists(phi2)) {
    make_plot <- TRUE
    phi1_tab <- read.table(phi1, skip=1, header=T)
    phi2_tab <- read.table(phi2, skip=1, header=T)
    # Remove individuals in original phi file that had no observations (i.e. all columns 0)
    phi2_tab <- dplyr::filter_at(phi2_tab, dplyr::vars(dplyr::contains("ET"), "OBJ"), dplyr::any_vars(. != 0.0))

    phi1name <- basename(phi1)
    phi2name <- basename(phi2)

    if(length(phi1_tab$OBJ) == length(phi2_tab$OBJ)) {
      p <- ggplot(data=NULL, aes(x=phi1_tab$OBJ, y=phi2_tab$OBJ)) +
        geom_point(shape=1) +
        geom_abline(intercept = 0, slope = 1) +
        xlab(phi1name) +
        ylab(phi2name) +
        theme_bw()
      out<-list(plot=p,
                make_plot=make_plot)
    } else {
      if(!quiet) {
        message("WARNING: Length of ID numbers in files ",phi1," and ",phi2," are not equal!")
      }
      make_plot <- FALSE
      out <- list(make_plot=make_plot)
    }
  } else {
    if(!file.exists(phi1) && !quiet) {
      message("WARNING: File ",phi1," not found!")
    }
    if(!file.exists(phi2) && !quiet) {
      message("WARNING: File ",phi2," not found!")
    }
    make_plot <- FALSE
    out <- list(make_plot=make_plot)
  }
    return(out)
}