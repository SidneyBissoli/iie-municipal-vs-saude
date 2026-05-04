# Assets — derivativos versionados de tabelas e matrizes

Pasta para artefatos derivados que servem como insumo para a redação
acadêmica e para o gerenciamento da bibliografia. Não confundir com
`outputs/` (resultados analíticos finais) nem com `data/`
(intermediários do pipeline `targets`).

## Conteúdo

### `synthesis_matrix_proposta_v02.csv`

Matriz de síntese da bibliografia para a redação da v02 da proposta de
pesquisa, conforme passo 6 do fluxo obrigatório da skill
`literature-review-academic-ptbr` ("Produza a matriz de síntese ... ANTES
de qualquer prosa"). Cada linha = uma referência substantiva do corpus
(software fica fora — `landau2021targetspackagedynamic` e
`saldanhaetal2019microdatasuspacotepara` migram para a seção *Software*
do manuscrito final).

**Formato:** CSV2 brasileiro (separador `;`, qualificador `"`,
escape de aspas duplas com `""`, encoding UTF-8 com BOM). Excel pt-BR
abre nativamente; em R, ler com `readr::read_csv2()` ou
`vroom::vroom(delim = ";")`.

**Colunas (12, fixas):**

| Coluna | Conteúdo |
|---|---|
| `chave_bibtex` | Citation key BetterBibTeX exata, do `bibliography/references.bib`. Chaves zumbi (`zotero-item-NNNN`) e malformadas mantidas até regeneração do BBT. |
| `autores` | Lista APA (todos quando ≤ 3; "Sobrenome, X. et al." quando > 3 — exceção: `alfradiqueetal2009` mantém os 10 autores por relevância documental da Lista Brasileira). |
| `ano` | Ano da publicação. |
| `objeto` | O que o estudo estuda (uma frase declarativa). |
| `metodo` | Desenho e estimador, em uma frase. |
| `achado_principal` | Resultado central relevante para o nosso projeto, em 1–2 frases. |
| `corrente_teorica` | Tradição teórica do autor/grupo, conforme regra 4 da skill ("declare a tradição teórica antes de parafrasear"). |
| `trecho_verbatim` | Citação literal entre aspas duplas. **`[VERBATIM PENDENTE]`** quando a leitura sistemática ainda não foi feita — preencher na sessão dedicada à leitura sistemática (cf. roadmap §0.5). |
| `pagina` | Página(s) do verbatim, ou referência da localização (`abstract`, `resumo`, `Section 1`, etc.). |
| `tag_tema` | Slug temático em kebab-case. Lista controlada: `iie-metodologia`, `iie-aplicacao-empirica`, `esf-mortalidade-evitavel`, `esf-icsap-pediatria`, `icsap-aps`, `mortalidade-externa-jovens`, `determinantes-sociais`, `educacao-pandemia`, `did-twfe-heterogeneidade`, `did-tratamento-continuo`, `inferencia-cluster`, `modelagem-bayesiana-espacial`, `balanceamento-causal`, `sensibilidade-confundimento`. |
| `tipo_publicacao` | `APR` (Artigo Periódico Revisado por Pares) · `WP` (Working Paper) · `RT` (Relatório Técnico/Livro/Capítulo) · `LET` (Letter científica) · `PP` (Preprint não-publicado em periódico). |
| `risco_verificacao` | `B` (baixo: PDF lido, verbatim em nota) · `M` (médio: abstract conhecido, conteúdo central conhecido) · `A` (alto: não lido integralmente, verbatim a extrair). |

**Ordem das linhas:** temática (não alfabética por chave), agrupando por
`tag_tema` para servir à redação seção a seção da v02. A ordem reflete o
fluxo argumentativo natural: IIE-metodologia → IIE-aplicação empírica →
ESF e mortalidade evitável → ICSAP → mortalidade externa jovens →
determinantes sociais → educação-pandemia → DiD-TWFE-heterogeneidade →
DiD-tratamento-contínuo → inferência cluster → modelagem espacial →
balanceamento → sensibilidade.

**Manutenção da matriz.** Editar diretamente o CSV (Excel ou editor de
texto UTF-8) é aceitável — a fonte da verdade é o CSV, não o XLSX
derivado. Após edição, re-gerar o XLSX rodando
`source("R/build_synthesis_matrix.R"); build_synthesis_matrix()` no R.
O XLSX **não** é versionado em Git (entra em `.gitignore`); o CSV é a
fonte versionada.

**Pendência operacional:** seis chaves precisam de regeneração via Better
BibTeX no Zotero antes da sincronização final dos documentos
dependentes. Procedimento documentado em `roadmap-v01.md` §0.5.

### `synthesis_matrix_proposta_v02.xlsx` *(derivado, não versionado)*

XLSX gerado a partir do CSV via `R/build_synthesis_matrix.R`. Formatado
para leitura: cabeçalho em negrito, freeze pane na primeira linha,
larguras de coluna ajustadas, autofiltro habilitado, agrupamento por
`tag_tema` com cor de fundo alternada. Não editar diretamente — editar
o CSV e re-gerar.

---

## Convenções

- **Versionar texto, derivar binário.** Fonte da verdade em formato
  textual (CSV, TSV, JSON, YAML, Markdown). Binários (XLSX, PDF, PNG)
  são derivados de scripts em `R/` e não vão para Git, exceto quando
  são entregas finais imutáveis (`technical-note/`, `slides/`).
- **Convenção brasileira em CSV.** Separador `;`, decimal com vírgula
  quando aplicável, encoding UTF-8 com BOM (Excel pt-BR aceita).
- **Naming.** Nome do arquivo em snake_case minúsculo, com sufixo de
  versão da proposta quando aplicável (`_proposta_v02`).
