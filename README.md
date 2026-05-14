# Inclusão Educacional como Determinante Intersetorial da Saúde de Jovens Brasileiros

Repositório de pesquisa sobre a associação entre o Índice de Inclusão
Educacional Municipal (IIEM 2017) e desfechos de mortalidade externa e
internações por condições sensíveis à atenção primária (ICSAP) em jovens de
20–29 anos no Brasil, 2018–2024.

- **Pesquisador:** Sidney da Silva Pereira Bissoli (pesquisador independente)
- **Edital:** Instituto Natura / Todos Pela Educação / B3 — Modalidade B
- **Janela de execução:** Jul/2026 – Dez/2026
- **Status:** Fase 0 — pré-execução e arquitetura

## Documentos

- [Proposta científica](manuscripts/proposta-de-pesquisa-v01.md) — fonte
  primária da pergunta de pesquisa, hipóteses e desenho.
- [Roadmap de execução](roadmap-v01.md) — plano operacional dos 5 meses.
- [GOVERNANCE](GOVERNANCE.md) — princípios, hierarquia de fontes, governança.
- [CONVENTIONS](CONVENTIONS.md) — formatos, templates, nomenclatura (ADR,
  REV, bibliografia, Conventional Commits).
- [RISKS](RISKS.md) — riscos ativos e mitigações.
- [CHANGELOG](CHANGELOG.md) — histórico de mudanças.
- [CLAUDE](CLAUDE.md) — convenções para sessões Claude Code.

## Estrutura

- `R/` — funções utilitárias (uma responsabilidade por função).
- `_targets.R` — pipeline reprodutível (`targets`).
- `tests/` — testes (`testthat`) e contratos de dados (`pointblank`).
- `decisions/` — ADRs (decisões metodológicas) e REVs (revisões mensais).
- `bibliography/` — `references.bib` (export do Zotero/BetterBibTeX) e notas
  de leitura.
- `manuscripts/` — proposta, artigo, preprints.
- `technical-note/` — nota técnica para gestores.
- `slides/` — apresentação executiva.
- `quarto/` — relatórios de progresso e dashboard interativo.
- `outputs/` — tabelas, figuras e validações finais.
- `assets/` — derivados versionados (matriz de síntese, etc.).

## Reprodutibilidade

Pipeline em `targets`, dependências travadas em `renv.lock`, ambiente
containerizado em `Dockerfile` (rocker/geospatial:4.5.3 + INLA).

```r
renv::restore()
targets::tar_make()
```

## Documentação das funções utilitárias

Build local com `pkgdown` (saída em `docs/`, ignorada pelo git):

```r
roxygen2::roxygenise(".")
pkgload::load_all(".")
pkgdown::build_site(new_process = FALSE, install = FALSE, lazy = TRUE, devel = TRUE)
```

Abrir `docs/index.html` no navegador. Deploy a GitHub Pages é decisão futura.

## Dados

Pastas `data-raw/` e `data/` **não são versionadas**:

- **DATASUS** (SIM, SIH, CNES, SINASC) — público; acesso via `microdatasus`.
- **IIEM 2017** — fornecido pela Lupa Social sob termo de não-redistribuição
  (metodologia Paciencia & Ismail, 2024).
- **IIE estadual 2015–2021** — público, repositório GitHub da Lupa Social.

## Citação

Ver [`CITATION.cff`](CITATION.cff). DOI será publicado via Zenodo no
release `v1.0.0` (Mês 5).

## Licença

[MIT](LICENSE).
