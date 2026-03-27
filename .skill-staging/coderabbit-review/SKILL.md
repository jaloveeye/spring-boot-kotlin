---
name: coderabbit-review
description: Prepare code changes for CodeRabbit-style automated pull request review by keeping PR scope tight, aligning changes with acceptance criteria, and triaging review findings pragmatically. Use when preparing a pull request, responding to automated review comments, or tightening code review readiness in Git-based backend workflows.
---

# CodeRabbit Review

Treat automated review as part of the delivery pipeline.
Optimize for clear pull requests and reviewable diffs.
Resolve findings with behavior and maintainability in mind.

## Core workflow

1. Keep the pull request scoped to one coherent change.
2. Ensure the change matches its spec or acceptance criteria.
3. Run relevant verification before review.
4. Read review findings by severity and likely impact.
5. Resolve or intentionally dismiss findings with clear reasoning.

## Default implementation preferences

- Prefer smaller pull requests.
- Keep diffs easy to understand.
- Use review comments to catch bugs, regressions, hidden complexity, and missing tests.
- Do not ignore review feedback without a conscious decision.
