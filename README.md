# Yudame Business Website

## 🚧 Active Rebuild in Progress

This repository is undergoing a complete rebuild from a single-page landing to a multi-page business website.

### Rebuild Goals
- **Corporate Homepage**: Showcase Yudame as an innovation lab and technology consultancy
- **Product Landing Pages**: Individual pages for each Yudame product (starting with QuickBooks MCP for Claude)
- **Modern Tech Stack**: Static HTML with Tailwind CSS (no JavaScript frameworks)
- **New Hosting**: Migrating from GitHub Pages to Cloudflare Pages

### Tech Stack
- HTML5 (static pages)
- Tailwind CSS (utility-first styling)
- Inline JavaScript only (no external JS files)
- Cloudflare Pages hosting

### Development

```bash
# Install dependencies
npm install

# Development server with hot reload
npm run dev

# Build for production
npm run build

# Clean build directory
npm run clean
```

### Project Structure
```
src/           # Source files
dist/          # Production build (git-ignored)
assets/        # Images and static assets
docs/plans/    # Planning documents
```

### Legacy Code Notice
Any code using the following should be removed:
- Bulma CSS framework
- HTMX library
- GitHub Pages configuration (CNAME)
- CDN-based dependencies

### Deployment
The site will be deployed to Cloudflare Pages with the domain `yuda.me`

---

See `docs/plans/rebuild.md` for detailed rebuild plan.