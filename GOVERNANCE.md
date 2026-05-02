# GOVERNANCE — Princípios de governança do projeto

Este documento registra os princípios pelos quais o projeto se organiza. O
*como fazer* operacional vive no roadmap; o *como decidir* e o *como pensar
sobre o projeto* vivem aqui. Convenções técnicas detalhadas (formatos,
templates, nomenclatura) ficam em `CONVENTIONS.md`.

---

## Estrutura do repositório — três naturezas de documento

Documentos do repositório dividem-se em três categorias com responsabilidades
distintas. Misturar naturezas em um único arquivo polui o sinal e complica
manutenção.

1. **Documentos científicos** — proposta, pré-registro, análise
   pré-especificada, manuscrito, nota técnica, slides, preprints. Saída para
   o mundo acadêmico e para gestores. Vivem em `manuscripts/`,
   `technical-note/`, `slides/`.
2. **Documentos de governança e gestão** — roadmap, CHANGELOG, ADRs, REVs.
   Como o projeto se organiza e decide. Vivem em `roadmap-vNN.md`,
   `CHANGELOG.md`, `decisions/`.
3. **Documentos meta do repositório** — README, LICENSE, CITATION.cff,
   CLAUDE.md, GOVERNANCE.md, CONVENTIONS.md, RISKS.md. Identidade pública e
   instruções de uso do repo. Vivem na raiz.

A proposta é documento científico (mesma natureza do artigo futuro), não de
gestão; por isso vive em `manuscripts/` junto com os demais manuscritos. Na
raiz ficam apenas documentos meta e de gestão.

---

## Hierarquia de fontes da verdade

Em ordem de precedência, da mais autoritativa para a menos:

1. **`manuscripts/proposta-de-pesquisa.md`** — fonte científica primária.
   Define pergunta de pesquisa, hipóteses, desenho geral. Modificável apenas
   por evento institucional formal (revisão da proposta junto ao edital).
2. **ADRs e REVs aceitos em `decisions/`** — fonte das decisões metodológicas
   e estratégicas tomadas durante a execução. Têm precedência sobre o roadmap
   quando há conflito; o roadmap deve ser atualizado para refletir, mas até
   lá o ADR ou REV vence.
3. **`roadmap-vNN.md` vigente** — fonte operacional. Como executar a proposta
   dadas as decisões registradas em ADRs/REVs. Quando atualizado de forma
   consistente com as decisões, é a fonte da verdade prática para o dia a dia
   da execução.
4. **`CLAUDE.md`** — fonte de convenções operacionais para Claude Code,
   derivadas do roadmap. Subordinado a ele.
5. **Código, manifests, contratos** — implementação. Subordinados a tudo
   acima.

Em caso de conflito, sobe na hierarquia. Ao notar inconsistência entre
roadmap e ADR, REV ou proposta, parar e investigar antes de prosseguir.

---

## Sistemas de captura de conhecimento

Dois sistemas paralelos, ambos versionados no repositório.

**ADRs** (Architecture Decision Records, em `decisions/`) registram decisões
*internas* do projeto — por que escolhemos X. **Bibliografia** (em
`bibliography/`) registra conhecimento *externo* capturado da literatura — o
que os outros já sabem. São complementares.

ADRs imutáveis após `accepted` preservam histórico de pensamento. Mudanças de
decisão criam novo ADR que `Supersedes ADR-XXX`; o anterior recebe status
`superseded by ADR-NNN`. Princípio: identificador é endereço permanente;
conteúdo evolui.

Implementação de qualquer item marcado com 🜲 no roadmap exige consultar o
ADR correspondente em `decisions/`. CLAUDE.md documenta essa regra para
Claude Code.

---

## Divisão Zotero ↔ repositório

Zotero permanece como fonte da verdade para metadados, PDFs e highlights
rápidos. Notas substantivas vão em `bibliography/notes/` no repositório,
porque são versionadas, revisáveis e importáveis como snippets diretamente no
manuscrito Quarto. Não duplicar metadados.

Citation keys do projeto são exportadas do Zotero via plugin BetterBibTeX
para `bibliography/references.bib`. São a única fonte de citation keys; chaves
provisórias inventadas a partir de autor+ano não são aceitas.

---

## Onde fazer — Claude Code, Claude Desktop ou humano

`[CD]` cobre Introdução, Discussão, cover letter, nota técnica para gestores,
lab notebook e rotulagem de análises exploratórias — justifica-se pela
iteração conversacional e pelo acesso vivo a literatura via MCPs (PubMed,
Consensus, Zotero).

`[humano]` cobre autenticação institucional, envio de e-mails, submissão a
periódico, autorização de DOI no Zenodo, apresentação ao vivo e revisão entre
colegas.

