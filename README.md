# oh-my-clebs-coder

Template público com uma estrutura enxuta de OpenCode para workspaces orientados a agentes.

## Objetivo

Este repositório não contém projetos de produto. Ele existe apenas para servir como base de configuração do OpenCode, incluindo:

- agentes principais
- subagentes especializados
- skills reutilizáveis
- comandos em markdown
- documentação curta de roteamento
- scripts leves de apoio
- área reservada para tools

## Estrutura

- `.opencode/agent/core/`: agentes principais
- `.opencode/agent/subagents/workspace/`: subagentes por papel
- `.opencode/skill/`: skills reutilizáveis
- `.opencode/command/`: comandos operacionais em markdown
- `.opencode/docs/`: guias curtos
- `.opencode/scripts/`: scripts leves de apoio
- `.opencode/tool/`: espaço para tools customizadas

## Como usar

1. Clone o repositório.
2. Adapte `AGENTS.md` para a sua realidade.
3. Ajuste os agentes em `.opencode/agent/`.
4. Evolua skills e comandos conforme o seu fluxo.

## Fora de escopo

- projetos de aplicação
- código de produto
- infra de deploy específica
- dependências locais como `node_modules`
