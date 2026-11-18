[![Deploy on Railway](https://railway.com/button.svg)](https://railway.com/new/template/enclosed?utm_medium=integration&utm_source=button&utm_campaign=enclosed)

# Enclosed on Railway

One-click [Enclosed](https://enclosed.cc) for [Railway](https://railway.com): a minimal, open-source web app for sending private notes and files. The browser encrypts each note (AES-GCM, 256-bit key) before it leaves, and the key travels only in the part of the link after `#`, so the server never sees the content. Notes can have a password, an expiry time and "delete after reading".

## What this template deploys

| | |
|---|---|
| App | Enclosed **1.16.1** |
| Image | official [`corentinth/enclosed:1.16.1`](https://hub.docker.com/r/corentinth/enclosed), pinned by digest `sha256:e65f73b085823ceeab1a39c515614c1a24e9b5c69b8e1221d3d7071a4f8bc4a8` |
| Services | one, `Enclosed` (Node.js server and web UI), with a public HTTPS domain |
| Storage | a Railway volume at `/app/.data`: the encrypted notes and attachments |
| Health check | `GET /api/ping` |

There is no admin account and no setup step: open the URL and create a note. Expired notes are removed every hour.

The Dockerfile only pins the image and sets `NODE_ENV=production`, `PORT=8787` and `STORAGE_DRIVER_FS_LITE_PATH=/app/.data`. The start command is upstream's own (`node index.cjs`).

## Variables

| Variable | Default | What it does |
|---|---|---|
| `PORT` | `8787` | Port Enclosed listens on. The public domain points at it. |
| `AUTHENTICATION_JWT_SECRET` | generated, 64 characters | Signs login tokens when you turn on authentication. Generated per deploy, so upstream's `change-me` default is never used. |

Nothing to fill in at deploy time.

### Optional settings

Add these to the service's variables when you need them (full list: [Enclosed configuration](https://docs.enclosed.cc/self-hosting/configuration)):

- **Only let your users create notes:** set `PUBLIC_IS_AUTHENTICATION_REQUIRED=true` and `AUTHENTICATION_USERS` to `email:bcrypt-hash` pairs, comma-separated. Make the hashes with upstream's [key generator](https://docs.enclosed.cc/self-hosting/users-authentication-key-generator). Without this, anyone who finds the URL can create notes.
- **Defaults of the note form:** `PUBLIC_DEFAULT_NOTE_TTL_SECONDS` (3600, 86400, 604800 or 2592000), `PUBLIC_DEFAULT_DELETE_NOTE_AFTER_READING`, `PUBLIC_IS_SETTING_NO_EXPIRATION_ALLOWED`.
- **Size limit:** `NOTES_MAX_ENCRYPTED_PAYLOAD_LENGTH` in bytes (50 MB by default).

## How updates reach you

This template builds from this repository. When we bump the pinned Enclosed version here, Railway shows an "update available" notice on your project, and you choose when to apply it. Read [CHANGELOG.md](CHANGELOG.md) first: breaking changes are listed first in each entry. Your notes stay on the volume across updates and redeploys.

## Run it locally

```sh
docker build -t enclosed-railway .
docker run --rm -p 8787:8787 -v enclosed-data:/app/.data enclosed-railway
```

Then open http://localhost:8787.

## License

The wrapper files in this repository are MIT licensed. Enclosed itself is under the [Apache 2.0 licence](https://github.com/CorentinTh/enclosed/blob/main/LICENSE).
