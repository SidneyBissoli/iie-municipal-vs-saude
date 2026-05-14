# Azevedo et al. (2021) — Simulação dos impactos potenciais do fechamento de escolas por COVID-19 sobre escolaridade e aprendizagem

## Metadados

- **Citação completa**: Azevedo JP, Hasan A, Goldemberg D, Geven K, Iqbal SA. Simulating the Potential Impacts of COVID-19 School Closures on Schooling and Learning Outcomes: A Set of Global Estimates. *The World Bank Research Observer* 2021; 36(1):1–40. DOI: 10.1093/wbro/lkab003.
- **Chave BetterBibTeX**: a confirmar no acervo Zotero (sugerido `azevedoetal2021simulatingthepotenti`).
- **Tipo**: artigo de simulação prospectiva sobre choque exógeno (forward-looking, baseado em parâmetros estipulados, sem identificação causal).
- **Status epistêmico**: referência canônica do Banco Mundial para magnitude do choque educacional COVID-19. Contemporâneo do início do choque, anterior à disponibilidade de dados pós-pandemia. Não foi validado contra desfechos observados. Útil como referência paramétrica e calibração de ordens de grandeza, **não** como evidência empírica do efeito.

## Objeto e contribuição declarada

O artigo simula o efeito potencial do fechamento de escolas por COVID-19 sobre dois desfechos: (i) escolaridade ajustada por aprendizagem (Learning-Adjusted Years of Schooling, LAYS) e (ii) proficiência medida pelo PISA, em 174 países que cobrem 98% da população mundial de 4–17 anos. Considera quatro cenários — otimista (3 meses), intermediário (5), pessimista (7), muito pessimista (9) — variando duração do fechamento e efetividade de mitigação. Contribuição declarada: tradução monetária da perda de aprendizagem em anos de renda futura individual e em valor presente agregado, articulando-a aos compromissos do ODS 4.

A contribuição é dupla: paramétrica (oferece um arcabouço calibrado por faixa de renda dos países e por nível de fechamento) e retórica (mobiliza ordens de grandeza — US$ 10 trilhões em valor presente no cenário intermediário — para sustentar urgência política).

## Marco conceitual

Constrói-se em torno de três blocos teóricos: (i) função linear de aprendizagem `l = f(p, t)` com produtividade escolar `p` por ano-série, calibrada por nível de renda dos países (HIC=20, UMIC=30, LMIC=40, LIC=50 pontos por ano); (ii) curva de esquecimento de Ebbinghaus (1885), com replicação por Murre & Dros (2015), justificando a hipótese de que parte do estoque de aprendizado prévio se perde durante o desengajamento; (iii) elasticidade abandono-renda específica por faixa etária (4–11 e 12–17), estimada por variação cross-section entre matrícula e bem-estar nas 130 pesquisas domiciliares do Global Monitoring Database.

A efetividade de mitigação `m` é decomposta multiplicativamente: `m = G × A × E`, onde G é a oferta governamental de modalidades alternativas, A o acesso domiciliar e E a efetividade pedagógica intrínseca da modalidade. Os autores impõem `m ≤ 60%` (HIC) e `m ≤ 20%` (LIC), explicitando a premissa de que aprendizagem remota nunca substitui integralmente o presencial.

A simulação distributiva 3 (efeito sobre fração abaixo do PISA Nível 2) admite três formatos de choque sobre a distribuição: neutro, assimétrico à esquerda (skews), achatado. Apenas o cenário assimétrico é reportado, escolha justificada como "intermediária".

## Síntese metodológica

**Insumos de dados**: HCI/LAYS (174 países), PISA/PISA-D (92 países), Macro Poverty Outlook outubro 2020 para projeção de PIB per capita, Global Monitoring Database para elasticidades, ILOSTAT/JoIn para retornos salariais.

**Equações centrais** (notação simplificada do artigo):

- `ΔLAYS_c = f(ΔHLO_c, ΔEYS_c)`
- `ΔHLO_c = f(s_c, m_c, p_c)`
- `ΔEYS_c = f(s_c, m_c, d_{c,a,w}, g_{c,w})`

