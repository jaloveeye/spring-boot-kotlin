---
name: spring-boot-modularization-kotlin
description: Guide package and module structure in Kotlin Spring Boot projects, including feature-based organization, layered boundaries, and pragmatic modularization decisions as the codebase grows. Use when reorganizing packages, defining feature boundaries, planning module splits, or reviewing architectural drift in larger Kotlin Spring Boot services.
---

# Spring Boot Modularization Kotlin

Default to simple package organization until growth justifies stronger boundaries.
Modularize to reduce complexity, not to showcase architecture.
Keep boundaries visible in code and package structure.

## Core workflow

1. Identify the current pain: package sprawl, boundary leaks, or growth in feature count.
2. Confirm whether a simple package cleanup is enough before proposing stronger modularization.
3. For package and feature organization, read `references/package-organization.md`.
4. For module split decisions, read `references/module-boundaries.md`.
5. Run relevant verification before finishing.

## Default implementation preferences

- Prefer feature-oriented grouping once the project outgrows a flat structure.
- Keep shared code minimal and intentional.
- Avoid introducing extra modules unless they remove real coupling.
- Keep the chosen structure understandable for new contributors.

## Verification

- Verify that structural changes do not break tests or configuration wiring.
- Prefer incremental reshaping over sweeping rewrites.
