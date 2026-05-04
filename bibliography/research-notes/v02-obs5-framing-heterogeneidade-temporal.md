---
type: research-note
topic: Framing editorial da v02 — onde tratar heterogeneidade temporal entre coortes (Obs. 5.A)
status: closed
date_opened: 2026-05-03
date_closed: 2026-05-03
related_obs: Observação 5.A (handoff sessão 008) — heterogeneidade do efeito do IIE entre coortes
related_adr: ADR-005 (decisão metodológica fechada; esta nota é decisão de framing, não de método)
related_section_v02: §4.2 (Identificação) primária; §4.3 (Sensibilidades), Apêndice metodológico, §Discussão secundárias
sources:
  - "Fernandes, de Felicio, Galvão & Ravaioli (2024) — Relação entre IIE e ISEs (chave atual: zotero-item-4250). Nota completa em bibliography/notes/zotero-item-4250.md."
  - "Goin & Riddell (2023) Epidemiology 34(4):535-543 (chave: goinriddell2023comparingtwowayfixed)."
  - "Wooldridge (2025) Empirical Economics 69(5):2545-2587 (chave: wooldridge2025twowayfixedeffects)."
  - "Hone et al. (2017) Health Affairs 36(1):149-158 (chave: honeetal2017largereductionsamenable); Ferreira-Batista et al. (2023) Health Economics 32(7):1504-1524 (chave: ferreira-batistaetal2023primaryhealthcare) — referência para tradição epidemiológica brasileira aplicada com TWFE clássico."
  - "Riddell & Goin (2023) Epidemiology 34(3):e21-e22 (chave: riddellgoin2023guidecomparingestimators) — leitura sistemática pendente (letter, 2 pp.)."
---

# Framing editorial da v02 — onde tratar heterogeneidade temporal entre coortes

## 1. Pergunta

A heterogeneidade do efeito do IIE estadual entre coortes (Obs. 5.A do
handoff sessão 008) é uma fragilidade real do Desenho B do projeto: o
contexto educacional brasileiro entre 2013 e 2019 mudou substantivamente
(reforma do EM via MP 746/2016 e Lei 13415/2017, expansão do FUNDEB,
mudanças de gestão estadual da rede), e efeitos do IIE estimados com
parâmetro único agregado podem mascarar heterogeneidade temporal real.
Operacionalmente, a estratégia já decidida nas sessões 003/005 e
formalizada no ADR-005 cobre o problema metodológico — TWFE Poisson como
baseline, ETWFE/Mundlak via inclusão manual de médias intra-UF e
intra-coorte como sensibilidade prática
(`wooldridge2025twowayfixedeffects`), com CGBS 2024
(`callawayetal2024differenceindifferencescontinuoustreatment`) e
CdH-PV-VB 2025
(`chaisemartinetal2025differenceindifferencesestimatorstreatments`)
como referência conceitual sobre tratamento contínuo distribuído em
todos os períodos. A pergunta residual é editorial: **onde** colocar a
discussão na v02.

Dois caminhos foram apresentados na sessão 008:

- **Caminho A — tratar 5.A na §4.2 (Identificação) como ameaça
  declarada e endereçada.** Antecipa a objeção; posiciona o projeto
  como contribuição que aplica corretamente avanços DiD pós-2020 em
  desenho aplicado de saúde; coerente com o framing "registro maduro
  de autocrítica" da v02 (decisão D1 da sessão 006 já cria §5
  "Limitações e antecipação de objeções"). Risco: densidade técnica
  alta para o leitor médio do Comitê Técnico do edital; potencial
  fricção com a cultura editorial de RSP/CSP/CSC, que historicamente
  aceita TWFE clássico sem problematização aprofundada.
- **Caminho B — tratar 5.A na §4.3 (Sensibilidades) como teste
  reportado, sem detalhamento conceitual em §4.2.** §4.2 enxuta;
  alinhado à tradição da epidemiologia brasileira aplicada
  (`honeetal2017largereductionsamenable`,
  `honeetal2019effecteconomicrecession`,
  `ferreira-batistaetal2022brazilianfamilyhealth`,
  `ferreira-batistaetal2023primaryhealthcare`). Risco: subutiliza o
  capital metodológico que o projeto já investiu na leitura crítica
  das fontes (cf. crítica não-declarada documentada em
  `bibliography/notes/zotero-item-4250.md`); reposiciona o autor
  reativamente em vez de proativamente.

