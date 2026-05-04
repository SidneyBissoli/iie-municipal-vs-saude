---
id: ADR-006
title: painel-uf-erratum-IIE-estadual-2021-2023
status: accepted
date: 2026-05-04
roadmap_ref: 1.6
supersedes: ADR-005 (parcialmente — apenas a justificativa textual da exclusão da coorte 2021; operação inalterada)
---

# ADR-006 — Errata interpretativa ao ADR-005: IIE estadual 2021 e 2023 existem publicamente

## Contexto

O ADR-005 (sessão 010, datado 2026-05-03) decidiu pela inclusão das
quatro coortes {2013, 2015, 2017, 2019} no painel UF do Desenho B,
com lag t = c+5, e pela exclusão da coorte 2021. A justificativa
textual oferecida no ADR-005 §Contexto registrou:

> "A coorte 2021 não foi calculada porque a partir de 2021 o INEP
> passou a divulgar microdados do SAEB com identificação escolar
> mascarada e o Censo Escolar agregado em nível de escola,
> inviabilizando o cálculo do IIE
> ([`@fernandesetal2024relacaoindiceinclusaoeducacional`], p. 6,
> nota 4)."

Esta justificativa era correta no momento em que o relatório técnico
de Fernandes-Felicio-Galvão-Ravaioli (2024) foi escrito (junho/2024).
**Tornou-se factualmente desatualizada** entre junho/2024 e maio/2026.
Verificação empírica realizada na continuação do chat da sessão 010
(retomada pós-compaction, 2026-05-04) sobre o dashboard online da
Lupa Social acessível em <https://www.painel-iie.com.br/> mostra que
o IIE estadual está disponível publicamente para sete coortes:
**2015, 2017, 2019, 2021 e 2023** (além de 2007, 2009, 2011, 2013
referidas no ADR-005). Valores nacionais: IIE Brasil 2021 = 17,0%;
IIE Brasil 2023 = 15,5%. Decomposição em três componentes (% atraso
2+ anos no Censo Escolar; % aprendizado abaixo do básico no SAEB; %
jovens fora da escola na PNADc) está disponível para todas as
coortes, inclusive 2021 e 2023.

A nota de rodapé do dashboard (página 9 da captura PDF lida na
sessão 010, `relatorio_iie.pdf` em `/mnt/project/`) explicita o
limite metodológico ainda vigente:

> *"Os dados mais recentes, 2021 e 2023, para as capitais ainda
> não foram calculados por conta da indisponibilidade dos
> microdados do Censo Escolar - Situação do Aluno. Assim que tais
> dados forem acessados, o painel será atualizado."*

A leitura cuidadosa desta nota distingue duas grandezas que o
ADR-005 não diferenciava:

- **IIE municipal (e por capital).** Depende dos microdados-aluno
  do Censo Escolar - Situação do Aluno, que o INEP passou a
  divulgar com identificação mascarada a partir de 2021. **Não
  calculado** para 2021 e 2023.
- **IIE estadual.** Construído a partir de fontes que admitem
  agregação ao nível UF (Censo Escolar agregado em nível UF +
  SAEB + PNADc), independentes do mascaramento dos microdados-aluno.
  **Calculado e publicado** para 2021 e 2023.

O argumento "não calculável a partir de 2021" do ADR-005 §Contexto,
herdado de Fernandes-Felicio-Galvão-Ravaioli (2024), aplica-se
estritamente ao IIE municipal — e portanto não justifica, em
maio/2026, a exclusão da coorte 2021 do IIE estadual no painel UF
do Desenho B.

## Decisão

A operação metodológica do ADR-005 permanece **integralmente em
vigor**. O painel UF do Desenho B segue:

- Quatro coortes operacionais: {2013, 2015, 2017, 2019} com
  t = c+5, produzindo desfechos UF × ano em {2018, 2020, 2022, 2024}.
- Coorte 2021 fora do painel; coorte 2023 fora do painel.
- Sensibilidade central de exclusão da coorte 2019 mantida em §4.3
  da v02 (camada adicional de imputação 2017→2019).
- TWFE Poisson como baseline; ETWFE/Mundlak via `fepois` como
  sensibilidade prática; CGBS 2024 e CdH-PV-VB 2025 como referência
  conceitual.
- Inferência cluster-robusta com wild bootstrap por UF.
- Implementação em `R/build_panel_uf.R`, `analysis/desenho_b_main.R`,
  `analysis/desenho_b_sens_etwfe.R`, `analysis/desenho_b_sens_no2019.R`
  (conforme ADR-005 §Decisão).

A **justificativa textual** da exclusão das coortes 2021 e 2023 é
atualizada da seguinte forma:

- Coortes 2021 e 2023 do IIE estadual **existem publicamente**
  no dashboard Lupa Social (<https://www.painel-iie.com.br/>).
- Ambas ficam fora do painel **pela janela de desfecho 2018–2024**
  combinada com o lag fixo t = c+5: 2021 + 5 = 2026 > 2024
  (insuficiência de cobertura do desfecho); 2023 + 5 = 2028 > 2024
  (idem).
- O motivo "indisponibilidade da fonte primária do IIE" segue
  válido apenas para o IIE municipal, não para o IIE estadual; e
  só é relevante para o Desenho A (cross-section municipal), não
  para o Desenho B (painel UF).

A redação da v02 e do manuscrito futuro deve refletir esta errata
e citar este ADR-006 nominalmente, conforme detalhado em
§Consequências.

## Consequências

**§4.1 da v02 (Bases — Validação Painel UF).** Substituir qualquer
formulação herdada do ADR-005 §Contexto que afirme inviabilidade
estrutural de cálculo do IIE estadual a partir de 2021 por
formulação atualizada: "as coortes 2021 e 2023 do IIE estadual
foram publicadas pela Lupa Social no dashboard
<https://www.painel-iie.com.br/>, mas ficam fora do painel UF
operacional pela janela de desfecho 2018–2024 com lag fixo
t = c+5 (2021+5=2026 > 2024; 2023+5=2028)". Citar ADR-006 como
fonte da decisão.

**§4.3 da v02 (Análises de Robustez).** A sensibilidade central
de exclusão da coorte 2019 permanece intacta (justificativa do
ADR-005 nesse ponto não é afetada por esta errata). Não é
necessário criar nova sensibilidade que reincorpore a coorte 2021
— a exclusão é estritamente operacional pela janela do desfecho.

**§5 da v02 (Limitações e antecipação de objeções).** Adicionar
parágrafo curto: "A janela de desfecho 2018–2024 imposta pelo
edital, combinada com o lag t = c+5, restringe o painel UF a
coortes com c ≤ 2019. Coortes 2021 e 2023 do IIE estadual existem
publicamente mas ficariam com cobertura insuficiente do desfecho
em SIM/SIH (2021+5=2026 e 2023+5=2028, ambas além da janela);
não foram, portanto, incorporadas. Eventual extensão futura do
projeto poderá ampliar a janela do desfecho e absorver essas
coortes sem mudança metodológica." Citar ADR-006.

**Manuscrito futuro.** Em "Métodos > Bases", repetir a justificativa
correta. Não citar a justificativa do ADR-005 §Contexto sem
cruzamento com ADR-006.

**ADR-005 §header YAML.** Atualizado nesta sessão para
`status: superseded by ADR-006`, conforme convenção em
`GOVERNANCE.md` e `CONVENTIONS.md` (§ADRs).

**Custos aceitos.**

- Aceita-se overhead arquitetural mínimo (um arquivo curto na
  pasta `decisions/`) em troca de coerência entre documento de
  governança e estado factual da fonte primária da exposição.
- Aceita-se que leitor do ADR-005 precisa seguir o ponteiro
  `superseded by ADR-006` para chegar à justificativa atualizada;
  esta é a fricção esperada em qualquer regime de imutabilidade
  de ADRs.

**Riscos residuais e gatilhos para superseder.**

- *Gatilho 1.* Se em sessão futura for verificado que o IIE
  estadual 2021 ou 2023 disponibilizado no dashboard Lupa Social
  carrega camada(s) adicional(is) de imputação não documentada(s)
  pelos autores do índice (analogamente à camada 2017→2019 da
  coorte 2019, registrada em
  `bibliography/research-notes/saeb-2019-idade.md`), este ADR
  pode ser superseded por ADR posterior que registre a camada
  e ajuste a redação da §5 da v02.
- *Gatilho 2.* Se o edital admitir extensão de janela de desfecho
  (até 2028, por exemplo) durante a execução do projeto, este
  ADR pode ser superseded por ADR que estenda o painel para
  incluir as coortes 2021 e 2023, com revalidação do lag.

**Não-gatilho.** A simples existência das coortes 2021 e 2023 no
dashboard, sem extensão da janela de desfecho, não justifica
revisão da decisão operacional; a exclusão dessas coortes é
estritamente uma consequência da janela de desfecho, não da
disponibilidade da exposição.

---

*ADR imutável após `accepted`. Mudança de decisão cria ADR novo
que `Supersedes ADR-006`; este recebe status
`superseded by ADR-NNN`. Convenção em `CLAUDE.md` §5 e
`roadmap-v01.md` §0.5.*
