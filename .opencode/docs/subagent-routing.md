# Subagent Routing

Guia curto para escolher o subagente certo no OpenCode e aplicar modelos diferentes por perfil de tarefa.

## Mapeamento Atual

| Subagente | Modelo | Motivo |
|---|---|---|
| `Development` | `openai/gpt-5.1-codex-mini` | implementação localizada |
| `Tests` | `github-copilot/gpt-5.4-mini` | cobertura e regressão |
| `ProductOwner` | `github-copilot/gemini-2.5-pro` | requisitos e critérios |
| `Review` | `openai/gpt-5.4` | revisão final |
| `Security` | `github-copilot/gemini-2.5-pro` | ameaças e controles |
| `DevOps` | `github-copilot/claude-sonnet-4.5` | operação e runtime |
