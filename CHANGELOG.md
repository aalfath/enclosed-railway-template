# Changelog

Breaking changes are listed first in each entry.

## 1.16.1 (2026-11-18)

- First release of this template: Enclosed 1.16.1 on the official `corentinth/enclosed` image, pinned by digest `sha256:e65f73b085823ceeab1a39c515614c1a24e9b5c69b8e1221d3d7071a4f8bc4a8`.
- Notes and attachments live on a Railway volume at `/app/.data`.
- Runs with `NODE_ENV=production`, listens on `PORT` (8787), health check `GET /api/ping`.
- `AUTHENTICATION_JWT_SECRET` is generated per deploy instead of upstream's `change-me` default.
- Deploy on Railway button in the README.
