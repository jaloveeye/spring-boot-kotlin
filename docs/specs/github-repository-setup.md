# GitHub Repository Setup

## Goal

Prepare the repository for GitHub-based collaboration and CI/CD by defining the minimum GitHub settings needed before CodeRabbit and protected PR workflows are introduced.

## Scope

- Document the required repository setup order.
- Document the remote push steps for `main` and `develop`.
- Document GitHub Environment names, secrets, and variables.
- Document recommended branch protection rules.

## Non-Goals

- Actually creating the remote repository
- Actually entering GitHub secrets in the UI
- Installing CodeRabbit

## Constraints

- Align with the existing GitFlow-style `main` and `develop` workflow.
- Keep the setup practical for a single repository and early-stage team.
- Preserve the existing CI and deployment workflow assumptions already committed in the repository.

## Acceptance Criteria

- The repository contains a clear GitHub setup checklist.
- The checklist explains what should be configured before CodeRabbit.
- The checklist includes environments, secrets, variables, and branch protection recommendations.

## Verification

- Review `GITHUB_SETUP.md`.
- Confirm it matches `.github/workflows/ci.yml`, `.github/workflows/deploy-dev.yml`, and `.github/workflows/deploy-prod.yml`.

## Notes

- Assumption: GitHub is the source of truth for PRs, CI, and deployments.
