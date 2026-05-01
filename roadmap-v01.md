<!--
Convenção do source: linhas quebradas em ~80 colunas para edição confortável.
Em markdown (CommonMark / GFM / Pandoc / Quarto), quebras de linha SIMPLES
dentro de um mesmo parágrafo ou bullet são tratadas como espaço na renderização
HTML — ou seja, o texto flui normalmente como se fosse uma linha só. Para
forçar quebra de linha VISÍVEL no HTML, usa-se `<br>` no fim da linha (ver bloco
de metadados do cabeçalho abaixo) ou parágrafo separado por linha em branco.
Continuação de bullet em múltiplas linhas usa indentação de 2 espaços alinhada
ao texto após `- [ ] `.
-->

# Roadmap de Execução — v01

**Projeto:** Inclusão Educacional como Determinante Intersetorial da Saúde de
Jovens Brasileiros — Associação entre o IIE Municipal e desfechos de mortalidade
externa e ICSAP no Brasil (2018–2024)<br>
**Edital:** Instituto Natura / Todos Pela Educação / B3 — Modalidade B
(5 meses)<br>
**Pesquisador responsável:** Sidney da Silva Pereira Bissoli
(pesquisador independente)<br>
**Janela de execução:** Jul/2026 – Dez/2026<br>
**Versão:** v01 · gerada a partir de `proposta-de-pesquisa.md` ·
*roadmap em construção (pré-definitivo)*

---

## Como usar este roadmap

- **Convenção de checkboxes:** `- [ ]` pendente · `- [x]` concluído · `- [~]`
  em andamento · `- [!]` bloqueado/risco ativo.
- **Prioridade:** `(P0)` crítico para o caminho crítico do cronograma; `(P1)`
  necessário, mas com folga; `(P2)` desejável, executar se sobrar tempo.
- **Decisão metodológica:** itens marcados com `🜲` exigem decisão registrada
  como ADR (Architecture Decision Record) em `decisions/ADR-NNN.md` antes de
  prosseguir. Convenção e template em **0.5 Convenções de documentação**.
  Não pular.
- **Gate:** itens marcados com `⛓` são *quality gates* — bloqueiam o avanço
  para a fase seguinte até validação aprovada.
- **Onde fazer** (ver seção a seguir): a maior parte dos itens fica **sem tag**
  — é sua escolha na hora. Tags aparecem apenas onde a escolha não-óbvia
  previne erro caro.
- O roadmap é versionado. Mudanças substantivas geram `roadmap-v02.md`, com
  diff em changelog próprio.

---

## Onde fazer — Claude Code, Claude Desktop ou humano

Convenção minimalista. Só marca o que importa decidir certo; o resto fica em
branco e você escolhe na hora.

| Tag | Significado |
|:-:|---|
| **`[CD]`** | Preferir Desktop. Decisão metodológica densa, ADR, redação acadêmica, revisão crítica. |
| **`[CD→CC]`** | Decidir em Desktop, implementar em Code. |
| **`[humano]`** | Não delegável a Claude. |
| *(sem tag)* | Sua escolha; default Code para qualquer coisa que vire arquivo executável. |

**Detalhes:** `[CD]` cobre Introdução, Discussão, cover letter, nota técnica
para gestores, lab notebook e rotulagem de análises exploratórias —
justifica-se pela iteração conversacional e pelo acesso vivo a literatura via
MCPs (PubMed, Consensus, Zotero). `[humano]` cobre autenticação institucional,
envio de e-mails, submissão a periódico, autorização de DOI no Zenodo,
apresentação ao vivo e revisão entre colegas.

**Princípio único:** tag é alerta, não regra. Se você está em Code com sessão
aberta e o item é `[CD]` curto, faça em Code — perde-se pouco. O custo real é
tentar redigir Discussão em Code (vira texto seco) ou extrair 7 anos de SIM em
Desktop (sessão longa frágil).

---

## Fase 0 — Pré-execução e arquitetura (antes do Mês 1)

Objetivo: deixar a infraestrutura analítica, de versionamento e de governança
pronta para que o Mês 1 inicie produzindo dados, não configurando ambiente.

### 0.1 Repositório e estrutura

- [ ] **(P0)** Criar repositório GitHub público `iie-municipal-vs-saude` sob
  licença MIT, com `README.md`, `LICENSE`, `CITATION.cff` e
  `CODE_OF_CONDUCT.md`.
- [ ] **(P0)** Inicializar projeto R (`projeto-r.Rproj` já existe — auditar)
  com `renv::init()` para isolamento de dependências.
- [ ] **(P0)** Definir estrutura de diretórios:
  - `data-raw/` (dados brutos, não versionados)
  - `data/` (intermediários derivados, não versionados; reprodutíveis pelo
    pipeline)
  - `R/` (funções utilitárias)
  - `_targets/` (cache do `targets`)
  - `analysis/` (scripts de análise pontuais e sandboxes)
  - `quarto/` (relatórios e dashboard)
  - `manuscripts/` (proposta, artigo, preprints — documentos científicos
    longos)
  - `technical-note/` (PDF para gestores)
  - `slides/` (apresentação executiva)
  - `decisions/` (ADRs — Architecture Decision Records)
  - `bibliography/` (referências, fila de leitura, notas de artigos)
  - `tests/` (testes de funções e validações `pointblank`)
  - `outputs/` (tabelas, figuras, mapas finais — versionados quando estáveis)
- [ ] **(P0)** Adicionar `.gitignore` excluindo `data-raw/`, `data/`,
  `_targets/objects/`, `*.Renviron`, `.Rhistory` (já presente — auditar).
- [ ] **(P0)** Mover `proposta-de-pesquisa.{md,docx,html}` da raiz para
  `manuscripts/`. A proposta é documento científico (mesma natureza do
  artigo futuro), não de gestão; cabe junto com os demais manuscritos. Na
  raiz ficam apenas documentos meta (`README.md`, `LICENSE`, `CITATION.cff`,
  `CLAUDE.md`, `CHANGELOG.md`) e de gestão (`roadmap-vNN.md`).
- [ ] **(P0)** Criar `CLAUDE.md` no root do repositório com instruções
  persistentes para Claude Code: convenções tidyverse e pipe `|>`, comentários
  de código em inglês, estrutura de diretórios canônica, comandos frequentes
  (`targets::tar_make()`, `quarto render`, `renv::snapshot()`), gates
  pré-commit (lint + `testthat` + `pointblank`), localização dos ADRs em
  `decisions/` e das notas de leitura em `bibliography/`, política de
  não-commit em `data-raw/` e `data/`. Atualizar sempre que estrutura ou
  convenções mudarem.
