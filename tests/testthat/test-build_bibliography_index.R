test_that("collect_md_resumo_prefixes extracts <author><year> from filenames", {
  tmp_dir <- tempfile()
  dir.create(tmp_dir)
  on.exit(unlink(tmp_dir, recursive = TRUE), add = TRUE)

  files <- c(
    "alfradiqueETAL_2009_icsap-lista-brasileira.md",
    "azevedoETAL_2021_simulating-impacts-covid19.md",
    "wooldridge_2025_twfe-mundlak.md",
    "README.md",
    "_resumo-template.md",
    "not-matching-filename.md"
  )
  for (f in files) writeLines("body", file.path(tmp_dir, f))

  out <- collect_md_resumo_prefixes(tmp_dir)
  expect_setequal(
    out,
    c("alfradiqueetal2009", "azevedoetal2021", "wooldridge2025")
  )
})

test_that("collect_md_resumo_prefixes returns empty for missing dir", {
  expect_identical(
    collect_md_resumo_prefixes(tempfile("nope_")),
    character()
  )
})

test_that("key_has_md_resumo matches citation key by prefix", {
  prefixes <- c("alfradiqueetal2009", "blangiardoetal2013")

  expect_true(key_has_md_resumo(
    "alfradiqueetal2009internacoesporcondicoesa",
    prefixes
  ))
  expect_true(key_has_md_resumo(
    "blangiardoetal2013spatialspatiotemporalmodelsa",
    prefixes
  ))
  expect_false(key_has_md_resumo(
    "honeetal2017largereductionsamenable",
    prefixes
  ))
  expect_false(key_has_md_resumo("anything", character()))
})

test_that("build_bibliography_index emits 'Tem resumo?' column and marks hits", {
  tmp_dir <- tempfile()
  dir.create(tmp_dir)
  on.exit(unlink(tmp_dir, recursive = TRUE), add = TRUE)

  bib <- file.path(tmp_dir, "refs.bib")
  writeLines(
    c(
      "@article{alfradiqueetal2009foo,",
      "  title = {ICSAP},",
      "  author = {A and B},",
      "  year = {2009}",
      "}",
      "@article{honeetal2017bar,",
      "  title = {Amenable},",
      "  author = {C},",
      "  year = {2017}",
      "}"
    ),
    bib
  )

  readme <- file.path(tmp_dir, "README.md")
  writeLines(
    c("# x", "<!-- BEGIN: BIB_INDEX -->", "stale", "<!-- END: BIB_INDEX -->"),
    readme
  )

  notes_dir <- file.path(tmp_dir, "notes")
  resumos_dir <- file.path(tmp_dir, "md-resumos")
  dir.create(notes_dir)
  dir.create(resumos_dir)
  writeLines("note", file.path(notes_dir, "honeetal2017bar.md"))
  writeLines("resumo", file.path(resumos_dir, "alfradiqueETAL_2009_x.md"))

  build_bibliography_index(
    bib_dir = tmp_dir,
    bib_path = bib,
    list_path = file.path(tmp_dir, "missing-list.md"),
    notes_dir = notes_dir,
    md_resumos_dir = resumos_dir,
    readme = readme
  )

  out <- readLines(readme)
  expect_true(any(grepl("Tem resumo\\?", out)))

  row_alfradique <- grep("alfradiqueetal2009foo", out, value = TRUE)
  expect_length(row_alfradique, 1L)
  cells <- trimws(strsplit(row_alfradique, "\\|")[[1]])
  cells <- cells[nzchar(cells)]
  expect_equal(cells[[length(cells) - 1L]], "—")
  expect_equal(cells[[length(cells)]], "✓")

  row_hone <- grep("honeetal2017bar", out, value = TRUE)
  cells_h <- trimws(strsplit(row_hone, "\\|")[[1]])
  cells_h <- cells_h[nzchar(cells_h)]
  expect_equal(cells_h[[length(cells_h) - 1L]], "✓")
  expect_equal(cells_h[[length(cells_h)]], "—")
})
