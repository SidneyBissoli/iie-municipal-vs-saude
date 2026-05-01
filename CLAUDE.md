# CLAUDE.md

Instruções persistentes para Claude Code neste repositório. Este documento é
**fonte da verdade** para convenções de código, layout e fluxo de trabalho.
Deve ser lido **antes** de qualquer ação em uma sessão Code. Atualizar sempre
que estrutura ou convenções mudarem (commit `docs(claude): ...`).

---

## 0. Antes de começar qualquer trabalho

**Verificar o manifest da sessão anterior.** Toda sessão Code começa com:

```r
source("R/verify_session_manifest.R")
verify_last_session_manifest()
```

Se a função retornar `pass`, prosseguir. Se retornar `fail` ou erro, **parar
imediatamente** e investigar — não tocar em nada novo até que a divergência
esteja explicada (hash divergente, contrato `pointblank` quebrado, commit
SHA fora de sincronia, etc.). Detalhes em §7 (Manifest de sessão).

Ler também `roadmap-v01.md` (raiz) para escopo da sessão e `decisions/` para
ADRs/REVs ativos relevantes.

---

## 1. Convenções de código (R)

- **Estilo:** tidyverse (`styler::style_pkg()` antes de commitar). `.lintr`
  na raiz reflete a configuração canônica.
- **Pipe:** sempre `|>` (base R, R ≥ 4.1). Não usar `%>%`.
- **Idioma:** **comentários e nomes de objetos em código sempre em inglês**.
  Conteúdo de documentos científicos (ADRs, REVs, manuscritos, nota técnica,
  notas de leitura) pode ser em português — depende do documento.
- **Atribuição:** `<-` (não `=`).
- **Strings:** aspas duplas `"..."`.
- **Larguras:** 80 colunas. Quebra com indentação alinhada.
- **Funções pequenas e puras.** Cada função em `R/` exporta uma única
  responsabilidade; testes correspondentes em `tests/testthat/test-<nome>.R`.
- **Nada de `library()` em scripts de pipeline.** Pacotes vão no
  `tar_option_set(packages = ...)` em `_targets.R` ou nos `NAMESPACE`-style
  imports `pkg::fun()` dentro das funções.

---

## 2. Estrutura de diretórios canônica

**Todas as pastas têm nomes em inglês.** Não traduzir, não criar variantes em
português.

```
.
├── data-raw/             # raw inputs (DATASUS, IIEM, INSE, IDHM); NOT versioned
├── data/                 # derived intermediates (.parquet); NOT versioned, reproducible
├── R/                    # utility functions (one responsibility each)
├── _targets/             # targets cache (objects/ ignored; metadata kept)
├── analysis/             # one-off analyses, sandboxes
├── quarto/               # reports and dashboard
├── manuscripts/          # proposal, paper drafts, preprints
├── technical-note/       # PDF for policymakers
├── slides/               # executive presentation
├── decisions/            # ADRs (ADR-NNN-*.md) and REVs (REV-MNN.md)
├── bibliography/         # references.bib + notes/<key>.md
├── tests/                # testthat + pointblank fixtures
├── outputs/              # final tables, figures, validation HTML
├── .github/workflows/    # GitHub Actions CI
├── .claude/              # Claude Code session manifests + reports (LOCAL only)
├── _targets.R            # pipeline definition
├── CLAUDE.md             # this file
├── CHANGELOG.md          # keepachangelog.com format
├── README.md             # project overview
├── LICENSE               # MIT
├── CITATION.cff          # citation metadata
├── roadmap-v01.md        # current execution plan
├── renv.lock             # R dependency snapshot
├── .lintr                # lint config
├── .gitignore
├── Dockerfile            # rocker/verse + INLA reproducibility image
└── projeto-r.Rproj
```

**Política de não-commit:** `data-raw/` e `data/` ficam fora do git. Dados
brutos (DATASUS, IIEM da Lupa Social) não são redistribuíveis; intermediários
são reproduzíveis pelo pipeline. Apenas `.gitkeep` e eventuais `README.md`
documentando origem dos arquivos são versionados.

