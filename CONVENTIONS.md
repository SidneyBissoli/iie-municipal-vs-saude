# CONVENTIONS — Convenções técnicas de formato e nomenclatura

Este documento define formatos, templates, nomenclaturas e padrões técnicos
do projeto. Princípios e razões pelos quais essas convenções existem ficam
em `GOVERNANCE.md`.

---

## Notação do roadmap

**Checkboxes:**
- `- [ ]` pendente
- `- [x]` concluído
- `- [~]` em andamento
- `- [!]` bloqueado / risco ativo

**Prioridade:**
- `(P0)` crítico para o caminho crítico do cronograma
- `(P1)` necessário, mas com folga
- `(P2)` desejável, executar se sobrar tempo

**Símbolos:**
- `🜲` decisão metodológica que exige ADR registrado em `decisions/` antes
  de prosseguir
- `⛓` quality gate; bloqueia avanço para a fase seguinte até validação
  aprovada

**Tags de execução:**
- `[CD]` preferir Claude Desktop (decisão metodológica densa, ADR, redação
  acadêmica, revisão crítica)
- `[CD→CC]` decidir em Desktop, implementar em Code
- `[humano]` não delegável a Claude
- *(sem tag)* escolha do pesquisador na hora; default Code para arquivos
  executáveis

Razões para a tipologia em `GOVERNANCE.md` § Onde fazer.

---

## Format markdown do source

Linhas quebradas em ~80 colunas para edição confortável. Em
markdown (CommonMark / GFM / Pandoc / Quarto), quebras de linha simples
dentro de um mesmo parágrafo ou bullet são tratadas como espaço na
renderização HTML — texto flui normalmente como se fosse uma linha só.

Para forçar quebra de linha visível no HTML, usa-se `<br>` no fim da linha
(ver bloco de metadados do cabeçalho do roadmap) ou parágrafo separado por
linha em branco. Continuação de bullet em múltiplas linhas usa indentação
de 2 espaços alinhada ao texto após `- [ ] `.

---

## ADRs — Architecture Decision Records

**Localização:** `decisions/`.

**Template:** `decisions/_template.md`. Cinco campos (Nygard, 2011): Título,
Status, Contexto, Decisão, Consequências.

**Status válidos:** `proposed` / `accepted` / `deprecated` /
`superseded by ADR-NNN`.

**Nomenclatura:** `ADR-NNN-slug-descritivo.md` (ex.:
`ADR-005-lag-painel-uf.md`). Numeração sequencial de três dígitos, sem datas
no nome.

**Imutabilidade:** ADR `accepted` não se edita. Mudança de decisão cria novo
ADR que `Supersedes ADR-XXX`; o anterior recebe status
`superseded by ADR-NNN`. Razão em `GOVERNANCE.md`.

**Granularidade:** uma decisão por ADR.

**Índice:** `decisions/README.md` com tabela auto-atualizada (título,
status, item do roadmap, data) gerada por `R/build_adr_index.R`.

**Numeração final pode variar conforme ordem cronológica de redação** — a
lista de ADRs pré-mapeados no roadmap é referencial, não definitiva.

---

## REVs — Revisões metodológicas

**Localização:** `decisions/`.

**Template:** `decisions/_template-revisao.md`.

**Nomenclatura:** `REV-MNN.md`, onde `NN` é o número do mês de execução
(`REV-M01` ao final do Mês 1, etc.).

**Cinco campos do template:**

1. **Estado factual** — o que foi feito; o que mudou desde o último gate.
2. **Surpresas** — o que descobri que não esperava (técnico, metodológico,
   literatura).
3. **Pressupostos do roadmap ainda válidos?** — listar 2–4 pressupostos
   centrais e marcar `confirma` / `ainda-incerto` / `invalida`.
4. **Decisão** — `seguir como planejado` / `seguir com ajustes
   [especificar]` / `pausar e revisar` / `pivot maior [especificar]`.
5. **Ações até a próxima revisão.**

---

## Bibliografia e citation keys

**Estrutura:** `bibliography/` na raiz, contendo:

- `reading-list.md` — fila consolidada com colunas: citation key, título
  curto, status (`to-read` / `reading` / `read`), papel no projeto,
  prioridade.
- `references.bib` — exportação BetterBibTeX do Zotero. Única fonte de
  citation keys. Re-exportar a cada vez que novas referências forem
  adicionadas ao projeto Zotero.
- `notes/` — uma nota markdown por artigo lido, nomeada `chave-citacao.md`
  (ex.: `melo-2017-icsap-educacao.md`), seguindo a citation key
  BetterBibTeX exata extraída de `references.bib`. Estrutura fixa do
  `_note-template.md`: citação formal + papel no projeto + resumo curto +
  citações quotáveis com página + crítica + conexões.
- `md-resumos/` — **resumos narrativos** de leitura, formato livre, em
  português, voltados para síntese conceitual e contexto histórico do
  artigo (não para extração de quotes literais ou crítica metodológica
  formal — esses ficam em `notes/`). Convenção de nomenclatura:
  `AutorETAL_AAAA_slug-tematico.md` (ex.:
  `alfradiqueETAL_2009_icsap-lista-brasileira.md`). Categoria distinta e
  complementar de `notes/` — uma referência pode ter um, outro, ou
  ambos.
- `research-notes/` — síntese investigativa que cruza ≥2 fontes (corpus
  + evidência empírica + scripts oficiais, etc.); identificadas por
  slug temático, não por citation key. Detalhes em
  `bibliography/research-notes/README.md`.