onde `s` = fração do ano letivo em fechamento, `m` = efetividade de mitigação, `p` = produtividade escolar, `d` = elasticidade abandono-renda por idade `a` e quintil de bem-estar `w`, `g` = choque de renda projetado.

**Tradução monetária**: cálculo de renda anual perdida por estudante; agregação ao valor presente por meio de tempo de trabalho de 45 anos, taxa de desconto de 3% (com sensibilidade entre 2% e 6%), ajuste por sobrevida adulta e por taxa de utilização do capital humano (Pennings, 2020).

**Cenário de distribuição**: somente o caso "skews" é reportado nas três simulações.

## Achados empíricos principais

- Perda de LAYS entre 0,3 (otimista) e 1,1 (muito pessimista) anos; cenário intermediário = 0,6 anos. Média global pré-pandemia de 7,8 LAYS cai para entre 6,7 e 7,5.
- 10,7 milhões de evasores adicionais imputáveis exclusivamente ao choque de renda; dois terços na faixa 12–17 anos.
- Perda de renda anual entre US$ 366 (otimista) e US$ 1.776 (muito pessimista); valor presente vitalício entre US$ 6.680 e US$ 32.397 a 3% de desconto.
- Perda agregada global em valor presente: US$ 4,5 a 26,8 trilhões dependendo de cenário e taxa de desconto; US$ 10,1 trilhões no caso central (intermediário, 3%).
- Em PISA, queda média de 7 (otimista) a 35 (muito pessimista) pontos; cenário intermediário = 17 pontos, equivalente a aproximadamente meio ano letivo.
- Fração de estudantes de ensino médio inicial abaixo do Nível 2 do PISA: aumento de 10 pontos percentuais (cenário intermediário, com hipótese de assimetria à esquerda).
- Comparação empírica com casos contemporâneos: Países Baixos 0,08 SD (Engzell, Frey & Verhagen, 2020) corresponde ao cenário otimista; Bélgica 0,19–0,29 SD (Maldonado & De Witte, 2020) corresponde ao intermediário-pessimista.
- **Item de leitura obrigatória para a v02 — nota 57**: Azevedo & Goldemberg (2020) estimam produtividade escolar municipal no Brasil entre 0,04 e 0,56 SD, com média de 0,3 SD. Cita-se variação intermunicipal substancial dentro do país, alinhada à literatura internacional.

## Limitações reconhecidas pelos próprios autores

- Trata-se de simulação prospectiva, não estimação causal; resultados condicionados a hipóteses sobre `s`, `m`, `p`, `d`, `g`.
- Modelo assume fechamento total inicial, sem reabertura parcial ou progressiva.
- Nenhuma resposta governamental remediativa é incorporada nas projeções (escolha deliberada).
- Sem precedente histórico para choque gêmeo de fechamento prolongado mais recessão global; calibração de elasticidades cross-section pode falhar em regime de choque sistêmico.
- Não se ajusta o efeito ao momento do ano letivo em que o fechamento ocorre (relevante para hemisférios e calendários distintos — Brasil incluso).
- Outras vias não-renda do abandono (segurança escolar, gravidez adolescente, violência doméstica, fechamento de escolas privadas, percepção de risco sanitário) ficam de fora por ausência de dados comparáveis. Os autores afirmam que suas estimativas de evasão são, por isso, *limites inferiores*.
- Apenas o cenário distributivo "skews" é reportado, dos três disponíveis — escolha que reduz a transparência sobre a sensibilidade dos resultados ao formato do choque.

## Avaliação crítica (modo revisor cético)

**Fragilidades estruturais**:

1. **Confusão epistêmica entre simulação e estimação**. Apesar do título e da carga retórica do texto, não há identificação causal de quantidade alguma. Todos os parâmetros são estipulados (ou recuperados de literatura prévia, esta sim eventualmente causal). A leitura desavisada do artigo trata os números como achados empíricos do efeito do COVID-19; os números são consequências aritméticas de premissas. A maioria dos pontos de citação subsequentes na literatura comete esse abuso.
2. **Elasticidade abandono-renda extrapolada de cross-section pré-pandêmica para regime de choque sistêmico**. As elasticidades vêm de variação inter-domicílios em 130 países antes da pandemia. Aplicá-las a um choque global, sincrônico e correlacionado com restrição sanitária e fechamento escolar pressupõe estabilidade estrutural da função abandono-renda. A literatura sobre choques agregados (Ferreira & Schady, 2009, citada pelos próprios autores) sugere precisamente que efeitos pró-cíclicos podem inverter sinal em recessões. A nota 12 reconhece o problema; o cálculo o ignora.
3. **Decomposição multiplicativa `m = G × A × E` é estilizada, não validada**. Não há fonte primária para a parametrização escolhida (e.g., HIC=20% no otimista, LIC=60%). As escolhas são "razoáveis", mas a sensibilidade dos resultados a essa parametrização não é reportada com a mesma sistematicidade que a sensibilidade à taxa de desconto. Em especial, a curva de Ebbinghaus, que é a base teórica do componente de "esquecimento", é experimentos individuais de séculos atrás sobre memorização sem sentido — extrapolá-la para perda de competências escolares ao longo de meses é manobra heurística, não calibração.
4. **Apresentação seletiva do choque distributivo**. Dos três cenários distributivos teorizados, somente "skews" entra na simulação 3. Os autores justificam como caso intermediário; é também o caso que produz aumento mais visível na proporção abaixo do MPL e portanto a narrativa mais impactante. Em sistemas com aprendizagem inicial muito baixa (e.g., LAC, MNA com 53–55% abaixo do nível 2 antes do choque), o cenário "neutro" produziria resultados qualitativamente diferentes — e o próprio texto reconhece que "in those cases […] most of the impact of COVID will be on children who were already below the MPL threshold". Reportar apenas um cenário em uma seção rotulada de "Discussion" é menos transparente do que o método autoriza.
5. **Conversão monetária amplifica escolhas sensíveis**. O número de capa, US$ 10 trilhões, depende criticamente da taxa de desconto: passa a US$ 4,8 trilhões a 6%. A renda esperada futura é projetada por 45 anos com retornos invariantes a Mincer, ignorando contracíclicos da elasticidade renda-educação em recessões prolongadas. O número é dramático; a margem de incerteza, comparável.
6. **Inconsistências internas pequenas, mas reveladoras**. O abstract afirma "11 million students could drop out"; o resultado da Simulação 1 reporta 10,7 milhões; a conclusão volta a "close to 10.7 million". A nota 12 reconhece que esse número é limite inferior por excluir vias não-renda. A própria figura 10 mostra a estimativa subindo de 2 milhões (MPO março/2020) para 10,7 milhões (MPO outubro/2020) em sete meses, conforme as projeções macro evoluíram — ou seja, a estimativa central é altamente instável a um único insumo macro, sem que essa instabilidade vire intervalo de incerteza explícito.
7. **Brasil aparece em rodapé**. A única evidência calibrada para o Brasil está na nota 57 (Azevedo & Goldemberg, 2020 — produtividade municipal entre 0,04 e 0,56 SD, média 0,3 SD). Não há simulação específica para o país. O Brasil tem características fortes — uma das janelas de fechamento mais longas globalmente, heterogeneidade municipal pronunciada, calendário escolar distinto do hemisfério norte — que mereceriam simulação dedicada e ficaram fora.
8. **Ausência de quantificação de incerteza além de cenários**. Não há intervalos de confiança, Monte Carlo, nem propagação de incerteza dos insumos paramétricos. A "incerteza" aparece como leque entre 4 cenários, o que é forma fraca de quantificação para um exercício de simulação numérica.

**Fortalezas a registrar**:

- Transparência paramétrica completa (Tabela 1) — é possível replicar o exercício.
- Reconhecimento explícito do caráter forward-looking, sem confundir com avaliação ex-post.
- Sensibilidade a discount rate sistematicamente reportada.
- Articulação cuidadosa com literatura prévia sobre disrupções (epidemias, guerras, terremotos, recessões, greves), que sustenta a base empírica das premissas.
- Honestidade sobre os canais não modelados (segurança, gênero, violência, escolas privadas), classificando a estimativa de evasão como limite inferior.
- Mobilização eficaz da literatura sobre LAYS e Human Capital Index para integrar acesso e qualidade num único indicador.
- Comparação com casos contemporâneos (Países Baixos, Bélgica, Suíça) oferece sanidade externa às magnitudes preditas.

