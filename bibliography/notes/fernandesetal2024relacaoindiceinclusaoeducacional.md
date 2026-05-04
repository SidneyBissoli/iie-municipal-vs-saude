---
citation_key: fernandesetal2024relacaoindiceinclusaoeducacional
title: Relação entre IIE e indicadores socioeconômicos selecionados
doi: ~  # literatura cinzenta — Regime 2 (URL institucional)
status: read
role: precedente metodológico para Desenho A (mortalidade externa) e §4.2 da v02 (linha de base TWFE clássico vs. ETWFE/Mundlak)
priority: supporting
date_read: 2026-05-03
---

# Relação entre o Índice de Inclusão Educacional - IIE e alguns Indicadores Socioeconômicos selecionados

**Autores · ano · periódico:** Reynaldo Fernandes, Fabiana de Felicio,
Maria Cristina Galvão & Patrícia Franco Ravaioli (com colaboração de
Lucas Oliveira Gallette) · 2024 · Relatório Técnico Metas Sociais para
Instituto Natura, 11 de junho de 2024, 64 páginas.

**Citation key:** `fernandesetal2024relacaoindiceinclusaoeducacional`
(sincronizada na sessão 010 via Caminho A — override BBT no campo
Extra do Zotero). URL institucional canônica não confirmada nesta
sessão; PDF lido integralmente via upload do pesquisador.

**Papel no projeto:** linha de base metodológica e empírica para o uso
do IIE estadual como exposição em painel UF. Precedente direto para o
Desenho A (mortalidade externa entre jovens) e contraponto metodológico
para o Desenho B (ICSAP), por usar TWFE/EA tradicional sem ETWFE/Mundlak
nem CGBS. Aterrissagem natural na §4.2 da v02 (Identificação) e na §1
(Justificativa, magnitude esperada do efeito).

## Resumo (3–5 linhas, em suas próprias palavras)

Painel UF (27 unidades, 3 a 7 momentos do tempo entre 2007 e 2019,
n=189 no caso completo) que estima o efeito do IIE estadual sobre
33+ indicadores socioeconômicos (ISEs) em cinco domínios — engajamento
cívico, saúde, ensino superior, mercado de trabalho, segurança — com
modelos de efeitos fixos e efeitos aleatórios estado × geração, com e
sem covariáveis (tamanho da população, urbanização, escolaridade média,
proporção PPI, proporção de mulheres). ISEs medidos em janelas etárias
posteriores à observação do IIE (a coorte tem o IIE medido aos 18 anos
e os ISEs aos 19–29 anos), com o objetivo declarado de excluir
causalidade reversa. O estudo encontra associação negativa robusta entre
IIE e gravidez na adolescência, óbitos por causas evitáveis, homicídios
18–21, violência contra a mulher, taxa de Nem-Nem; associação positiva
robusta com ingresso e conclusão de ensino superior, ocupação e renda
relativa em idades mais avançadas. Inclui simulação de Δ10 p.p. no IIE
e exercício comparativo IIE × IDEB × Saeb como preditores.

## Citações quotáveis

> "(...) ainda que a metodologia empregada não seja definitiva para
> confirmar uma relação de causalidade entre a qualidade da educação
> medida pelo IIE e os indicadores socioeconômicos analisados, a
> questão temporal dos indicadores possibilita afirmar que as
> evidências de relação entre eles, que sejam identificadas, nunca se
> devem a uma causalidade inversa." — p. 5.

> "Enquanto a metodologia requer que haja variação significativa nos
> indicadores entre estados e geração sucessivas, o que torna a
> metodologia mais rigorosa, mas também pode dificultar a detecção da
> existência de uma relação causal (...), não se pode descartar a
> possibilidade de um terceiro fator impactar ambos (tanto o IIE
> quanto o ISE), e que ele ocorra no período de observação, de modo a
> determinar parte ou todo o resultado obtido." — p. 34.

## Crítica e limitações

**Declaradas pelos autores.**

- Auto-reconhecimento de que a metodologia não é definitiva para
  causalidade (p. 5; p. 34).
- Reconhecimento de que pode haver terceiro fator confundidor cuja
  variação ocorre no período de observação (p. 34).
- Comparativo IIE × IDEB × Saeb (p. 32 e Apêndice C): autores admitem
  que "não foi possível escolher o melhor indicador de qualidade da
  educação para determinar os ISE no futuro, pois os resultados
  variaram bastante entre os indicadores selecionados" (p. 32) —
  contradiz parte da narrativa que vinha sendo construída sobre a
  superioridade do IIE.
- Reconhecimento de resultado contraintuitivo para peso ao nascer
  (negativamente associado ao IIE em todas as especificações) e
  hipótese de "efeitos que não estão sendo contemplados nas variáveis
  de controle inclusas" (p. 26).

**Não declaradas — relevantes para o nosso projeto.**

- **TWFE/EA puro sem proteção contra heterogeneidade.** Ignora toda a
  literatura pós-2020 sobre vieses do TWFE em desenhos com tratamento
  contínuo distribuído em todos os períodos (CGBS 2024,
  CdH-PV-VB 2025). Como o IIE estadual é justamente um tratamento
  contínuo presente em todas as coortes, o estimador OLS pode estar
  somando ATTs com pesos negativos. Isso é exatamente o ponto que a
  v02 aborda na §4.2 via ETWFE/Mundlak `fepois` — este estudo é o
  contraste necessário.