- `_note-template.md` — template fixo das notas formais em `notes/`:
  citation key + DOI (link para Zotero), papel no projeto (hipótese /
  método / seção do manuscrito), resumo em 3–5 linhas em palavras
  próprias, citações quotáveis com número de página, crítica e
  limitações, conexões com outras notas.
- `README.md` — índice auto-atualizado (chave, título, status, papel)
  gerado por `R/build_bibliography_index.R`.

**Citation key format:** `authEtAl.lower + year + shorttitle.lower`,
travada no plugin BetterBibTeX. `authEtAl` adiciona o sufixo `EtAl`
quando há mais de um autor.

Exemplo: `meloetal2017icsap`.

**PDFs não ficam no repositório** — permanecem no Zotero.

**Citation keys provisórias inventadas a partir de autor+ano são proibidas**
— a chave vem de `references.bib`, sempre.

---

## Matriz de síntese — coluna `pagina`

Convenção para o campo `pagina` em
`assets/synthesis_matrix_proposta_v02.csv`.

**Princípio:** o campo registra a paginação **visível diretamente no PDF
disponível**, lida do rodapé, cabeçalho ou marginalia da página onde o
verbatim aparece. O número não é inferido nem reconstruído.

**Casos de uso:**

- **PDF com paginação publicada visível:** registrar o número impresso na
  página onde o trecho está. Ex.: `1347` (Cad. Saúde Pública), `e1575`
  (Lancet Glob Health).
- **PDF AIP/preprint sem paginação publicada visível:** registrar a
  paginação interna 1–N do PDF com sufixo identificando a versão. Ex.:
  `4 (AIP)`, `2 (arXiv)`, `2 (Resumo)` para preliminares sem paginação.
- **Trecho na região de resumo/abstract sem paginação claramente impressa:**
  usar `abstract` ou `resumo` (formato adotado por entradas pré-existentes
  da matriz).

**Regras inegociáveis:**

- Nunca inferir a paginação publicada por offset, cálculo ou conhecimento
  prévio do paper. Se o rodapé da página onde o trecho aparece não mostra
  o número da publicação, **não escrever** esse número.
- Se houver dúvida (rodapé ilegível, número parcialmente cortado,
  paginação inconsistente entre páginas), tratar como AIP/preprint e usar
  a paginação interna com sufixo.

**Divisão de responsabilidade entre `references.bib` e o campo `pagina` da
matriz:**

- `references.bib` mantém a paginação canônica da publicação (para citação
  acadêmica formal). É a fonte de verdade para o intervalo completo de
  páginas do artigo (ex.: `pages = {149--158}`).
- O campo `pagina` da matriz documenta **onde o verbatim foi efetivamente
  localizado** no PDF disponível, que pode ser uma versão preprint, AIP,
  ou online com paginação distinta. Os dois servem propósitos
  complementares e podem divergir legitimamente.

**Implicação operacional:** ao citar uma fonte da matriz em manuscrito ou
nota técnica, usar a paginação canônica do `references.bib`, não o campo
`pagina` da matriz (que é metadado de localização do verbatim, não
referência bibliográfica).

---

## Conventional Commits

Mensagens de commit seguem o formato Conventional Commits.

**Tipos usados no projeto:**

- `docs:` documentação (roadmap, README, GOVERNANCE, CONVENTIONS, RISKS,
  ADRs, REVs, notas de bibliografia)
- `feat:` nova função, novo target, novo módulo
- `fix:` correção de bug
- `refactor:` reorganização de código sem mudança de comportamento
- `test:` adição ou ajuste de testes
- `chore:` infraestrutura (renv, Docker, CI, .gitignore, .lintr)

**Exemplos para o roadmap:**

- `docs(roadmap): marca 1.2 concluído` — patch
- `docs(roadmap): adiciona Gini estadual em 1.5; ref REV-M02` — minor
- `docs(roadmap): cria v02; pivota Desenho B para t+3; ref REV-M03` — major

Toda alteração no roadmap referencia a REV-MNN ou ADR-NNN que a motivou (à
exceção de patches triviais como marcar checkbox executado).

---

## Identificadores no roadmap

Numeração de fases e subseções (Fase N, N.M) é **permanente** através de
versões do roadmap.

**Regras:**

- Conteúdo de item muda → mantém número, edita conteúdo.
- Bullet novo dentro de subseção existente → adiciona como bullet, sem
  número novo.
- Subseção nova entre existentes → usa sufixo de letra (`1.5a`, `2.3b`).
- Item descontinuado → marca `~~deprecated~~` com nota cruzada para REV-MNN
  que motivou; não remove.

ADRs e revisões referenciam itens por número e não devem ser invalidados
por renumeração. Razão em `GOVERNANCE.md`.

---

## CHANGELOG

`CHANGELOG.md` na raiz, formato keepachangelog.com.

**Categorias por seção:** `### Added`, `### Changed`, `### Deprecated`,
`### Removed`, `### Fixed`.

**Estrutura:**

- `## [Unreleased]` no topo, acumula mudanças entre versões do roadmap.
- `## [roadmap-vNN] - YYYY-MM-DD` por versão fechada.

Para cada `roadmap-vNN.md` novo, o CHANGELOG traz a seção que explica todas
as diferenças em relação à versão anterior.

---

## Código R

- Estilo tidyverse; linter `.lintr` configurado.
- Pipe nativo `|>`, não `%>%`.
- Comentários em inglês.
- Testes em `tests/testthat/`.

Convenções operacionais detalhadas em `CLAUDE.md`.
