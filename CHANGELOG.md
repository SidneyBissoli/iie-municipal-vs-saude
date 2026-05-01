# Changelog

Todas as mudanças relevantes do projeto são registradas aqui.

O formato segue [Keep a Changelog](https://keepachangelog.com/pt-BR/1.1.0/) e
versões correspondem a versões do roadmap (`roadmap-vNN.md`). Mudanças
**patch** e **minor** acumulam em `[Unreleased]` até a próxima major; mudanças
**major** abrem nova seção e congelam o roadmap anterior. Detalhes da convenção
em `roadmap-v01.md` §T.8 e `CLAUDE.md` §8.

Categorias padrão: `Added`, `Changed`, `Deprecated`, `Removed`, `Fixed`,
`Security`.

---

## [Unreleased]

<!--
### Added
### Changed
### Deprecated
### Removed
### Fixed
-->

---

## [roadmap-v01] — 2026-05-01

### Added

- Versão inicial do roadmap de execução, gerada a partir de
  `manuscripts/proposta-de-pesquisa.md`. Define cinco fases (Mês 0–5),
  três eixos transversais (T.1 Qualidade · T.2 Reprodutibilidade · T.3
  Comunicação · T.4 Riscos · T.5 Boas práticas · T.6 Fail-fast · T.7
  Revisões metodológicas mensais · T.8 Controle de mudanças) e oito ADRs
  pré-mapeados.
- Infraestrutura de Fase 0 (sessão Code 001):
  - Estrutura canônica de diretórios em inglês.
  - `CLAUDE.md` com convenções, comandos e regras de manifest e mudança.
  - Esqueleto `_targets.R`, `.lintr`, Dockerfile rocker/geospatial+INLA,
    workflows GitHub Actions (`R-CMD-check`, `targets-check`).
  - Templates ADR e REV (`decisions/_template.md`,
    `decisions/_template-revisao.md`) e índice unificado em
    `R/build_adr_index.R`.
  - Esqueleto de bibliografia (`bibliography/_note-template.md`,
    `reading-list.md`, `references.bib` placeholder, índice em
    `R/build_bibliography_index.R`) — população via Zotero/BetterBibTeX
    em sessão posterior.
  - Infraestrutura fail-fast (T.6): `R/contracts.R` (placeholders Fase 1),
    `R/write_with_contract.R`, `R/build_session_manifest.R`,
    `R/verify_session_manifest.R` + testes em `tests/testthat/`.

---

<!--
Modelo de seção para próximas versões:

## [roadmap-vNN] — AAAA-MM-DD

### Added
### Changed
### Deprecated
### Removed
### Fixed
-->
