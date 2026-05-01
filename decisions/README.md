# Decisões metodológicas — ADRs e revisões

Este diretório consolida dois tipos de registro de pensamento do projeto:

- **ADRs (Architecture Decision Records)** — decisões pontuais sobre como
  resolver uma escolha metodológica ou de implementação (`ADR-NNN-*.md`,
  numeração sequencial). Convenção Nygard, cinco campos. Imutáveis após
  `accepted`. Template em `_template.md`.
- **REVs (revisões metodológicas mensais)** — gates de direção ao final de
  cada mês de execução (`REV-MNN.md`, NN = mês). Cinco campos: estado
  factual, surpresas, pressupostos, decisão, ações. Template em
  `_template-revisao.md`.

Os índices abaixo são **gerados automaticamente** por
`R/build_adr_index.R`. Não editar à mão; rodar
`source("R/build_adr_index.R"); build_adr_index()` após adicionar novo ADR
ou REV.

<!-- BEGIN: ADR_INDEX -->
## ADRs

| ID | Título | Status | Item do roadmap | Data |
|---|---|---|---|---|
| _(nenhum ADR registrado ainda)_ | | | | |

<!-- END: ADR_INDEX -->

<!-- BEGIN: REV_INDEX -->
## Revisões metodológicas (REVs)

| ID | Título | Status | Fase | Data |
|---|---|---|---|---|
| _(nenhuma REV registrada ainda)_ | | | | |

<!-- END: REV_INDEX -->

---

## Convenção rápida

- **Nomenclatura ADR:** `ADR-NNN-slug-descritivo.md`. Numeração sequencial,
  global no projeto. Sem datas no nome.
- **Nomenclatura REV:** `REV-MNN.md` (NN com dois dígitos: `REV-M01`,
  `REV-M02`, …, `REV-M05`).
- **Imutabilidade:** ADR `accepted` não se edita. Mudança de decisão cria
  ADR novo que `Supersedes ADR-XXX`; o anterior recebe status
  `superseded by ADR-NNN`. REV `completed` também não se edita.
- **Granularidade ADR:** uma decisão por ADR. Se um documento tem 4
  decisões, divide-se em 4.

Detalhes em `CLAUDE.md` §5 e `roadmap-v01.md` §0.5 / §T.7.
