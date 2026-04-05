# OpenCode Local

Configuração base de OpenCode para um workspace orientado a agentes.

## Estrutura

- `agent/core/`: agentes principais.
- `agent/subagents/`: definições de subagentes por papel.
- `command/`: comandos em markdown para fluxos recorrentes.
- `skill/`: skills de orquestração e execução.
- `scripts/`: scripts leves de suporte.
- `tool/`: área para tools customizadas.
- `docs/`: orientações curtas de roteamento e colaboração.

## Convenção

- Cada agente declara frontmatter com `name`, `description`, `model`, `temperature` e `mode` quando aplicável.
- O modelo pode variar por papel, custo de erro e tipo de tarefa.
- Modelos menores ficam em tarefas localizadas e de menor risco.
- Modelos maiores ficam em planejamento, revisão e temas com custo alto de erro.

## Uso

- Leia `AGENTS.md` e o contexto do repositório antes de delegar.
- Consulte `docs/subagent-routing.md` para escolher o subagente mais adequado.