## 2. Decisão

**Caminho A com calibração de tom.** Decidida pelo pesquisador na
sessão 009 (2026-05-03).

A heterogeneidade temporal entre coortes é tratada na §4.2
(Identificação) da v02, não na §4.3, e é apresentada como ameaça à
identificação corretamente endereçada pela combinação de TWFE Poisson
(baseline) e ETWFE/Mundlak (sensibilidade prática), com referência
conceitual a CGBS 2024 e CdH-PV-VB 2025 para o caso geral de tratamento
contínuo distribuído em todos os períodos.

## 3. Calibração operacional para a redação da §4.2

Quatro travas para evitar que o Caminho A vire mini-tratado de
econometria:

1. **§4.2 cabe em ~1,5 página total.** Limite operacional rígido. O
   capital metodológico está em demonstrar que o projeto compreendeu o
   problema e respondeu adequadamente, não em reproduzir a álgebra dos
   estimadores.
2. **Heterogeneidade temporal entre coortes (5.A) tratada em 2
   parágrafos, não em mini-seção dedicada.** Primeiro parágrafo: a
   ameaça (mudanças contextuais 2013–2019 podem produzir efeito
   heterogêneo entre coortes que TWFE OLS agregaria com pesos
   potencialmente negativos sob heterogeneidade —
   `dechaisemartindhaultfoeuille2020twowayfixedeffects`,
   `goodman-bacon2021differenceindifferencesvariationtreatment`,
   `goinriddell2023comparingtwowayfixed`). Segundo parágrafo: a
   resposta (ETWFE/Mundlak via `fepois` permite estimar ATTs
   coorte-específicos sob hipótese mais fraca de parallel trends
   condicionado a covariáveis tempo-variantes —
   `wooldridge2025twowayfixedeffects` — sem necessidade de pacote
   externo; CGBS e CdH-PV-VB ficam como referência conceitual no caso
   geral de tratamento contínuo).
