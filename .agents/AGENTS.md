# AGENTS.md — wa-bot (Mention All)

> Project context for all AI agents working in this repository.
> Loaded automatically by all KπX agents when present at project root.

## KπX Mantras

**Exploration:** Problem First → Why before How → Visualization
**Architecture:** 0 Trust · 100% Control | 0 Magic · 100% Transparency | 0 Hardcoding · 100% Flexibility

## Project Overview

| Field | Value |
|-------|-------|
| Purpose | A self-hosted WhatsApp bot to tag/mention all participants in a group chat upon a specific command. |
| Stack | Node.js / JavaScript |
| Key Libs | `@whiskeysockets/baileys`, `pino`, `qrcode-terminal` |
| Deployment | Docker / Docker Compose |
| Status | 🟢 Active & Maintained |

## Architecture Rules

- **Headless Operation:** The bot uses the Baileys library to connect directly to WhatsApp via WebSockets. It does not use a browser (like Selenium).
- **Persistent Session:** Authentication data is stored in a Docker volume (`./auth_info`) to survive container restarts, avoiding the need to re-scan the QR code.
- **Configuration via Environment:** All configuration (throttle delay, authorized user whitelist) is managed via a `.env` file.
- **Secure Whitelist:** The bot only responds to commands from users whose JID or LID is present in the `WHATSAPP_CHAT_IDS` environment variable. It explicitly checks if the author is authorized.
- **ID Normalization:** Uses Baileys' `jidNormalizedUser` to correctly handle different WhatsApp ID formats (JID vs. LID) for robust authorization.
- **CI/CD:** The project does not have a CI/CD pipeline for testing or deployment. It is intended for manual deployment on the homelab.

## Evolution Rules

- Any change to dependencies requires rebuilding the Docker image (`docker compose up -d --build`).
- Changes to environment variables (`.env`) require a container restart (`docker compose restart wa-bot`).
- Before modifying the command logic in `bot.js`, carefully review the authorization checks (`isAuthorized`) and the anti-spam throttling logic.
- **Makefile is the standard task runner** — use `make push` for versioning.
