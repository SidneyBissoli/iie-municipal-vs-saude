# _targets.R
# Pipeline definition for the IIEM x youth-mortality / ICSAP project.
# See roadmap-v01.md for the full plan; targets below are placeholders for
# Phases 1-3. Each phase is grouped with `tar_target()` calls that will be
# implemented incrementally; the skeleton here exists so that `tar_visnetwork()`
# and CI smoke tests can run from session 001 onward.

library(targets)
library(tarchetypes)

tar_option_set(
  packages = c(
    "dplyr", "tidyr", "purrr", "readr", "stringr", "tibble", "lubridate",
    "fs", "arrow", "pointblank"
  ),
  format = "qs",   # qs is unavailable on R 4.5; qs2 is the successor.
  storage = "worker",
  retrieval = "worker",
  workspace_on_error = TRUE
)

# Source utility functions from R/. Files are sourced at pipeline build time.
source_dir <- function(path) {
  files <- list.files(path, pattern = "\\.R$", full.names = TRUE)
  invisible(lapply(files, source))
}
source_dir("R")

list(

  # ---- Phase 1: analytical-base construction --------------------------------

  # 1.1 Exposure: IIEM 2017 (input from Lupa Social).
  # tar_target(iiem_raw_path, "data-raw/iiem/iiem-2017.csv", format = "file"),
  # tar_target(iiem_2017,     build_iiem_2017(iiem_raw_path)),

  # 1.2 Outcome: SIM (external mortality, 20-29 yrs, 2018-2024).
  # tar_target(sim_uf_list,   build_uf_list()),
  # tar_target(sim_raw,
  #   fetch_sim(uf = sim_uf_list, year_start = 2018, year_end = 2024),
  #   pattern = map(sim_uf_list)),
  # tar_target(obitos_mun_ano_causa, aggregate_sim(sim_raw)),

  # 1.3 Outcome: SIH (ICSAP, 20-29 yrs, 2018-2024).
  # tar_target(sih_raw,
  #   fetch_sih(uf = sim_uf_list, year_start = 2018, year_end = 2024),
  #   pattern = map(sim_uf_list)),
  # tar_target(icsap_mun_ano_grupo, aggregate_sih_icsap(sih_raw)),

  # 1.4 Population denominators.
  # tar_target(pop_mun_ano_idade_sexo, build_population_panel()),

  # 1.5 Municipal covariates (ESF, INSE, IDHM, urbanisation, Bolsa, Gini, etc.).
  # tar_target(covariaveis_mun, build_municipal_covariates()),

  # 1.6 State panel (Design B: TWFE with 4 IIE cohorts).
  # tar_target(painel_uf, build_uf_panel()),

  # 1.7 Spatial scaffolding.
  # tar_target(municipios_sf, geobr::read_municipality(year = 2020)),
  # tar_target(uf_sf,         geobr::read_state()),
  # tar_target(neighbours,    spdep::poly2nb(municipios_sf)),

  # ---- Phase 2: Design A (cross-section) ------------------------------------

  # tar_target(model_a_poisson_extmort, fit_design_a(...)),
  # tar_target(model_a_negbin_icsap,    fit_design_a(...)),
  # tar_target(model_a_bym_full,        fit_bym(...)),

  # ---- Phase 3: Design B (TWFE) and Design C (heterogeneity) ----------------

  # tar_target(model_b_twfe,  fit_design_b(painel_uf)),
  # tar_target(model_c_heter, fit_design_c(...)),

  # ---- Quarto reports -------------------------------------------------------

  # tar_quarto(report_m1, "quarto/report-mes-1.qmd"),
  # tar_quarto(report_m2, "quarto/report-mes-2.qmd"),
  # tar_quarto(report_m3, "quarto/report-mes-3.qmd"),
  # tar_quarto(dashboard, "quarto/dashboard.qmd"),

  # Placeholder so that the pipeline is non-empty during session 001.
  tar_target(roadmap_version, "v01")
)
