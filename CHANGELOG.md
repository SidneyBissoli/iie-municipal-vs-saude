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

### Fixed (Sessão Code 016) — 2026-05-14

- CI (`.github/workflows/R-CMD-check.yaml` e `targets-check.yaml`):
  destravados após série de falhas iniciadas em 2026-05-04 (PR #3).
  Causa raiz: a action `r-lib/actions/setup-r-dependencies@v2` invoca
  `pak::lockfile_create(c("deps::.", ...))`, e o scanner do pak
  enumerava o diretório `renv/library/<plat>/pak/library/` — onde o
  próprio `pak` vendoriza internamente o pacote `async` (arquivado do
  CRAN) e cópias internas de `testthat` e `pointblank`. Resultado:
  `! Could not solve package dependencies: * async: Can't find package
  called async`. Correção: substituir `setup-r-dependencies@v2` por
  `setup-renv@v2` em ambos os workflows, que restaura direto do
  `renv.lock` (já é a fonte de verdade do projeto, CLAUDE.md §3) sem
  acionar o scanner do pak. `lintr` e `styler` (dev-only, fora do
  lockfile) passam a ser instalados em passo dedicado no
  R-CMD-check.

### Added (Sessão Code 015) — 2026-05-14

- `manuscripts/proposta-de-pesquisa-v03.md` — nova versão da proposta
  científica, sucessora de v02. Versão v02 preservada intacta como
  fonte da submissão anterior (GOVERNANCE.md §"Hierarquia de fontes":
  sufixo `-vNN` preserva histórico de submissões).
- `manuscripts/proposta-de-pesquisa-v04.md` — versão posterior,
  extraída via `pandoc -f docx -t gfm --wrap=auto --columns=80` a partir
  da `v04.docx` para restabelecer markdown como fonte canônica. 509
  linhas; estrutura §1–§7 + Apêndice IA verificada presente. Único
  artefato pós-conversão corrigido: duplicação do header `**2.
  Objetivos**`.
- `manuscripts/proposta-de-pesquisa-v02.html` — render HTML pareado com
  a fonte canônica v02.md.
- `manuscripts/proposta-de-pesquisa-v03.docx`,
  `proposta-de-pesquisa-v04.docx`, `proposta-de-pesquisa-v04.pdf` —
  derivados publicados rastreados para auditoria de submissões.
- `manuscripts/sidney-bissoli-pesquisa-aplicada-associacao-iie-saude.pdf`
  — PDF da submissão ao Instituto Natura / Todos Pela Educação / B3
  (Modalidade B). Mantido com nome usado na submissão para
  rastreabilidade institucional.
- `bibliography/md-resumos/` — nova categoria de bibliografia, formal
  e operacionalmente distinta de `notes/` (template fixo, citation
  keys) e `research-notes/` (síntese cruzando ≥2 fontes). Resumos
  narrativos em português, formato livre, nomenclatura
  `AutorETAL_AAAA_slug-tematico.md`. Três entradas iniciais:
  `alfradiqueETAL_2009_icsap-lista-brasileira.md`,
  `azevedoETAL_2021_simulating-impacts-covid19.md`,
  `blangiardoETAL_2013_spatial-and-spatio-temporal-models.md`.
- `.gitignore`: adicionado `.positai` (cache local do plugin AI da
  IDE).

### Changed (Sessão Code 015) — 2026-05-14

- `CLAUDE.md` — atualização editorial após sessões 011–014, alinhando
  documento ao estado real do repo. Substituídas referências fixas a
  `proposta-de-pesquisa.md` e `roadmap-v01.md` por formas genéricas
  `proposta-de-pesquisa-vNN.md` e `roadmap-vNN.md vigente`,
  prevenindo nova divergência a cada major do roadmap. Adicionado
  `assets/` à árvore canônica §2. Em §3, documentado
  `write_with_contract(df, contract, path)` como caminho obrigatório
  para gravar derivados em `data/` (roda `pointblank` antes; aborta em
  falha). §6 estendido para explicitar três naturezas de notas:
  `notes/<citation-key>.md` (formal), `md-resumos/` (narrativa livre)
  e `research-notes/<topico>.md` (síntese investigativa). §7 ganha
  nota de que o fluxo de manifests está em produção desde a sessão 001
  — não é modelo aspiracional.
- `CONVENTIONS.md` — formalização de `bibliography/md-resumos/` como
  terceira categoria sob `bibliography/`. Distinção operacional vs.
  `notes/`: `notes/` segue template fixo (`_note-template.md`) com
  quotes literais com página, crítica metodológica formal e conexões;
  `md-resumos/` é formato livre para síntese conceitual e contexto
  histórico, em português. Convenção de nomenclatura formalizada:
  `AutorETAL_AAAA_slug-tematico.md`. Uma referência pode ter um,
  outro, ou ambos.
- `manuscripts/proposta-de-pesquisa-v02.md` — refluxo cosmético
  (wrap a 80 colunas, alinhamento `:------:` da tabela de Produtos
  Esperados). Sem mudança substantiva — conteúdo finalizado em
  d91f723.
- `.lintr` — `indentation_linter` permanece `NULL`, agora com bloco de
  comentário explicando o motivo (`styler` é a fonte canônica de
  indentação por CLAUDE.md §1; nenhum `hanging_indent_style` do lintr
  alinha com styler em chamadas aninhadas).
- `R/*.R` (5 arquivos: `build_adr_index.R`, `build_bibliography_index.R`,
  `build_session_manifest.R`, `build_synthesis_matrix.R`,
  `verify_session_manifest.R`) — reformatação cosmética idempotente
  via `styler::style_dir("R/")`, sem mudança de comportamento. Gates
  verdes: `lintr` zero lints; `styler` 0 changes pendentes;
  `testthat` 18/18 PASS.
- `roadmap-v01.html` regenerado pareado com a fonte v01.md (que
  permanece como fonte histórica da Fase 0). Diff dominado por
  mudanças mecânicas do gerador Quarto; conteúdo do .md fonte não
  alterado.

## [roadmap-v02] — 2026-05-07

### Added (Sessão Code 014) — 2026-05-07

- `roadmap-v02.md` (raiz) — versão major do roadmap, sucede
  `roadmap-v01.md` (preservado intacto conforme regra de imutabilidade
  documentada em `GOVERNANCE.md` §T.8). Identificadores de fase e seção
  (Fase N, N.M) preservados conforme `CONVENTIONS.md` §Identificadores;
  ~95% do conteúdo herda literal da v01. Mudanças cirúrgicas localizadas
  em três pontos:
  - **Cabeçalho:** "Versão: v02 · gerada a partir de
    `proposta-de-pesquisa-v02.md` (em redação) · sucede
    `roadmap-v01.md`".
  - **§3.1 (Desenho B — Painel UF com TWFE):** acrescentado bullet
    sobre ETWFE/Mundlak via `fixest::fepois` (médias intra-UF e
    intra-coorte do IIE como controles), blindando o Desenho B contra
    heterogeneidade temporal entre coortes. Itens pré-existentes
    mantidos integralmente. Ancoragem em Wooldridge (2025), ADR-005 e
    nota de pesquisa
    `bibliography/research-notes/v02-obs5-framing-heterogeneidade-temporal.md`.
  - **§3.3 (Robustez avançada):** quatro acréscimos e uma substituição.
    Acréscimos: (i) S1 — painel UF restrito sem 2020-2021
    (sensibilidade ao choque pandêmico, briefing v02 §2.4); (ii) S2 —
    estratificação temporal por subperíodos 2018-2019 vs. 2022-2024
    (briefing v02 §2.4); (iii) tendências lineares por UF
    (`α_u + γ_c + α_u·t`, briefing v02 §2.4); (iv) exclusão da coorte
    2019 do Desenho B (referência a ADR-005, sensibilidade central).
    Substituição: bullet "Negative controls outcomes (P1, viabilidade
    em ADR)" substituído por "Não-ICSAP no Desenho A como negative
    control outcome obrigatório (Lipsitch et al., 2010), reportado em
    apêndice (1–2 pp.)" — promove de "talvez P1, viabilidade em ADR"
    para sensibilidade obrigatória sem ADR adicional.
  - **§0.5 (catálogo de ADRs pré-mapeadas):** ADR-008 (viabilidade de
    negative controls) marcada como **descontinuada** na v02. O bullet
    de §3.3 do roadmap-v02 já operacionaliza Não-ICSAP no Desenho A
    como negative control outcome obrigatório, resolvendo positivamente
    a pergunta original de viabilidade. Sete ADRs pré-mapeadas
    remanescentes: ADR-001, ADR-002, ADR-003, ADR-004, ADR-005,
    ADR-007, ADR-009. ADR-006 já materializada (errata interpretativa
    do ADR-005, sessão 010).
