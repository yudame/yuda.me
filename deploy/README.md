# Cloudflare Deployment Guide

This guide explains how to deploy the yuda.me site to Cloudflare Workers with KV storage.

## Quick Start for New Developers

### First Time Setup

1. **Clone the repository**
   ```bash
   git clone [repo-url]
   cd yuda.me
   npm install
   ```

2. **Install Wrangler CLI**
   ```bash
   npm install -g wrangler
   ```

3. **Login to Cloudflare**
   ```bash
   wrangler login
   ```

4. **Get Access** (for team members)
   - Request access to Cloudflare account from Tom or Valor
   - Get added to the yuda.me domain in Cloudflare

### Daily Deployment

```bash
# Option 1: Build and deploy in one command
npm run deploy:build

# Option 2: Step by step
npm run build         # Build the site
npm run deploy        # Deploy to Cloudflare
```

That's it! Your changes are live at https://yuda.me

## Prerequisites

- Node.js 16+ and npm
- Wrangler CLI (`npm install -g wrangler`)
- Cloudflare account access
- Repository access

## Architecture Overview

```
[GitHub Repo] → [Build Process] → [KV Storage] → [Cloudflare Worker] → [yuda.me]
                                        ↓
                                   Static Assets
                                   (HTML, CSS, Images)
```

## Project Structure

```
yuda.me/
├── src/                    # Source files (edit these)
│   ├── index.html         # Homepage
│   └── quickbooks.html    # Product page
├── dist/                   # Built files (auto-generated)
├── assets/                 # Images and static files
├── deploy/                 # Deployment scripts
│   ├── cloudflare/        
│   │   └── worker.js      # Worker script (serves the site)
│   ├── deploy.sh          # Automated deployment script
│   └── README.md          # This file
├── wrangler.toml          # Cloudflare configuration
└── package.json           # Dependencies and scripts
```

## Available Commands

| Command | Description | When to Use |
|---------|-------------|-------------|
| `npm run dev` | Start dev server | Local development |
| `npm run build` | Build production files | Before deploying |
| `npm run deploy` | Deploy to Cloudflare | Ship to production |
| `npm run deploy:build` | Build + Deploy | Quick deployment |
| `npm run worker:dev` | Test Worker locally | Debug Worker issues |
| `npm run worker:tail` | View live logs | Monitor production |

## Common Tasks

### Adding a New Page

1. Create HTML file in `src/`
   ```bash
   touch src/new-page.html
   ```

2. Build and deploy
   ```bash
   npm run deploy:build
   ```

3. Access at `https://yuda.me/new-page.html`

### Updating Images

1. Add image to `assets/` folder
2. Reference in HTML: `<img src="/assets/folder/image.png">`
3. Deploy: `npm run deploy:build`

### Checking Deployment Status

```bash
# View real-time logs
npm run worker:tail

# Test locally before deploying
npm run worker:dev
```

## Deployment Process Details

The `deploy.sh` script handles:

1. **Building** - Compiles Tailwind CSS, copies HTML files
2. **Uploading** - Sends files to Cloudflare KV storage
3. **Deploying** - Updates the Worker script

### What Gets Deployed

- ✅ HTML files from `dist/`
- ✅ CSS files from `dist/`
- ✅ Images from `dist/assets/` (base64 encoded)
- ✅ Worker script from `deploy/cloudflare/worker.js`

### KV Storage Structure

```
Key                                    | Type    | Size
---------------------------------------|---------|--------
index.html                             | HTML    | ~25KB
quickbooks.html                        | HTML    | ~31KB
styles.css                             | CSS     | ~17KB
assets/logos/logo-square-trans.png    | Base64  | ~20KB
assets/logos/favicon.png              | Base64  | ~41KB
assets/profiles/tomcounsell.jpg       | Base64  | ~270KB
assets/profiles/valorengels.jpg       | Base64  | ~208KB
```

## Environment Variables

### Required for CI/CD (GitHub Actions)

Set these in GitHub repo settings → Secrets:

- `CLOUDFLARE_API_TOKEN` - Get from Cloudflare Dashboard → API Tokens
- `CLOUDFLARE_ACCOUNT_ID` - Already in wrangler.toml (not secret)
- `KV_NAMESPACE_ID` - Already in wrangler.toml (not secret)

### Local Development (Optional)

Create `.env` file (already in .gitignore):

```env
CLOUDFLARE_API_TOKEN=your_token_here
```

## Troubleshooting

### Common Issues

| Problem | Solution |
|---------|----------|
| "Not logged in" | Run `wrangler login` |
| "KV namespace not found" | Check namespace ID in wrangler.toml |
| "Build failed" | Run `npm install` then try again |
| "404 on site" | Check if file was built: `ls dist/` |
| "Images broken" | Verify upload completed: check logs |
| "Deploy failed" | Check API token permissions |

### Debug Commands

```bash
# Check Wrangler auth
wrangler whoami

# List KV contents
wrangler kv:key list --namespace-id=e4b6d938447a4a74bf487f1affc31f60

# Test Worker locally
npm run worker:dev

# View production logs
npm run worker:tail
```

## Performance Notes

- **Global CDN**: Served from 200+ Cloudflare locations
- **Response Time**: <50ms average globally
- **Caching**: HTML (1hr), Assets (24hrs)
- **Free Tier**: 100k requests/day, 1GB storage

## Making Changes

### Quick Edit Workflow

1. Edit files in `src/`
2. Test locally: `npm run dev`
3. Deploy: `npm run deploy:build`
4. Verify: Check https://yuda.me

### Adding Team Members

1. Add to Cloudflare account (dashboard)
2. Grant permissions to:
   - yuda.me domain
   - Workers
   - KV namespace
3. Share repository access

## CI/CD

GitHub Actions automatically deploys on push to `main` branch.

### Manual Deployment
```bash
npm run deploy:build
```

### Automatic Deployment
```bash
git push origin main  # Triggers GitHub Actions
```

## DNS Configuration

Already configured, but for reference:

| Type | Name | Value | Proxy |
|------|------|-------|-------|
| AAAA | @ | 100:: | ON |
| AAAA | www | 100:: | ON |

Workers routes handle actual traffic routing.

## Getting Help

1. **Check logs**: `npm run worker:tail`
2. **Test locally**: `npm run worker:dev`
3. **Read docs**: [Cloudflare Workers Docs](https://developers.cloudflare.com/workers/)
4. **Team contacts**: Listed in package.json

## Rollback Process

If something goes wrong:

1. **Quick fix**: Make change and redeploy
2. **Git rollback**: 
   ```bash
   git revert HEAD
   git push
   ```
3. **Emergency**: Contact Tom or Valor

---

**Last updated**: August 2024  
**Maintained by**: Yudame Team  
**Questions?** Check troubleshooting first, then reach out to the team.
