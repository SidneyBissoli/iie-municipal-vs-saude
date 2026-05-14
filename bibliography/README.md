# Bibliografia e notas

Sistema versionado de captura de conhecimento externo do projeto. Operação
detalhada em `CLAUDE.md` §6 e `roadmap-v01.md` §0.5.

## Conteúdo

- **`references.bib`** — exportação BetterBibTeX do Zotero. Única fonte de
  citation keys do projeto. Convenção em `CONVENTIONS.md` (BetterBibTeX:
  `authEtAl.lower + year + shorttitle.lower`). **Não editar à mão.**
- **`reading-list.md`** — fila com `to-read | reading | read`, papel no
  projeto e prioridade. Indexada pelas keys de `references.bib`.
- **`notes/<citation-key>.md`** — **notas de leitura**: uma por artigo,
  identificada pela citation key BetterBibTeX exata. Seguem
  `_note-template.md`. PDFs ficam no Zotero. Indexadas automaticamente na
  tabela BIB_INDEX abaixo (coluna *Tem nota?*).
- **`md-resumos/<Autor[ETAL]>_<AAAA>_<slug>.md`** — **resumos
  narrativos** em português, formato livre, síntese conceitual de uma
  obra. Categoria distinta e complementar das notas de leitura: o
  resumo é discursivo (não-tabular) e nomeado por slug temático em vez
  de citation key. Indexados automaticamente na tabela BIB_INDEX abaixo
  (coluna *Tem resumo?*), via match `<autor><ano>` prefixo da citation
  key. Detalhes em `CONVENTIONS.md`.
- **`research-notes/<topico>.md`** — **notas de pesquisa**: síntese
  investigativa de uma pergunta que cruza ≥2 fontes (corpus + evidência
  empírica + scripts oficiais, etc.). Identificadas por slug temático,
  não por citation key. Detalhes e índice em
  [`research-notes/README.md`](research-notes/README.md).
- **`_note-template.md`** — template fixo das notas de leitura (citação,
  papel, resumo, citações quotáveis com página, crítica, conexões).

O índice abaixo é **gerado automaticamente** por
`R/build_bibliography_index.R`. Não editar à mão; rodar
`source("R/build_bibliography_index.R"); build_bibliography_index()` após
re-exportar o `.bib` ou adicionar nota nova.

<!-- BEGIN: BIB_INDEX -->

