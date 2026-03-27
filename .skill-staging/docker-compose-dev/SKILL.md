---
name: docker-compose-dev
description: Create and maintain Docker Compose files for local development dependencies such as PostgreSQL, Redis, or supporting services used by Kotlin Spring Boot projects. Use when adding or refining local development infrastructure, service wiring, ports, environment variables, or compose-based startup workflows for Spring Boot development.
---

# Docker Compose Dev

Keep local development infrastructure simple and predictable.
Use Docker Compose for dependencies, not for hiding application design issues.
Prefer readable service definitions over clever Compose tricks.

## Core workflow

1. Identify which local dependencies the application actually needs.
2. Keep the compose file limited to development-relevant services.
3. For service wiring, read `references/service-wiring.md`.
4. For local developer ergonomics, read `references/dev-ergonomics.md`.
5. Run relevant verification before finishing.

## Default implementation preferences

- Prefer explicit ports, volumes, and environment variables.
- Keep service names stable and understandable.
- Avoid unnecessary services.
- Document non-obvious startup assumptions in the repository.

## Verification

- Verify that compose settings match the application's local configuration.
- Prefer the smallest useful runtime stack for local development.