- §0.5 "Referências centrais a importar no Zotero" do roadmap-v02
  mantida literal: é checklist histórica de bootstrap bibliográfico
  (sessões 003 e 006, datas e procedências explícitas), não
  bibliografia viva — atualizá-la implicaria reescrever histórico de
  sessões. As 4 chaves da matriz ausentes em §0.5
  (`chaisemartinetal2025differenceindifferencesestimatorstreatments`,
  `riddellgoin2023guidecomparingestimators`,
  `luposocial2026inclusaoeducacionalpobreza`,
  `luposocial2026dashboardiie`) já constam no `references.bib` desde
  sessões posteriores e aparecem nominalmente na §7 da proposta-v02
  (Passo 2 do briefing).
- Demais seções (Fase 0, Fase 1, Fase 2, Fase 4, Fase 5; eixos
  transversais T.1–T.8; marcos críticos) herdam literais.
- Mudanças metodológicas alinhadas a: briefing v02 da proposta (cole
  de Desktop na sessão 014); decisões já fechadas em ADR-005 (lag do
  painel UF) e ADR-006 (errata 2021/2023 do IIE estadual); matriz de
  síntese 100% pronta em `assets/synthesis_matrix_proposta_v02.csv`
  (33 entradas, sessão 013-bis).
- Magnitude: **major** (cria novo `roadmap-vNN.md` conforme
  `GOVERNANCE.md` §T.8 "Major — muda o plano"; congela `[Unreleased]`
  anterior em `[roadmap-v02]`; `roadmap-v01.md` permanece imutável
  como documento histórico).

### Added (Sessão Code 014, continuação) — 2026-05-07 — manuscript proposta-v02 e apêndice de IA

- `manuscripts/proposta-de-pesquisa-v02.md` (versão final limpa,
  citações APA 7) e
  `manuscripts/_drafts/proposta-de-pesquisa-v02-with-tags.md` (rascunho
  com tags `[SOURCED]` + verbatim lateral conforme
  `epistemic-tagging-rules.md` §1) — criados nesta sessão por cópia
  bit-a-bit da v01, preservando v01 intacta (regra de imutabilidade
  `GOVERNANCE.md` §T.8). Mudanças cirúrgicas:
  - **§1 D1:** desconfla
    `fernandesetal2024relacaoindiceinclusaoeducacional` (gravidez,
    homicídios 18-21, ensino superior, mercado de trabalho, engajamento
    cívico) de `luposocial2026inclusaoeducacionalpobreza` (pobreza na
    transição para a vida adulta, resultados preliminares).
  - **§1 D2 + §4.1 D2 + §7 D2:** Paciencia & Ismail 2024 → 2025
    (correção de ano em três pontos do documento).
  - **§4.2:** três parágrafos novos entre Desenho B e Desenho C — P1
    (ameaça reconhecida, literatura crítica TWFE pós-2020), P2
    (resposta defensiva: caso do projeto não tem patologias do
    staggered binário; ETWFE/Mundlak via Poisson de pseudo-máxima
    verossimilhança com efeitos fixos como camada adicional de
    robustez), P3 (posicionamento entre tradição epidemiológica
    brasileira aplicada e econometria DiD pós-2020 em saúde pública;
    cita Fernandes et al. 2024 como precedente sem proteção pós-2020).
  - **§4.3:** ampliada de 5 para 11 bullets — três sensibilidades
    obrigatórias (ETWFE/Mundlak, Não-ICSAP no Desenho A como negative
    control outcome ancorado em Lipsitch et al. 2010, exclusão da
    coorte 2019 do Desenho B conforme ADR-005) + três adicionais com
    qualifier "(Desenho B)" (S1 painel restrito sem 2020-2021, S2
    estratificação temporal por subperíodos, tendências lineares por
    UF).
  - **§4.4:** título atualizado para "Limitações estruturais, Software,
    Reprodutibilidade e Equipe"; parágrafo de Limitações estruturais no
    início (coortes 2021/2023 do IIE estadual existem mas ficam fora
    pela janela de desfecho 2018-2024 com lag t=c+5; ADR-006);
    parágrafo de software reescrito sob D4 estrita (sem packages-R;
    menciona Quarto e GitHub Actions como serviços/plataformas);
    parágrafo de equipe ajustado para neutralidade autopromocional.
  - **§7 Referências:** reescrita completa em ordem alfabética com 35
    entradas — removidas 4 órfãs por D4 (Bergé 2018, Bissoli 2026,
    Landau 2021, Saldanha et al. 2019), desconflada entrada confusa
    "Fernandes 2024" (que era factualmente Lupa Social 2026 sobre
    pobreza) em duas entradas distintas, adicionadas 19 entradas novas
    conforme briefing v02 §2.6 + Lipsitch et al. 2010 (consequência da
    §4.3 sens 2). APA 7 distingue Lupa Social (2026a) e (2026b) por
    título.
  - **Coortes do Desenho B:** correção factual aplicada em §2 (l.102),
    §4.1 (l.175) e §4.2 (l.206): {2015, 2017, 2019, 2021} → {2013,
    2015, 2017, 2019}. Execução de decisão fechada via ADR-005 +
    ADR-006 (lag t=c+5, janela de desfecho 2018-2024); não constitui
    reformulação metodológica nova.
  - **Apêndice — Declaração de uso de IA generativa** (após §7
    Referências, conforme briefing v02 §2.9): cinco blocos numerados —
    ferramentas e versões (Claude Desktop sessões 003-010; Claude Code
    sessões 001, 011-014; Claude.ai web como revisor cético da sessão
    014); áreas de uso (governança documental, infraestrutura técnica,
    curadoria bibliográfica, redação assistida, verificação cruzada);
    garantias de revisão humana com ancoragem auditável na matriz de
    síntese; declaração de responsabilidade autoral única do
    pesquisador; compromisso de transparência via repositório público.
