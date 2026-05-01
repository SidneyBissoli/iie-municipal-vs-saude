# Source `R/` utilities once per test run.
invisible(lapply(
  list.files(
    file.path(rprojroot::find_root(rprojroot::has_file("projeto-r.Rproj")), "R"),
    pattern = "\\.R$",
    full.names = TRUE
  ),
  source
))
