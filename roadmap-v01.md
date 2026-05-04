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
**Versão:** v01 · gerada a partir de `proposta-de-pesquisa-v01.md`

---

## Como usar este roadmap

- **Convenção de checkboxes:** `- [ ]` pendente · `- [x]` concluído · `- [~]`
  em andamento · `- [!]` bloqueado/risco ativo.
- **Prioridade:** `(P0)` crítico para o caminho crítico do cronograma; `(P1)`
  necessário, mas com folga; `(P2)` desejável, executar se sobrar tempo.
- **Decisão metodológica:** itens marcados com `🜲` exigem decisão registrada
  como ADR (Architecture Decision Record) em `decisions/ADR-NNN.md` antes de
  prosseguir. Convenção e template em `CONVENTIONS.md`. Não pular.
- **Gate:** itens marcados com `⛓` são *quality gates* — bloqueiam o avanço
  para a fase seguinte até validação aprovada.
- **Onde fazer** (ver seção a seguir): a maior parte dos itens fica **sem tag**
  — é sua escolha na hora. Tags aparecem apenas onde a escolha não-óbvia
  previne erro caro.
- O roadmap é versionado. Mudanças substantivas geram `roadmap-v02.md`, com
  diff em changelog próprio.

Documentos auxiliares: `GOVERNANCE.md` (princípios), `CONVENTIONS.md`
(formatos e templates), `RISKS.md` (riscos e mitigações), `CHANGELOG.md`
(histórico de mudanças), `CLAUDE.md` (convenções para Claude Code).

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

### 0.1 Repositório e estrutura

- [x] **(P0)** Criar repositório GitHub público `iie-municipal-vs-saude` sob
  licença MIT, com `README.md`, `LICENSE`, `CITATION.cff` e
  `CODE_OF_CONDUCT.md`. *(sessão 012 — repo público criado em
  https://github.com/SidneyBissoli/iie-municipal-vs-saude, branch padrão
  `main`, MIT detectada pelo GitHub a partir do `LICENSE`. Commits
  `7b7507f docs(meta): adiciona README, LICENSE, CITATION.cff e
  CODE_OF_CONDUCT` e `8a113ee docs(roadmap): corrige referência para
  proposta-de-pesquisa-v01.md`. README em PT-BR aponta para proposta,
  GOVERNANCE, CONVENTIONS, RISKS, CHANGELOG e CLAUDE.md; CITATION.cff
  em formato CFF 1.2.0 sem DOI ainda — DOI Zenodo virá no release
  v1.0.0 (Mês 5, item §5.3); CODE_OF_CONDUCT é Contributor Covenant
  2.1 traduzido com contato sbissoli76@gmail.com.)*
- [x] **(P0)** Inicializar projeto R (`projeto-r.Rproj` já existe — auditar)
  com `renv::init()` para isolamento de dependências. *(sessão 001 —
  `renv::activate()` em estado parcial preexistente; lockfile sincronizado
  após hydrate, R 4.5.3.)*
- [x] **(P0)** Definir estrutura de diretórios:
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
  - `decisions/` (ADRs e REVs)
  - `bibliography/` (referências, fila de leitura, notas de artigos)
  - `assets/` (derivados versionados que servem como insumo para redação
    e gestão do corpus — ex.: matriz de síntese da bibliografia em CSV;
    XLSX correspondente é derivado e não versionado)
  - `tests/` (testes de funções e validações `pointblank`)
  - `outputs/` (tabelas, figuras, mapas finais — versionados quando estáveis)
- [x] **(P0)** Adicionar `.gitignore` excluindo `data-raw/`, `data/`,
  `_targets/objects/`, `*.Renviron`, `.Rhistory` (já presente — auditar).
  *(sessão 001 — também ignora `.claude/`.)*
- [x] **(P0)** Mover `proposta-de-pesquisa.{md,docx,html}` da raiz para
  `manuscripts/`.
