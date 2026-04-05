# Subagent Routing

Guia curto para escolher o subagente certo no OpenCode e aplicar modelos diferentes por perfil de tarefa.

## Mapeamento Atual

| Subagente | Modelo | Motivo |
|---|---|---|
| `Development` | `openai/gpt-5.1-codex-mini` | implementação localizada |
| `Tests` | `openai/gpt-5.4-mini` | cobertura e regressão |
| `ProductOwner` | `google/gemini-3.1-pro-preview` | requisitos e critérios |
| `Review` | `openai/gpt-5.4` | revisão final |
| `Security` | `google/gemini-3.1-pro-preview` | ameaças e controles |
| `DevOps` | `github-copilot/claude-sonnet-4.5` | operação e runtime |