- [ ] **(P1)** Configurar `.lintr` e `styler` para padronização tidyverse;
  commit hook via `precommit` package.

### 0.2 Reprodutibilidade e CI/CD

- [ ] **(P0)** Implementar esqueleto do pipeline `targets` em `_targets.R` com
  placeholders para cada fase analítica.
- [ ] **(P0)** Configurar GitHub Actions: workflow `R-CMD-check` para funções
  de `R/`; workflow `targets-check` para validação de pipeline (smoke test em
  subset municipal).
- [ ] **(P1)** Configurar `renv` com snapshot inicial; documentar `R.version`
  e SO de desenvolvimento.
- [ ] **(P1)** Criar Dockerfile reprodutível (rocker/verse + INLA) — opcional,
  mas útil para revisores.
- [ ] **(P2)** Configurar `pkgdown` para documentação navegável das funções
  utilitárias.

### 0.3 Governança da pesquisa

- [ ] **(P0)** **🜲** **`[CD]`** Decidir e registrar em ADR a estratégia de
  **pré-registro**: OSF Registries vs. AsPredicted vs. submissão de
  pré-registro como manuscrito. Recomendado: OSF antes do recebimento dos dados
  desfecho ainda não inspecionados (parte do SIM/SIH 2018–2024 já é pública —
  discutir limite de pré-registro honesto).
- [ ] **(P0)** **`[CD→humano]`** Solicitação formal do IIEM 2017 à Lupa
  Social: redigir e iterar carta (escopo, finalidade, destinação de dados,
  declaração de não-redistribuição); enviar do e-mail institucional.
- [ ] **(P1)** Verificar necessidade de submissão a CEP/CONEP. Posição
  preliminar: dados secundários públicos agregados em nível municipal/estadual
  dispensam aprovação ética (Resolução CNS 510/2016, Art. 1º, parágrafo único,
  IV). Registrar parecer em ADR.
- [ ] **(P1)** **🜲** **`[CD→CC]`** Definir política de tratamento de **dados
  ausentes** e **municípios sem cobertura completa** (especialmente IIEM
  ausente em municípios criados após 2017). Documentar em ADR e implementar em
  `R/missing_policy.R`.
- [ ] **(P0)** **`[CD]`** Criar `analise-pre-especificada.qmd` listando
  hipóteses H1–H4 e modelos principais antes de tocar nos dados desfecho.
  Travar em commit assinado.

### 0.4 Pacotes e infraestrutura computacional

- [ ] **(P0)** Validar instalação de: `tidyverse`, `targets`, `tarchetypes`,
  `pointblank`, `quarto`, `microdatasus`, `educabR`, `geobr`, `sf`, `fixest`,
  `MASS`, `pscl`, `sandwich`, `lmtest`, `marginaleffects`, `did`, `INLA`,
  `spdep`, `R-INLA` deps.
- [ ] **(P0)** Validar acesso ao DATASUS via `microdatasus` (teste com
  extração mínima de SIM 2023, 1 UF).
- [ ] **(P0)** Validar pacote `educabR` próprio (versão CRAN 0.9.1 declarada
  na proposta — confirmar disponibilidade pública ou usar versão dev local).
- [ ] **(P1)** Configurar paralelismo:
  `future::plan(multisession, workers = 16)` para `microdatasus`;
  `data.table::setDTthreads()` para operações de agregação.
- [ ] **(P2)** Smoke test de INLA com modelo BYM em subset (1 UF) para
  detectar problemas de instalação cedo.

### 0.5 Convenções de documentação

Dois sistemas de captura de conhecimento, ambos versionados no repositório.
**ADRs** registram decisões internas do projeto (por que escolhemos X);
**bibliografia** registra conhecimento externo capturado da literatura (o que
os outros já sabem). São complementares e operam com convenções paralelas.

#### ADRs (Architecture Decision Records)

- [ ] **(P0)** Estabelecer convenção de **ADRs** em `decisions/`:
  - **Nomenclatura:** `ADR-NNN-slug-descritivo.md` (ex.:
    `ADR-005-lag-painel-uf.md`). Numeração sequencial, sem datas no nome.
  - **Template fixo** com cinco campos (Nygard, 2011): Título, Status
    (`proposed` / `accepted` / `deprecated` / `superseded by ADR-NNN`),
    Contexto, Decisão, Consequências. Salvar em `decisions/_template.md`.
  - **Imutabilidade:** ADR `accepted` não se edita. Mudança de decisão
    cria novo ADR que `Supersedes ADR-XXX`; o anterior recebe status
    `superseded by ADR-NNN`. Preserva histórico de pensamento.
  - **Granularidade:** uma decisão por ADR. Se um ADR tem 4 decisões,
    divide-se em 4.
  - **Índice:** manter `decisions/README.md` com tabela auto-atualizada
    (título, status, item do roadmap, data) — pode ser script R simples
    em `R/build_adr_index.R` que varre os arquivos.
  - **Pré-mapeados:** oito ADRs já identificados pelos itens 🜲 — ADR-001
    pré-registro (0.3); ADR-002 política de missing (0.3); ADR-003
    correção de subnotificação (1.2); ADR-004 agrupamento ICSAP em três
    blocos (1.3); ADR-005 lag do painel UF (1.6); ADR-006 nível de
    cluster (2.1); ADR-007 viabilidade de negative controls (3.3);
    ADR-008 periódico-alvo (4.1). Numeração final pode variar conforme
    ordem cronológica de redação.
  - **Referência cruzada com `CLAUDE.md`:** documentar localização e
    convenção de leitura de ADRs antes de implementar itens 🜲.

#### Bibliografia e notas de leitura

