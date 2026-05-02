# RISKS — Riscos e mitigações

Documento vivo. Riscos são identificados a qualquer momento (na elaboração
inicial do projeto, em revisões metodológicas mensais, durante execução) e
adicionados aqui sem ciclo formal de versionamento. Riscos resolvidos ou
descartados são marcados, não removidos.

Cada risco tem prioridade (P0/P1/P2) consistente com a notação do roadmap
e mitigação concreta.

---

## Riscos ativos

### R-01 — Atraso na liberação do IIEM

**Prioridade:** P0.

**Mitigação:** solicitação formal já no Mês 0; manter contato semanal com
Lupa Social; plano B usando indicadores agregados públicos do IIE até
liberação.

---

### R-02 — SIH-RD ou SIM-DO 2024 não disponíveis em Jul/2026

**Prioridade:** P0.

**Mitigação:** confirmar disponibilidade na Fase 0; ajustar janela para
2018–2023 se necessário, com documentação explícita.

---

### R-03 — Instabilidade do INLA em alguns sistemas

**Prioridade:** P1.

**Mitigação:** smoke test no Mês 0 (executado na sessão 001); ter
alternativa em `spatialreg` para SAR.

---

### R-04 — Alta colinearidade IIEM × INSE × IDHM levando a estimativas instáveis

**Prioridade:** P1.

**Mitigação:** análise de VIF na Fase 2; especificações com cada controle
isolado; discussão honesta de identificação no manuscrito.

---

### R-05 — Lag t+5 do painel UF inviável para coorte 2021

**Prioridade:** P1.

**Mitigação:** ADR-005 antes do Mês 1 (item 1.6 do roadmap).

---

### R-06 — Efeito da pandemia COVID-19 confundir resultados 2020–2021

**Prioridade:** P1.

**Mitigação:** análise principal com dados pré e pós-pandemia separados
como sensibilidade.

---

### R-07 — Rejeição editorial do periódico-alvo

**Prioridade:** P2.

**Mitigação:** ter periódico-alvo secundário pré-definido (Mês 4); preprint
em OSF/SciELO.

---

## Riscos resolvidos ou descartados

*(Vazio até primeira ocorrência.)*