- [x] **(P0)** Criar `CLAUDE.md` no root do repositório com instruções
  persistentes para Claude Code: convenções tidyverse e pipe `|>`, comentários
  de código em inglês, estrutura de diretórios canônica, comandos frequentes
  (`targets::tar_make()`, `quarto render`, `renv::snapshot()`), gates
  pré-commit (lint + `testthat` + `pointblank`), localização dos ADRs em
  `decisions/` e das notas de leitura em `bibliography/`, política de
  não-commit em `data-raw/` e `data/`. Atualizar sempre que estrutura ou
  convenções mudarem.
- [~] **(P1)** Configurar `.lintr` e `styler` para padronização tidyverse;
  commit hook via `precommit` package. *(sessão 001 — `.lintr` configurado
  e validado (0 lints em `R/`); `styler` instalado; precommit hook ainda
  pendente. **Sessão Code 011** — `cyclocomp` adicionado ao ambiente
  (dependência implícita de `cyclocomp_linter` no `.lintr`; sem ele
  o linter falhava silenciosamente, o que invalidava parcialmente o
  "0 lints" da sessão 001; lint atual real = 0 após fix de 1 char em
  `R/build_synthesis_matrix.R:54`). Decisão pendente sobre `styler`:
  `style_dir("R/", dry = "on")` propõe mudanças em 5 arquivos,
  incluindo reestruturação de `tryCatch` em `build_session_manifest.R`;
  diff completo registrado em `.claude/sessao-011.md` §10. Caminhos:
  (a) aplicar styler em sessão dedicada com commit
  `style: aplica tidyverse_style em R/`; (b) ajustar `.lintr` para
  acomodar o estilo manual do projeto.)*

### 0.2 Reprodutibilidade e CI/CD

- [x] **(P0)** Implementar esqueleto do pipeline `targets` em `_targets.R` com
  placeholders para cada fase analítica. *(sessão 001 — `format = "qs2"`
  porque `qs` não tem build em R 4.5.)*
- [x] **(P0)** Configurar GitHub Actions: workflow `R-CMD-check` para funções
  de `R/`; workflow `targets-check` para validação de pipeline (smoke test em
  subset municipal).
- [x] **(P1)** Configurar `renv` com snapshot inicial; documentar `R.version`
  e SO de desenvolvimento. *(sessão 001 — R 4.5.3 / Windows 11; lockfile
  com 128 pacotes, `synchronized: TRUE`.)*
- [x] **(P1)** Criar Dockerfile reprodutível (rocker/verse + INLA) — opcional,
  mas útil para revisores. *(sessão 001 — `rocker/geospatial:4.5.3` + INLA
  via repo oficial.)*
- [ ] **(P2)** Configurar `pkgdown` para documentação navegável das funções
  utilitárias.

### 0.3 Governança da pesquisa

- [ ] **(P0)** **🜲** **`[CD]`** Decidir e registrar em ADR a estratégia de
  **pré-registro**: OSF Registries vs. AsPredicted vs. submissão de
  pré-registro como manuscrito. Recomendado: OSF antes do recebimento dos dados
  desfecho ainda não inspecionados (parte do SIM/SIH 2018–2024 já é pública —
  discutir limite de pré-registro honesto).
- [ ] **(P0)** **`[CD→humano]`** Solicitação formal do IIEM 2017 à Lupa
  Social, conforme metodologia Paciencia & Ismail (2024): redigir e iterar
  carta (escopo, finalidade, destinação de dados, declaração de
  não-redistribuição, citação acadêmica do método); enviar do e-mail
  institucional.
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

- [x] **(P0)** Validar instalação de: `tidyverse`, `targets`, `tarchetypes`,
  `pointblank`, `quarto`, `microdatasus`, `educabR`, `geobr`, `sf`, `fixest`,
  `MASS`, `pscl`, `sandwich`, `lmtest`, `marginaleffects`, `did`, `INLA`,
  `spdep`, `R-INLA` deps. *(sessão 001 — todos OK; `qs` substituído por
  `qs2` por incompatibilidade com R 4.5; `fwildclusterboot` falhou em CRAN
  e GitHub por falta de `summclust` — pendente até Fase 3, alternativa
  `clubSandwich` instalada.)*