## Implicações para a v02 da proposta de pesquisa

A v02 mantém o esqueleto da v01 (hipóteses, desenhos A/B/C, janela 2018–2024, lag t=c+5, painel canônico) e altera centralmente o tratamento metodológico do Desenho B: TWFE Poisson como *baseline*; ETWFE/Mundlak via inclusão manual de médias intra-UF e intra-coorte em `fixest::fepois` como sensibilidade central; justificação textual contra Goodman-Bacon (2021), Callaway & Sant'Anna (2021) e de Chaisemartin & D'Haultfœuille (2020); remoção da menção imprecisa a `did`; citação de Wooldridge (2025), CGBS (2024) e CdH-PV-VB (2025) como referência conceitual para tratamento contínuo por dose, sem grupo nunca-tratado e sem coortes de adoção escalonada.

A leitura crítica de Azevedo et al. (2021) gera implicações específicas que devem ser absorvidas em pontos discretos da v02:

1. **§2 (justificativa e pano de fundo)**. O artigo é a melhor referência única disponível para sustentar a importância substantiva do estudo: educação como canal não-trivial de capital humano e renda futura; choques educacionais com efeitos materiais sobre trajetórias de vida. Citar como fundamentação da relevância da inclusão educacional para desfechos a jusante (saúde, mortalidade, ICSAP) — não como evidência da magnitude do efeito sobre saúde, que o artigo não estima.

2. **§3 (definição da janela 2018–2024 e ameaça à identificação)**. Este é o ponto mais importante. A janela analítica da v02 atravessa o choque COVID-19 (~2020–2021), que Azevedo et al. (2021) caracterizam como o maior choque educacional global da história contemporânea. Implicações operacionais para a v02:
   - **Documentar explicitamente, na §3, que 2020–2021 contém um choque exógeno comum a todos os municípios brasileiros, com intensidade heterogênea (variação subnacional na duração de fechamento, na oferta de ensino remoto e no acesso domiciliar a tecnologia).**
   - **Discutir, na §3, se o IIEM utilizado como tratamento corresponde a edição pré-pandêmica, intra-pandêmica ou pós-pandêmica.** Se o IIEM é construído com insumos sensíveis ao choque (taxas de proficiência, frequência, evasão), seus valores 2020–2021 não são comparáveis aos de 2018–2019; isso deve estar registrado e tratado, não invisibilizado.
   - **Antecipar a objeção de revisor**: "o sinal estimado é confundido pelo choque pandêmico". A v02 precisa ter uma resposta explícita pronta na §4.

3. **§4.2 (justificativa para o Desenho B com TWFE/ETWFE-Mundlak)**. A heterogeneidade de mitigação `m = G × A × E` documentada por Azevedo et al. é munição argumentativa direta para a estratégia da v02:
   - O choque COVID atinge todos os municípios simultaneamente em `t`, mas com **dose efetiva heterogênea** — exatamente a estrutura conceitual que justifica tratamento contínuo por dose, sem grupo nunca-tratado e sem coortes de adoção escalonada.
   - A literatura crítica ao TWFE (Goodman-Bacon, 2021; Callaway & Sant'Anna, 2021; de Chaisemartin & D'Haultfœuille, 2020) trata principalmente do caso de adoção binária escalonada. O caso da v02 — IIEM como dose contínua + choque COVID como dose contínua sobreposta — é exatamente o caso para o qual `did` (binário escalonado) seria inadequado, e para o qual ETWFE/Mundlak via `fixest::fepois` é tecnicamente apropriado. Sugestão de redação: incorporar à §4.2 uma frase do tipo "o choque COVID-19 ilustra o caso geral de dose heterogênea sem coorte nunca-tratada (cf. Azevedo et al., 2021), reforçando a inadequação de estimadores de adoção binária escalonada e a necessidade do enfoque ETWFE/Mundlak adotado neste desenho".
   - Acrescentar referência metodológica conceitual: a estrutura `m = G × A × E` exemplifica decomposição de tratamento contínuo em componentes observáveis e não-observáveis — útil para discutir o que as médias Mundlak intra-UF capturam (componente da heterogeneidade observável agregada) e o que continua não capturado (efetividade idiossincrática `E` em nível municipal).