| Chave | Título curto | Status | Papel | Tem nota? | Tem resumo? |
|---|---|:-:|---|:-:|:-:|
| `alfradiqueetal2009internacoesporcondicoesa` | {Interna\c c\~oes por condi\c c\~oes sens\'iveis \`a aten\c… | ? | ? | — | ✓ |
| `azevedoetal2021simulatingpotentialimpacts` | Simulating the {{Potential Impacts | ? | ? | — | ✓ |
| `blangiardoetal2013spatialspatiotemporalmodelsa` | Spatial and Spatio-Temporal Models with {{R-INLA | ? | ? | — | ✓ |
| `callawayetal2024differenceindifferencescontinuoustreatment` | Difference-in-Differences with a {{Continuous Treatment | ? | ? | — | — |
| `callawaysantanna2021differenceindifferencesmultipletime` | Difference-in-{{Differences | ? | ? | — | — |
| `cameronetal2008bootstrapbasedimprovementsinference` | Bootstrap-{{Based Improvements | ? | ? | — | — |
| `chaisemartinetal2025differenceindifferencescontinuoustreatments` | Difference-in-{{Differences | ? | ? | — | — |
| `chaisemartinetal2025differenceindifferencesestimatorstreatments` | Difference-in-{{Differences Estimators | ? | ? | — | — |
| `cutlerlleras-muney2010understandingdifferenceshealth` | Understanding Differences in Health Behaviors by Education | ? | ? | — | — |
| `dechaisemartindhaultfoeuille2020twowayfixedeffects` | Two-{{Way Fixed Effects Estimators | ? | ? | — | — |
| `doriamborgesignaciocano2017homicidiosnaadolescencia` | Homic\'idios Na Adolesc\^encia No {{Brasil | ? | ? | — | — |
| `fernandesetal2024relacaoindiceinclusaoeducacional` | Rela\c c\~ao Entre o {{\'Indice | ? | ? | ✓ | — |
| `fernandesetal2025evolucaodesempenhoeducacional` | A {{Evolu\c c\~ao | ? | ? | — | — |
| `ferreira-batistaetal2022brazilianfamilyhealth` | The {{Brazilian Family Health Strategy | ? | ? | — | — |
| `ferreira-batistaetal2023primaryhealthcare` | Is Primary Health Care Worth It in the Long Run? {{Evidence | ? | ? | — | — |
| `goinriddell2023comparingtwowayfixed` | Comparing {{Two-way Fixed Effects | ? | ? | — | — |
| `goodman-bacon2021differenceindifferencesvariationtreatment` | Difference-in-Differences with Variation in Treatment Timing | ? | ? | — | — |
| `honeetal2017largereductionsamenable` | Large {{Reductions In Amenable Mortality Associated With Br… | ? | ? | — | — |
| `honeetal2019effecteconomicrecession` | Effect of Economic Recession and Impact of Health and Socia… | ? | ? | — | — |
| `iacusetal2012causalinferencebalance` | Causal {{Inference | ? | ? | — | — |
| `landau2021targetspackagedynamic` | The Targets {{R | ? | ? | — | — |
| `lichandetal2022impactsremotelearning` | The Impacts of Remote Learning in Secondary Education durin… | ? | ? | — | — |
| `lipsitchetal2010negativecontrolstool` | Negative {{Controls | ? | ? | — | — |
| `luposocial2026dashboardiie` | {Painel IIE --- \'Indice de Inclus\~ao Educacional (Lupa So… | ? | ? | — | — |
| `luposocial2026inclusaoeducacionalpobreza` | Inclus\~ao {{Educacional | ? | ? | — | — |
| `macinkoharris2015brazilsfamilyhealth` | Brazil's {{Family Health Strategy | ? | ? | — | — |
| `mackinnonetal2023clusterrobustinferenceguide` | Cluster-Robust Inference: {{A | ? | ? | — | — |
| `marmot2017closinghealthgap` | Closing the Health Gap | ? | ? | — | — |
| `meloetal2017mortalidadehomensjovens` | Mortalidade de Homens Jovens Por Agress\~oes No {{Brasil | ? | ? | — | — |
| `pacienciaismail2025indiceinclusaoeducacional` | \'Indice de {{Inclus\~ao Educacional Municipal | ? | ? | — | — |
| `pintojunioretal2018efeitoestrategiasaude` | Efeito Da {{Estrat\'egia Sa\'ude | ? | ? | — | — |
| `riddellgoin2023guidecomparingestimators` | Guide for {{Comparing Estimators | ? | ? | — | — |
| `rueetal2009approximatebayesianinference` | Approximate {{Bayesian Inference | ? | ? | — | — |
| `saldanhaetal2019microdatasuspacotepara` | Microdatasus: Pacote Para Download e Pr\'e-Processamento de… | ? | ? | — | — |
| `vanderweeleding2017sensitivityanalysisobservational` | Sensitivity {{Analysis | ? | ? | — | — |
| `wooldridge2025twowayfixedeffects` | Two-Way Fixed Effects, the Two-Way Mundlak Regression, and … | ? | ? | — | — |

<!-- END: BIB_INDEX -->

> **Nota da sessão 006:** índice acima gerado **manualmente** porque a
> sessão 006 é conversacional (Desktop), não-Code. Após ratificação de
> metadado das 5 entradas zumbi e re-exportação do `.bib` pelo Zotero,
> rodar `source("R/build_bibliography_index.R"); build_bibliography_index()`
> em sessão Code para regenerar este índice automaticamente. As 27 chaves
> válidas listadas são autoritativas; as 5 zumbi (`zotero-item-NNNN`) são
> placeholders e serão reescritas para `authEtAl.lower + year +
> shorttitle.lower` após o pesquisador preencher metadado mínimo no Zotero.

---

## Histórico de bootstrap

A sequência inicial de bootstrap da bibliografia (importação no Zotero,
configuração de citation key BetterBibTeX, exportação do `.bib`) foi
executada na sessão 006 (2026-05-03). Estado atual:

- 27 entradas válidas no `.bib` (centrais do corpus + 2 expansões).
- 5 entradas zumbi sem metadado (a polir no Zotero).
- 7 entradas com chave fora do padrão (`2017…`, `2021…`, e as 5 zumbi).
- `reading-list.md` ainda não populado — pendente para sessão futura.
- Nenhuma nota de leitura criada — sessão 006 priorizou nota de pesquisa
  em `research-notes/saeb-2019-idade.md`.

Detalhes em `CHANGELOG.md` (sessão 006) e em
`.claude/sessao-006-handoff.md` (handoff manual desta sessão).
