---
name: project-orchestration
description: Orquestrar trabalho multiagente com handoff mínimo, etapas e tarefas pequenas
version: 1.0.0
author: workspace
type: skill
category: orchestration
tags:
  - orchestration
  - multi-agent
  - workflow
---

# Project Orchestration Skill

## Objetivo

Oferecer um fluxo simples de orquestração para features, bugs e mudanças transversais.

## Fluxo Recomendado

1. `ProductOwner` quando o escopo estiver ambíguo.
2. `Development` para implementar.
3. `Tests` para validar comportamento e regressão.
4. `Security` e `DevOps` quando houver risco específico.
5. `Review` para fechamento orientado a risco.

## Handoff mínimo

- objetivo
- escopo e fora de escopo
- arquivos ou áreas relevantes
- critério de aceite
- riscos conhecidos