3. **Álgebra ETWFE/Mundlak preservada para Apêndice metodológico.**
   Equações da decomposição de pesos do TWFE e da regressão Mundlak
   estendida vão para apêndice (estilo "Apêndice A — Especificação
   detalhada do Desenho B"), referenciado por chamada na §4.2. Leitor
   do periódico-alvo que quiser detalhe técnico tem rota; leitor médio
   passa direto.
4. **§4.3 mantém a sensibilidade ETWFE/Mundlak como teste reportado
   quantitativamente, conforme ADR-005.** A §4.3 não duplica a
   discussão conceitual da §4.2 — ela apenas executa o teste
   (estimativas comparadas TWFE clássico vs. ETWFE/Mundlak via
   `fepois` com médias intra-UF e intra-coorte) e reporta convergência
   ou divergência. Isso preserva a divisão de trabalho entre as duas
   seções: §4.2 declara estratégia, §4.3 mostra robustez.

## 4. Nota de delimitação posicional (parágrafo de fechamento da §4.2)

A v02 inclui um parágrafo curto, no fim da §4.2, posicionando o projeto
explicitamente entre duas tradições convergentes:

- **Tradição epidemiológica brasileira aplicada com TWFE clássico** —
  `honeetal2017largereductionsamenable`,
  `honeetal2019effecteconomicrecession`,
  `ferreira-batistaetal2022brazilianfamilyhealth`,
  `ferreira-batistaetal2023primaryhealthcare`,
  `pintojunioretal2018efeitoestrategiasaude`. Estabelece linha de base
  empírica e plausibilidade de magnitude; não problematiza vieses do
  TWFE sob heterogeneidade.
- **Econometria DiD pós-2020 em saúde pública** —
  `goinriddell2023comparingtwowayfixed`,
  `riddellgoin2023guidecomparingestimators`,
  `wooldridge2025twowayfixedeffects`. Documenta vieses do TWFE clássico
  e fornece estimadores blindados; aplicação ainda incipiente em
  saúde pública aplicada brasileira.

O posicionamento da v02 é declarado: o projeto preserva a comparabilidade
com a tradição brasileira aplicada (TWFE Poisson como baseline), e
adiciona a camada de blindagem metodológica (ETWFE/Mundlak via `fepois`)
sem trocar de paradigma estimativo. A inferência primária permanece via
wild bootstrap por UF
(`cameronetal2008bootstrapbasedimprovementsinference`,
`mackinnonetal2023clusterrobustinferenceguide`), como decidido em ADR-005.

## 5. Relação com o estudo Fernandes, de Felicio, Galvão & Ravaioli (2024) — `zotero-item-4250`

A nota de leitura completa
(`bibliography/notes/zotero-item-4250.md`, sessão 008) registra que o
único uso pré-existente do IIE estadual em painel UF próximo ao Desenho
B do projeto emprega TWFE/EA tradicional sem proteção contra
heterogeneidade DiD. Esse precedente é citado nominalmente na §4.2 da
v02, em frase do tipo:

> *"Estudos prévios que utilizaram o IIE estadual em painel UF
> [`@zotero-item-4250` — chave a regenerar via Better BibTeX]
> empregaram TWFE/EA tradicional, sem incorporar os avanços
> metodológicos documentados após 2020 sobre vieses do TWFE sob
> heterogeneidade temporal de efeitos
> [`@goinriddell2023comparingtwowayfixed`,
> `@dechaisemartindhaultfoeuille2020twowayfixedeffects`]. Este projeto
> avança a estratégia de identificação ao incorporar ETWFE/Mundlak via
> regressão Mundlak estendida em `fepois`
> [`@wooldridge2025twowayfixedeffects`], reportada como sensibilidade
> central na §4.3."*

Frase exata redigida na sessão de redação da v02; aqui apenas registrada
a estrutura argumentativa.

## 6. Implicações operacionais

- **Não cria ADR.** Decisão é de framing editorial, não de método.
  Método já fechado em ADR-005.
- **Bloqueia início da redação da §4.2 da v02 — agora destravado.**
  Esta nota é o registro substantivo que a §4.2 referencia ao longo do
  desenvolvimento do parágrafo.
- **Não bloqueia matriz de síntese (Obs. 6).** A matriz captura o
  corpus disponível; a aterrissagem editorial de cada referência (em
  qual seção da v02 entra) é decisão posterior à matriz.
- **Não modifica ADR-005.** O ADR documenta a decisão metodológica; a
  decisão editorial sobre onde discutir essa metodologia na prosa da
  v02 é um plano arquitetural posterior.

## 7. Pendências não-bloqueantes herdadas

- **Letter de Riddell & Goin (2023) — `riddellgoin2023guidecomparingestimators`,
  e21–e22.** Leitura sistemática pendente; criar nota de leitura
  `bibliography/notes/<chave>.md` quando a chave BBT estiver estável e
  o texto for lido (sessão de leitura sistemática agendada para a
  matriz de síntese ou imediatamente após).
- **Sensibilidade IIE × IDEB × Saeb como exposição substituta.** A
  nota `bibliography/notes/zotero-item-4250.md` §"Para a §4.3
  (Sensibilidade)" propõe sensibilidade análoga ao Apêndice C do estudo
  Fernandes-Felicio-Galvão-Ravaioli (2024) — substituir IIE por IDEB
  ou proficiência média do SAEB do EM. Decisão de incluir ou não fica
  para a sessão de redação da v02 ou para uma sessão dedicada à
  arquitetura de sensibilidades; não é decisão de framing da §4.2.

## 8. Marcação epistêmica

Conforme Regra 6 da skill `literature-review-academic-ptbr`:

- §1 (Pergunta): `[INFERRED]` — síntese da tensão, não declaração textual
  de fonte.
- §2 (Decisão): registro factual da decisão tomada na sessão 009.
- §3 (Calibração): `[INFERRED]` — recomendação editorial sintetizada da
  sessão 008, ratificada pelo pesquisador na sessão 009.
- §4 (Delimitação posicional): `[SOURCED]` para as listas de referências
  (cada chave já lida ou conhecida via abstract); `[INFERRED]` para o
  posicionamento entre tradições.
- §5 (Relação com zotero-item-4250): `[SOURCED: nota completa em
  bibliography/notes/zotero-item-4250.md, sessão 008]`. Frase-modelo
  para a v02 é proposta da sessão 009, não verbatim de fonte externa.
