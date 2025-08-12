# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## ⚠️ ACTIVE REBUILD IN PROGRESS

**Current Status**: Transitioning from legacy single-page site to multi-page business website

**Goal**: Complete rebuild as a professional business site with:
- Corporate homepage showcasing Yudame as an innovation lab
- Individual product landing pages (starting with QuickBooks MCP)
- Static HTML + Tailwind CSS (compiled)
- All JavaScript inline (no external JS files)
- Deployment on Cloudflare Pages (not GitHub Pages)

**Important**: Any legacy code using Bulma CSS, HTMX, or GitHub Pages configuration should be deleted. We are doing a complete rebuild from scratch.

## Project Overview

Multi-page business website for Yudame, deployed on Cloudflare Pages at `yuda.me`. Features corporate information and individual product landing pages.

## Development Commands

### Build Process
```bash
npm install          # Install dependencies (Tailwind CSS)
npm run dev          # Start development server with hot reload
npm run build        # Build production CSS
npm run watch        # Watch for CSS changes
```

### Local Development
```bash
npm run dev          # Runs build watch + local server
# OR
python server.py     # Simple Python server (after building CSS)
```

### Deployment
- Deploy `dist/` folder to Cloudflare Pages
- Static HTML + CSS files only
- All JavaScript must be inline in HTML

## Architecture

### Technology Stack
- **Static HTML** - Single page, no framework
- **Tailwind CSS** - Utility-first CSS with local build process
- **PostCSS** - For Tailwind processing
- **Inline JavaScript** - Any interactivity must be inline, no separate JS files
- **Google Fonts** - Raleway font family

### Build Output Structure
```
dist/
├── index.html       # Production HTML with inline JS
├── styles.css       # Compiled Tailwind CSS (minified)
└── assets/          # Images and brand assets
```

### Development Structure
```
src/
├── index.html       # Source HTML
├── styles.css       # Tailwind input file with @tailwind directives
tailwind.config.js   # Tailwind configuration
postcss.config.js    # PostCSS configuration
```

### Key Architectural Decisions
- **Build process for CSS only** - Tailwind requires compilation but output remains static
- **Inline JavaScript** - All JS must be in `<script>` tags within HTML
- **No external JS dependencies** - No CDN scripts, everything self-contained
- **Optimized for Cloudflare** - Fast static site with edge caching
- **Mobile-first design** - Using Tailwind's responsive utilities

## Important Context

This is the marketing landing page only. The main application lives at `app.yuda.me`. Primary CTA directs to `https://app.yuda.me/getting-started/0/`.

### Development Guidelines
- Keep all JavaScript inline in HTML `<script>` tags
- Use Tailwind utility classes for all styling
- Optimize images for web before adding to assets/
- Test on mobile devices first
- Maintain yellow/red brand color scheme
- Focus on performance and fast page loads