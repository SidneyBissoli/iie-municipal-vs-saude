---
id: REV-MNN
title: Revisão metodológica — Mês NN
status: completed   # in-progress | completed
date: AAAA-MM-DD
roadmap_ref: T.7
phase_ref: <ex.: Fase 1, Fase 2; mês de execução>
---

# REV-MNN — Revisão metodológica do Mês NN

## 1. Estado factual

O que foi feito desde a última revisão. Marcos atingidos, marcos atrasados,
artefatos produzidos. Diferença entre planejado (roadmap) e executado.

## 2. Surpresas

O que descobri que não esperava — técnico, metodológico, de literatura, de
dados. Inclui surpresas positivas (algo deu mais certo do que parecia) e
negativas (algo deu mais trabalho ou apontou em direção diferente).

## 3. Pressupostos do roadmap ainda válidos?

Listar 2–4 pressupostos centrais da fase em revisão. Para cada um, marcar:

- **`confirma`** — evidência empírica reforça o pressuposto.
- **`ainda-incerto`** — não há evidência suficiente para julgar.
- **`invalida`** — evidência empírica contradiz; redirecionar plano.

Pressupostos típicos por fase em `roadmap-v01.md` §T.7.

## 4. Decisão

Uma das quatro:

- **`seguir como planejado`** — roadmap não muda.
- **`seguir com ajustes [especificar]`** — patch ou minor (cf. T.8); editar
  roadmap atual, commit referencia esta REV.
- **`pausar e revisar`** — interrompe execução; retomar após resolução de
  pendência específica (qual?).
- **`pivot maior [especificar]`** — major change (cf. T.8); criar
  `roadmap-vNN.md` novo, com seção dedicada no `CHANGELOG.md`.

## 5. Ações até a próxima revisão

Lista de itens executáveis com responsável (CC / CD / humano), referência ao
item do roadmap e prazo. Cada ação deve estar rastreável em commit ou ADR.

---

*REV imutável após `completed`. Convenção em `CLAUDE.md` §5 e
`roadmap-v01.md` §T.7.*