4. **§4.3 (sensibilidades)**. Acrescentar duas análises de sensibilidade adicionais inspiradas diretamente no choque COVID-19:
   - **(S1) Painel restrito excluindo 2020–2021** — testar se o efeito IIEM→saúde estimado é sensível à inclusão dos anos pandêmicos. Se o estimador ETWFE/Mundlak central muda materialmente entre painel completo e painel sem 2020–2021, isso é indicador de contaminação pelo choque COVID e deve ser reportado quantitativamente.
   - **(S2) Estratificação pré- vs. pós-2020** — estimar separadamente o coeficiente de interesse no subperíodo 2018–2019 e no subperíodo 2022–2024 (ou equivalente conforme disponibilidade do IIEM), ainda que com baixa potência estatística em cada metade. A divergência entre os dois subperíodos é informação substantiva sobre estabilidade estrutural da relação IIEM→saúde.
   - Reportar ambas as sensibilidades quantitativamente, na mesma tabela em que o ETWFE/Mundlak central já é reportado conforme a especificação da v02.

5. **§4.4 (limitações declaradas)**. Adicionar limitação explícita: "o painel 2018–2024 contém o choque COVID-19, com intensidade heterogênea entre municípios brasileiros e potencial efeito direto tanto sobre o tratamento (IIEM) quanto sobre os desfechos (mortalidade externa e ICSAP), via canais sanitários, econômicos e educacionais simultâneos. As sensibilidades S1 e S2 (§4.3) endereçam parcialmente essa preocupação; o efeito identificado pelo Desenho B deve ser interpretado como média ao longo de regime que inclui o choque pandêmico, não como efeito estável da inclusão educacional em regime estacionário."

6. **§4 (Desenho C, heterogeneidade)**. O artigo documenta efeitos heterogêneos do choque por sexo (meninas), grupos marginalizados, deficiência e nível socioeconômico. Isso oferece base para o Desenho C heterogêneo da v02 ao longo de eixos compatíveis com microdados brasileiros disponíveis: sexo (mortalidade externa de mulheres jovens via gravidez/violência; ICSAP por gênero), região (NE/N tipicamente com menor mitigação pandêmica do que S/SE), urbano-rural (acesso domiciliar a tecnologia educacional). Reforça-se: o Desenho C ganha sustentação ao citar Azevedo et al. (2021) como evidência prévia de que choques educacionais não atingem populações homogeneamente.

7. **§5 (limitações e contribuição)**. Azevedo et al. (2021) param na tradução monetária (renda futura). Não estimam efeitos sobre saúde, mortalidade ou utilização de serviços. Esta é lacuna empírica explícita da literatura — a v02 pode posicionar sua contribuição como **avanço da cadeia causal**: enquanto Azevedo et al. estimam o canal "educação → renda futura", a v02 estima o canal complementar "educação → saúde → mortalidade externa / ICSAP", aproveitando que microdados brasileiros (DATASUS) permitem identificação que os dados internacionais não permitem. A redação da §5 ganha em pertinência se enquadrar essa complementaridade.

8. **Calibração paramétrica para o Brasil — nota 57**. Azevedo & Goldemberg (2020) registram produtividade escolar municipal brasileira entre 0,04 e 0,56 SD (média 0,3 SD). Esse intervalo é compatível com a interpretação do IIEM como tratamento contínuo com variação substantiva entre municípios. Citar como evidência empírica prévia da heterogeneidade municipal do "produto educacional" no Brasil — útil tanto para o Desenho A (corte transversal municipal) quanto para sustentar a especificação Mundlak intra-UF do Desenho B.

