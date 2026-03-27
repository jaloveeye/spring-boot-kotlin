---
name: spring-webclient-kotlin
description: Implement outbound HTTP clients in Kotlin Spring Boot projects using Spring WebClient, including client configuration, timeout handling, mapping, error handling, and test strategy. Use when adding external API calls, refining WebClient usage, or reviewing outbound HTTP behavior in Kotlin and Gradle Spring Boot services.
---

# Spring WebClient Kotlin

Keep outbound client code explicit about timeouts, failures, and response mapping.
Avoid scattering HTTP concerns across business logic.
Make external dependency behavior testable.

## Core workflow

1. Identify the remote API behavior and failure modes that matter.
2. Keep client configuration and mapping visible and explicit.
3. For client setup and response mapping, read `references/client-design.md`.
4. For timeouts and failure handling, read `references/resilience.md`.
5. For testing strategy, read `references/testing.md`.
6. Run relevant verification before finishing.

## Default implementation preferences

- Centralize WebClient configuration.
- Keep DTO mapping explicit.
- Set clear timeout and failure expectations.
- Do not hide retry or fallback behavior.

## Verification

- Prefer `.\gradlew.bat test` after client changes.
- Verify success-path mapping and at least one failure-path behavior.
