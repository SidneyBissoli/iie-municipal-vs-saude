# Bibliografia e notas de leitura

Sistema versionado de captura de conhecimento externo do projeto. Operação
detalhada em `CLAUDE.md` §6 e `roadmap-v01.md` §0.5.

- **`references.bib`** — exportação BetterBibTeX do Zotero. Única fonte de
  citation keys do projeto. Convenção: `auth.lower + year + shorttitle.lower`,
  travada. **Não editar à mão.**
- **`reading-list.md`** — fila com `to-read | reading | read`, papel no
  projeto e prioridade. Indexada pelas keys de `references.bib`.
- **`notes/<citation-key>.md`** — uma nota markdown por artigo lido,
  seguindo `_note-template.md`. PDFs ficam no Zotero.
- **`_note-template.md`** — template fixo (citação, papel, resumo, citações
  quotáveis com página, crítica, conexões).

O índice abaixo é **gerado automaticamente** por
`R/build_bibliography_index.R`. Não editar à mão; rodar
`source("R/build_bibliography_index.R"); build_bibliography_index()` após
re-exportar o `.bib` ou adicionar nota nova.

<!-- BEGIN: BIB_INDEX -->
| Chave | Título curto | Status | Papel | Tem nota? |
|---|---|:-:|---|:-:|
| _(referências serão listadas após import inicial via Zotero)_ | | | | |
<!-- END: BIB_INDEX -->

---

## Sequência de bootstrap (a fazer fora do Code, antes da próxima sessão)

Conforme roadmap §0.5 — sem atalhos:

1. **Importar no Zotero** as 10 referências centrais identificadas na
   proposta (Melo et al. 2017; Borges & Cano 2017; Alfradique et al. 2009;
   Cutler & Lleras-Muney 2010; Marmot 2017; Blangiardo et al. 2013;
   Cameron et al. 2008; MacKinnon et al. 2023; Iacus, King & Porro 2012;
   VanderWeele & Ding 2017; Simonsohn et al. 2020) usando DOI quando
   possível.
2. **Instalar/ativar o plugin BetterBibTeX** no Zotero.
3. **Configurar citation key estável** com formato `auth.lower + year +
   shorttitle.lower`, travada (não auto-update).
4. **Exportar a coleção** do projeto como `.bib` para
   `bibliography/references.bib`.

Só depois disso é seguro popular `reading-list.md` (a próxima sessão Code
faz isso lendo as keys diretamente do `.bib`).