- **Três desvios editoriais conscientes do mapa explícito do briefing
  §2.2**, registrados como decisões derivadas de consequência mecânica
  de princípios já validados, não como decisões metodológicas novas:
  - **(D-i)** Renomeação do título da §4.4 da proposta-v02 (inclui
    "Limitações estruturais" para visibilidade no índice; briefing
    §2.2 prescreve adição do parágrafo de Limitações em §4.4 mas não
    atualiza o título original).
  - **(D-ii)** CdH-PV-VB 2025 versão "Stayers"
    (`chaisemartinetal2025differenceindifferencescontinuoustreatments`)
    é a única citada na §7 da proposta-v02 (briefing §2.6 lista também
    "Estimators" como destaque, mas só "Stayers" é citada no corpo via
    §4.2 P2; "Estimators" permanece no `.bib` + matriz para uso no
    artigo final).
  - **(D-iii)** Remoção de "via microdatasus" da célula da tabela §6
    (Cronograma, Mês 1) — derivada da D4 estendida ao corpo todo da
    proposta-v02; completa coerência interna §6 ↔ §7 ↔ §4.4 (sem
    packages-R nominados em qualquer ponto da v02).
- **Não tocados nesta sessão (preservados literais):** Fase 0 a Fase 5
  do roadmap-v02; §§2, 3, 5, 6 da proposta-v02 (exceto correções
  factuais derivadas de ADRs aceitos: coortes em §2/§4.1/§4.2 e ano em
  D2 §1/§4.1/§7).
- Magnitude: **minor** (manuscript v02 é continuação da major
  `roadmap-v02`; reformulação editorial localizada da proposta sob a
  blindagem metodológica nova adotada na major).

### Added (Sessão Code 013) — 2026-05-06

- `bibliography/pdfs-leitura/` populada com os 17 PDFs correspondentes
  às entradas com `risco_verificacao ∈ {M, A}` da matriz de síntese
  (`assets/synthesis_matrix_proposta_v02.csv`), pré-requisito
  operacional para a tarefa de completar a matriz a 100% (passo 6 da
  skill `literature-review-academic-ptbr`). Registro retroativo: a
  pasta foi populada pelo pesquisador antes desta sessão e não havia
  sido documentada no CHANGELOG. Lista das chaves cobertas:
  `luposocial2026inclusaoeducacionalpobreza`,
  `honeetal2017largereductionsamenable`,
  `honeetal2019effecteconomicrecession`,
  `ferreira-batistaetal2022brazilianfamilyhealth`,
  `macinkoharris2015brazilsfamilyhealth`,
  `alfradiqueetal2009internacoesporcondicoesa`,
  `cutlerlleras-muney2010understandingdifferenceshealth`,
  `marmot2017closinghealthgap`,
  `azevedoetal2021simulatingpotentialimpacts`,
  `goodman-bacon2021differenceindifferencesvariationtreatment`,
  `callawaysantanna2021differenceindifferencesmultipletime`,
  `cameronetal2008bootstrapbasedimprovementsinference`,
  `mackinnonetal2023clusterrobustinferenceguide`,
  `rueetal2009approximatebayesianinference`,
  `blangiardoetal2013spatialspatiotemporalmodelsa`,
  `iacusetal2012causalinferencebalance`,
  `vanderweeleding2017sensitivityanalysisobservational`.
  `bibliography/pdfs-leitura/` permanece em `.gitignore` — PDFs não
  são versionados (peso, copyright); fonte canônica continua sendo
  o Zotero do pesquisador. Magnitude: patch (housekeeping documental
  retroativo; sem mudança de código ou dados versionados).

### Changed (Sessão Code 013-bis) — 2026-05-06

- `CONVENTIONS.md` — adiciona seção "Convenções bibliográficas — coluna
  `pagina` da matriz de síntese" formalizando a regra de paginação direta
  visível no PDF (vs. inferida por offset). Decisão emerge da sessão 013
  (commit `16fe07e`), onde o problema foi observado em PDFs AIP/preprint
  com paginação interna 1-N divergente da paginação publicada
  registrada na matriz e no `.bib`. Magnitude: minor (governança
  documental; não afeta dados, código ou pipeline).

  Refs: #1; ADR-? (não aplicável); commit `16fe07e`.