---

## 3. Comandos frequentes

Da raiz do projeto (sessão R):

```r
# Restaurar dependências exatas
renv::restore()

# Snapshot após instalar pacote novo
renv::snapshot()

# Rodar pipeline inteiro
targets::tar_make()

# Rodar target específico
targets::tar_make(names = "obitos_mun_ano_causa")

# Inspecionar grafo de dependências
targets::tar_visnetwork()

# Render Quarto (manuscrito ou dashboard)
quarto::quarto_render("quarto/report-mes-1.qmd")

# Build dos índices ADR/REV e bibliografia
source("R/build_adr_index.R");          build_adr_index()
source("R/build_bibliography_index.R"); build_bibliography_index()
```

Da raiz do projeto (shell):

```bash
quarto render quarto/dashboard.qmd
```

---

## 4. Gates pré-commit

Antes de cada commit, rodar (ordem):

1. **Lint:** `lintr::lint_dir("R/")` — zero warnings.
2. **Style:** `styler::style_dir("R/")` — sem mudanças pendentes.
3. **Tests:** `testthat::test_dir("tests/testthat")` — todos passando.
4. **Contracts:** se algum target produziu artefato em `data/`, rodar
   `pointblank` no contrato correspondente em `R/contracts.R` — `pass`.

CI roda os mesmos gates em `.github/workflows/R-CMD-check.yaml` e
`targets-check.yaml`.

---

## 5. ADRs e revisões metodológicas (REVs)

- **ADRs** ficam em `decisions/ADR-NNN-slug.md`. Convenção Nygard: cinco
  campos (Título, Status, Contexto, Decisão, Consequências). Template em
  `decisions/_template.md`. Status `accepted` é imutável; mudança de
  decisão cria ADR novo que `Supersedes ADR-XXX`. Detalhes em
  roadmap-v01.md §0.5.
- **REVs** (revisões metodológicas mensais) ficam em `decisions/REV-MNN.md`.
  Cinco campos: Estado factual, Surpresas, Pressupostos válidos?, Decisão,
  Ações. Template em `decisions/_template-revisao.md`. Detalhes em
  roadmap-v01.md §T.7.
- Índice unificado em `decisions/README.md`, gerado por
  `R/build_adr_index.R` (varre `ADR-*.md` e `REV-*.md`).

**Antes de implementar item marcado com 🜲 no roadmap**, verificar se o ADR
correspondente já está `accepted`. Se não, parar e sinalizar — a decisão
metodológica precede a implementação.

---

## 6. Bibliografia e notas de leitura

- `bibliography/references.bib` — gerado por export do BetterBibTeX (Zotero).
  **Não editar à mão.** Citation keys são as do Zotero (`auth.lower + year +
  shorttitle.lower`, travadas).
- `bibliography/reading-list.md` — fila de leitura indexada pelas citation
  keys do `references.bib`.
- `bibliography/notes/<citation-key>.md` — uma nota por artigo lido,
  seguindo `bibliography/_note-template.md`. Nome do arquivo = citation key
  exata do `references.bib`. PDFs ficam no Zotero, não no repo.
- Índice em `bibliography/README.md`, gerado por
  `R/build_bibliography_index.R` (cruza `references.bib` com `notes/`).

**Citation keys provisórias inventadas a partir de autor+ano são proibidas.**
Sempre exportar do Zotero antes de adicionar uma referência ao
`reading-list.md`.

---

## 7. Manifest de sessão (T.6 do roadmap)

Cada sessão Code abre verificando o manifest da sessão anterior e fecha
gerando o manifest da própria sessão. Isso ancora reprodutibilidade entre
sessões: se algo foi corrompido entre uma sessão e outra (edição manual,
restore ruim, falha no `renv`), a divergência aparece imediatamente.

**Funções:**

