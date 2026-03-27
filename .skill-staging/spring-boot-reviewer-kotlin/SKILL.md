---
name: spring-boot-reviewer-kotlin
description: Review Kotlin Spring Boot code for architectural drift, API boundary leaks, weak test coverage, risky configuration, security mistakes, and persistence regressions. Use when reviewing pull requests, changed files, service implementations, or backend refactors in Kotlin and Gradle Spring Boot projects.
---

# Spring Boot Reviewer Kotlin

Focus on concrete findings, not abstract style advice.
Prioritize bugs, regressions, and maintainability risks over cosmetic issues.
Keep findings tied to actual files and behavior.

## Core workflow

1. Confirm the review scope: file, diff, module, or whole service.
2. Read the relevant code before loading extra references.
3. For architecture or API concerns, read `references/architecture-and-api.md`.
4. For testing concerns, read `references/testing.md`.
5. For persistence concerns, read `references/persistence.md`.
6. For security and configuration concerns, read `references/security-and-config.md`.
7. Report findings by severity with concrete evidence.

## Review priorities

- behavior regressions
- missing validation or authorization
- controller or service boundary leaks
- persistence mistakes that create incorrect or expensive behavior
- test gaps around changed logic
- configuration that is fragile, hidden, or unsafe

## Output guidance

- Prefer findings-first review output.
- Cite file paths and line numbers when possible.
- If no findings are present, say so explicitly and mention any remaining blind spots.