- [x] **(P0)** Validar acesso ao DATASUS via `microdatasus` (teste com
  extração mínima de SIM 2023, 1 UF). *(sessão 001 — DF, 14 079 óbitos em
  4.1s.)*
- [x] **(P0)** Validar pacote `educabR` próprio (versão CRAN 0.9.1 declarada
  na proposta — confirmar disponibilidade pública ou usar versão dev local).
  *(sessão 001 — `educabR 0.9.1` carrega de CRAN.)*
- [ ] **(P1)** Configurar paralelismo:
  `future::plan(multisession, workers = 16)` para `microdatasus`;
  `data.table::setDTthreads()` para operações de agregação.
- [x] **(P2)** Smoke test de INLA com modelo BYM em subset (1 UF) para
  detectar problemas de instalação cedo. *(sessão 001 — INLA 25.10.19,
  BYM em grade 5×5 ajustado em 0.9s no Windows.)*

### 0.5 Convenções de documentação

Dois sistemas de captura de conhecimento, ambos versionados no repositório.
**ADRs** registram decisões internas do projeto (por que escolhemos X);
**bibliografia** registra conhecimento externo capturado da literatura (o que
os outros já sabem). São complementares e operam com convenções paralelas.

#### ADRs (Architecture Decision Records)

- [x] **(P0)** Estabelecer convenção de **ADRs** em `decisions/`. Convenção
  detalhada em `CONVENTIONS.md`. Bullets operacionais:
  - Template em `decisions/_template.md` com cinco campos (Nygard, 2011).
  - Imutabilidade após `accepted`; mudança de decisão cria novo ADR
    `Supersedes ADR-XXX`.
  - Uma decisão por ADR.
  - Índice em `decisions/README.md` gerado por `R/build_adr_index.R`.
  - **Pré-mapeados:** oito ADRs identificados pelos itens 🜲 — ADR-001
    pré-registro (0.3); ADR-002 política de missing (0.3); ADR-003
    correção de subnotificação (1.2); ADR-004 agrupamento ICSAP em três
    blocos (1.3); ADR-005 lag do painel UF (1.6); ADR-007 nível de
    cluster (2.1); ADR-008 viabilidade de negative controls (3.3);
    ADR-009 periódico-alvo (4.1). O número **ADR-006** foi inicialmente
    materializado em fase intermediária da sessão 010 sob diagnóstico
    factualmente errado (substituições manuais pós-export do `.bib`,
    Caminho B do BBT) e o arquivo correspondente foi removido pelo
    pesquisador via `git rm` na continuação do chat. Em seguida o
    número ADR-006 foi reaproveitado na mesma sessão para a errata
    interpretativa do ADR-005
    (`ADR-006-painel-uf-erratum-IIE-estadual-2021-2023.md`), já que
    o pré-mapeamento original do ADR-005 deixava o número 6
    propositalmente livre (sequência pulava de ADR-005 para ADR-007).
    Ver `CHANGELOG.md`, seções `Fixed (sessão 010)`, `Removed
    (sessão 010, pós-encerramento)` e `Added (sessão 010,
    pós-encerramento)`.

#### Bibliografia e notas de leitura

