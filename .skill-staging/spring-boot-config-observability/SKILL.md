---
name: spring-boot-config-observability
description: Configure Spring Boot Kotlin services for application settings, profiles, logging, Actuator, health probes, and operational visibility. Use when working on application.yml structure, environment-specific config, readiness and liveness endpoints, logging defaults, or observability-related setup in Kotlin and Gradle Spring Boot projects.
---

# Spring Boot Config Observability

Keep configuration explicit and easy to reason about.
Prefer operational defaults that help both local development and deployment.
Expose observability endpoints intentionally rather than by accident.

## Core workflow

1. Identify whether the task is configuration structure, environment override, logging, or health visibility.
2. Keep config layout understandable and consistent with current conventions.
3. For application configuration layout, read `references/config-layout.md`.
4. For Actuator and health endpoints, read `references/actuator-and-health.md`.
5. For logging choices, read `references/logging.md`.
6. Run relevant verification before finishing.

## Default implementation preferences

- Prefer `application.yml`.
- Keep environment-sensitive values externalized.
- Use profiles intentionally and sparingly.
- Keep health endpoints aligned with actual runtime dependencies.
- Favor useful logs over noisy logs.

## Verification

- Prefer `.\gradlew.bat test` for code-backed configuration changes.
- If runtime visibility changed, verify startup and the relevant actuator behavior when practical.
