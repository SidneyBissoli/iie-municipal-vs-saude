---
id: ADR-005
title: Painel UF — coortes incluídas, lag operacional e comparabilidade entre coortes
status: superseded by ADR-006
date: 2026-05-03
roadmap_ref: 1.6
supersedes: ~
---

# ADR-005 — Painel UF: coortes incluídas, lag operacional e comparabilidade entre coortes

## Contexto

O Desenho B do projeto (item 1.6 do roadmap) constrói um painel
unidade-da-federação × coorte com o IIE estadual como exposição contínua,
desfechos UF × ano em t = c+5 (mortalidade externa e ICSAP em 20–29 anos),
e estimação por TWFE Poisson em `fixest::fepois` com sensibilidade
ETWFE/Mundlak via inclusão manual de médias intra-UF e intra-coorte
(decisão fechada na sessão 003, ancorada em
[`@wooldridge2025twowayfixedeffects`]; CGBS 2024
[`@callawayetal2024differenceindifferencescontinuoustreatment`] e
CdH-PV-VB 2025 [`@chaisemartinetal2025differenceindifferencesestimatorstreatments`]
mantidas como referência conceitual, não como estimadores operacionais —
ver decisão da sessão 005 detalhada em
`bibliography/research-notes/saeb-2019-idade.md` §5).

A série pública do IIE estadual (Lupa Social/Metas Sociais) tem 7 coortes
disponíveis: 2007, 2009, 2011, 2013, 2015, 2017, 2019. A coorte 2021 não
foi calculada porque a partir de 2021 o INEP passou a divulgar microdados
do SAEB com identificação escolar mascarada e o Censo Escolar agregado em
nível de escola, inviabilizando o cálculo do IIE
([`@fernandesetal2024relacaoindiceinclusaoeducacional`], p. 6,
nota 4). Essa restrição é estrutural: não é uma escolha do projeto, é um
limite da fonte primária da exposição.

Três tensões metodológicas residuais sobre a janela operacional:

1. **Janela do desfecho 2018–2024.** Todos os desfechos vêm de SIM e SIH
   nesse intervalo. Para um lag fixo t = c+5, isso restringe coortes
   admissíveis a c ∈ {2013, 2015, 2017, 2019}, dado que
   2013+5=2018 (limite inferior) e 2019+5=2024 (limite superior). A
   coorte 2021 estaria fora — o que coincide com o limite estrutural
   acima.

2. **Comparabilidade entre coortes — camada de imputação adicional na
   coorte 2019.** Documentado em verbatim de fonte primária
   ([`@fernandesetal2025evolucaodesempenhoeducacional`], pp. 8 e 22;
   análise integral em
   `bibliography/research-notes/saeb-2019-idade.md` §7) e em sessão 006
   pelo triplo selo (declaração explícita dos autores do IIE + scripts
   oficiais INEP `INPUT_R_TS_ALUNO_*.R` + verificação empírica do
   pesquisador via `educabR`): o SAEB 2019 não coletou idade nem data
   de nascimento. Os autores do IIE imputam a estrutura idade-série ×
   proficiência da coorte 2019 transportando a distribuição condicional
   observada em 2017, sob hipótese implícita não-testada de invariância
   2017→2019 dessa relação. As coortes 2013, 2015 e 2017 não carregam
   essa camada adicional. A coorte 2019 carrega três camadas de
   imputação acumuladas: (i) Tabela 5 inteira preenchida via SAEB do
   ano *t* com gerações vizinhas; (ii) Tabela 6 montada por diferenças
   sequenciais entre PNADs/PNADc; (iii) específica de 2019, transporte
   2017→2019 da Tabela 5 (síntese em
   `bibliography/research-notes/saeb-2019-idade.md` §4).

3. **Reforma do Ensino Médio.** A janela 2017–2019 abrange o ciclo final
   da reforma instituída pela MP 746/2016 e Lei 13415/2017. Em tese, a
   reforma poderia alterar exatamente a relação condicional idade-série
   × proficiência que o método de imputação assume invariante. Os
   autores do IIE não discutem essa hipótese
   ([`@fernandesetal2025evolucaodesempenhoeducacional`]; análise crítica em
   `bibliography/research-notes/saeb-2019-idade.md` §5).

Alternativas avaliadas para o lag operacional e a janela:

(a) **Restringir a 2015 e 2017** apenas. Vantagem: descarta a única
coorte com camada adicional de imputação; comparabilidade máxima entre
coortes. Desvantagem: derruba o painel para 27 UFs × 2 coortes = 54
observações. Inferência clusterizada com 27 UFs já é apertada
([`@cameronetal2008bootstrapbasedimprovementsinference`];
[`@mackinnonetal2023clusterrobustinferenceguide`]); reduzir para duas
coortes inviabiliza identificação da heterogeneidade temporal e degrada
poder.

(b) **Usar t+3 para a coorte 2021.** Permitiria incluir 2021 → 2024.
Inviável por dois motivos independentes: a coorte 2021 do IIE não existe
(restrição estrutural acima); e a comparabilidade entre lags
heterogêneos (t+3 vs. t+5) introduz fonte adicional de variação não
controlada.

(c) **Média móvel das taxas estaduais** sobre janelas centradas em c+5.
Suavizaria flutuação, mas não resolve nem a inexistência da coorte 2021
nem a camada de imputação 2017→2019 da coorte 2019. Além disso,
introduz dependência serial nos resíduos do painel, complicando a
estrutura de erro-padrão clusterizado.

(d) **Manter 2013, 2015, 2017 e 2019 com t = c+5; declarar a camada de
imputação adicional da coorte 2019 explicitamente; testar exclusão de
2019 como sensibilidade central.** Vantagens: maximiza n do painel
(27 UFs × 4 coortes = 108 observações); preserva amplitude temporal
para identificação de tendências cross-cohort; trata a fragilidade da
coorte 2019 com transparência metodológica e teste empírico, em vez de
removê-la unilateralmente.

## Decisão

O painel UF do Desenho B inclui as **quatro coortes com t = c+5 dentro
da janela 2018–2024 dos desfechos**: 2013 → 2018, 2015 → 2020,
2017 → 2022, 2019 → 2024. Lag operacional fixo de cinco anos em todas
as coortes. Caminho (d) acima.

A coorte 2021 fica **estruturalmente fora** do painel pela restrição da
fonte primária do IIE (não calculável a partir de 2021).

A camada adicional de imputação 2017→2019 carregada pela coorte 2019
([`@fernandesetal2025evolucaodesempenhoeducacional`], p. 22) é **declarada explicitamente em §4.1
(Bases) e em §5 (Limitações) da v02** e tratada como teste central de
robustez, e não caveat marginal: sensibilidade obrigatória de
re-estimação do Desenho B excluindo a coorte 2019, registrada em §4.3,
para verificar se os resultados sobrevivem à remoção da única coorte
com a imputação adicional. Se os resultados forem qualitativamente
robustos com e sem 2019, conclusão fortalecida; se divergirem, abrir
investigação na §Discussão sobre invariância 2017→2019 como mecanismo
plausível, com referência explícita ao ciclo final da Reforma do Ensino
Médio (MP 746/2016, Lei 13415/2017).

Operacionalização:

- Construção do painel canônico em `data/painel_uf.parquet` com chave
  `(uf, coorte)` e variáveis `iie_uf_coorte`, taxas de desfecho UF × ano
  em t+5, denominadores populacionais e covariáveis dependentes da UF e
  do tempo.
- Implementação em `R/build_panel_uf.R`, chamado pelo target
  `painel_uf` em `_targets.R`. Contrato `pointblank` em `R/contracts.R`
  exigindo as quatro coortes presentes em todas as 27 UFs (n = 108
  observações balanceadas).
- Estimação principal em `analysis/desenho_b_main.R` via
  `fixest::fepois(y ~ iie_uf_coorte + X | uf + coorte,
  data = painel_uf, offset = ~ log(pop_20_29), cluster = ~ uf)`.
- Sensibilidade ETWFE/Mundlak em
  `analysis/desenho_b_sens_etwfe.R` por inclusão manual de médias
  intra-UF e intra-coorte do IIE no mesmo `fepois`, ancorada em
  [`@wooldridge2025twowayfixedeffects`] (decisão da sessão 003).
- Sensibilidade central de exclusão de 2019 em
  `analysis/desenho_b_sens_no2019.R`, re-estimando o modelo principal
  no subconjunto `coorte ∈ {2013, 2015, 2017}` (n = 81 observações).
- Inferência cluster-robusta com wild bootstrap por UF
  ([`@cameronetal2008bootstrapbasedimprovementsinference`];
  [`@mackinnonetal2023clusterrobustinferenceguide`]) — 27 clusters está
  no limite inferior do que o assintótico clusterizado padrão suporta;
  wild bootstrap é a inferência primária, analítico clusterizado é
  reportado para comparação.