- [x] **(P0)** Estabelecer estrutura em `bibliography/`. Convenção detalhada
  em `CONVENTIONS.md`. Bullets operacionais:
  - `bibliography/reading-list.md`, `references.bib`, `notes/`,
    `_note-template.md`, `README.md` criados na sessão 001.
  - `bibliography/research-notes/` criada na sessão 006 para notas de
    pesquisa temáticas (cruzam ≥2 fontes). Distinção operacional em
    `bibliography/research-notes/README.md`.
  - **Bootstrap executado na sessão 006** (sequência obrigatória,
    sem atalhos): (1) referências centrais importadas no Zotero pelo
    pesquisador — Paciencia & Ismail (2024) IIEM (metodologia da
    exposição); Melo et al. (2017) ICSAP-educação; Borges & Cano (2017)
    subnotificação; Alfradique et al. (2009) Lista Brasileira; Fernandes
    et al. (2024) evidência prévia da rede IIE; Cutler & Lleras-Muney
    (2010); Marmot (2017); Blangiardo et al. (2013) BYM; Rue, Martino &
    Chopin (2009) INLA; Cameron et al. (2008) e MacKinnon et al. (2023)
    wild bootstrap; Callaway & Sant'Anna (2021) TWFE multi-período;
    Iacus, King & Porro (2012) CEM; VanderWeele & Ding (2017) E-value.
    Referências exclusivamente-pacote-R (Bergé 2018 fixest; Bissoli 2026
    educabR; Landau 2021 targets; Pereira et al. 2019 geobr; Saldanha
    et al. 2019 microdatasus) ficaram fora desta lista — serão importadas
    apenas se/quando forem necessárias para a seção de Software no
    manuscrito final;
    (2) plugin BetterBibTeX configurado no Zotero com convenção de
    citation key estável (`authEtAl.lower + year + shorttitle.lower`);
    (3) exportado como `.bib` para `bibliography/references.bib`;
    (4) `reading-list.md` ainda não populado — pendente para sessão
    futura, lendo as citation keys diretamente de `references.bib`.
  - **Pendências do bootstrap.** Resolvidas na sessão 010 via
    **Caminho A** do BBT (override no campo Extra do Zotero, sintaxe
    canônica `Citation Key: <valor>`, reexportação). Operação
    realizada pelo pesquisador antes do início da sessão 010. Estado
    canônico do `references.bib` verificado por leitura completa do
    arquivo: as 6 chaves alvo estão presentes
    (`azevedoetal2021simulatingpotentialimpacts`,
    `pacienciaismail2025indiceinclusaoeducacional`,
    `luposocial2026inclusaoeducacionalpobreza`,
    `chaisemartinetal2025differenceindifferencescontinuoustreatments`,
    `fernandesetal2025evolucaodesempenhoeducacional`,
    `fernandesetal2024relacaoindiceinclusaoeducacional`); nenhum campo
    `annotation` redundante remanescente. Plano de fallback Caminho B
    foi cogitado, materializado em fase intermediária, e cancelado
    arquiteturalmente; remoção dos artefatos órfãos concluída pelo
    pesquisador via `git rm` na continuação do chat — ver
    `CHANGELOG.md` seção `Removed (sessão 010, pós-encerramento)`.
    Sem item operacional residual.
  - **Referências adicionais identificadas em revisão crítica
    (sessão 003)** — verificadas individualmente via Consensus, PubMed,
    ScienceDirect e páginas dos editores. A serem incluídas na revisão
    da proposta antes do prazo prorrogado de 08/mai/2026 e
    simultaneamente importadas no Zotero. Três frentes:
    - **Fragilidade do Desenho B (TWFE):** Goodman-Bacon (2021)
      *J Econometrics* 225(2):254-277, DOI 10.1016/j.jeconom.2021.03.014
      — decomposição de Bacon; Chaisemartin & D'Haultfœuille (2020)
      *AER* 110(9):2964-96, DOI 10.1257/aer.20181169 — pesos negativos
      do TWFE; Goin & Riddell (2023) *Epidemiology* 34(4):535-543,
      DOI 10.1097/EDE.0000000000001611, PMID 36943806 — comparação
      TWFE vs. CS-DiD em policy evaluation com simulação;
      Wooldridge (2025) *Empirical Economics* 69(5):2545-2587,
      DOI 10.1007/s00181-025-02807-z — ETWFE/Mundlak (versão publicada,
      substituiu working paper SSRN 3906345 de 2021); Callaway,
      Goodman-Bacon & Sant'Anna (2024) NBER WP 32117,
      DOI 10.3386/w32117 — DiD com tratamento contínuo (verificada
      sessão 005); Chaisemartin, D'Haultfœuille, Pasquier, Sow &
      Vazquez-Bare (2025) arXiv:2201.06898v3,
      DOI 10.48550/arXiv.2201.06898 — DiD para tratamento contínuo
      distribuído em todos os períodos (versão atualizada agosto/2025;
      substituiu v2 de 2022/2023 verificada na sessão 005).
    - **Empirismo brasileiro próximo:** Macinko & Harris (2015) *NEJM*
      372(23):2177-2181, DOI 10.1056/NEJMp1501140, PMID 26039598 — ESF
      como modelo APS (note: dois autores, não et al.); Hone et al.
      (2017) *Health Affairs* 36(1):149-158, DOI 10.1377/hlthaff.2016.0966,
      PMID 28069858 — expansão ESF e mortalidade evitável em painel de
      1.622 municípios (2000-2012); Hone et al. (2019) *Lancet Global
      Health* 7(11):e1575-e1583, DOI 10.1016/S2214-109X(19)30409-7,
      PMID 31607469 — recessão e mortalidade adulta em 5.565 municípios
      (note: autores NÃO acharam efeito em 15-29 anos, fato relevante
      para discussão); Ferreira-Batista et al. (2023) *Health Economics*
      32(7):1504-1524, DOI 10.1002/hec.4676, PMID 37010114 —
      heterogeneidade do ESF por intensidade; Ferreira-Batista et al.
      (2022) *Economics & Human Biology* 46:101143,
      DOI 10.1016/j.ehb.2022.101143 — ESF e saúde adulta em áreas
      metropolitanas (expansão do corpus na sessão 006); Pinto Junior
      et al. (2018) *Cad Saúde Pública* 34(2):e00133816,
      DOI 10.1590/0102-311x00133816 — ESF e ICSAP em <1 ano (Bahia, 417
      municípios, painel 2000-2012; em português).
    - **Contexto pandêmico sobre IIE/coorte 2021:** Lichand et al. (2022)
      *Nature Human Behaviour* 6(8):1079-1086,
      DOI 10.1038/s41562-022-01350-6, PMID 35618779 — aprendizagem
      remota e evasão em SP; Azevedo et al. (2021)
      *World Bank Research Observer* 36(1):1-40, DOI 10.1093/wbro/lkab003 —
      simulação global de perda de aprendizagem (note: 2021, não 2020).
    - **Adicionada na sessão 006:** Fernandes, Felício & Saad (2024)
      *A Evolução do Desempenho Educacional dos Jovens Brasileiros ao
      Final da Educação Básica*, Instituto Natura/Metas Sociais — fonte
      metodológica primária do IIE estadual, especialmente da imputação
      adotada na coorte 2019 (supressão de idade no SAEB 2019).
      Verbatim e análise em
      `bibliography/research-notes/saeb-2019-idade.md`. URL:
      https://www.institutonatura.org/wp-content/uploads/2025/04/20240314_IIE-e-a-Evolucao-do-Desempenho-da-Educacao-Basica.pdf
      (PDF) ou
      https://github.com/lupa-social/iie-indice-de-inclusao-educacional
      (repositório).
    Estas referências justificam edições na proposta nas §§ 1, 4.1, 4.2 e
    4.3. Coordenar inclusão aqui (Zotero) com a revisão de proposta.

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
- [ ] **(P0)** Validar cobertura: expectativa de ~4.775 municípios
  (Paciencia & Ismail, 2024 — exclusão estrutural pelo filtro de <10
  matrículas em 2008 da coorte de 2000); confirmar n exato do arquivo
  recebido e identificar quais ausentes; cruzar com lista oficial IBGE
  2017.
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

