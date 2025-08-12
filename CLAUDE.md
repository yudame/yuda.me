# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Multi-page business website for Yudame, deployed on Cloudflare Workers with KV storage at `yuda.me`. Features corporate homepage showcasing Yudame as an innovation lab and individual product landing pages (QuickBooks MCP).

## Development Commands

### Build Process
```bash
npm install          # Install dependencies
npm run build        # Build production files (CSS + copy HTML/assets)
npm run dev          # Start dev server with hot reload
npm run clean        # Clean dist directory
```

### Local Development
```bash
npm run dev          # Tailwind watch + local server on port 8080
npm run worker:dev   # Test Cloudflare Worker locally
npm run worker:tail  # View live production logs
```

### Deployment
```bash
npm run deploy       # Deploy to Cloudflare Workers + KV
npm run deploy:build # Build and deploy in one command
```

**Automatic deployment**: Push to `main` branch triggers GitHub Actions deployment

## Architecture

### Technology Stack
- **Static HTML** - Multi-page site, no framework
- **Tailwind CSS** - Utility-first CSS with local build process
- **Cloudflare Workers** - Edge compute platform for serving the site
- **Cloudflare KV** - Key-value storage for static assets
- **Inline JavaScript** - All JS must be in `<script>` tags within HTML

### Deployment Architecture
```
[GitHub] → [GitHub Actions] → [Cloudflare KV Storage] → [Cloudflare Worker] → [yuda.me]
                                      ↓
                              Static Assets (HTML, CSS, Images as base64)
```

### Project Structure
```
yuda.me/
├── src/                    # Source files (edit these)
│   ├── index.html         # Homepage
│   ├── quickbooks.html    # Product page
│   └── styles.css         # Tailwind input file
├── dist/                   # Built files (auto-generated)
│   ├── *.html             # Copied from src/
│   ├── styles.css         # Compiled Tailwind CSS
│   └── assets/            # Copied images
├── deploy/
│   ├── cloudflare/
│   │   └── worker.js      # Worker script (serves from KV)
│   └── deploy.sh          # Deployment script
├── wrangler.toml          # Cloudflare Workers config
└── package.json           # NPM scripts and dependencies
```

### Key Architectural Decisions
- **Cloudflare Workers + KV** - Serves site from 200+ edge locations globally
- **Base64 encoded images** - Images stored as base64 in KV storage
- **Inline JavaScript** - All JS must be in `<script>` tags within HTML
- **No external dependencies** - Everything self-contained, no CDN scripts
- **Cache strategy** - HTML cached 1hr, assets cached 24hrs

## Cloudflare Configuration

### KV Namespace
- **Namespace ID**: `e4b6d938447a4a74bf487f1affc31f60`
- **Binding**: `SITE_ASSETS`
- Files stored with paths as keys (e.g., `index.html`, `assets/logos/favicon.png`)

### Worker Routes
- `yuda.me/*`
- `www.yuda.me/*`

### Required Environment Variables (for CI/CD)
- `CLOUDFLARE_API_TOKEN` - API token with Workers and KV permissions
- `CLOUDFLARE_ACCOUNT_ID` - Account ID (in wrangler.toml)
- `KV_NAMESPACE_ID` - KV namespace ID (in wrangler.toml)

## Important Context

This is the marketing landing page only. The main application lives at `app.yuda.me`. Primary CTA directs to `https://app.yuda.me/getting-started/0/`.

### Development Guidelines
- Keep all JavaScript inline in HTML `<script>` tags
- Use Tailwind utility classes for all styling
- Images are base64 encoded during deployment - keep file sizes reasonable
- Test locally with `npm run worker:dev` before deploying
- Maintain yellow/red brand color scheme
- Performance: <50ms response time from Cloudflare edge locations