---
type: research-note
topic: Supressão de idade no SAEB 2019 e imputação na coorte 2019 do IIE estadual
status: closed
date_opened: 2026-05-03
date_closed: 2026-05-03
related_obs: Observação 4 (handoff sessão 005), passo 3
related_adr: ADR-005 (a redigir nesta sessão)
related_section_v02: §4.1 (Bases — Validação Painel UF), §4.3 (Análises de Robustez)
sources:
  - "Fernandes, Felicio & Saad (2025) — IIE Evolução do Desempenho Educacional: PDF Instituto Natura, https://www.institutonatura.org/wp-content/uploads/2025/04/20240314_IIE-e-a-Evolucao-do-Desempenho-da-Educacao-Basica.pdf (chave BBT: fernandesetal2025evolucaodesempenhoeducacional)"
  - "INEP (2019) — scripts oficiais INPUT_R_TS_ALUNO_2EF.R, INPUT_R_TS_ALUNO_5EF.R, INPUT_R_TS_ALUNO_9EF.R, INPUT_R_TS_ALUNO_34EM.R, distribuídos com os microdados públicos do SAEB 2019 (cache local em educabR/data/saeb/uncompressed/2019/INPUTS/, lidos integralmente em 2026-05-03)"
  - "Verificação empírica do pesquisador via educabR::get_saeb(year = 2019, type = 'aluno', n_max = 50, keep_zip = TRUE), registrada no handoff da sessão 005 — output com 53 colunas, sem variável de idade ou data de nascimento"
---

# Supressão de idade no SAEB 2019 e imputação na coorte 2019 do IIE estadual

## 1. Pergunta

Como a Lupa Social/Metas Sociais construiu a coorte 2019 do IIE estadual
sem variável de idade nos microdados aluno do SAEB 2019, e que implicações
metodológicas isso tem para o uso do IIE estadual como exposição em painel
UF (Desenho B do projeto)?

## 2. Resposta verificada

**Fato 1 — supressão de idade no SAEB 2019.** A edição 2019 do SAEB não
coletou data de nascimento nem idade no questionário de contexto
sociodemográfico. Verificado por três canais independentes:

(a) **Declaração explícita dos autores do IIE.** Fernandes, Felicio & Saad
(2025) registram a supressão tanto na seção descritiva quanto na seção de
metodologia (verbatim 1 e 2 abaixo). Os autores são, respectivamente,
consultor associado da Metas Sociais (R. Fernandes), sócia-diretora da
Metas Sociais (F. Felicio) e Diretor Presidente do Instituto Natura
(D. Saad) — fonte primária do método de construção do IIE.

(b) **Scripts oficiais de leitura do INEP.** Os quatro scripts
`INPUT_R_TS_ALUNO_*.R` distribuídos junto aos microdados SAEB 2019 (para
2EF, 5EF, 9EF e 34EM) declaram operacionalmente todas as variáveis dos
microdados aluno via blocos `factor()`. Em **nenhum** dos quatro scripts
aparece variável `IDADE`, `IDA`, `DT_NASC`, `ANO_NASC` ou equivalente. As
únicas variáveis de estratificação demográfica disponíveis são `ID_REGIAO`,
`ID_UF`, `ID_AREA` (capital/interior), `IN_PUBLICA`, `ID_LOCALIZACAO`
(urbana/rural) e `ID_SERIE`. As 19–20 perguntas do questionário aluno
(`TX_RESP_Q001` a `Q019` ou `Q020`) cobrem idioma falado em casa, cor/raça,
escolaridade dos pais, posses, transporte, expectativas — nenhuma capta
idade ou data de nascimento.

(c) **Verificação empírica do pesquisador.** A chamada
`educabR::get_saeb(year = 2019, type = "aluno")` retornou 53 colunas (mais
amplas que as ~30 colunas-base do INEP por incluir variáveis derivadas de
peso amostral e classificação por nível de proficiência), e nenhuma delas
de idade ou data de nascimento. Registrado no handoff da sessão 005.

**Fato 2 — mecanismo de imputação para o IIE 2019.** Fernandes, Felicio
& Saad (2025) descrevem o procedimento adotado em duas etapas (verbatim 3
abaixo). A "Tabela 5" do artigo é a distribuição **idade-série ×
proficiência** ao final do ensino médio (cinco linhas: adiantado, em
linha, atrasado 1, atrasado 2, atrasado 3+; duas colunas: não-proficiente,
proficiente).