- [ ] **(P0)** Baixar IIE estadual 2015/2017/2019/2021 do repositório
  público da Lupa Social no GitHub (`iie_geral_2015_2021.xlsx` + arquivos
  `.rds` complementares). Snapshot em `data-raw/lupa-social/`, com
  proveniência (URL, SHA do commit, hash do arquivo) registrada no README
  da pasta. Sem necessidade de pedido formal — dado é público, e o edital
  reconhece explicitamente.
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

Riscos identificados estão registrados em `RISKS.md` (documento vivo, sem
versionamento formal). Revisar `RISKS.md` ao final de cada REV mensal e
atualizar conforme novos riscos aparecem.

### T.5 Boas práticas científicas

- [ ] **(P0)** Disponibilizar dados derivados (não os brutos do DATASUS, que
  já são públicos) para replicação imediata.

Princípios de integridade científica em `GOVERNANCE.md`.

### T.6 Contratos e fail-fast

Princípios em `GOVERNANCE.md`. Bullets operacionais:

- [~] **(P0)** **Data contracts em todo artefato derivado.** Cada `.parquet`
  produzido pelo pipeline (IIEM, óbitos por causa, ICSAP por grupo,
  denominadores, covariáveis, painel UF) carrega contrato declarado em
  `R/contracts.R`. Função que escreve o arquivo chama
  `pointblank::create_agent()` com o contrato e só retorna se passar. Falha
  = parada do pipeline. Implementar como wrapper `R/write_with_contract.R`
  usado em todos os targets que geram artefatos. *(sessão 001 — wrapper
  `R/write_with_contract.R` implementado e testado; placeholders dos seis
  contratos em `R/contracts.R`; corpo de cada contrato será preenchido na
  sessão da Fase 1 que constrói o artefato correspondente.)*