- [ ] **(P0)** Estabelecer estrutura em `bibliography/`:
  - **`bibliography/reading-list.md`** — fila consolidada com colunas:
    citation key (BetterBibTeX), título curto, status (`to-read` /
    `reading` / `read`), papel no projeto (hipótese, método, seção do
    manuscrito), prioridade.
  - **`bibliography/references.bib`** — exportação BetterBibTeX do Zotero,
    única fonte de citation keys do projeto. Alimenta `reading-list.md` e
    o manuscrito Quarto. Re-exportar a cada vez que novas referências
    forem adicionadas ao projeto Zotero.
  - **`bibliography/notes/`** — uma nota markdown por artigo lido, nomeada
    `chave-citacao.md` (ex.: `melo-2017-icsap-educacao.md`), seguindo a
    citation key BetterBibTeX exata extraída de `references.bib`. PDFs
    **não** ficam aqui — permanecem no Zotero.
  - **`bibliography/_note-template.md`** — template fixo: citation key +
    DOI (link para Zotero), papel no projeto (hipótese / método / seção do
    manuscrito), resumo em 3–5 linhas em suas próprias palavras, citações
    quotáveis com número de página, crítica e limitações do estudo,
    conexões com outras notas (links relativos).
  - **Índice:** `bibliography/README.md` com tabela auto-atualizada
    (chave, título, status, papel) — mesmo padrão de `decisions/README.md`,
    script R correspondente em `R/build_bibliography_index.R`.
  - **Divisão com Zotero:** Zotero permanece como fonte da verdade para
    metadados, PDFs e highlights rápidos. Notas substantivas vão no repo
    porque são versionadas, revisáveis e importáveis como snippets
    diretamente no manuscrito Quarto. Não duplicar metadados.
  - **Popular bibliografia no início da Fase 0** (sequência obrigatória,
    sem atalhos): (1) importar no Zotero as referências centrais
    identificadas na proposta — Melo et al. (2017) ICSAP-educação; Borges
    & Cano (2017) subnotificação; Alfradique et al. (2009) Lista
    Brasileira; Cutler & Lleras-Muney (2010); Marmot (2017); Blangiardo
    et al. (2013) BYM; Cameron et al. (2008) e MacKinnon et al. (2023)
    wild bootstrap; Iacus, King & Porro (2012) CEM; VanderWeele & Ding
    (2017) E-value; Simonsohn et al. (2020) specification curve;
    (2) instalar/configurar plugin BetterBibTeX no Zotero com convenção de
    citation key estável (`auth.lower + year + shorttitle.lower`,
    travada); (3) exportar como `.bib` para `bibliography/references.bib`;
    (4) só então popular `reading-list.md` lendo as citation keys
    diretamente de `references.bib`. Citation keys provisórias inventadas
    a partir de autor+ano são proibidas — a chave é a do Zotero, ponto.

⛓ **Gate Fase 0:** repositório público criado, pipeline `targets` rodando
smoke test em CI, IIEM solicitado, pré-registro publicado, convenções de
documentação (ADR + bibliografia) com templates e índices prontos, todos
pacotes instalados e validados. Sem isso, **não iniciar Mês 1**.

---

## Fase 1 — Mês 1 (Jul/2026): Construção da base analítica

Marco do edital: **base analítica consolidada (5.570 municípios) + relatório
de progresso #1**.

### 1.1 Exposição — IIEM 2017

- [ ] **(P0)** Recepcionar e auditar arquivo IIEM 2017 da Lupa Social:
  dicionário, codebook, granularidade (município por código IBGE 7 dígitos),
  variáveis (IIE contínuo, três subdimensões, n da coorte).
- [ ] **(P0)** Validar cobertura: 5.570 municípios? Quais ausentes? Cruzar com
  lista oficial IBGE 2017.
- [ ] **(P0)** Construir `iiem_2017` como tibble canônico em
  `data/iiem_2017.parquet`, com `cod_mun_7`, `iiem`, `iiem_acesso`,
  `iiem_idade_serie`, `iiem_proficiencia`, `n_coorte`.
- [ ] **(P1)** Documentar fonte, data de recepção, hash do arquivo recebido em
  `data-raw/iiem/README.md`.

### 1.2 Desfechos — SIM (mortalidade externa)

- [ ] **(P0)** **Tracer bullet (cf. T.6):** rodar o conjunto inteiro abaixo
  (extração → filtros CID → decomposição em causas → ADR-003 correção →
  agregação → validação `pointblank`) primeiro para uma única UF (DF,
  2018–2024). Só escalar para as 27 UFs após todos os contratos passarem.
- [ ] **(P0)** Extrair via `microdatasus::fetch_datasus()` SIM-DO 2018–2024
  (paralelizado por UF, `n_jobs >= 16`).
- [ ] **(P0)** Filtrar `IDADE` 20–29 anos por residência (`CODMUNRES`); CID-10
  capítulo XX (V01–Y98).
- [ ] **(P0)** Decompor desfecho em três subgrupos:
  - Homicídios: `X85–Y09`
  - Suicídios: `X60–X84`
  - Acidentes de transporte: `V01–V99`
- [ ] **(P0)** **🜲** **`[CD→CC]`** Implementar correção de subnotificação e
  indeterminação de intenção segundo Borges & Cano (2017), seguindo Melo et
  al. (2017). Decisão: aplicar correção somente em homicídios? Ou também em
  suicídios? Documentar em ADR. Comparar resultados com e sem correção em
  sensibilidade.
- [ ] **(P0)** Agregar a tibble `obitos_mun_ano_causa` (município × ano ×
  causa).
- [ ] **(P1)** Validar com microdados: spot-check em 5 UFs cruzando com Painel
  de Monitoramento de Mortalidade do MS.
- [ ] **(P0)** **Escala completa:** após tracer bullet aprovado, re-rodar o
  pipeline para as 27 UFs e re-validar contratos `pointblank` na base
  consolidada.

### 1.3 Desfechos — SIH (ICSAP)

- [ ] **(P0)** **Tracer bullet (cf. T.6):** rodar o conjunto inteiro abaixo
  (extração → filtros idade/reinternação → classificação ICSAP via
  `R/icsap_classify.R` → ADR-004 agrupamento em três blocos → agregação →
  validação `pointblank`) primeiro para uma única UF (DF, 2018–2024). Só
  escalar para as 27 UFs após contratos passarem.
- [ ] **(P0)** Extrair via `microdatasus::fetch_datasus()` SIH-RD 2018–2024
  (paralelizado por UF).
- [ ] **(P0)** Filtrar internações em residentes 20–29 anos (`MUNIC_RES`,
  `IDADE`); excluir reinternações conforme literatura ICSAP.
- [ ] **(P0)** Aplicar Lista Brasileira de ICSAP (Portaria SAS/MS 221/2008;
  Alfradique et al., 2009) sobre `DIAG_PRINC`. Implementar como função
  reutilizável em `R/icsap_classify.R` com testes unitários.
- [ ] **(P0)** **🜲** **`[CD→CC]`** Decidir agrupamento dos 19 grupos da Lista
  Brasileira em três blocos analíticos (infecciosas, crônicas, agudas). Não há
  consenso único na literatura — buscar precedentes via PubMed/SciELO MCP,
  registrar mapeamento explícito em ADR e em apêndice do artigo,
  operacionalizar em tabela de-para versionada.
- [ ] **(P0)** Agregar a tibble `icsap_mun_ano_grupo`.
- [ ] **(P1)** Validar com totais TabNet/SIH agregados por UF e ano.
- [ ] **(P0)** **Escala completa:** após tracer bullet aprovado, re-rodar o
  pipeline para as 27 UFs e re-validar contratos `pointblank` na base
  consolidada.

