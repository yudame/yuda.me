# Yudame Website Rebuild Plan

## Objective
Complete rebuild of yuda.me as a modern business website showcasing Yudame's products and services, with dedicated landing pages for each product offering.

## Architecture Overview

### Tech Stack
- **HTML**: Static pages with semantic structure
- **Tailwind CSS**: Utility-first styling (compiled locally, deployed as static CSS)
- **JavaScript**: Inline only, no external dependencies
- **Hosting**: Cloudflare Pages
- **Build Process**: Node.js/npm for Tailwind compilation only

### Directory Structure
```
yuda.me/
├── src/                      # Source files
│   ├── index.html           # Homepage - Company overview
│   ├── quickbooks.html      # QuickBooks MCP landing page
│   └── styles.css           # Tailwind input file
├── dist/                    # Production build (git-ignored)
│   ├── index.html
│   ├── quickbooks.html
│   ├── styles.css          # Compiled Tailwind
│   └── assets/
├── assets/                  # Static assets
│   ├── logos/
│   ├── images/
│   └── icons/
├── docs/
│   └── plans/
│       └── rebuild.md
├── package.json
├── tailwind.config.js
├── postcss.config.js
└── .gitignore
```

## Pages to Build

### 1. Homepage (index.html)
**Purpose**: Corporate landing showcasing Yudame as an innovation lab

**Sections**:
- Hero: "Building Tomorrow's Digital Products"
- About: Brief company overview
- Portfolio: Client showcase
  - Deckfusion (Data storytelling)
  - Bumble (Social platform)
  - Chainstarters (Web3 no-code)
  - Other notable clients
- Products: Our own innovations
  - QuickBooks MCP for Claude
  - AI Agents Suite
  - Other Yudame products
- Contact/CTA: Connect with us

**Design Elements**:
- Clean, professional layout
- Yellow/red accent colors (brand colors)
- Mobile-first responsive design
- Fast loading, minimal JavaScript

### 2. QuickBooks MCP Landing Page (quickbooks.html)
**Purpose**: Product page for QuickBooks Claude Desktop integration

**Sections**:
- Hero: "QuickBooks + Claude Desktop = Accounting Superpowers"
- Problem: Manual accounting tasks are tedious
- Solution: AI-powered QuickBooks assistant in Claude
- Features:
  - Natural language queries
  - Automated report generation
  - Smart reconciliation
  - Invoice processing
- How it Works: 3-step process
- Pricing: Early access/waitlist
- CTA: Join waitlist or sign up
- FAQ: Common questions

**Design Elements**:
- Product-focused layout
- Screenshots/demos (if available)
- Trust signals (security, privacy)
- Clear value proposition
- Strong CTAs throughout

## Implementation Steps

### Phase 1: Setup & Cleanup
1. ✅ Create new branch `rebuild-business-site`
2. ✅ Set up package.json with Tailwind dependencies
3. ✅ Configure Tailwind and PostCSS
4. Remove old files:
   - Delete old index.html
   - Remove CNAME (for GitHub Pages)
   - Clean up unused assets
5. Set up new directory structure

### Phase 2: Build Core Pages
1. Create Tailwind base styles (src/styles.css)
2. Build homepage (src/index.html)
   - Header/navigation component
   - Hero section
   - Portfolio grid
   - Products showcase
   - Footer
3. Build QuickBooks landing (src/quickbooks.html)
   - Product hero
   - Features section
   - Pricing/waitlist
   - FAQ section

### Phase 3: Styling & Polish
1. Implement responsive design
2. Add micro-interactions (inline JS)
3. Optimize images
4. Performance optimization
5. Cross-browser testing

### Phase 4: Deployment Setup
1. Configure Cloudflare Pages
2. Set up build command: `npm run build`
3. Set publish directory: `dist`
4. Configure custom domain (yuda.me)
5. Set up redirects if needed

## Design System

### Colors
- Primary: Yudame Yellow (#FFC107)
- Secondary: Yudame Red (#DC2626)
- Dark: #1F2937
- Light backgrounds: #F9FAFB, #FFFFFF
- Text: #111827 (primary), #6B7280 (secondary)

### Typography
- Headlines: Raleway (Google Fonts)
- Body: System font stack
- Sizes: Tailwind's default scale

### Components (Tailwind utilities)
- Buttons: Yellow primary, red secondary
- Cards: White bg with subtle shadows
- Navigation: Sticky header, mobile hamburger
- Forms: Clean inputs for waitlist signup

## Content Requirements

### Homepage Content
- Company mission statement
- Client logos/testimonials
- Product descriptions
- Team info (optional)

### QuickBooks Page Content
- Feature list with benefits
- Pricing structure
- Security/compliance info
- Integration requirements
- Support information

## Success Metrics
- Page load time < 2 seconds
- Mobile-first responsive design
- Clear CTAs with tracking
- SEO-optimized structure
- Accessibility standards met

## Timeline
1. **Day 1**: Setup, cleanup, base structure
2. **Day 2**: Homepage development
3. **Day 3**: QuickBooks landing page
4. **Day 4**: Polish, optimize, test
5. **Day 5**: Deploy to Cloudflare Pages

## Notes
- All JavaScript must be inline
- No external JS dependencies
- Images optimized for web
- Consider adding more product pages later
- Maintain clean, semantic HTML
- Focus on conversion optimization