### Added (Sessão Code 012) — 2026-05-04

- `README.md` (raiz) — visão geral do projeto em PT-BR: identifica
  edital, status (Fase 0), aponta para `manuscripts/proposta-de-pesquisa-v01.md`,
  `GOVERNANCE.md`, `CONVENTIONS.md`, `RISKS.md`, `CHANGELOG.md` e
  `CLAUDE.md`; instruções básicas de reprodutibilidade
  (`renv::restore()` + `targets::tar_make()`); nota sobre `data-raw/`
  e `data/` não versionados, com origem explícita das três fontes
  (DATASUS via `microdatasus`; IIEM 2017 sob termo de
  não-redistribuição da Lupa Social; IIE estadual 2015–2021 público
  do GitHub da Lupa Social).
- `LICENSE` (raiz) — MIT, copyright 2026 Sidney da Silva Pereira
  Bissoli. Detectada automaticamente pelo GitHub no metadado do repo.
- `CITATION.cff` (raiz) — Citation File Format v1.2.0, `type: software`,
  autoria solo (Bissoli, sbissoli76@gmail.com, "Pesquisador
  independente"), keywords (saúde pública, educação, determinantes
  sociais, mortalidade externa, ICSAP, Brasil, IIE, DATASUS), abstract
  curto. Sem `version` nem `doi` ainda — DOI Zenodo será atribuído no
  release `v1.0.0` (Mês 5, item §5.3 do roadmap).
- `CODE_OF_CONDUCT.md` (raiz) — Contributor Covenant 2.1 traduzido para
  PT-BR; contato de aplicação `sbissoli76@gmail.com`.
- **Repositório GitHub público criado:**
  <https://github.com/SidneyBissoli/iie-municipal-vs-saude>
  (visibilidade `PUBLIC`, branch padrão `main`, licença MIT detectada,
  remote `origin` configurado e rastreando `origin/main`). Cumpre
  primeiro bullet do item §0.1 do roadmap (P0). Magnitude: minor (adiciona
  artefatos meta sem invalidar plano).

### Changed (Sessão Code 012) — 2026-05-04

- `roadmap-v01.md` — §0.1 primeiro bullet marcado `[ ]` → `[x]` com
  anotação registrando URL do repo, commits `7b7507f` (meta) e
  `8a113ee` (patch da referência da proposta), formato CFF, política
  de DOI postergada para §5.3, e Contributor Covenant 2.1 traduzido.
  Cabeçalho do roadmap (linha 22) corrigido em commit anterior desta
  sessão: `proposta-de-pesquisa.md` → `proposta-de-pesquisa-v01.md`,
  alinhando com o sufixo de versão adotado no commit `f919bc4` da
  sessão 008 ("docs(manuscripts): renomeia proposta para
  proposta-de-pesquisa-v01"). Magnitude: patch (correção de referência
  + marca progresso).
- `roadmap-v01.html` — re-renderizado com Quarto 1.9.37
  (`quarto render roadmap-v01.md --to html`). Diff do HTML é grande
  (~2 374 linhas alteradas) porque reflete diferença de versão do
  render entre a sessão 011 (Quarto anterior) e a 012; o conteúdo
  lógico segue o `.md`.