### 1.4 Denominadores populacionais

- [ ] **(P0)** Coletar estimativas IBGE/DATASUS por município, idade simples e
  sexo, 2018–2024.
- [ ] **(P0)** Implementar interpolação linear ancorada em Censos 2010 e 2022
  para anos sem estimativa direta. Documentar método em função
  `R/interpolate_pop.R` com testes unitários.
- [ ] **(P0)** Construir `pop_mun_ano_idade_sexo` — base para todos os
  offsets.
- [ ] **(P1)** Comparar denominadores com publicações do MS para 2 ou 3 anos
  como sanity check.

### 1.5 Covariáveis municipais

- [ ] **(P0)** **Cobertura ESF** — extrair série mensal e-Gestor AB/SISAB
  2018–2024; agregar média anual e média do período. Cuidado: mudanças
  metodológicas no SISAB em 2020 — documentar.
- [ ] **(P0)** **INSE 2017** — INEP (preferência: INSE escolar agregado a
  município com peso por matrícula). Usar `educabR` se já implementar; caso
  contrário, extração manual.
- [ ] **(P0)** **IDHM 2010 + IDHM 2022** (PNUD/Atlas) — registrar limitação se
  IDHM 2022 ainda não estiver publicado em granularidade municipal na data de
  execução.
- [ ] **(P0)** **Taxa de urbanização** — Censo 2022 (preliminar IBGE).
- [ ] **(P1)** **Bolsa Família/Auxílio Brasil/Cadastro Único** — CECAD/MDS,
  proporção de beneficiários sobre população, média 2018–2024.
- [ ] **(P1)** **Coeficiente de Gini municipal** — IPEADATA / PNUD (último
  disponível; provavelmente Censo 2010 — declarar limitação).
- [ ] **(P0)** **Taxa pré-coorte do desfecho** — calcular taxas municipais
  2010–2014 de mortalidade externa e ICSAP em 20–29 anos para uso em ANCOVA.
- [ ] **(P0)** Consolidar `covariaveis_mun.parquet` com chave `cod_mun_7`.

### 1.6 Painel UF (Desenho B)

- [ ] **(P0)** Adquirir IIE estadual 2015/2017/2019/2021 (Lupa Social) —
  ideal: incluir no mesmo pedido formal da Fase 0.
- [ ] **(P0)** Construir desfechos UF × ano em t = c+5 (i.e., desfechos 2020,
  2022, 2024, 2026 — atenção: 2026 indisponível na execução; restringir a
  coortes com t+5 dentro de 2018–2024 ou ajustar lag).
- [ ] **(P0)** **🜲** **`[CD]`** Decidir lag operacional do painel (t+5 vs.
  t+5±1 vs. média móvel). A coorte 2021 → 2026 é problemática para Mês 1 de
  Jul/2026. Possíveis caminhos: (a) restringir painel a coortes 2015 e 2017;
  (b) usar t+3 para 2021; (c) usar média móvel das taxas estaduais. Registrar
  em ADR e justificar. *Bloqueante para Desenho B.*
- [ ] **(P0)** Consolidar `painel_uf.parquet` (após decisão acima).

### 1.7 Componente espacial

- [ ] **(P0)** Carregar shapefiles via
  `geobr::read_municipality(year = 2020)` e `read_state()`; harmonizar com
  chave `cod_mun_7`.
- [ ] **(P1)** Construir matrizes de vizinhança municipais para uso futuro em
  BYM/SAR (`spdep::poly2nb`, `nb2listw`).

### 1.8 Análise descritiva e mapas exploratórios

- [ ] **(P0)** Tabela 1 descritiva (média, mediana, IQR) das principais
  variáveis por macrorregião e por quintil de IIEM.
- [ ] **(P0)** Mapas coropléticos exploratórios: IIEM 2017, taxa de
  mortalidade externa 2018–2024, taxa ICSAP 2018–2024.
- [ ] **(P1)** Bivariate maps (IIEM × cada desfecho) para comunicação inicial.
- [ ] **(P1)** Cálculo de Moran's I global e local (LISA) nos resíduos
  descritivos para diagnosticar autocorrelação espacial residual.

### 1.9 Validação ⛓

- [ ] **(P0)** ⛓ **Gate `pointblank` da base analítica:** ausência de
  duplicatas em `cod_mun_7`; cobertura ≥ 99% dos 5.570 municípios em desfechos
  e covariáveis críticas; intervalos plausíveis em todas as taxas;
  consistência entre denominador e numerador; relatório HTML auto-gerado em
  `outputs/validation/base_v01.html`.
- [ ] **(P0)** ⛓ Code review interno (auto-revisão estruturada com checklist)
  do pipeline de construção.

### 1.10 Entregas Mês 1

- [ ] **(P0)** Base analítica consolidada e versionada.
- [ ] **(P0)** Relatório de progresso #1 (Quarto, 4–6 páginas): bases
  recebidas, decisões metodológicas tomadas, descritivos centrais, próximos
  passos.

---

## Fase 2 — Mês 2 (Ago/2026): Desenho A — Cross-section municipal

Marco do edital: **estimativas principais + relatório de progresso #2**.

### 2.1 Especificação dos modelos principais

- [ ] **(P0)** Especificar modelo Poisson com offset `log(N_m^{20-29})` para
  cada desfecho. Implementação em `fixest::fepois()` com FE de macrorregião +
  cluster por microrregião. Variável principal: IIEM contínuo padronizado
  (z-score).
- [ ] **(P0)** Estimar binomial negativa (`MASS::glm.nb` ou `fixest::fenegbin`)
  e comparar dispersão. Reportar formal teste de sobre-dispersão
  (`AER::dispersiontest`).
- [ ] **(P0)** Especificação ANCOVA: incluir taxa pré-coorte (2010–2014) do
  mesmo desfecho na faixa 20–29 anos como covariável.
- [ ] **(P0)** **🜲** **`[CD]`** Cluster por microrregião — confirmar nível de
  cluster (microrregião IBGE? região imediata? CIR?). Registrar em ADR.
- [ ] **(P0)** Erros-padrão robustos clusterizados
  (`fixest::vcov(cluster = ~ microrregiao)` ou `sandwich::vcovCL`).
- [ ] **(P1)** Especificação alternativa por quintis de IIEM com teste de
  tendência linear (Wald em coeficientes ordinais).

### 2.2 Análise principal — H1 e H2

