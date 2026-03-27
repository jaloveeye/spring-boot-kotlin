---
name: spring-security-kotlin
description: Implement and review Spring Security in Kotlin Spring Boot services, including SecurityFilterChain setup, authorization rules, JWT resource server configuration, method security, password handling, test support, and secure API defaults. Use when working on authentication, authorization, JWT/OAuth2 resource server setup, endpoint protection, or security-related backend changes in Kotlin and Gradle Spring Boot projects.
---

# Spring Security Kotlin

Prefer simple and explicit security configuration.
Protect endpoints intentionally rather than relying on accidental defaults.
Keep security decisions visible in configuration and tests.

## Core workflow

1. Identify whether the task is authentication, authorization, token validation, or endpoint exposure.
2. Confirm the current security setup before adding new rules.
3. For filter-chain and endpoint rules, read `references/filter-chain.md`.
4. For JWT or OAuth2 resource server work, read `references/jwt-and-oauth2.md`.
5. For test strategy, read `references/testing.md`.
6. For secure defaults and common mistakes, read `references/secure-defaults.md`.
7. Run relevant verification before finishing.

## Default implementation preferences

- Prefer a single clear `SecurityFilterChain` until complexity genuinely requires more.
- Deny by default and explicitly allow only the endpoints that should be public.
- Keep authentication mechanism choices explicit.
- Use method security only when it complements, not obscures, request-level rules.
- Keep secrets and signing material externalized from source.
- Prefer built-in Spring Security testing support over custom ad hoc helpers.

## Verification

- Prefer `.\gradlew.bat test` after security changes.
- Verify at least one allowed path and one denied path for meaningful changes.
- When token handling changes, verify invalid-token behavior as well as happy-path access.