Pacote `did_multiplegt_dyn` (CdH-PV-VB) e `etwfe` (Grant McDermott)
permanecem fora do escopo operacional, conforme decisão da sessão 005:
o primeiro é Stata-only e a versão R cobre apenas dois períodos; o
segundo só trata staggered binário. ETWFE/Mundlak via `fepois` é a
única implementação prática.

## Consequências

**Implicações práticas.**

- Painel principal balanceado em 27 UFs × 4 coortes = 108 observações.
  Coerente com o cronograma do edital (Modalidade B, 5 meses) e com a
  granularidade do IIE estadual disponível.
- Sensibilidade central de exclusão de 2019 reduz n para 81 observações
  (27 × 3); poder estatístico cai, mas o objetivo do teste é verificar
  estabilidade qualitativa do sinal e da magnitude, não obter
  significância idêntica.
- §4.1 da v02 incorpora declaração explícita das três camadas de
  imputação acumuladas no IIE estadual e da camada adicional específica
  da coorte 2019, citando [`@fernandesetal2025evolucaodesempenhoeducacional`] como fonte primária.
- §4.2 da v02 mantém TWFE Poisson como baseline, ETWFE/Mundlak como
  sensibilidade prática, CGBS 2024 e CdH-PV-VB 2025 como referência
  conceitual sobre tratamento contínuo distribuído em todos os
  períodos.
- §4.3 da v02 lista a sensibilidade de exclusão de 2019 como teste
  central, não marginal. Este ADR é citado nominalmente.
- §5 da v02 (nova seção "Limitações e antecipação de objeções",
  resultado da decisão D1 da sessão 006) registra: limitações da
  imputação 2017→2019; ausência da coorte 2021 e o que ela impede; n=27
  unidades para inferência clusterizada; lag fixo t+5 como aproximação
  para o intervalo de manifestação dos desfechos.

**Custos aceitos.**

- Aceita-se carregar a coorte 2019 no painel principal apesar da camada
  adicional de imputação, em troca de manter amplitude temporal para
  identificação. A sensibilidade central protege contra interpretação
  espúria caso a hipótese de invariância 2017→2019 falhe.
- Aceita-se a indisponibilidade da coorte 2021 como restrição
  estrutural não-negociável da fonte; o projeto não tenta estendê-la
  por imputação adicional.
- Aceita-se inferência apertada por n=27 unidades; mitigação via wild
  bootstrap conforme item 3.1 do roadmap.

**Riscos residuais e gatilhos para superseder.**

- *Gatilho 1.* Se a sensibilidade de exclusão de 2019 mostrar inversão
  de sinal ou colapso de magnitude do efeito do IIE, este ADR é
  superseded por ADR posterior que restrinja o painel principal a
  {2013, 2015, 2017} e mova a coorte 2019 para apêndice. A
  superseder-se pelo ADR-005 não invalida a análise Desenho A
  (cross-section municipal), que não depende do painel UF.
- *Gatilho 2.* Se o pesquisador localizar evidência empírica
  publicada de quebra da relação condicional idade-série × proficiência
  entre 2017 e 2019 (por exemplo, em estudos do INEP ou da literatura
  brasileira de avaliação educacional), este ADR é superseded por
  ADR que documente a quebra e restrinja o painel a {2013, 2015, 2017}.
- *Gatilho 3.* Se o IIE for republicado para 2021 ou anos posteriores
  com metodologia que contorne a supressão de idade no SAEB, este ADR
  é superseded por ADR que estenda o painel para incluir as novas
  coortes, com avaliação de comparabilidade.

**Não-gatilho.** Resultados nulos ou de baixa magnitude no painel
principal **não** são gatilho para superseder este ADR. Painel UF de 27
clusters tem poder limitado e a literatura empírica brasileira próxima
([`@honeetal2017largereductionsamenable`];
[`@honeetal2019effecteconomicrecession`];
[`@ferreira-batistaetal2023primaryhealthcare`]) opera tipicamente em
nível municipal precisamente por isso. O Desenho A é o desenho
principal; o Desenho B é triangulação (decisão de framing pré-existente
do projeto).

---

*ADR imutável após `accepted`. Mudança de decisão cria ADR novo que
`Supersedes ADR-005`; este recebe status `superseded by ADR-NNN`.
Convenção em `CLAUDE.md` §5 e `roadmap-v01.md` §0.5.*