- [ ] **(P0)** Estimar modelos para cada desfecho:
  - Mortalidade externa total (H1)
  - Homicídios (decomposição H1)
  - Suicídios (decomposição H1)
  - Acidentes de transporte (decomposição H1)
  - ICSAP total (H2)
  - ICSAP infecciosas (decomposição H2)
  - ICSAP crônicas (decomposição H2)
  - ICSAP agudas (decomposição H2)
- [ ] **(P0)** Restringir análise principal a municípios com população > 20
  mil habitantes (≈1.700), seguindo Melo et al. (2017).
- [ ] **(P0)** Reportar IRR (Incidence Rate Ratios) com IC 95% e p-valor;
  padronizar saída via `marginaleffects` ou
  `broom::tidy(exponentiate = TRUE)`.

### 2.3 Sensibilidade inicial

- [ ] **(P0)** **Sensibilidade 1 — todos os 5.570 municípios + suavização
  BYM:** modelo bayesiano hierárquico via `INLA`, com componente espacial
  estruturado (CAR) + não-estruturado (iid) (Blangiardo et al., 2013). Saída:
  posteriores das taxas suavizadas e do efeito do IIEM.
- [ ] **(P0)** **Sensibilidade 2 — exclusão de 2020–2021** (perturbação
  pandêmica): re-estimar modelos principais.
- [ ] **(P1)** **Sensibilidade 3 — modelo SAR** (`spatialreg::lagsarlm` ou via
  INLA).
- [ ] **(P1)** **Sensibilidade 4 — IIEM em logit-IIE** para teste de
  não-linearidade; também modelo com termo quadrático.

### 2.4 Diagnósticos

- [ ] **(P0)** Resíduos: Pearson, deviance; mapa de resíduos para inspeção
  visual de padrão espacial residual.
- [ ] **(P0)** Moran's I dos resíduos (esperar ≈0 após controles). Se não,
  justificar uso de BYM como principal.
- [ ] **(P0)** VIF entre covariáveis (atenção a colinearidade IIEM × INSE ×
  IDHM — provavelmente alta).