Em 2019, o SAEB permite estimar apenas o **total marginal por coluna**
(proficiente / não-proficiente, agregando todas as condições idade-série).
A célula é então preenchida assim:

- **Etapa 1.** Os totais de coluna observados em 2019 são distribuídos
  entre as cinco linhas segundo a distribuição condicional observada na
  Tabela 5 de 2017.
- **Etapa 2.** Cada linha é normalizada para somar 1, mantendo as
  proporções resultantes da Etapa 1.

**Operacionalmente:** cada célula de 2019 é função do total observado da
coluna 2019 ponderado pela proporção condicional dessa célula em 2017.
A estrutura conjunta idade-série × proficiência da Tabela 5 de 2019 é,
portanto, **transportada de 2017** e ajustada apenas pelos totais
observados de proficiência em 2019.

**Fato 3 — hipótese implícita.** O método assume invariância da relação
condicional entre proficiência e atraso idade-série entre 2017 e 2019. Se
uma UF (ou subgrupo) teve mudança substantiva de fluxo escolar nesse
intervalo, o IIE estadual 2019 da UF **subestima** essa mudança.

## 3. Verbatim-chave

**Verbatim 1** — Fernandes, Felicio & Saad (2025), p. 8, parágrafo
introdutório à Tabela 2 (escopo das mudanças nas bases de dados):

> *"Outro fato relevante é que a edição de 2019 do SAEB não coletou a
> informação de data de nascimento (ou sequer idade) inviabilizando
> algumas das análises mais relevantes neste ano."*

**Verbatim 2** — Fernandes, Felicio & Saad (2025), p. 8, Tabela 2, linha
"SAEB / Inep":

> *"[…] cada participante realiza ambas [as provas, LP e MT] e responde
> ao questionário de contexto sociodemográfico que contém a informação de
> idade e sexo, porém ambas foram suprimidas da edição de 2019."*

**Verbatim 3** — Fernandes, Felicio & Saad (2025), p. 22, seção
*Metodologia*, descrição operacional da imputação para o IIE 2019:

> *"Em 2019 o INEP não coletou no questionário de contexto
> sociodemográfico informações que permitissem identificar o ano de
> nascimento dos estudantes, impossibilitando a separação dos estudantes
> quanto ao alinhamento idade-série — adiantados, em linha e atrasados.
> Assim, o SAEB 2019 só permite obter uma estimativa para a última linha
> da Tabela 5. Para lidar com isso, o procedimento adotado foi, em
> primeiro lugar, distribuir o total de cada coluna da Tabela 5, em 2019,
> de acordo com a distribuição obtida para 2017 (mantendo o total da
> coluna de 2019 que é observado). Em segundo lugar, cada linha da tabela
> deve somar 1, mas mantendo as proporções obtidas pela primeira
> transformação. Esses são os dados considerados nas linhas da Tabela 5,
> para o ano de 2019."*

**Verbatim 4** — INEP (2019), cabeçalho declarativo dos quatro scripts
`INPUT_R_TS_ALUNO_*.R` (texto idêntico nos quatro arquivos):

> *"Este programa abre a base de dados com os rótulos das variáveis de
> acordo com o dicionário de dados que compõe os microdados."*

(Esta nota é importante porque caracteriza os scripts como definição
autoritativa do conjunto de variáveis dos microdados, não como subset
arbitrário. Logo, ausência de uma variável no script implica ausência nos
microdados publicados.)

## 4. Camadas de imputação acumuladas no IIE estadual

Pelo método declarado em Fernandes, Felicio & Saad (2025, pp. 21–23), o
IIE estadual carrega **três camadas de imputação** que não são
independentes entre si:

1. **Tabela 5 inteira preenchida via SAEB do ano *t*.** Os autores
   declaram que, "por simplicidade", todos os dados da Tabela 5 são
   preenchidos com base no SAEB do ano *t*, usando gerações vizinhas como
   aproximação para adiantados (que não fizeram SAEB no ano *t*) e
   atrasados-1 (idem). Tecnicamente, atrasados-2 poderiam ser estimados
   pelo SAEB *t+2*, mas isso não foi adotado (Fernandes et al., 2025,
   p. 22).