- [ ] **(P0)** **Tracer bullet na Fase 1.** Antes de processar 5.570
  municípios ou 27 UFs, rodar o pipeline inteiro em escala 1/27 — uma UF
  pequena (DF) — desde extração até validação `pointblank` final. Só
  escalar quando o tracer bullet passar todos os contratos. Aplicado em
  1.2 (SIM), 1.3 (SIH) e idealmente em 1.5 (covariáveis).
- [x] **(P0)** **Session handoff manifest entre sessões Code.** Ao final de
  cada sessão, gerar `.claude/sessao-NNN-manifest.json` com lista de
  artefatos produzidos, hash SHA-256, status `pointblank`, commit SHA,
  versão `renv` ativa. Próxima sessão Code começa por verificar o último
  manifest. Implementar `R/build_session_manifest.R` (gera) e
  `R/verify_session_manifest.R` (verifica). Documentar uso em `CLAUDE.md`.
  *(sessão 001 — ambas funções implementadas, 18 expectativas em
  `tests/testthat/` passando; uso documentado em `CLAUDE.md` §0 e §7;
  manifest da própria sessão 001 verificado com `pass`.)*

### T.7 Revisões metodológicas periódicas

Princípios e formato em `GOVERNANCE.md` e `CONVENTIONS.md`. REVs registradas
em `decisions/REV-MNN.md` ao final de cada mês de execução.

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

Princípios e regras em `GOVERNANCE.md` e `CONVENTIONS.md`.

- [x] **(P0)** Convenção de magnitude (patch / minor / major) aplicada a
  toda mudança no roadmap.
- [x] **(P0)** `CHANGELOG.md` na raiz, formato keepachangelog.com.
- [x] **(P0)** Toda alteração no roadmap referencia REV-MNN ou ADR-NNN que a
  motivou. Mensagens de commit em formato Conventional Commits.
- [x] **(P0)** Versões anteriores do roadmap nunca apagadas.
- [x] **(P0)** Identificadores de seção (Fase N, N.M) permanentes através de
  versões.

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
