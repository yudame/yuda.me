# Yudame Business Website

🌐 **Live at**: [yuda.me](https://yuda.me)

A modern, responsive business website for Yudame, featuring AI-forward product development services and product landing pages.

## Tech Stack

- **Frontend**: HTML5 + Tailwind CSS
- **Hosting**: Cloudflare Workers + KV Storage
- **Domain**: yuda.me
- **Build**: Node.js + PostCSS

## Quick Start

### Prerequisites

- Node.js (v16+)
- npm or yarn
- Wrangler CLI (for deployment): `npm install -g wrangler`

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

### Deployment

```bash
# Build and deploy to Cloudflare Workers
npm run deploy:build

# Or separately:
npm run build      # Build the site
npm run deploy     # Deploy to Cloudflare

# Monitor deployment
npm run worker:tail  # View real-time logs
npm run worker:dev   # Test locally with Wrangler
```

For detailed deployment instructions, see [deploy/README.md](deploy/README.md).

## Project Structure

```
├── src/              # Source HTML files
├── dist/             # Built files (generated)
├── assets/           # Images and static assets
├── deploy/           # Deployment scripts and configs
│   ├── cloudflare/   # Cloudflare Worker files
│   └── README.md     # Deployment documentation
├── .github/          # GitHub Actions workflows
├── package.json      # Dependencies and scripts
├── wrangler.toml     # Cloudflare Workers config
├── tailwind.config.js # Tailwind CSS configuration
└── postcss.config.js # PostCSS configuration
```

## Available Scripts

| Script | Description |
|--------|-------------|
| `npm run dev` | Start development server with hot reload |
| `npm run build` | Build production files |
| `npm run clean` | Clean build directory |
| `npm run deploy` | Deploy to Cloudflare Workers |
| `npm run deploy:build` | Build and deploy in one command |
| `npm run worker:dev` | Test Worker locally |
| `npm run worker:tail` | View Worker logs |

## Environment Setup

1. Copy `.env.example` to `.env`
2. Add your Cloudflare credentials:
   ```env
   CLOUDFLARE_ACCOUNT_ID=your_account_id
   CLOUDFLARE_API_TOKEN=your_api_token
   ```

## CI/CD

The project includes GitHub Actions workflow for automatic deployment on push to main branch.

Required GitHub Secrets:
- `CLOUDFLARE_API_TOKEN`
- `CLOUDFLARE_ACCOUNT_ID`
- `KV_NAMESPACE_ID`

## Pages

- **Homepage** (`/`) - Company overview and capabilities
- **QuickBooks MCP** (`/quickbooks.html`) - Product landing page

## Performance

- Hosted on Cloudflare's edge network (200+ locations)
- Static assets cached for 24 hours
- HTML cached for 1 hour
- Average response time: <50ms globally

## Contributing

1. Create a feature branch
2. Make your changes
3. Test locally with `npm run dev`
4. Build with `npm run build`
5. Submit a pull request

## License

© 2024 Yudame. All rights reserved.

---

For deployment documentation, see [deploy/README.md](deploy/README.md)
