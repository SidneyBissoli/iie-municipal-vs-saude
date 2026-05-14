# Data contracts for derived artefacts (`*.parquet` files in `data/`).
# Each contract is a function that takes a data frame and returns a
# `pointblank::create_agent()` object configured with `col_*` and `rows_*`
# steps but *not yet* interrogated. The wrapper in
# `R/write_with_contract.R` is responsible for `interrogate()` and for
# halting the pipeline on `fail`.
#
# The contracts here are PLACEHOLDERS for Phase 1. Each one is documented
# with the schema the actual implementation must enforce. Implementation
# is deferred to the session that builds each artefact (see roadmap §1.x).

#' Contract: IIEM 2017 (municipal exposure).
#'
#' Schema expected (see roadmap §1.1):
#' - `cod_mun_7`        chr,  7-digit IBGE code, unique non-null.
#' - `iiem`             dbl,  continuous IIE index in `[0, 1]`.
#' - `iiem_acesso`      dbl,  sub-dimension in `[0, 1]`.
#' - `iiem_idade_serie` dbl,  sub-dimension in `[0, 1]`.
#' - `iiem_proficiencia` dbl, sub-dimension in `[0, 1]`.
#' - `n_coorte`         int,  cohort size > 0.
#' Coverage: ~5570 rows (one per Brazilian municipality, 2017).
#'
#' @param df Data frame to validate.
#' @return A `pointblank` agent ready for `interrogate()`.
iiem_2017_contract <- function(df) {
  stop("Not implemented yet; see roadmap-v01.md §1.1.")
}

#' Contract: external mortality counts by municipality x year x cause group.
#'
#' Schema expected (see roadmap §1.2):
#' - `cod_mun_7` chr,  7-digit IBGE code.
#' - `ano`       int,  in `[2018, 2024]`.
#' - `causa`     chr,  in {homicidio, suicidio, transporte, outras_externas}.
#' - `obitos`    int,  >= 0.
#' Invariants: no duplicate (cod_mun_7, ano, causa); years complete; counts
#' nonnegative; municipality codes match the official IBGE list.
#'
#' @param df Data frame to validate.
#' @return A `pointblank` agent ready for `interrogate()`.
obitos_mun_ano_causa_contract <- function(df) {
  stop("Not implemented yet; see roadmap-v01.md §1.2.")
}

#' Contract: ICSAP hospitalisations by municipality x year x clinical group.
#'
#' Schema expected (see roadmap §1.3):
#' - `cod_mun_7` chr.
#' - `ano`       int, in `[2018, 2024]`.
#' - `grupo`     chr, in {infecciosas, cronicas, agudas} (see ADR-004).
#' - `internacoes` int, >= 0.
#' Invariants: no duplicate (cod_mun_7, ano, grupo); excludes readmissions;
#' Lista Brasileira ICSAP applied on `DIAG_PRINC` upstream.
#'
#' @param df Data frame to validate.
#' @return A `pointblank` agent ready for `interrogate()`.
icsap_mun_ano_grupo_contract <- function(df) {
  stop("Not implemented yet; see roadmap-v01.md §1.3.")
}

#' Contract: population denominators by municipality x year x age x sex.
#'
#' Schema expected (see roadmap §1.4):
#' - `cod_mun_7` chr.
#' - `ano`       int, in `[2018, 2024]`.
#' - `idade`     int, single year of age in `[20, 29]`.
#' - `sexo`      chr, in {M, F}.
#' - `pop`       dbl, > 0.
#' Invariants: anchored on Censos 2010 and 2022; linear interpolation for
#' intermediate years; consistent with IBGE/DATASUS published estimates
#' within a small tolerance.
#'
#' @param df Data frame to validate.
#' @return A `pointblank` agent ready for `interrogate()`.
pop_mun_ano_idade_sexo_contract <- function(df) {
  stop("Not implemented yet; see roadmap-v01.md §1.4.")
}

#' Contract: municipal covariates panel (single row per municipality).
#'
#' Schema expected (see roadmap §1.5):
#' - `cod_mun_7`        chr, unique.
#' - `cob_esf_media`    dbl, ESF coverage (% population) averaged 2018-2024.
#' - `inse_2017`        dbl, INSE municipal aggregated by enrolment weight.
#' - `idhm_2010`        dbl, in (0, 1).
#' - `idhm_2022`        dbl, in (0, 1) when available; NA tolerated.
#' - `tx_urb_2022`      dbl, in `[0, 1]`.
#' - `pct_bf_cadunico`  dbl, in `[0, 1]`.
#' - `gini_municipal`   dbl, latest available; NA tolerated.
#' - `tx_pre_extmort`   dbl, mortality rate per 100k 20-29 yrs, 2010-2014.
#' - `tx_pre_icsap`     dbl, ICSAP rate per 1k 20-29 yrs, 2010-2014.
#' Invariants: at least 99% coverage of the 5570 municipalities for
#' critical variables (ESF, INSE, IDHM, urbanisation, pre-cohort rates).
#'
#' @param df Data frame to validate.
#' @return A `pointblank` agent ready for `interrogate()`.
covariaveis_mun_contract <- function(df) {
  stop("Not implemented yet; see roadmap-v01.md §1.5.")
}

#' Contract: state panel for Design B (TWFE).
#'
#' Schema expected (see roadmap §1.6):
#' - `uf`     chr, 2-letter abbreviation; 27 unique values.
#' - `coorte` int, in {2015, 2017, 2019, 2021}.
#' - `iie_uf` dbl, in `[0, 1]`.
#' - `ano_outcome` int, c+5 (or per ADR-005 lag policy).
#' - `obitos`     int, >= 0.
#' - `internacoes` int, >= 0.
#' - `pop_uf_20_29` int, > 0.
#' Invariants: 27 UF x 4 cohorts = 108 rows (or per ADR-005 if lag policy
#' restricts cohorts).
#'
#' @param df Data frame to validate.
#' @return A `pointblank` agent ready for `interrogate()`.
painel_uf_contract <- function(df) {
  stop("Not implemented yet; see roadmap-v01.md §1.6.")
}
