# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Static business website for Yudame, deployed on GitHub Pages at `yuda.me`. Corporate site (homepage + practice/case-study/security pages) positioning Yudame as a product engineering studio for development banks, governments, and operators across Asia and the Pacific.

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
```

**Automatic deployment**: Push to `main` branch triggers GitHub Actions deployment

## Architecture

### Technology Stack
- **Static HTML** - Single-page site, no framework
- **Tailwind CSS** - Utility-first CSS with local build process
- **GitHub Pages** - Static site hosting
- **GitHub Actions** - CI/CD for automatic deployment on push to main

### Build Pipeline
1. **Source files** in `src/` (HTML) and `assets/` (images)
2. **Build process** compiles Tailwind CSS and copies files to `dist/`
3. **GitHub Actions** builds and deploys `dist/` to GitHub Pages
4. **Live site** served at `yuda.me` via GitHub Pages

### Project Structure
```
yuda.me/
├── src/                    # Source files (edit these)
│   ├── index.html         # Homepage
│   ├── case-studies/      # /case-studies/ page
│   ├── pacific-telecom/   # /pacific-telecom/ practice page
│   ├── security/          # /security/ compliance page
│   └── styles.css         # Tailwind input + shared design system CSS
├── docs/designs/           # Design charter and .pen files
│   └── charter.md         # THE design contract — read before visual changes
├── dist/                   # Built files (auto-generated, gitignored)
├── assets/                 # Static images
│   ├── logos/             # Company logos and favicons
│   └── profiles/          # Team member photos
└── .github/workflows/     # GitHub Actions deployment
```

### Key Architectural Decisions
- **No JavaScript framework** - All interactivity via inline `<script>` tags in HTML
- **One stylesheet** - All styling lives in `src/styles.css` (shared design-system CSS after the Tailwind directives). Pages carry NO inline `<style>` blocks — see `docs/designs/charter.md`
- **GitHub Pages deployment** - Automatic via GitHub Actions on push to main
- **Static images** - Served directly from `assets/` directory (not base64 encoded)

## Important Context

This is the marketing landing page only. The main application lives at `app.yuda.me`. Primary CTA directs to `https://app.yuda.me/getting-started/0/`.

### Development Guidelines
- Keep all JavaScript inline in HTML `<script>` tags
- Style via the shared classes in `src/styles.css`; new rules go there, never inline
- Test locally with `npm run dev` before pushing
- Design language (see `docs/designs/charter.md`): Lora 500 for headings, Inter for body, IBM Plex Mono for labels/buttons. Accent `--yellow` (#FFC107) at full strength exactly once per page (the CTA); elsewhere a line/tick/dot. Raleway is retired (2026-06-12)

## Deployment Process

**GitHub Pages Configuration**:
- Deployment triggered automatically on push to `main` branch
- GitHub Actions workflow builds and deploys `dist/` directory
- Custom domain `yuda.me` configured via GitHub Pages settings
- Build artifacts are not committed - `dist/` is gitignored

## Business Context

For business context, project notes, and assets see the work vault: `~/src/work-vault/Yudame/`