2. **Tabela 6 montada por diferenças sequenciais entre PNADs.** A
   distribuição da geração entre as cinco condições de atraso ao final do
   ensino médio é estimada pela proporção da geração que terminou o
   ensino médio em cada PNAD sucessiva (PNAD do ano *t* para adiantados;
   PNAD *t+1* para "em linha"; e assim sucessivamente, por subtração).
   A transição PNAD → PNADc atravessa o intervalo 2015–2016, com
   verificação dos autores em 2013 mostrando "não causar distorção"
   (Fernandes et al., 2025, p. 24, nota 15).
3. **Em 2019 apenas: imputação adicional 2017→2019 da Tabela 5.** O
   transporte da estrutura condicional idade-série × proficiência de 2017
   para 2019 (Fato 2 acima).

Para as coortes 2015 e 2017, apenas as camadas (1) e (2) operam. Para a
coorte 2019, as três operam **simultaneamente**.

## 5. Crítica metodológica (modo "Professor Crítico")

Pontos legítimos para ressalva acadêmica, sem invalidar o uso do índice:

- **Auto-reconhecimento parcial dos vieses.** Os autores reconhecem que
  ~25% dos escalados para o SAEB do EM não realizam o exame e que isso
  pode produzir vieses em direções opostas (subestimação se faltosos
  forem super-representados entre baixa proficiência; superestimação se
  baixa proficiência for sub-representada por causa de alta reprovação
  pré-prova). Declaram que "nenhum procedimento foi adotado para lidar
  com esses potenciais problemas" (Fernandes et al., 2025, p. 22).
- **Decisão de simplicidade não-justificada formalmente.** Optar por
  preencher toda a Tabela 5 com SAEB *t* em vez de combinar SAEB *t* (em
  linha + adiantados + atrasados-1) com SAEB *t+2* (atrasados-2) é
  declarado como escolha de simplicidade (Fernandes et al., 2025,
  pp. 21–22), sem análise de quanto isso afeta as estimativas.
- **Hipótese de invariância 2017→2019 não testada.** A imputação assume
  estabilidade da relação condicional idade-série × proficiência entre
  duas coortes consecutivas, em um intervalo que inclui o ciclo final do
  ensino médio reformado pela MP 746/2016 (Lei 13415/2017) — sendo essa
  uma reforma que, em tese, poderia alterar exatamente essa relação. Os
  autores não discutem essa hipótese.
- **Caveat sobre identificação no Desenho B.** O método tem implicações
  diretas para a discussão de identificação no Desenho B do projeto, dado
  que tratamento contínuo distribuído em todos os períodos —
  caracterização literal do IIE estadual no painel UF — exige cuidados
  específicos discutidos por `chaisemartinetal2025differenceindifferencesestimatorstreatments`
  (Chaisemartin, D'Haultfœuille, Pasquier, Sow & Vazquez-Bare, 2025,
  arXiv:2201.06898v3). E a estratégia ETWFE/Mundlak via inclusão manual
  de médias intra-UF e intra-coorte em `fixest::fepois` invocada como
  sensibilidade (Obs. 1 da sessão 005) está formalmente justificada por
  `wooldridge2025twowayfixedeffects` (Wooldridge, 2025, *Empirical
  Economics* 69(5):2545–2587, DOI 10.1007/s00181-025-02807-z).

## 6. Implicações para o projeto

### 6.1. §4.1 da v02 (Bases — Validação Painel UF)

A versão estritamente conservadora pré-redigida na sessão 005 (formulação
condicional ao README Lupa) é **substituída** por formulação ancorada em
fonte primária. Declarar explicitamente:

- Que o IIE estadual 2019 carrega imputação adicional da estrutura
  idade-série × proficiência de 2017, documentada pelos autores do índice;
- Citar Fernandes, Felicio & Saad (2025, pp. 8 e 22) como fonte primária
  do método;
- Distinguir entre o **fato declarado** (supressão de idade no SAEB 2019)
  e a **hipótese metodológica** (invariância da relação condicional
  2017→2019).

### 6.2. §4.3 da v02 (Análises de Robustez)

