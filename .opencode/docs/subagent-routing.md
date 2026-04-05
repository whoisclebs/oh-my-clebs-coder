# Subagent Routing

Guia curto para escolher o subagente certo no OpenCode e aplicar modelos diferentes por perfil de tarefa.

## Mapeamento Atual

| Subagente | Modelo | Motivo |
|---|---|---|
| `Development` | `openai/o3-mini` | implementação localizada |
| `Tests` | `openai/gpt-4o-mini` | cobertura e regressão |
| `ProductOwner` | `google/gemini-2.5-pro` | requisitos e critérios |
| `Review` | `openai/gpt-4o` | revisão final |
| `Security` | `google/gemini-2.5-pro` | ameaças e controles |
| `DevOps` | `github-copilot/claude-3.5-sonnet` | operação e runtime |
