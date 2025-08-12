#!/bin/bash

# Deploy script for yuda.me to Cloudflare Workers + KV
# This script builds the site and uploads all files to Cloudflare KV

set -e  # Exit on error

echo "======================================"
echo "Yuda.me Deployment Script"
echo "======================================"
echo ""

# Configuration - update these if needed
KV_NAMESPACE_ID="e4b6d938447a4a74bf487f1affc31f60"
DIST_DIR="dist"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check if wrangler is installed
if ! command -v wrangler &> /dev/null; then
    echo -e "${RED}❌ Wrangler CLI is not installed.${NC}"
    echo "Install it with: npm install -g wrangler"
    echo "Then run: wrangler login"
    exit 1
fi

# Check if we're in the right directory
if [ ! -f "package.json" ]; then
    echo -e "${RED}❌ Not in project root directory${NC}"
    echo "Please run this script from the yuda.me project root"
    exit 1
fi

# Build the project
echo -e "${YELLOW}📦 Building the project...${NC}"
npm run build

# Check if build was successful
if [ ! -d "$DIST_DIR" ]; then
    echo -e "${RED}❌ Build failed - dist directory not found${NC}"
    exit 1
fi

echo -e "${GREEN}✅ Build complete${NC}"
echo ""

# Upload HTML files
echo -e "${YELLOW}📄 Uploading HTML files...${NC}"
for file in $DIST_DIR/*.html; do
    if [ -f "$file" ]; then
        filename=$(basename "$file")
        echo "  Uploading: $filename"
        wrangler kv:key put --namespace-id="$KV_NAMESPACE_ID" "$filename" \
            --path="$file" --preview=false
    fi
done

# Upload CSS files
echo -e "${YELLOW}🎨 Uploading CSS files...${NC}"
for file in $DIST_DIR/*.css; do
    if [ -f "$file" ]; then
        filename=$(basename "$file")
        echo "  Uploading: $filename"
        wrangler kv:key put --namespace-id="$KV_NAMESPACE_ID" "$filename" \
            --path="$file" --preview=false
    fi
done

# Upload Images (base64 encoded)
echo -e "${YELLOW}🖼️  Uploading images...${NC}"

# Function to upload image
upload_image() {
    local file_path=$1
    local kv_key=$2
    
    if [ -f "$file_path" ]; then
        echo "  Uploading: $kv_key"
        base64 "$file_path" | \
        wrangler kv:key put --namespace-id="$KV_NAMESPACE_ID" \
            "$kv_key" --preview=false
    else
        echo -e "${YELLOW}  ⚠️  Skipping (not found): $kv_key${NC}"
    fi
}

# Upload logo files
upload_image "$DIST_DIR/assets/logos/logo-square-trans.png" "assets/logos/logo-square-trans.png"
upload_image "$DIST_DIR/assets/logos/favicon.png" "assets/logos/favicon.png"
upload_image "$DIST_DIR/assets/logos/logo-brand-trans.png" "assets/logos/logo-brand-trans.png"
upload_image "$DIST_DIR/assets/logos/paint_strip.png" "assets/logos/paint_strip.png"

# Upload profile images
upload_image "$DIST_DIR/assets/profiles/tomcounsell.jpg" "assets/profiles/tomcounsell.jpg"
upload_image "$DIST_DIR/assets/profiles/valorengels.jpg" "assets/profiles/valorengels.jpg"

echo ""
echo -e "${YELLOW}🚀 Deploying Worker...${NC}"
wrangler deploy

echo ""
echo -e "${GREEN}✅ Deployment complete!${NC}"
echo ""
echo "Your site is available at:"
echo "  • https://yuda-me-site.workers.dev"
echo "  • https://yuda.me (once DNS is configured)"
echo "  • https://www.yuda.me (once DNS is configured)"
echo ""
echo "To view logs: wrangler tail yuda-me-site"