A sensibilidade de exclusão da coorte 2019 do Desenho B (re-estimação
restrita a 2015 e 2017) deixa de ser caveat marginal e passa a ser
**teste central**. Justificativa: testar se conclusões dependem da camada
de imputação adicional carregada apenas pela coorte 2019.

Se os resultados do Desenho B forem qualitativamente robustos com e sem
2019, conclusão fortalecida. Se divergirem, abrir investigação sobre
invariância 2017→2019 como mecanismo plausível.

### 6.3. ADR-005 (a redigir nesta sessão)

Título proposto: "ADR-005 — Tratamento da série histórica do IIE
estadual: lag operacional e comparabilidade entre coortes".

Conteúdo ancorado em verbatims 1, 2 e 3 desta nota. Subseção
"Consequências" lista a hipótese de invariância idade-série × proficiência
2017→2019 como **condição que poderia invalidar a decisão** (gatilho
explícito para superseder por ADR posterior caso evidência empírica
contradiga).

### 6.4. §6 / Discussão (depende de D1)

Limitação a registrar: três camadas de imputação acumulam-se no IIE
estadual; sua interação amplifica risco de erro **não-clássico** se a
estrutura da imputação covariar com características das UFs (porte,
macrorregião, perfil socioeconômico, intensidade de implementação do EM
reformado).

## 7. Pendências não-bloqueantes

- **Citation key BibTeX da fonte central.** Resolvido na sessão 010 via
  Caminho A (override no campo Extra do Zotero, sintaxe BBT
  `Citation Key: <valor>`, e reexportação). Chave canônica:
  `fernandesetal2025evolucaodesempenhoeducacional`.
- **URL alternativa GitHub.** Confirmar URL do repositório
  `lupa-social/iie-indice-de-inclusao-educacional` no GitHub (pasta
  `estudos/`) — verificação via `web_fetch` quando autorizada. URL
  primária confirmada: Instituto Natura, abril/2025
  (https://www.institutonatura.org/wp-content/uploads/2025/04/20240314_IIE-e-a-Evolucao-do-Desempenho-da-Educacao-Basica.pdf).
  Não bloqueante — cópia local foi lida integralmente nesta sessão.
- **Triagem do terceiro estudo Lupa Social.** *"Relação entre IIE e
  Seleção de Indicadores Socioeconômicos"* (Fernandes, Felicio, Galvão &
  Ravaioli, 2024 — relatório técnico Metas Sociais para Instituto Natura;
  importado no Zotero na sessão 007, chave BBT:
  `fernandesetal2024relacaoindiceinclusaoeducacional`, com PDF lido
  integralmente). Relevância substantiva para a v02 ainda a decidir na
  Obs. 5 ou Obs. 6 (matriz de síntese): o estudo é o uso pré-existente do
  IIE como exposição em desenho próximo ao Desenho B do projeto
  (painel UF × geração, ISEs em ICSAP-correlatos, n=189), ainda que com
  EF/EA tradicional sem ETWFE/Mundlak ou CGBS — contraste metodológico
  natural para a discussão de identificação em §4.2.

## 8. Marcação epistêmica das afirmações

Conforme Regra 6 da skill `literature-review-academic-ptbr`:

- Fato 1 (supressão de idade): `[SOURCED: Fernandes-Felicio-Saad 2025,
  pp. 8 e 22]` + `[SOURCED: INEP 2019, scripts INPUT_R_TS_ALUNO_*.R]` +
  evidência empírica do pesquisador (sessão 005). Triplo selo.
- Fato 2 (mecanismo de imputação): `[SOURCED: Fernandes-Felicio-Saad
  2025, p. 22]`. Verbatim integral preservado.
- Fato 3 (hipótese implícita): `[INFERRED]` — síntese lógica do método
  declarado, não declaração textual. Marcação preserva a distinção.
- Camadas acumuladas (§4): `[SOURCED: Fernandes-Felicio-Saad 2025,
  pp. 21–23]` + `[INFERRED]` para a frase "Para a coorte 2019, as três
  operam simultaneamente" — combina três sources já SOURCED.
- Crítica metodológica (§5): mistura de `[SOURCED]` (auto-reconhecimentos
  textuais dos autores) e `[INFERRED]` (a hipótese 2017→2019 não-testada
  é leitura crítica da omissão; declarada como tal).