- `assets/synthesis_matrix_proposta_v02.csv` — entrada nova
  `luposocial2026dashboardiie` (33ª da matriz): dashboard
  interativo Lupa Social (<https://www.painel-iie.com.br/>) como
  fonte primária da descoberta da coorte 2021/2023 do IIE
  estadual, referenciando ADR-006. Verbatim p. 9 (nota de rodapé
  metodológica das capitais), 13 palavras. `tipo_publicacao = "RT"`
  (consistente com `fernandesetal2025evolucaodesempenhoeducacional`,
  outro relatório técnico Instituto Natura/Metas Sociais; `OUT`
  cogitado pelo briefing não existe na taxonomia da matriz);
  `risco_verificacao = "B"`. Magnitude: minor.
- `.claude/sessao-011.md` — housekeeping da sessão Code 011 (gap
  manifest 002→011 documentado; commits aplicados; styler diff
  reportado para decisão futura). **Local-only** (`.claude/` é
  gitignored — manifests e session reports não são commitados,
  reprodutibilidade ancora em `renv.lock` + commit SHA).
- `.claude/sessao-011-manifest.json` — manifest da sessão Code 011,
  ancorado no `commit_sha` do último commit do trabalho. Local-only.

### Changed (Sessão Code 011) — 2026-05-04

- `assets/synthesis_matrix_proposta_v02.csv` — 4 entradas
  atualizadas com verbatins extraídos dos 4 PDFs em
  `bibliography/pdfs-leitura/` via `pdftools::pdf_text()`:
  - `callawayetal2024differenceindifferencescontinuoustreatment`
    (NBER WP 32117, fev/2024; 61 pp.) — verbatim p. 2
    (Abstract): *"parameters associated with popular linear
    two-way fixed-effect (TWFE) specifications can be hard to
    interpret"* (14 palavras).
  - `chaisemartinetal2025differenceindifferencescontinuoustreatments`
    — PDF na pasta é versão Jan/2024 (SSRN 4011782); BBT key
    registra 2025 (arXiv:2201.06898v3 ago/2025); verbatim
    p. 1 (Abstract): *"We generalize our estimators to the
    instrumental-variable case"* (8 palavras). Discrepância de
    versão registrada no campo `metodo` da entrada.
  - `riddellgoin2023guidecomparingestimators` (Letter,
    Epidemiology 34(3), mai/2023; 2 pp. — e21–e22) — verbatim
    p. e21: *"the two-way fixed-effects estimate is providing
    a valid estimate but to the wrong question"* (14 palavras).
  - `doriamborgesignaciocano2017homicidiosnaadolescencia` (livro
    IHA 2014, Observatório das Favelas; 108 pp.) — **PDF tem
    text-layer extraível** (média 2459 chars/pág, contrariando
    expectativa do briefing de OCR-pendente); verbatim p. 18
    (Cap. 2 — Metodologia): *"estas mortes intencionais são
    redistribuídas de acordo com a razão entre homicídios e
    suicídios"* (14 palavras).

  Todos os 4 verbatins respeitam o limite estrito de 15 palavras
  (skill `literature-review-academic-ptbr`). `risco_verificacao`
  migrado A → B nas 4 entradas.

- `bibliography/README.md` (BIB_INDEX) e `decisions/README.md`
  (ADR_INDEX) regenerados via `R/build_bibliography_index.R` e
  `R/build_adr_index.R`. BIB_INDEX agora reflete 35 entradas
  canônicas; ADR_INDEX inclui ADR-005 (`superseded by ADR-006`)
  e ADR-006 (`accepted`).

- `R/build_synthesis_matrix.R` (linha 54) — comentário inline
  removido para satisfazer `line_length_linter` (81 → 67 chars).
  Único lint pendente após instalar `cyclocomp`. Demais sugestões
  do `styler::style_dir("R/", dry = "on")` (5 arquivos com
  realinhamentos e reestruturação de `tryCatch` em
  `build_session_manifest.R`) **não aplicadas** — registradas em
  `.claude/sessao-011.md` para decisão do pesquisador (briefing
  rule explícita: reportar diff e seguir SEM aplicar).

- `renv.lock` — snapshot incorpora `openxlsx2 1.26` (já usado por
  `R/build_synthesis_matrix.R` mas ausente da lockfile, causando
  `synchronized = FALSE`). `pdftools 3.8.0` instalado durante a
  sessão para leitura dos PDFs **não foi snapshotado** (não é
  referenciado por nenhum script em `R/`; é dependência
  operacional one-shot). `cyclocomp 1.1.2` e `styler 1.11.0`
  instalados para satisfazer gates pré-commit também não foram
  snapshotados (dependências de desenvolvimento, não da pipeline).

- `.gitignore` — exclui `bibliography/pdfs-leitura/` (PDFs ficam
  no Zotero, não no repo, conforme CLAUDE.md §6).

### Removed (Sessão Code 011) — 2026-05-04

- `decisions/ADR-006-substituicoes-manuais-bib-pos-export.md` e
  `R/post_export_fix_bib.R` — **artefatos órfãos finalmente
  removidos do filesystem**. CHANGELOG da sessão 010 declarava
  remoção via `git rm`, mas factualmente os arquivos
  permaneceram no working tree como untracked (nunca tinham sido
  commitados, então `git rm` falharia). Removidos via `rm` por
  esta sessão Code 011, conforme HALT-rule do briefing
  ("arquivos órfãos ainda presentes → halt, executar `git rm`
  se for o caso") e intenção documentada na seção `Removed
  (sessão 010, pós-encerramento)`. Magnitude: patch (correção
  factual de divergência entre CHANGELOG e estado do repo).

### Notes (Sessão Code 011) — 2026-05-04

- **Distribuição de risco da matriz após esta sessão:** 2 A / 16 B
  / 15 M (era 6 A / 11 B / 15 M antes). 4 entradas migraram A → B
  pelos verbatins extraídos; 1 entrada nova (dashboard) entrou em B.
- **Pendências A restantes (2 entradas):**
  `luposocial2026inclusaoeducacionalpobreza` (resultados
  preliminares, sem PDF) e
  `honeetal2019effecteconomicrecession` (sem abstract no `.bib`,
  sem PDF na pasta).
- **Bibliografia inalterada:** 35 entradas, sem chaves
  `zotero-item-NNNN`, sem `annotation` redundantes.
- **ADRs inalterados:** ADR-005 e ADR-006 mantêm imutabilidade do
  conteúdo deliberativo (regra de imutabilidade preserva ADRs
  `accepted`/`superseded`).
- **Conflito de numeração resolvido:** sessão renumerada de
  "002" (proposta no briefing inicial) para "011" — coerente com
  sequência factual de sessões Desktop 003-010 documentadas no
  CHANGELOG. `sessao-002-manifest.json` da housekeeping documental
  preservado intocado em `.claude/`.
- **Manifest da sessão anterior NÃO verificado:** `verify_last_
  session_manifest()` retornaria `fail` no `sessao-002-manifest.
  json` (CHANGELOG.md/CLAUDE.md/roadmap-v01.md editados via
  Desktop entre 2026-05-02 e 2026-05-04 sem commit). Verificação
  manual substitutiva no início desta sessão confirma estado
  factual da bibliografia (35 entradas, 0 zotero-item, 0
  annotation), dos 4 PDFs em `bibliography/pdfs-leitura/`, do
  ADR-005 (`superseded by ADR-006`) e do ADR-006 errata.

### Added (sessão 010)

- `bibliography/research-notes/v02-obs5-framing-heterogeneidade-temporal.md`
  (criada na sessão 009; **ratificada na sessão 010** por instrução do
  pesquisador "Caminho A com calibração") — fechamento da Observação
  5.A do handoff sessão 008. Heterogeneidade temporal entre coortes
  do IIE estadual será tratada na §4.2 (Identificação) da v02
  (≈1,5 pág. total; 5.A em 2 parágrafos; álgebra ETWFE/Mundlak
  preservada para Apêndice metodológico; §4.3 mantém ETWFE/Mundlak
  como sensibilidade reportada quantitativamente). Não gera ADR
  (método já fechado em ADR-005; decisão de framing editorial).
  Magnitude: minor.
- Confirmação empírica da existência da coorte 2021 do IIE estadual
  via leitura do dashboard online Lupa Social (`relatorio_iie.pdf`
  em `/mnt/project/`, 9 páginas, capturado em PDF). Série pública por
  UF e por capital cobre 2015, 2017, 2019, **2021 e 2023**: IIE Brasil
  2021 = 17,0%; IIE Brasil 2023 = 15,5% (com nota: dado 2023 sujeito
  a pequena alteração quando o Censo Escolar - Situação do Aluno 2024
  for disponibilizado). Decomposição em 3 componentes (% atraso 2+
  anos no Censo Escolar; % aprendizado abaixo do básico no SAEB; %
  jovens fora da escola na PNADc) também disponível para 2021 e 2023.
  **Limite metodológico:** o IIE municipal/capitais ainda **não** foi
  calculado para 2021/2023 — nota de rodapé do dashboard, p. 9:
  *"Os dados mais recentes, 2021 e 2023, para as capitais ainda não
  foram calculados por conta da indisponibilidade dos microdados do
  Censo Escolar - Situação do Aluno"*. **Implicação para o ADR-005:**
  a afirmação "coorte 2021 estruturalmente fora" só é válida para o
  IIE municipal, não para o estadual; vale dizer, para o Desenho B do
  projeto (painel UF), as coortes 2021 e 2023 do IIE estadual existem
  publicamente. Mudança operacional, no entanto, é nula: a coorte
  2021 já estaria fora pela janela do desfecho 2018-2024 com lag
  t=c+5 (2021+5=2026 > 2024). Decisão sobre supersession do ADR-005
  fica em aberto para próxima sessão. Magnitude: minor.

### Changed (sessão 010)

- `bibliography/references.bib` — 6 chaves substituídas via
  **Caminho A do BetterBibTeX** (operação realizada pelo pesquisador
  no Zotero antes da sessão 010: override no campo Extra com sintaxe
  canônica `Citation Key: <valor>`, seguida de reexportação):
  `2021oupacceptedmanuscripta` →
  `azevedoetal2021simulatingpotentialimpacts`;
  `zotero-item-4223` →
  `pacienciaismail2025indiceinclusaoeducacional`;
  `zotero-item-4225` → `luposocial2026inclusaoeducacionalpobreza`;
  `zotero-item-4245` →
  `chaisemartinetal2025differenceindifferencescontinuoustreatments`;
  `zotero-item-4247` →
  `fernandesetal2025evolucaodesempenhoeducacional`;
  `zotero-item-4250` →
  `fernandesetal2024relacaoindiceinclusaoeducacional`.
  Estado verificado por leitura do `.bib` reexportado no início da
  sessão 010. Os 9 campos `annotation` que existiam na exportação
  intermediária (após primeira tentativa de override pelo pesquisador,
  com sintaxe não-canônica) foram automaticamente eliminados pelo BBT
  na reexportação canônica. Magnitude: minor (sem alteração de
  conteúdo bibliográfico substantivo; recuperação da convenção
  `autores+ano+titulo`).
- `bibliography/research-notes/saeb-2019-idade.md` — §7 (primeira
  pendência) atualizada para refletir resolução via Caminho A
  (anteriormente apontava para "Caminho B + ADR-006", remanescência
  de plano de fallback que não precisou ser executado). Magnitude:
  patch.
- `bibliography/notes/fernandesetal2024relacaoindiceinclusaoeducacional.md`
  (já renomeado em sessão pré-010) — campo "Citation key" atualizado
  para refletir Caminho A. Magnitude: patch.
- `assets/synthesis_matrix_proposta_v02.csv` — entrada
  `pacienciaismail2025indiceinclusaoeducacional` enriquecida com
  magnitudes quantitativas das correlações IIEM × ISEs lidas das
  pp. 16-17 do PDF original (Paciencia & Ismail, 2025, agora com 35
  páginas disponíveis no pacote, contra 9 na sessão prévia). Para
  Δ10pp no IIEM: ingresso ES mulheres 7,0→8,7%; metrópoles
  11,3→13,8; ENEM 41,7→46,6%; empregabilidade mulheres 15-24
  9,4→11,2%; homicídios masculinos 50,9→43,9/100mil; gravidez
  <18 anos 9,5→8,5%; óbitos fetais em gestantes <18 anos 8,0→6,6%;
  saúde mental não-significativa ou contra-intuitiva. Método refinado:
  n=4.775 municípios; coorte 2000 com IIEM calculado para 2017;
  4 modelos progressivos OLS (simples, +covariáveis, +macrorregião,
  +UF); clusterização não-hierárquica em 4 grupos pela mediana + 1
  grupo outlier >500 mil hab. Páginas refinadas para "1 (resumo);
  4-7 (metodologia); 16-17 (resultados)". Verbatim do resumo
  preservado (cobertura ampla dos 3 indicadores). Risco mantido em
  B. Magnitude: patch.

### Fixed (sessão 010)

- **Reporte equivocado intermediário sobre falha do Caminho A.** Na
  primeira leitura do `.bib` na sessão 010, a ferramenta
  `filesystem:read_text_file` retornou um snapshot obsoleto do
  arquivo (provavelmente cache do contexto comprimido da sessão
  009) que ainda mostrava as 6 chaves antigas e os 9 campos
  `annotation` redundantes. Diagnóstico inicial registrado pelo Claude
  — "Caminho A falhou tecnicamente; o BBT não honrou a sintaxe" —
  foi factualmente errado. Releitura do arquivo (head + leitura
  completa) confirmou que o Caminho A funcionou integralmente e que
  o `.bib` está em estado canônico. Plano original de execução do
  Caminho B (criação de ADR-006, script `R/post_export_fix_bib.R`,
  edição manual das chaves no `.bib`) foi **cancelado
  arquiteturalmente** após a verificação; entretanto, dois
  artefatos materializados em uma fase intermediária da sessão
  (capturada no transcript
  `2026-05-04-02-21-58-iie-sessao-010-caminho-b.txt`) sobreviveram
  no repositório: `decisions/ADR-006-substituicoes-manuais-bib-pos-export.md`
  e `R/post_export_fix_bib.R`. Tratamento desses arquivos órfãos
  fica em aberto para decisão do pesquisador — ver seção
  `Discovered (sessão 010, pós-encerramento)` abaixo.
- Inconsistências de marcação `risco_verificacao` corrigidas em
  sessão 010 (já aplicadas antes do compaction):
  `honeetal2019effecteconomicrecession` B → A (verbatim pendente,
  sem abstract no `.bib`);
  `chaisemartinetal2025differenceindifferencesestimatorstreatments`
  M → B (verbatim presente conferido contra abstract do `.bib`);
  `rueetal2009approximatebayesianinference` B → M (verbatim pendente,
  abstract disponível mas sem leitura sistemática).
- Contagem de pendentes na matriz pós-correção: 12 entradas com
  risco B (verbatim presente) / 20 com verbatim pendente.

### Removed (sessão 010, pós-encerramento)

- `decisions/ADR-006-substituicoes-manuais-bib-pos-export.md` e
  `R/post_export_fix_bib.R` — **decisão arquitetural: apagar**
  (autorizada pelo pesquisador na continuação do chat da sessão 010
  pós-compaction). Justificativa: ambos os arquivos foram materializados
  em fase intermediária da sessão 010 (transcript
  `/mnt/transcripts/2026-05-04-02-21-58-iie-sessao-010-caminho-b.txt`)
  sob o diagnóstico factualmente errado de que "o BBT não honrou a
  sintaxe `Citation Key:`". A verificação empírica posterior do
  `references.bib` mostrou que o BBT honrou integralmente a sintaxe
  quando aplicada no formato canônico `Citation Key: <valor>` no campo
  Extra; não há campos `annotation` remanescentes a remover, e o script
  não tem trabalho a fazer no `.bib` atual.

  O pesquisador entende que ADR baseado em premissa factualmente errada
  não se qualifica como "decisão" no sentido em que a regra de
  imutabilidade existe (preservar trilha de pensamento válido). A trilha
  histórica integral fica preservada nesta seção do CHANGELOG e nos
  transcripts arquivados em `/mnt/transcripts/`. **Remoção física
  concluída pelo pesquisador** via `git rm` na continuação do chat
  da sessão 010; arquivos não existem mais no repositório.

  Magnitude: minor (remoção de artefatos órfãos sem efeito operacional;
  não invalida nenhum plano nem decisão arquitetural ativa).

### Added (sessão 010, pós-encerramento)

- `decisions/ADR-006-painel-uf-erratum-IIE-estadual-2021-2023.md`
  (errata interpretativa do ADR-005), criado nesta sessão após
  decisão do pesquisador pela opção (b) das três consideradas
  (apagar / superseder / tratar só na v02). Reaproveita o número
  ADR-006 já que (i) o arquivo órfão anterior foi removido por `git rm`
  na mesma sessão, e (ii) o pré-mapeamento original do ADR-005
  deixava o número 6 propositalmente livre na sequência. Conteúdo:
  ratifica integralmente a operação do ADR-005 (painel UF com 4
  coortes {2013, 2015, 2017, 2019}, lag t = c+5, sensibilidade central
  de exclusão de 2019); atualiza a justificativa textual da exclusão
  da coorte 2021 para "janela de desfecho 2018–2024 com t = c+5"
  em vez de "indisponibilidade da fonte primária do IIE"; explicita
  que o limite de mascaramento dos microdados-aluno do Censo Escolar
  a partir de 2021 afeta apenas o IIE municipal (Desenho A), não o
  IIE estadual (Desenho B); registra que coortes 2021 e 2023 do IIE
  estadual existem publicamente em <https://www.painel-iie.com.br/>;
  estabelece dois gatilhos para superseder.

  ADR-005 atualizado nesta sessão: header YAML
  `status: accepted` → `status: superseded by ADR-006`. Corpo do
  ADR-005 inalterado, conforme regra de imutabilidade do conteúdo
  deliberativo. Magnitude: minor (errata interpretativa sem alteração
  operacional).

### Added (sessão 006)

- `bibliography/research-notes/` (sessão 006) — nova subpasta para
  **notas de pesquisa temáticas**, distintas das notas de leitura
  (uma-por-obra) em `bibliography/notes/`. Inclui `README.md` com
  distinção operacional (nota de leitura: foco em uma obra, identificada
  por citation key BetterBibTeX; nota de pesquisa: foco em uma pergunta
  que cruza ≥2 fontes, identificada por slug temático). Índice manual
  no README da subpasta. Magnitude: minor (criação de nova categoria de
  documento, sem invalidar plano).
- `bibliography/research-notes/saeb-2019-idade.md` (sessão 006) —
  primeira nota de pesquisa: fechamento da Obs. 4 do handoff sessão 005,
  passo 3 (supressão de idade no SAEB 2019 e mecanismo de imputação na
  coorte 2019 do IIE estadual). Tríplice selo de evidência: empírica via
  `educabR::get_saeb()` (sessão 005), declarativa via 4 scripts oficiais
  INEP `INPUT_R_TS_ALUNO_*.R`, documental via Fernandes-Felício-Saad
  (2024) lido integralmente. Três verbatims-chave preservados (pp. 8 e
  22 do PDF). Mecanismo de imputação documentado: transporte da
  estrutura idade-série × proficiência de 2017 para 2019, com normalização
  por linha. Implicações para §4.1, §4.3 e ADR-005 da v02. Magnitude:
  minor.
- Fernandes, Felício & Saad (2024) *A Evolução do Desempenho Educacional
  dos Jovens Brasileiros ao Final da Educação Básica* (Instituto
  Natura/Metas Sociais) ao corpus central. Fonte metodológica primária
  do IIE estadual. Importada no Zotero como `techreport` com metadado
  pendente (zumbi). Magnitude: minor (adição ao corpus de referências).
- `bibliography/references.bib` populado com 27 referências do corpus
  via Zotero/BetterBibTeX (sessão 006). Índice BIB_INDEX em
  `bibliography/README.md` populado **manualmente** (sessão 006 é
  conversacional, não-Code; regeneração automática via
  `R/build_bibliography_index.R` em sessão futura). Magnitude: minor
  (avanço operacional de ítem `[~]` para `[x]` no roadmap §0.5).

### Changed (sessão 006)

- `bibliography/README.md` — explicita as duas categorias de notas
  (leitura `notes/` vs. pesquisa `research-notes/`); BIB_INDEX populado;
  seção "Sequência de bootstrap" reescrita como "Histórico de bootstrap"
  (executado na sessão 006). Magnitude: minor.
- `roadmap-v01.md` §0.5 — item de bootstrap da bibliografia marcado
  como concluído (`[x]`); pendências residuais (5 entradas zumbi sem
  metadado, 2 entradas com chave fora do padrão) registradas como
  polímento pós-bootstrap; lista de referências adicionais (sessão 003)
  atualizada com referências verificadas na sessão 005 (Callaway,
  Goodman-Bacon & Sant'Anna 2024 NBER WP 32117; Chaisemartin et al. 2025
  arXiv:2201.06898v3 — v3 substituiu v2 de 2022/2023); referência
  adicionada na sessão 006 (Fernandes-Felício-Saad 2024); duas
  observações de expansão do corpus na sessão 006: (a) Goin & Riddell
  2023 importado pelo pesquisador (referência metodológica relevante,
  TWFE vs. CS-DiD em policy evaluation; Goin, Rudolph & Ahern 2023
  originalmente listado pode ser também importado em momento futuro
  no padrão de corpus amplo); (b) Ferreira-Batista et al. (2022)
  Economics & Human Biology adicionado pelo pesquisador. Linguagem
  "ressubmissão" corrigida para "prazo prorrogado até 08/mai/2026
  para revisão voluntária da v01" (não houve reprovação; pesquisador
  está melhorando proposta já submetida). Magnitude: minor.
- `GOVERNANCE.md` — patch documental herdado da sessão 003:
  referência a `manuscripts/proposta-de-pesquisa.md` (sem sufixo)
  corrigida para `manuscripts/proposta-de-pesquisa-vNN.md` (com sufixo
  de versão), tanto na hierarquia de fontes quanto na lista de
  documentos científicos. Política de versionamento da proposta
  explicitada (sufixo `-v01`, `-v02`, etc.; nova submissão cria novo
  arquivo, não sobrescreve). Magnitude: patch (correção documental
  alinhando GOVERNANCE com fato no repositório).

### Added (sessões 001–005)

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

### Changed (sessões 001–005)

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
- `roadmap-v01.md` § 0.3 — item da solicitação formal do IIEM 2017 à
  Lupa Social refinado para citar a metodologia Paciencia & Ismail (2024)
  como base do dado solicitado e incluir citação acadêmica do método na
  carta. Magnitude: minor (refinamento de etapa).
- `roadmap-v01.md` § 0.5 — Paciencia & Ismail (2024) adicionado à lista
  de referências centrais a importar no Zotero, marcado como referência
  metodológica da exposição IIEM. Magnitude: minor (correção de omissão
  na lista de referências centrais).
- `roadmap-v01.md` § 1.1 — expectativa de cobertura municipal ajustada
  de 5.570 para ~4.775 municípios (Paciencia & Ismail, 2024 — filtro
  estrutural de <10 matrículas em 2008 da coorte de 2000). Magnitude:
  patch (correção factual de expectativa, sem invalidação de plano).
- `roadmap-v01.md` § 1.6 — fonte do IIE estadual 2015/2017/2019/2021
  alterada de "pedido formal à Lupa Social" para "download direto do
  repositório público GitHub Lupa Social" (`iie_geral_2015_2021.xlsx` +
  arquivos `.rds` complementares); proveniência será registrada no README
  de `data-raw/lupa-social/`. Magnitude: minor (mudança de fonte
  operacional sem alteração do objetivo).
- `CONVENTIONS.md` § Bibliografia — formato de citation key BetterBibTeX
  corrigido de `auth.lower + year + shorttitle.lower` para
  `authEtAl.lower + year + shorttitle.lower`. Mudança afeta todas as
  referências com múltiplos autores (sufixo `EtAl` automático).
  Magnitude: patch (correção factual da convenção registrada
  erroneamente; nenhuma chave foi gerada com o padrão anterior).
- `roadmap-v01.md` § 0.5 — lista de referências centrais a importar no
  Zotero auditada contra a seção 7 da proposta. Removido item espúrio:
  Simonsohn et al. (2020) specification curve (não citado na proposta).
  Adicionados oito itens omitidos: Fernandes et al. (2024); Callaway &
  Sant'Anna (2021); Rue, Martino & Chopin (2009); Bergé (2018); Bissoli
  (2026); Landau (2021); Pereira et al. (2019); Saldanha et al. (2019).
  Lista reorganizada em duas categorias — referências teóricas e
  metodológicas; referências dos pacotes R declarados na proposta.
  Padrão de citation key também corrigido inline para coincidir com
  `CONVENTIONS.md`. Magnitude: minor (correção de omissões e item espúrio
  na lista; sem alteração metodológica). Legislação citada na proposta
  (Brasil/Portaria SAS/MS 221/2008) tratada à parte: pode ser registrada
  no Zotero como Government Document, mas não entra na lista de
  referências centrais.
- `roadmap-v01.md` § 0.5 — lista de referências centrais reduzida ao
  critério editorial estrito (teóricas, metodológicas ou empíricas
  próximas; referências exclusivamente-pacote-R desligadas). Removidas
  Bergé (2018), Bissoli (2026), Landau (2021), Pereira et al. (2019) e
  também Saldanha et al. (2019), por decisão do pesquisador (referências
  de pacote R ficam para a seção de Software no manuscrito final, não
  para a seção de referências da proposta).
  Adicionado bullet de "Referências adicionais identificadas em revisão
  crítica (sessão 003)" com 11 itens novos em três frentes:
  fragilidade metodológica do Desenho B (Goodman-Bacon 2021;
  Chaisemartin & D'Haultfœuille 2020; Goin et al. 2023; Wooldridge
  2021/2025); empirismo brasileiro próximo (Macinko & Harris 2015 NEJM;
  Hone et al. 2017 Health Affairs; Hone et al. 2019 Lancet GH;
  Ferreira-Batista et al. 2023; Pinto Junior et al. 2018); contexto
  pandêmico (Lichand et al. 2022 Nat Human Behaviour; Azevedo et al.
  2021 World Bank). Cada referência foi verificada individualmente via
  Consensus, PubMed, ScienceDirect e páginas dos editores; metadados
  completos (DOI, PMID, páginas, número exato de autores) registrados
  inline. Erros corrigidos em relação a versão anterior do bullet:
  Macinko & Harris (não et al. — dois autores); Hone et al. 2017
  refere-se a 1.622 municípios (não 5.565); Hone et al. 2019 declarou
  ausencia de efeito em 15-29 anos (fato registrado); Azevedo et al. é
  2021 (não 2020); Wooldridge tem versão publicada em 2025 preferível
  ao working paper SSRN de 2021. Magnitude: minor (refinamento
  editorial e correção factual de erros de Dim. 2 metadados e Dim. 2
  conteúdo afirmado, conforme taxonomia da skill
  literature-review-academic-ptbr).

Motivação das mudanças acima: correções factuais resultantes da
leitura do Edital de Pesquisa IIE (que reconhece dados como públicos
antes da seleção), da inspeção do repositório público GitHub Lupa
Social (que contém `iie_geral_2015_2021.xlsx` + scripts e estudos) e da
leitura do estudo Paciencia & Ismail (2024) na pasta `estudos/` do mesmo
repositório (que documenta o método do IIEM e o n efetivo de municípios
calculáveis), e da auditoria da § 0.5 do roadmap contra a § 7 da
proposta-de-pesquisa.md (que revelou um item espúrio e oito omissões).
Sem necessidade de REV ou ADR — são correções factuais, não decisões
metodológicas.

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
