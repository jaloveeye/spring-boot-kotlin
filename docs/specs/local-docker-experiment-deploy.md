# Local Docker Experiment Deploy

## Goal

Provide a low-friction way to rehearse Docker-based deployment on the same local machine before wiring a remote host into CI/CD.

## Scope

- Add a local deployment compose file that runs both the app and PostgreSQL.
- Add a local env example with safe default ports.
- Add a helper script for up, down, logs, and status.
- Document how local experiment deployment differs from development and remote deployment.

## Non-Goals

- Replace the existing local development compose workflow
- Provision a remote host
- Add container orchestration

## Constraints

- Keep local experimentation separate from the existing `compose.yaml` development flow.
- Avoid port collisions with the current app and local PostgreSQL defaults.
- Reuse the repository Dockerfile instead of inventing a second image path.

## Acceptance Criteria

- A developer can build and start the app plus PostgreSQL on the same machine with one script.
- Local experiment deployment uses dedicated default ports.
- Documentation explains when to use the local experiment flow versus the regular development flow.

## Verification

- Run `bash scripts/local-deploy.sh up`.
- Confirm the containers are healthy with `bash scripts/local-deploy.sh status`.
- Call `http://localhost:18081/api/guestbook/messages`.
- Run `bash scripts/local-deploy.sh down`.

## Notes

- Assumption: local experiment deployment is for release rehearsal, not for day-to-day coding.
