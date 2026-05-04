# Notas de pesquisa

Este diretório registra **notas de pesquisa temáticas**, complementares —
e estruturalmente distintas — das **notas de leitura** em
`bibliography/notes/`.

## Distinção operacional

| Tipo | Local | Escopo | Identificador | Indexada por? |
|---|---|---|---|---|
| **Nota de leitura** | `bibliography/notes/<chave>.md` | Uma obra | citation key BetterBibTeX (do `references.bib`) | `R/build_bibliography_index.R` (auto, em `bibliography/README.md`) |
| **Nota de pesquisa** | `bibliography/research-notes/<topico>.md` | Uma pergunta que cruza ≥2 fontes | slug temático em kebab-case | Tabela manual abaixo |

A nota de leitura responde "o que esta obra diz e como ela conecta ao
projeto?". A nota de pesquisa responde "como esta pergunta específica do
projeto se resolve dado o conjunto de fontes disponíveis?".

Notas de pesquisa **não têm citation key própria** — citam obras do corpus
em formato APA inline, com chave BetterBibTeX entre colchetes na primeira
menção quando já disponível.

## Quando criar uma nota de pesquisa

Crie quando a pergunta atender pelo menos um critério:

- Cruza ≥2 fontes do corpus e a síntese não cabe em uma nota de leitura
  única;
- Combina fontes do corpus com evidência empírica primária do pesquisador
  (inspeção de microdados, scripts oficiais, repositórios de código, etc.);
- Tem implicação direta em ≥1 seção do manuscrito ou em um ADR;
- Resolve uma pendência da skill `literature-review-academic-ptbr`
  (verificação de plausibilidade, desambiguação de mecanismo, fechamento
  de cenário).

Use nota de leitura quando a obra é única e o foco é entendê-la
isoladamente.

## Estrutura mínima de uma nota de pesquisa

Frontmatter YAML com:

- `type: research-note`
- `topic`: descrição em uma linha
- `status`: `open` / `in-progress` / `closed`
- `date_opened`, `date_closed` (ISO 8601)
- `related_obs`: observação herdada (sessão anterior) que motivou a nota
- `related_adr`: ADR(s) que dependem da conclusão
- `related_section_v02`: seção(ões) do manuscrito afetada(s)
- `sources`: lista das fontes com identificador estável (DOI, URL,
  arquivo local)

Corpo:

- **Pergunta** (uma frase declarativa).
- **Resposta verificada** (síntese curta, com referências numeradas).
- **Verbatim-chave** (citações literais com página/localização e atribuição).
- **Implicações** (manuscrito, ADR, sensibilidade, limitação).
- **Pendências** (o que ficou aberto).

## Índice (manual)

| Arquivo | Tópico | Pergunta fechada | Status | Data |
|---|---|---|:-:|---|
| [`saeb-2019-idade.md`](saeb-2019-idade.md) | Supressão de idade no SAEB 2019 e imputação na coorte 2019 do IIE estadual | Como Lupa Social/Metas Sociais construiu a coorte 2019 sem idade nos microdados? | closed | 2026-05-03 |
| [`v02-obs5-framing-heterogeneidade-temporal.md`](v02-obs5-framing-heterogeneidade-temporal.md) | Framing editorial da v02 — onde tratar heterogeneidade temporal entre coortes (Obs. 5.A) | Caminho A (§4.2 com calibração) ou Caminho B (§4.3 só) para discutir heterogeneidade entre coortes do IIE estadual? | closed | 2026-05-03 |

Atualize manualmente ao adicionar nova nota.