Tag é alerta, não regra. Em Code com sessão aberta e item `[CD]` curto, fazer
em Code — perde-se pouco. Custo real é tentar redigir Discussão em Code (vira
texto seco) ou extrair 7 anos de SIM em Desktop (sessão longa frágil).

Itens marcados com `[CD]` ou `[CD→CC]` formam três regiões do projeto:

1. **Governança e ADRs** — pré-registro, política de missing, mapeamento
   ICSAP, lag do painel UF, nível de cluster, escolha de periódico,
   viabilidade de negative controls, correção de subnotificação. Oito ADRs
   cumulativos.
2. **Manuscrito — seções narrativas** — Introdução, Discussão, escolha de
   periódico. Métodos, Resultados e Apêndices ficam livres porque mesclam
   prosa e técnica.
3. **Comunicação para humanos** — cover letter, nota técnica para gestores,
   lab notebook, rotulagem de exploratórias, resposta a feedback adversarial.

Itens humanos indelegáveis somam sete pontos de fricção institucional ao
longo dos cinco meses: envio de e-mail à Lupa Social, submissão ao periódico,
posting de preprint, autorização de DOI no Zenodo, ensaio cronometrado,
apresentação ao Comitê, revisão entre colegas.

Todo o resto é livre. Code é o default razoável para tudo que vira arquivo
executável; Desktop, se já estiver lá pensando em outra coisa.

---

## Princípios T.6 — Contratos e fail-fast

Detectar erro na primeira oportunidade possível, parando em vez de propagar
estado corrompido.

**Data contracts em todo artefato derivado.** Função que escreve um arquivo
chama `pointblank::create_agent()` com o contrato declarado em
`R/contracts.R`; só retorna se passar. Falha = parada do pipeline, não
warning. Erro detectado no momento exato em que ocorre, não três sessões
depois.

**Tracer bullet antes de escala completa.** Antes de processar 5.570
municípios ou 27 UFs, rodar o pipeline inteiro em escala 1/27 — uma UF
pequena, do início ao fim, incluindo validação. Custo ~1/30 do tempo total.
Bugs estruturais (classificação CID, joins quebrados, tipos errados)
aparecem antes do gasto de tempo de máquina e disco em escala completa.

**Session handoff manifest.** Toda sessão Code começa verificando o último
manifest em `.claude/`: re-hashear arquivos listados, re-rodar `pointblank`,
conferir commit. Divergência = halt. Sessão seguinte não toca em nada novo
até resolver.

---

## Princípio T.7 — Revisões metodológicas periódicas

Gates técnicos (⛓) verificam *execução*; gates metodológicos verificam
*direção*. Ao final de cada mês de execução, parar 30 minutos para perguntar:
dado o que sabemos agora, o desenho original ainda é a melhor resposta à
pergunta de pesquisa? Sem este mecanismo, viés de confirmação e sunk cost
operam sem freio em pesquisador solo.

Cinco REVs ao longo do projeto, registradas em `decisions/REV-MNN.md`.
Formato fixo: estado factual, surpresas, pressupostos do roadmap ainda
válidos, decisão (seguir / ajustar / pausar / pivotar), ações até a próxima
revisão. Template em `decisions/_template-revisao.md`.

---

## Princípio T.8 — Controle de mudanças

Roadmap é documento vivo, mas mudanças sem método viram caos. Distinguir
três magnitudes de mudança e tratar cada uma diferente.

**Patch** — correção pequena: typo, link, ajuste de redação, marcar checkbox.
Edita direto, commit normal, não muda versão do roadmap.

**Minor** — adiciona conteúdo sem invalidar plano: nova covariável, novo ADR,
refinamento de etapa, novo bullet em subseção existente. Edita direto, commit
referencia REV-MNN ou ADR-NNN, não muda versão do roadmap.

**Major** — muda o plano: pivota hipótese, troca desenho, exclui análise
central, redefine periódico-alvo. Cria `roadmap-vNN.md` novo, com seção
dedicada no `CHANGELOG.md` explicitando o que mudou e por quê. Roadmap
anterior permanece imutável como documento histórico.

Toda mudança rastreia até a REV ou ADR que a motivou. Detalhes operacionais
(formato Conventional Commits, identificadores estáveis) em `CONVENTIONS.md`.

---

## Princípios de integridade científica

- Toda análise não pré-registrada é rotulada explicitamente como
  **exploratória** no manuscrito.
- Reportar todas as decisões metodológicas relevantes, não apenas as que
  produziram resultados favoráveis.
- Aceitar e responder a feedback adversarial; documentar respostas em
  apêndice ou OSF.

Estes princípios precedem qualquer decisão sobre apresentação de resultados
ou estratégia editorial.
