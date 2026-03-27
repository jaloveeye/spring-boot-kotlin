---
name: gitflow-workflow
description: Apply GitFlow branch conventions in repository work, including use of develop, feature branches, release branches, and hotfix branches. Use when planning branch strategy, creating branches for new work, or aligning pull request flow with GitFlow in team-based backend development.
---

# GitFlow Workflow

Use GitFlow as the default branch model.
Keep branch purpose explicit and lifecycle-appropriate.
Prefer clear branch naming and small, reviewable integration steps.

## Core workflow

1. Start regular work from `develop`.
2. Create `feature/*` branches for new implementation work.
3. Use `release/*` branches for release preparation when needed.
4. Use `hotfix/*` branches from production-ready history for urgent fixes.
5. Merge back through the expected GitFlow path.

## Default implementation preferences

- Keep branch names descriptive.
- Keep commits reviewable and intentional.
- Avoid mixing multiple unrelated features on one branch.
- Use pull requests so review and checks stay in the loop.
