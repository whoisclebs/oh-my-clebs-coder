# AGENTS

## Objetivo

Este repositório existe como template de configuração do OpenCode. O foco aqui é orquestração, agentes, skills, comandos e convenções de colaboração.

## Regras Globais

- Leia primeiro `README.md` e `.opencode/README.md`.
- Prefira mudanças pequenas e reversíveis.
- Registre regras transversais primeiro nos agentes, skills ou docs antes de espalhar a lógica em vários arquivos.
- Use subagentes quando houver ganho real de especialização ou paralelismo.

## Estrutura Base

- `.opencode/agent/`: contratos dos agentes
- `.opencode/skill/`: skills reutilizáveis
- `.opencode/command/`: comandos em markdown
- `.opencode/docs/`: documentação curta
- `.opencode/scripts/`: scripts auxiliares
- `.opencode/tool/`: espaço reservado para tools customizadas

## Como Agir

- Ao criar novos agentes, mantenha frontmatter consistente.
- Ao criar novas skills, documente objetivo, quando usar, artefatos e handoff mínimo.
- Ao criar novos comandos, descreva fluxo, saída esperada e exemplos de uso.
- Evite acoplamento com um projeto específico neste template.