- `R/build_session_manifest.R` exporta `build_session_manifest(session_id,
  artifacts)`. Gera `.claude/sessao-NNN-manifest.json` com timestamp ISO
  8601, commit SHA do HEAD, hash do `renv.lock`, e para cada artefato
  listado: caminho relativo, `sha256`, status `pointblank` (`pass` /
  `fail` / `warn` / `n/a`), tamanho em bytes.
- `R/verify_session_manifest.R` exporta `verify_last_session_manifest()`.
  Encontra o `.json` mais recente em `.claude/`, re-hasha, re-roda
  `pointblank` em cada artefato, compara commit SHA. Retorna report
  estruturado e lança erro se qualquer item diverge.

**Regra de uso:**

- **Início de sessão:** `verify_last_session_manifest()`. Se erro, parar e
  investigar antes de qualquer outra coisa.
- **Fim de sessão:** `build_session_manifest(session_id = "NNN", artifacts
  = c(...))` listando todo artefato produzido (código, dados derivados,
  ADRs, relatórios). Commit final inclui o `commit_sha` correspondente no
  manifest.

---

## 8. Controle de mudanças (T.8 do roadmap)

Três magnitudes de mudança no roadmap, com tratamento distinto:

| Magnitude | Quando | Ação | Versão do roadmap |
|---|---|---|:-:|
| **patch** | typo, link quebrado, marcar checkbox | edita direto | inalterada |
| **minor** | adiciona conteúdo sem invalidar plano (nova covariável, novo ADR, refinamento) | edita direto, commit referencia REV-MNN ou ADR-NNN | inalterada |
| **major** | muda o plano (pivota hipótese, troca desenho, redefine periódico) | cria `roadmap-vNN.md` novo, com seção dedicada no `CHANGELOG.md` | nova versão |

**Identificadores estáveis.** Numeração de fases e subseções (Fase N, N.M)
é **permanente** entre versões. Item descontinuado vira `~~deprecated~~`
com nota cruzada — não se remove. Subseção nova entre existentes usa sufixo
de letra (`1.5a`, `2.3b`).

**Imutabilidade.** `roadmap-v01.md` nunca é apagado quando v02 é criado.

**Mensagens de commit em formato Conventional Commits**, com referência a
REV-MNN ou ADR-NNN quando aplicável:

```
docs(roadmap): marca 1.2 concluído                              # patch
docs(roadmap): adiciona Gini estadual em 1.5; ref REV-M02       # minor
docs(roadmap): cria v02; pivota Desenho B para t+3; ref REV-M03 # major

feat(R): adiciona icsap_classify() com testes
fix(targets): corrige join órfão em painel_uf
test(R): cobre interpolate_pop() em ano-de-Censo
chore(renv): snapshot após instalar fwildclusterboot
```

`CHANGELOG.md` na raiz acumula mudanças entre versões do roadmap, formato
keepachangelog.com.

---

## 9. Quando há tensão entre Code e Desktop

Itens marcados com `[CD]` no roadmap são preferencialmente feitos em Claude
Desktop (decisão metodológica densa, ADR, redação acadêmica). Itens
`[CD→CC]` decidem em Desktop e implementam em Code. `[humano]` não é
delegável.

**Em sessão Code, se o roadmap pede um item `[CD]`:**

- Se for curto e já tem decisão clara, executar.
- Se exigir reflexão metodológica ou redação narrativa, **parar e sinalizar
  ao pesquisador** — escopo mais limpo em Desktop.

---

## 10. Acesso a dados sensíveis

- **DATASUS** (SIM, SIH, CNES, SINASC) — públicos, mas pesados. Acesso via
  `microdatasus::fetch_datasus()` com paralelismo `future::plan(multisession,
  workers >= 16)`.
- **IIEM da Lupa Social** — fornecido mediante solicitação formal, sob termo
  de não-redistribuição. Arquivo bruto fica em `data-raw/iiem/` (gitignored)
  com `README.md` documentando data de recepção, hash SHA-256 e origem.
- **Não commitar** nada de `data-raw/` nem de `data/`. Verificar antes de
  cada `git add`.
