# Changelog

Todas as mudanças relevantes do projeto são registradas aqui.

O formato segue [Keep a Changelog](https://keepachangelog.com/pt-BR/1.1.0/) e
versões correspondem a versões do roadmap (`roadmap-vNN.md`). Mudanças
**patch** e **minor** acumulam em `[Unreleased]` até a próxima major; mudanças
**major** abrem nova seção e congelam o roadmap anterior. Detalhes da convenção
em `GOVERNANCE.md` (princípios) e `CONVENTIONS.md` (formato Conventional
Commits, identificadores estáveis).

Categorias padrão: `Added`, `Changed`, `Deprecated`, `Removed`, `Fixed`,
`Security`.

---

## [Unreleased]

### Added

- `GOVERNANCE.md` na raiz — princípios de governança do projeto:
  hierarquia de fontes (proposta → ADRs/REVs → roadmap → CLAUDE), tripartição
  meta/gestão/científicos, separação Zotero/repo, princípios T.6/T.7/T.8 e
  princípios de integridade científica.
- `CONVENTIONS.md` na raiz — convenções técnicas: notação do roadmap,
  formato ADR (Nygard) e REV, nomenclatura de citation keys, formato
  Conventional Commits, regras de identificadores estáveis, formato
  CHANGELOG, formato markdown do source.
- `RISKS.md` na raiz — riscos ativos e mitigações (extraídos de T.4 do
  roadmap), documento vivo sem versionamento formal.

### Changed

- `roadmap-v01.md` enxugado para checklist operacional puro: princípios e
  convenções detalhadas extraídas para `GOVERNANCE.md` e `CONVENTIONS.md`;
  T.4 Riscos extraída para `RISKS.md`; bullets de T.6/T.7/T.8 mantidos
  apenas com conteúdo operacional, princípios remetidos a `GOVERNANCE.md`;
  seção final "Onde Desktop ganha decisivamente" removida (análise
  interpretativa, não instrução); nota final reformulada.
- `CLAUDE.md` ajustado para refletir nova estrutura: declaração de
  hierarquia de fontes adicionada, referências aos novos documentos
  auxiliares no header, §§ 5/6/8 enxutas para apontar para `CONVENTIONS.md`
  e `GOVERNANCE.md` em vez de duplicar convenções.

<!--
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
