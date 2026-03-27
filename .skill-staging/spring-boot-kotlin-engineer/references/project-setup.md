# Project Setup

## Baseline defaults

- Kotlin for application code
- Gradle with Kotlin DSL
- Spring Boot 4.x
- Java 25 runtime

## Build guidance

- Prefer Spring Boot starters over hand-assembled dependency sets.
- Keep plugin versions aligned with Spring Initializr defaults when possible.
- Minimize custom Gradle logic unless the project genuinely needs it.

## Configuration guidance

- Prefer `application.yml`.
- Keep local development setup simple and documented.
- Favor project-local defaults when shell environment setup is fragile.
