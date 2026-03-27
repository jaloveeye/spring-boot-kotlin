---
name: spring-ai-kotlin
description: Implement and review Spring AI usage in Kotlin Spring Boot projects, including model client wiring, prompt flow boundaries, configuration, and pragmatic integration of AI features into backend services. Use when adding Spring AI dependencies, model calls, AI service abstractions, or prompt-driven backend features in Kotlin and Gradle Spring Boot applications.
---

# Spring AI Kotlin

Keep AI integration isolated and observable.
Treat prompt flow as application behavior that needs structure and testing.
Avoid smearing AI client details across the codebase.

## Core workflow

1. Identify the AI feature boundary and what part of the service should own it.
2. Keep model client wiring explicit and configurable.
3. For service boundaries, read `references/service-boundaries.md`.
4. For configuration and runtime concerns, read `references/configuration.md`.
5. For testing strategy, read `references/testing.md`.
6. Run relevant verification before finishing.

## Default implementation preferences

- Isolate AI-facing code behind clear service boundaries.
- Keep prompts and request shaping understandable.
- Externalize model and provider configuration.
- Avoid coupling business logic too tightly to one provider API.

## Verification

- Prefer `.\gradlew.bat test` for surrounding application behavior.
- Verify graceful handling of provider failures or missing configuration when those paths matter.
