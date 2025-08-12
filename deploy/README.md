# Cloudflare Deployment Guide

This guide explains how to deploy the yuda.me site to Cloudflare Workers with KV storage.

## Prerequisites

1. Cloudflare account
2. Wrangler CLI installed (`npm install -g wrangler`)
3. Node.js and npm installed

## Initial Setup

### 1. Login to Cloudflare

```bash
wrangler login
```

### 2. Create KV Namespace

```bash
wrangler kv:namespace create "SITE_ASSETS"
```

Copy the generated namespace ID and update it in `wrangler.toml`.

### 3. Configure DNS

Add your domain to Cloudflare and configure DNS records:

1. Go to Cloudflare Dashboard → Add Site → Enter `yuda.me`
2. Update nameservers at your domain registrar
3. Add DNS records:
   - Type: AAAA, Name: @, IPv6: 100::, Proxy: ON
   - Type: AAAA, Name: www, IPv6: 100::, Proxy: ON

## Deployment

### Automated Deployment

Run the deployment script from the project root:

```bash
./deploy/deploy.sh
```

This script will:
1. Build the project (`npm run build`)
2. Upload all files to KV storage
3. Deploy the Worker

### Manual Deployment

1. Build the project:
   ```bash
   npm run build
   ```

2. Upload files to KV:
   ```bash
   # HTML files
   wrangler kv:key put --namespace-id="YOUR_NAMESPACE_ID" "index.html" --path="dist/index.html"
   wrangler kv:key put --namespace-id="YOUR_NAMESPACE_ID" "quickbooks.html" --path="dist/quickbooks.html"
   
   # CSS files
   wrangler kv:key put --namespace-id="YOUR_NAMESPACE_ID" "styles.css" --path="dist/styles.css"
   
   # Images (base64 encoded)
   base64 dist/assets/logos/favicon.png | wrangler kv:key put --namespace-id="YOUR_NAMESPACE_ID" "assets/logos/favicon.png"
   # ... repeat for other images
   ```

3. Deploy the Worker:
   ```bash
   wrangler deploy
   ```

## Project Structure

```
yuda.me/
├── src/                    # Source files
├── dist/                   # Built files (generated)
├── deploy/                 # Deployment scripts
│   ├── cloudflare/        # Cloudflare-specific files
│   │   └── worker.js      # Worker script
│   ├── deploy.sh          # Automated deployment script
│   └── README.md          # This file
├── wrangler.toml          # Wrangler configuration
└── package.json           # Node.js dependencies
```

## Environment Variables

Create a `.env` file for local development (do not commit):

```env
CLOUDFLARE_ACCOUNT_ID=your_account_id
CLOUDFLARE_API_TOKEN=your_api_token
KV_NAMESPACE_ID=your_namespace_id
```

## Testing

### Local Testing

```bash
wrangler dev
```

This starts a local development server at http://localhost:8787

### Production Testing

After deployment, test at:
- Worker URL: https://yuda-me-site.workers.dev
- Domain: https://yuda.me
- WWW: https://www.yuda.me

## Monitoring

View real-time logs:

```bash
wrangler tail yuda-me-site
```

## Troubleshooting

| Issue | Solution |
|-------|----------|
| 404 errors | Check KV keys match exactly (case-sensitive) |
| Images not loading | Verify base64 encoding is complete |
| Domain not working | Check DNS propagation (dnschecker.org) |
| Worker not triggering | Verify routes in Workers settings |
| Build fails | Run `npm install` and check Node version |

## KV Storage Structure

```
KV Keys:
├── index.html
├── quickbooks.html
├── styles.css
├── assets/
│   ├── logos/
│   │   ├── logo-square-trans.png
│   │   ├── favicon.png
│   │   └── logo-brand-trans.png
│   └── profiles/
│       ├── tomcounsell.jpg
│       └── valorengels.jpg
```

## Updating Content

To update the site:

1. Make changes in `src/`
2. Run `./deploy/deploy.sh`
3. Changes are live immediately

## CI/CD with GitHub Actions

Create `.github/workflows/deploy.yml`:

```yaml
name: Deploy to Cloudflare

on:
  push:
    branches: [main]

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      
      - uses: actions/setup-node@v3
        with:
          node-version: '18'
          
      - run: npm ci
      - run: npm run build
      
      - uses: cloudflare/wrangler-action@v3
        with:
          apiToken: ${{ secrets.CLOUDFLARE_API_TOKEN }}
          command: deploy
```

Add secrets to GitHub:
- `CLOUDFLARE_API_TOKEN`: Your Cloudflare API token

## Performance Optimization

The Worker implements:
- Proper cache headers (1 hour for HTML, 1 day for assets)
- Content-Type detection
- Gzip compression (handled by Cloudflare)
- Global CDN distribution

## Security

- All assets served over HTTPS
- X-Content-Type-Options: nosniff header
- No server-side execution risks
- KV storage is read-only from the internet

## Costs

Free tier includes:
- 100,000 requests/day
- 1 GB KV storage
- Unlimited bandwidth

## Support

For issues or questions:
- Check the troubleshooting section
- Review Cloudflare Workers documentation
- Contact the team

---

Last updated: August 2024