9. **Hipóteses (§2) e lag t=c+5**. Cohortes em idade escolar 2020–2021 entram no estrato 20–29 anos a partir de aproximadamente 2025–2030, ou seja, no limite ou fora da janela de desfecho 2018–2024. A v02 não captura empiricamente o efeito do choque COVID sobre saúde aos 20–29 anos via lag t=c+5 — captura, na verdade, o efeito do IIEM em coortes que tinham idade escolar entre 2013–2019 (para terem 20–29 anos em 2018–2024 com lag de 5 anos). Implicação: o choque COVID afeta principalmente o painel de tratamento (medida do IIEM em 2020–2021) e os desfechos contemporâneos (mortalidade e ICSAP em 2020–2024), **não** a coorte historicamente exposta à educação que está produzindo desfechos no estrato 20–29. Esse esclarecimento merece um parágrafo na §2 ou §3 — é distinção sutil que o leitor pode confundir.

10. **Não-implicação direta**. O artigo não traz evidência ou método que afete:
    - A construção do desfecho ICSAP (regulada pela Portaria SAS/MS nº 221/2008 e pelo resumo Alfradique et al., 2009).
    - A escolha entre `geobr` ou outras malhas territoriais.
    - Detalhes do empilhamento longitudinal SIH/SIM/SINASC/CNES.
    - O Desenho A em si (corte transversal municipal), exceto via ponto 8.

## Itens não absorvidos (deliberadamente)

- Tradução monetária (perdas em US$). A v02 não trata de retornos econômicos da educação; absorvê-la seria ampliação de escopo. Manter no horizonte para um artigo de discussão de implicações de política, fora desta proposta.
- Modelagem explícita do choque COVID-19 como variável de tratamento autônoma. A proposta atual é sobre o IIEM como tratamento contínuo, não sobre o choque pandêmico. Tratar COVID como tratamento adicional reabre identificação completamente; manter como ameaça à identificação a ser contida pelas sensibilidades S1 e S2 (§4.3, ponto 4 acima), não como objeto de estudo.
- Hipótese específica de assimetria distributiva do choque sobre desfechos de saúde (análoga ao "skews" de Azevedo et al.). Substantivamente plausível, mas exige ferramental quantílico que não está no escopo TWFE/ETWFE Poisson da v02. Registrar como agenda futura.

## Anotações para preenchimento manual

- Confirmar entrada Zotero do artigo Azevedo et al. (2021) com chave BetterBibTeX. Adicionar como nó da bibliografia em `bibliography/`.
- Adicionar, se ainda não estiver, Azevedo & Goldemberg (2020) ao acervo Zotero como `Country Brief, EduAnalytics, World Bank, Washington, DC` — referência diretamente brasileira, atualmente citada apenas em rodapé do artigo principal. Esta é a referência mais útil dos dois para a §4.2 da v02.
- Verificar se existe atualização posterior do exercício de simulação (e.g., Azevedo, 2020 — *Learning Poverty: Measures and Simulations*, Policy Research Working Paper 9446) que combine os dados pós-2021 efetivamente observados com a estrutura paramétrica deste artigo. Se sim, considerar substituir parcialmente a citação central pela versão validada empiricamente.
- Decidir e documentar em ADR: a v02 trata o choque COVID-19 como (a) ameaça à identificação contida apenas por sensibilidades S1 e S2; (b) ameaça discutida narrativamente sem teste quantitativo; (c) variável de controle adicional no modelo principal. A recomendação derivada deste resumo é a opção (a), por preservar a parsimônia do desenho central e produzir teste falsificável.
- Conferir, ao redigir a §4.2, se a citação a Wooldridge (2025), CGBS (2024) e CdH-PV-VB (2025) está em formato bibliográfico final estável (volume, páginas, DOI). Estes itens metodológicos centrais não são tratados aqui — pertencem a outro resumo crítico, a ser produzido a partir dos PDFs `did-continuous-treatment.pdf`, `did-instruments-with-stayers.pdf` e `guide-for-comparing-estimators.pdf` já presentes em `bibliography/pdfs-leitura/`.