- **Inferência sem registro explícito de SE cluster-robusto.** Com
  n=27 unidades, inferência clusterizada padrão é severamente
  enviesada para cima; o estudo não declara uso de wild bootstrap nem
  CR2 (cf. Cameron-Gelbach-Miller 2008; MacKinnon-Nielsen-Webb 2023).
  A robustez dos asteriscos `***` em várias tabelas é, portanto,
  questionável.
- **ISEs construídos como razões, não taxas.** Vários indicadores são
  da forma "% do total de óbitos por causas evitáveis ocorridos na
  geração de referência entre 19-21 anos" — denominador é o total de
  óbitos por causas evitáveis no período, não a população em risco.
  Isso confunde efeito sobre o desfecho com efeito sobre a composição
  etária da mortalidade total. Para o Desenho A do nosso projeto, é
  preciso reformular para taxa por 100 mil habitantes-ano da geração.
- **Imputação não discutida.** O IIE 2019 carrega a imputação
  2017→2019 documentada em `saeb-2019-idade.md`, mas esse fato não
  aparece no estudo. Os resultados que envolvem coortes mais novas
  (2002, IIE 2019) — incluindo praticamente toda a §Resultados sobre
  ensino superior, mercado de trabalho aos 21 anos, gravidez na
  adolescência aos 15-17 — herdam a hipótese implícita de invariância.
- **Heterogeneidade UF × tempo não modelada.** Sem interações
  UF × geração nem tendências UF-específicas. Para o Desenho A do
  nosso projeto, isso é diretamente endereçado no ETWFE/Mundlak via
  inclusão das médias intra-UF e intra-coorte.
- **Coeficientes não significativos interpretados como ausência de
  efeito.** Várias tabelas (ex.: Tabela 14, ocupação aos 25 anos)
  apresentam alternância de sinais entre EF e EA — interpretação dos
  autores é narrativa ad hoc ("até 25 anos os indivíduos da geração
  estariam ocupados com a universidade", p. 29), sem registro de
  teste de Hausman ou exploração formal de heterogeneidade.

## Conexões com outras notas

- [`../research-notes/saeb-2019-idade.md`](../research-notes/saeb-2019-idade.md)
  — o estudo usa o IIE estadual sem discutir as três camadas de
  imputação documentadas em Fernandes-Felicio-Saad (2025). A coorte
  IIE 2019 (geração 2002) entra em quase todos os exercícios deste
  estudo carregando essa imputação.
- (Futuro) `goinriddell2023comparingtwowayfixed.md` — base para
  argumento de que TWFE puro (como o usado neste estudo) tende a
  performar mal sob efeitos heterogêneos ou dinâmicos. Ponto central
  da §4.2 da v02.
- (Futuro) `chaisemartinetal2025differenceindifferencesestimatorstreatments.md`
  — fundamenta o caveat conceitual sobre tratamento contínuo
  distribuído em todos os períodos, que descreve com precisão o IIE
  estadual neste estudo.

## Implicações para este projeto

**Para a §1 (Justificativa).** Este estudo é o precedente empírico
direto da hipótese de que o IIE estadual capta variação que se reflete
em desfechos de saúde dos jovens — em particular, a relação negativa
robusta com gravidez na adolescência, óbitos por causas evitáveis e
homicídios é convergente com a hipótese H1 do nosso projeto
(mortalidade externa). A simulação de Δ10 p.p. (Figura 1, p. 34) — ex.:
"4 mil vidas preservadas devido à redução nos óbitos por causas
evitáveis entre 18 e 21 anos" — pode ser citada para sustentar
relevância de saúde pública.

**Para a §4.2 (Identificação).** Este estudo é a linha de base
metodológica que a v02 supera. Posicionamento sugerido: "Estudos
prévios que usaram o IIE estadual em painel UF (Fernandes et al., 2024)
empregaram TWFE/EA tradicional, sem proteção contra os vieses
documentados por Goin & Riddell (2023) para TWFE sob heterogeneidade
de efeitos. Este projeto avança a estratégia de identificação ao..."
— em seguida descrever ETWFE/Mundlak via `fepois`, baseline TWFE
blindado, e CdH-PV-VB como referência conceitual.

**Para a §4.3 (Sensibilidade).** O exercício comparativo IIE × IDEB ×
Saeb (Apêndice C) sugere que a substituição do indicador de educação
afeta as conclusões em vários ISEs — o que é evidência de que a
qualidade preditiva do IIE não é claramente superior. Para o nosso
projeto, isso recomenda incluir uma sensibilidade análoga ao menos
para os desfechos centrais (ICSAP no Desenho B; mortalidade externa no
Desenho A), substituindo IIE por IDEB ou por proficiência média do
SAEB do EM. Decisão a ratificar na Obs. 5 ou na construção da matriz
de síntese.

**Para a §5 (Limitações).** O resultado contraintuitivo de peso ao
nascer (associação negativa com IIE em todas as especificações deste
estudo) é exemplo concreto do tipo de achado que a v02 deve
problematizar honestamente: indicadores compostos sob ajuste fraco
podem produzir sinal contraintuitivo que não é interpretado como
ausência de efeito mas como evidência de viés de variável omitida.
Cita-se este estudo nominalmente.

**Para a Obs. 5 (heterogeneidade temporal entre coortes).** O estudo
trata as 7 coortes (2007–2019) como intercambiáveis no painel,
ignorando a camada 3 de imputação 2017→2019. Se reproduzimos esse
desenho na v02 sem protetores adicionais, herdamos a mesma fragilidade
— exatamente o que motiva mover a Obs. 5 para a §4.3 como teste central
de exclusão da coorte 2019.
