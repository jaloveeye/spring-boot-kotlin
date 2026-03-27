# GitHub Setup Guide

## Current State

- No GitHub remote is configured yet.
- Local branches currently present: `main`, `develop`
- CI/CD workflows already exist in `.github/workflows/`

## Recommended Order

1. Create the GitHub repository
2. Add the remote and push `main` and `develop`
3. Enable GitHub Actions and Packages permissions
4. Create `dev` and `prod` GitHub Environments
5. Add environment secrets and variables
6. Configure branch protection for `develop` and `main`
7. Confirm CI runs on a test push or pull request
8. After that, connect CodeRabbit

## 1. Create The Repository

Create a new GitHub repository for this project.

Recommended:

- Keep it private while the project is still changing quickly
- Do not initialize it with README, `.gitignore`, or a license if this repository already exists locally

## 2. Add Remote And Push Branches

Replace `OWNER` and `REPO` with your actual values:

```bash
git remote add origin git@github.com:OWNER/REPO.git
git push -u origin main
git push -u origin develop
```

If you prefer HTTPS:

```bash
git remote add origin https://github.com/OWNER/REPO.git
git push -u origin main
git push -u origin develop
```

## 3. Repository Settings

### Actions

In the repository settings:

- Allow GitHub Actions to run
- Allow actions to create and approve pull requests only if you explicitly want that later
- Keep workflow permissions at least sufficient for package publishing

Recommended workflow permissions:

- `Read and write permissions`

Reason:

- `deploy-dev.yml` and `deploy-prod.yml` push images to GHCR using `GITHUB_TOKEN`

### Packages

Make sure GitHub Container Registry use is allowed for the repository owner or organization.

## 4. Create GitHub Environments

Create these environments:

- `dev`
- `prod`

Recommended:

- `dev`: no reviewer gate at first
- `prod`: require reviewers before deployment

## 5. Add Environment Secrets And Variables

Add the following secrets to both `dev` and `prod` unless the values intentionally differ:

- `DEPLOY_HOST`
- `DEPLOY_PORT`
- `DEPLOY_USER`
- `DEPLOY_SSH_KEY`
- `SPRING_DATASOURCE_URL`
- `SPRING_DATASOURCE_USERNAME`
- `SPRING_DATASOURCE_PASSWORD`

Optional environment variables:

- `SERVER_PORT`
- `SPRING_PROFILES_ACTIVE`

Typical values:

- `SERVER_PORT`: `8080`
- `SPRING_PROFILES_ACTIVE`: `prod`

If `dev` and `prod` use different servers or databases, set different values per environment.

## 6. Branch Protection

### `develop`

Recommended rules:

- Require a pull request before merging
- Require status checks to pass before merging
- Require branch to be up to date before merging
- Include administrators if you want the rule to be strict

Suggested required checks:

- `test-and-build`

### `main`

Recommended rules:

- Require a pull request before merging
- Require at least 1 approval
- Require status checks to pass before merging
- Require branch to be up to date before merging
- Restrict direct pushes
- Consider requiring conversation resolution before merge

Suggested required checks:

- `test-and-build`

## 7. Merge Strategy

Recommended repository options:

- Allow squash merge
- Disable merge commits if you want a cleaner history
- Rebase merge is optional

For this project, squash merge is usually the simplest default.

## 8. First Validation

After pushing:

1. Open a small pull request into `develop`
2. Confirm `CI` runs successfully
3. Merge into `develop`
4. Confirm `Deploy Dev` runs automatically
5. Later, manually run `Deploy Prod` from Actions when ready

## 9. After GitHub Setup

Once the above is stable:

- Connect CodeRabbit
- Add CodeRabbit review requirements to the PR process
- Tighten branch protection rules if needed

## Notes

- This repository already contains local deployment rehearsal support in `scripts/local-deploy.sh`, which is separate from GitHub-based remote deployment.
- The deployment workflows assume the target host already has Docker Engine available.