- [ ] **(P1)** Influência (Cook's D, leverage) para municípios outliers;
  spot-check.

### 2.5 Validação ⛓

- [ ] **(P0)** ⛓ Replicação interna: rodar pipeline do zero em ambiente limpo
  (Docker ou nova sessão R com `renv::restore()`); coeficientes idênticos.
- [ ] **(P0)** ⛓ **`[CD]`** Auditoria de pré-registro: comparar modelos
  rodados com `analise-pre-especificada.qmd`; toda análise não pré-registrada
  deve ser rotulada como exploratória.

### 2.6 Entregas Mês 2

- [ ] **(P0)** Tabelas de resultados principais (formato publicação).
- [ ] **(P0)** Figuras: forest plot de IRRs por desfecho; mapas de resíduos.
- [ ] **(P0)** Relatório de progresso #2 (Quarto): especificação, resultados
  principais, sensibilidades iniciais, plano de Mês 3.

---

## Fase 3 — Mês 3 (Set/2026): Desenhos B e C + Robustez

Marco do edital: **estimativas validadas e heterogeneidades + relatório de
progresso #3**.

### 3.1 Desenho B — Painel UF com TWFE

- [ ] **(P0)** Estimar painel
  `log E[Y_{u,c+5}] = β·IIE_{u,c} + α_u + γ_c + X'γ + offset` via
  `fixest::fepois` com `fe = c("uf", "coorte")`.
- [ ] **(P0)** Erros-padrão clusterizados por UF (27 clusters → atenção a
  inferência).
- [ ] **(P0)** **Wild bootstrap (Cameron et al., 2008)** via
  `fwildclusterboot::boottest` ou `clubSandwich`.
- [ ] **(P0)** **Wild cluster bootstrap-t (MacKinnon et al., 2023)** — re-rodar
  e comparar com analítico.
- [ ] **(P1)** Testes de robustez do painel: pseudo-trends pré-tratamento
  (placebos com lags); exclusão de UFs influentes.
- [ ] **(P0)** Comparar magnitude do β entre Desenho A e Desenho B — testar
  hipótese H4.

### 3.2 Desenho C — Heterogeneidade

- [ ] **(P0)** **H3 — IIEM × cobertura ESF:** interação contínua e por tercis;
  teste de significância da interação.
- [ ] **(P0)** **IIEM × porte municipal** (5 estratos populacionais conforme
  classificação IBGE).
- [ ] **(P0)** **IIEM × macrorregião** (5 categorias).
- [ ] **(P0)** **IIEM × sexo** — re-estimar modelos separadamente para homens
  e mulheres.
- [ ] **(P0)** Correção de Holm para múltiplas comparações nos testes de
  interação.
- [ ] **(P1)** Visualização das heterogeneidades: predições marginais com
  `marginaleffects::plot_predictions()`.

### 3.3 Robustez avançada

- [ ] **(P0)** **CEM (Iacus, King & Porro, 2012):** balancear municípios em
  quintis extremos do IIEM por porte, macrorregião, IDHM e cobertura ESF;
  estimar ATT pareado. Pacote `MatchIt` ou `cem`.
- [ ] **(P0)** **E-value (VanderWeele & Ding, 2017):** calcular para
  estimativas principais de cada desfecho. Pacote `EValue`.
- [ ] **(P1)** **`[CD→CC]`** **Negative controls outcomes:** identificar 1–2
  desfechos plausivelmente *não* afetados pelo IIEM — discutir viabilidade em
  ADR (com busca de precedentes via MCP). Pode não ser factível neste
  contexto.
- [ ] **(P1)** Análise de **specification curve** (Simonsohn et al., 2020) —
  todas as combinações razoáveis de controles; visualização da estabilidade do
  β.

### 3.4 Validação ⛓

- [ ] **(P0)** ⛓ **`[CD]`** **Reunião crítica de revisão interna**
  (auto-revisão estruturada simulando *adversarial review*): listar 5 ataques
  mais prováveis ao desenho, redigir resposta a cada um. Documentar em
  `decisions/internal-review-mes3.md`.
- [ ] **(P0)** ⛓ **`[CD]`** Comparar painel B com cross-section A: se sinais
  e magnitudes divergem, investigar e documentar — não esconder.

### 3.5 Entregas Mês 3

- [ ] **(P0)** Tabela master de resultados (Desenhos A, B, C, todas as
  robustezes) — uma única tabela longa para conferência.
- [ ] **(P0)** Mapas finais de IIEM e desfechos (qualidade publicação).
- [ ] **(P0)** Relatório de progresso #3.

---

## Fase 4 — Mês 4 (Out/2026): Comunicação científica

Marco do edital: **manuscrito em primeira versão + painel funcional +
relatório de progresso #4**.

### 4.1 Manuscrito

- [ ] **(P0)** **🜲** **`[CD]`** Escolher periódico-alvo entre Revista de
  Saúde Pública (RSP), Cadernos de Saúde Pública (CSP) e Ciência & Saúde
  Coletiva (CSC). Decisão influencia formato (limite de palavras, número de
  tabelas, idioma — RSP aceita inglês, CSP/CSC bilíngue). Registrar em ADR.
- [ ] **(P0)** Estruturar manuscrito Quarto em `manuscripts/` com template do
  periódico (csl, bibliografia BibTeX).
- [ ] **(P0)** **`[CD]`** Redigir **Introdução** com gap claramente definido
  (substituição matrícula → inclusão plena).
- [ ] **(P0)** Redigir **Métodos** com nível de detalhe suficiente para
  replicação completa; incluir link para repositório e pré-registro.
- [ ] **(P0)** Redigir **Resultados** com tabelas e figuras finais; respeitar
  limites do periódico.
- [ ] **(P0)** **`[CD]`** Redigir **Discussão** organizada por: (a) síntese
  dos achados; (b) comparação com literatura (Melo et al., 2017; Cutler &
  Lleras-Muney, 2010; Marmot, 2017); (c) interpretação para políticas
  públicas; (d) limitações; (e) implicações para pesquisa futura.
- [ ] **(P0)** Apêndices: dicionário de variáveis, mapeamento ICSAP,
  especificações alternativas, código mínimo reproduzível.
- [ ] **(P1)** **`[humano]`** Revisão por pares informal: enviar versão
  pré-submissão a 1 ou 2 colegas pesquisadores em saúde coletiva para feedback
  antes da submissão.

### 4.2 Painel interativo

- [ ] **(P0)** Quarto Dashboard em `quarto/dashboard.qmd`:
  - Página 1: visão nacional (mapas IIEM e desfechos)
  - Página 2: explorador municipal (busca por nome/UF, perfil completo)
  - Página 3: heterogeneidades (gráficos interativos por porte, macrorregião,
    ESF)
  - Página 4: metodologia em linguagem acessível
- [ ] **(P0)** Hospedar via GitHub Pages ou Quarto Pub; URL pública e estável.
- [ ] **(P1)** Acessibilidade: alt-text em mapas, contraste WCAG AA, teclado
  navegável.

### 4.3 Materiais auxiliares

- [ ] **(P0)** Refinar todos os mapas finais (paletas color-blind safe,
  projeções coerentes, escala harmonizada entre desfechos).
- [ ] **(P1)** **`[CD]`** Iniciar esboço da nota técnica para gestores (será
  finalizada no Mês 5).

### 4.4 Validação ⛓

- [ ] **(P0)** ⛓ Build limpo do manuscrito: `quarto render` sem warnings;
  bibliografia compilando; cross-refs funcionais.
- [ ] **(P0)** ⛓ Build limpo do dashboard: navegação testada em
  Chrome/Firefox; filtros funcionais.
- [ ] **(P0)** ⛓ Verificar reprodutibilidade end-to-end: clone do repo +
  `renv::restore()` + `targets::tar_make()` + render do manuscrito = manuscrito
  final.

### 4.5 Entregas Mês 4

- [ ] **(P0)** Manuscrito em primeira versão completa.
- [ ] **(P0)** Painel interativo Quarto publicado.
- [ ] **(P0)** Relatório de progresso #4.

---

## Fase 5 — Mês 5 (Nov–Dez/2026): Submissão e entrega final

Marco do edital: **todos os produtos entregues + entrega formal ao edital**.

### 5.1 Submissão do artigo

- [ ] **(P0)** **`[CD]`** Revisão final do manuscrito (autoria solo —
  confirmar).
- [ ] **(P0)** **`[CD]`** Carta de apresentação (cover letter) destacando
  ineditismo e relevância para política pública.
- [ ] **(P0)** Conformidade com checklist STROBE para estudo ecológico.
- [ ] **(P0)** **`[humano]`** Submissão ao periódico-alvo. Registrar data e
  protocolo.
- [ ] **(P1)** **`[humano]`** Posting concomitante em SciELO Preprints ou OSF
  Preprints.

### 5.2 Nota técnica para gestores

- [ ] **(P0)** **`[CD]`** Redigir nota técnica de 8–12 páginas com:
  - Sumário executivo (1 página)
  - Pergunta de pesquisa em linguagem acessível
  - Achados centrais (3–5 bullets, sem jargão estatístico)
  - Mapas-chave (2 ou 3, alta legibilidade)
  - Recomendações de política pública intersetorial (educação ↔ APS)
  - Limitações em linguagem honesta e acessível
  - Como ler o painel interativo
- [ ] **(P0)** Diagramação profissional (Quarto + template institucional ou
  Affinity/Adobe).
- [ ] **(P0)** Versão PDF final em
  `technical-note/iie-saude-jovens-nota-tecnica-v01.pdf`.

### 5.3 Repositório GitHub público

- [ ] **(P0)** Limpeza final: remover branches obsoletos, scripts de sandbox,
  dados sensíveis.
- [ ] **(P0)** README robusto com: descrição, como reproduzir, dependências,
  citação (CITATION.cff), licença, link para pré-registro, link para artigo
  (DOI quando disponível).
- [ ] **(P0)** Tag de release `v1.0.0` com arquivo de release notes.
- [ ] **(P0)** **`[humano]`** DOI do release via Zenodo (integração
  GitHub-Zenodo) — autorizar no Zenodo.
- [ ] **(P1)** Badge de CI/CD passando, badge de licença, badge de DOI no
  README.

### 5.4 Apresentação executiva ao Comitê Técnico

- [ ] **(P0)** Slides Quarto + reveal.js em `slides/comite-tecnico.qmd`:
  - Pergunta e gap (1 slide)
  - Dados e desenho (2 slides)
  - Resultados principais (3–4 slides com mapas e forest plots)
  - Heterogeneidades (1 slide)
  - Robustez (1 slide)
  - Implicações para política (2 slides)
  - Próximos passos (1 slide)
- [ ] **(P0)** **`[humano]`** Ensaio cronometrado da apresentação (≤ 20 min).
- [ ] **(P0)** **`[humano]`** Apresentação ao Comitê.

### 5.5 Entrega formal

- [ ] **(P0)** Pacote final ao edital contendo: manuscrito submetido,
  comprovante de submissão, nota técnica PDF, link do dashboard, link do
  repositório, slides, relatório executivo final.
- [ ] **(P0)** Relatório executivo final consolidando todos os 5 meses.

---

## Eixos transversais (executar continuamente)

### T.1 Qualidade e validação

- [ ] **(P0)** Manter `pointblank` agents para todas as bases derivadas, com
  relatórios HTML auto-publicados em `outputs/validation/`.
- [ ] **(P1)** Testes unitários (`testthat`) para funções críticas em `R/`
  (correção de subnotificação, classificação ICSAP, interpolação populacional).
- [ ] **(P1)** Linter (`lintr`) e estilo (`styler`) verificados em CI.

### T.2 Reprodutibilidade

- [ ] **(P0)** Cada análise rodada via `targets::tar_make()`. Sem scripts
  orfãos no caminho crítico.
- [ ] **(P0)** Snapshots `renv` atualizados após qualquer instalação de
  pacote.
- [ ] **(P1)** Dockerfile testado mensalmente.
- [ ] **(P1)** Tag de versão a cada relatório de progresso entregue.

### T.3 Comunicação e diário de pesquisa

- [ ] **(P1)** **`[CD]`** Manter `lab-notebook.qmd` com entradas datadas:
  decisões, problemas, soluções, hipóteses descartadas. Útil para Discussão do
  artigo e para futura auditoria.
- [ ] **(P2)** Posts curtos em blog ou thread (LinkedIn/X) ao final de cada
  fase, em linguagem acessível — útil para construção de público para o painel
  interativo.

### T.4 Riscos e mitigação

- [ ] **(P0)** **Risco: atraso na liberação do IIEM.** Mitigação: solicitação
  formal já no Mês 0; manter contato semanal com Lupa Social; plano B usando
  indicadores agregados públicos do IIE até liberação.
- [ ] **(P0)** **Risco: SIH-RD ou SIM-DO 2024 não disponíveis em Jul/2026.**
  Mitigação: confirmar disponibilidade na Fase 0; ajustar janela para
  2018–2023 se necessário, com documentação explícita.
- [ ] **(P1)** **Risco: instabilidade do INLA em alguns sistemas.** Mitigação:
  smoke test no Mês 0; ter alternativa em `spatialreg` para SAR.
- [ ] **(P1)** **Risco: alta colinearidade IIEM × INSE × IDHM** levando a
  estimativas instáveis. Mitigação: análise de VIF na Fase 2; especificações
  com cada controle isolado; discussão honesta de identificação no manuscrito.
- [ ] **(P1)** **Risco: lag t+5 do painel UF inviável para coorte 2021** (cf.
  1.6). Mitigação: ADR antes do Mês 1.
- [ ] **(P1)** **Risco: efeito da pandemia COVID-19 confundir resultados
  2020–2021.** Mitigação: análise principal com dados pré e pós-pandemia
  separados como sensibilidade.
- [ ] **(P2)** **Risco: rejeição editorial do periódico-alvo.** Mitigação: ter
  periódico-alvo secundário pré-definido (Mês 4); preprint em OSF/SciELO.

### T.5 Boas práticas científicas

- [ ] **(P0)** **`[CD]`** Toda análise não pré-registrada é rotulada
  explicitamente como **exploratória** no manuscrito.
- [ ] **(P0)** **`[CD]`** Reportar todas as decisões metodológicas relevantes,
  não apenas as que produziram resultados favoráveis.
- [ ] **(P0)** Disponibilizar dados derivados (não os brutos do DATASUS, que
  já são públicos) para replicação imediata.
- [ ] **(P1)** **`[CD]`** Aceitar e responder a feedback adversarial;
  documentar respostas em apêndice ou OSF.

### T.6 Contratos e fail-fast

Princípio: detectar erro na primeira oportunidade possível, parando em vez de
propagar estado corrompido. Três padrões cobrem a maior parte do valor.

- [ ] **(P0)** **Data contracts em todo artefato derivado.** Cada `.parquet`
  produzido pelo pipeline (IIEM, óbitos por causa, ICSAP por grupo,
  denominadores, covariáveis, painel UF) carrega contrato declarado em
  `R/contracts.R` (esquema esperado: nomes de colunas, tipos, invariantes —
  ex.: `cod_mun_7` único, taxas ≥ 0, ano em [2018, 2024]). A função que
  *escreve* o arquivo chama `pointblank::create_agent()` com o contrato e só
  retorna se passar. Falha = parada do pipeline, não warning. Implementar
  como wrapper `R/write_with_contract.R` usado em todos os targets que geram
  artefatos.
- [ ] **(P0)** **Tracer bullet na Fase 1.** Antes de processar 5.570
  municípios ou 27 UFs, rodar o pipeline inteiro em escala 1/27 — uma UF
  pequena (sugerido: DF, dados leves) — desde extração até validação
  `pointblank` final. Só escalar quando o tracer bullet passar todos os
  contratos. Aplicado explicitamente em 1.2 (SIM), 1.3 (SIH) e idealmente em
  1.5 (covariáveis). Custo: ~1/30 do tempo total. Benefício: bugs
  estruturais (classificação CID, joins quebrados, tipos errados) aparecem
  antes do gasto de tempo de máquina e disco em escala completa.
- [ ] **(P0)** **Session handoff manifest entre sessões Code.** Ao final de
  cada sessão, gerar `.claude/sessao-NNN-manifest.json` com: lista de
  artefatos produzidos (caminhos), hash SHA-256 de cada, status `pointblank`
  de cada (`pass` / `fail` / `warn`), commit SHA de fechamento da sessão,
  versão `renv` ativa. Próxima sessão Code começa por *verificar o último
  manifest*: re-hashear arquivos listados, re-rodar `pointblank`, conferir
  commit. Se qualquer item diverge, halt — não toca em nada novo até
  resolver. Implementar `R/build_session_manifest.R` (gera) e
  `R/verify_session_manifest.R` (verifica). Documentar uso em `CLAUDE.md`.

### T.7 Revisões metodológicas periódicas

Princípio: gates técnicos (⛓) verificam execução; gates metodológicos
verificam *direção*. Ao final de cada mês de execução, parar 30 minutos para
perguntar: dado o que sabemos agora, o desenho original ainda é a melhor
resposta à pergunta de pesquisa? Sem este mecanismo, viés de confirmação e
sunk cost operam sem freio em pesquisador solo.

Formato fixo, registrado em `decisions/REV-MNN.md` (paralelo aos ADRs).
Template em `decisions/_template-revisao.md` com cinco campos:
(1) **Estado factual** — o que foi feito; o que mudou desde o último gate;
(2) **Surpresas** — o que descobri que não esperava (técnico, metodológico,
literatura); (3) **Pressupostos do roadmap ainda válidos?** — listar 2–4
pressupostos centrais e marcar `confirma` / `ainda-incerto` / `invalida`;
(4) **Decisão** — `seguir como planejado` / `seguir com ajustes
[especificar]` / `pausar e revisar` / `pivot maior [especificar]`;
(5) **Ações até a próxima revisão.**

- [ ] **(P0)** **REV-M01** ao final do Mês 1 (Jul/2026): base analítica
  consolidada; pressupostos sobre disponibilidade DATASUS, estrutura IIEM,
  cobertura municipal.
- [ ] **(P0)** **REV-M02** ao final do Mês 2 (Ago/2026): estimativas Desenho
  A; pressupostos sobre identificação cross-section, colinearidade,
  magnitude esperada do efeito.
- [ ] **(P0)** **REV-M03** ao final do Mês 3 (Set/2026): Desenhos B e C +
  robustez; pressupostos sobre lag t+5, consistência A↔B, heterogeneidades
  esperadas.
- [ ] **(P0)** **REV-M04** ao final do Mês 4 (Out/2026): manuscrito v1 +
  dashboard; pressupostos sobre periódico-alvo, narrativa do artigo,
  comunicabilidade dos achados.
- [ ] **(P0)** **REV-M05** ao final do Mês 5 (Nov–Dez/2026): submissão e
  entregas; revisão consolidada do projeto inteiro, lições aprendidas,
  agenda de pesquisa futura.

### T.8 Controle de mudanças

Princípio: roadmap é documento vivo, mas mudanças sem método viram caos.
Distinguir três magnitudes de mudança e tratar cada uma diferente; toda
mudança rastreia até a revisão (REV) ou ADR que a motivou.

- [ ] **(P0)** **Convenção de magnitude.** Três tipos de mudança:
  - **Patch** — correção pequena: typo, link quebrado, ajuste de redação,
    marcar checkbox executado. Edita direto, commit normal, **não muda
    versão do roadmap**.
  - **Minor** — adiciona conteúdo sem invalidar plano: nova covariável,
    novo ADR, refinamento de etapa, novo bullet em subseção existente.
    Edita direto, commit referencia REV-MNN ou ADR-NNN, **não muda versão
    do roadmap**.
  - **Major** — muda o plano: pivota hipótese, troca desenho, exclui
    análise central, redefine periódico-alvo. Cria `roadmap-vNN.md` novo,
    com seção dedicada no `CHANGELOG.md` explicitando o que mudou e por
    quê. Roadmap anterior permanece imutável como documento histórico.
- [ ] **(P0)** **`CHANGELOG.md`** na raiz do repositório, formato
  keepachangelog.com, com seções por versão do roadmap. Categorias
  padronizadas: `### Added`, `### Changed`, `### Deprecated`, `### Removed`,
  `### Fixed`. Para `roadmap-v02.md`, `CHANGELOG.md` traz a seção que
  explica todas as diferenças em relação a `v01`.
- [ ] **(P0)** **Rastreabilidade de mudanças.** Toda alteração no roadmap
  referencia a REV-MNN ou ADR-NNN que a motivou. Mensagens de commit em
  formato Conventional Commits:
  - `docs(roadmap): marca 1.2 concluído` (patch)
  - `docs(roadmap): adiciona Gini estadual em 1.5; ref REV-M02` (minor)
  - `docs(roadmap): cria v02; pivota Desenho B para t+3; ref REV-M03`
    (major)
- [ ] **(P0)** **Imutabilidade de versões anteriores.** `roadmap-v01.md`
  nunca é apagado quando `v02` é criado. Versões antigas ficam no repo como
  registro histórico. Útil em auditoria e em revisão por pares ("quando
  decidimos isso?").
- [ ] **(P0)** **Identificadores estáveis.** Numeração de fases e
  subseções (Fase N, N.M) é **permanente** através de versões do roadmap.
  Regras:
  - Conteúdo de item muda → mantém número, edita conteúdo.
  - Bullet novo dentro de subseção existente → adiciona como bullet, sem
    número novo.
  - Subseção nova entre existentes → usa sufixo de letra (`1.5a`, `2.3b`).
  - Item descontinuado → marca `~~deprecated~~` com nota cruzada para
    REV-MNN que motivou; **não remove**.
  Princípio: identificador é endereço permanente; conteúdo evolui. ADRs e
  revisões referenciam itens por número e não devem ser invalidados por
  renumeração.

---

## Marcos críticos (resumo)

| # | Marco | Mês | Tipo |
|:-:|---|:-:|:-:|
| M0 | Repositório, pipeline e pré-registro publicados; IIEM solicitado | Mês 0 | Gate |
| M1 | Base analítica consolidada (5.570 mun.) + Relatório #1 | Mês 1 | Edital |
| M2 | Estimativas Desenho A + Relatório #2 | Mês 2 | Edital |
| M3 | Desenhos B, C e robustez + Relatório #3 | Mês 3 | Edital |
| M4 | Manuscrito v1 + Painel interativo + Relatório #4 | Mês 4 | Edital |
| M5 | Submissão + Nota técnica + Repo + Apresentação | Mês 5 | Edital |

---

## Onde Desktop ganha decisivamente — visão consolidada

Os itens marcados com `[CD]` ou `[CD→CC]` formam um eixo claro: **decisões
metodológicas registradas como ADR + redação acadêmica densa + revisão
crítica**. Concentram-se em três regiões do projeto.

1. **Governança e ADRs** (Fase 0.3 e itens 🜲 ao longo do projeto):
   pré-registro, política de missing, mapeamento ICSAP em 3 blocos, lag do
   painel UF, nível de cluster, escolha de periódico, viabilidade de negative
   controls, correção de subnotificação. São oito ADRs cumulativos no projeto
   inteiro.

2. **Manuscrito — seções narrativas** (Fase 4.1): Introdução, Discussão,
   escolha de periódico. Métodos, Resultados e Apêndices ficam livres porque
   mesclam prosa e técnica em proporções variáveis.

3. **Comunicação para humanos** (Fase 5): cover letter, nota técnica para
   gestores, lab notebook, rotulagem de exploratórias, resposta a feedback
   adversarial.

**Itens humanos indelegáveis:** envio de e-mail à Lupa Social, submissão ao
periódico, posting de preprint, autorização de DOI no Zenodo, ensaio
cronometrado, apresentação ao Comitê, revisão entre colegas. Sete pontos de
fricção institucional ao longo dos 5 meses.

**Todo o resto é livre.** Code é o default razoável para tudo que vira arquivo
executável; Desktop, se você já estiver lá pensando em outra coisa.

---

*Este roadmap é o plano de gestão do projeto. Atualizações cotidianas se fazem
marcando os checkboxes de execução; revisões metodológicas substantivas geram
nova versão (`roadmap-vNN.md`) com changelog próprio.*
