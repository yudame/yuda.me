export default {
  async fetch(request, env) {
    const url = new URL(request.url);
    let path = url.pathname;
    
    // Route handling
    if (path === '/' || path === '') {
      path = '/index.html';
    }
    
    // Remove leading slash for KV lookup
    const kvKey = path.startsWith('/') ? path.slice(1) : path;
    
    try {
      // Try to fetch from KV
      const asset = await env.SITE_ASSETS.get(kvKey);
      
      if (asset) {
        // Determine content type
        const contentType = getContentType(path);
        
        // For binary files (images), we need to handle them differently
        if (contentType.startsWith('image/')) {
          const base64Data = asset;
          const binaryData = Uint8Array.from(atob(base64Data), c => c.charCodeAt(0));
          
          return new Response(binaryData, {
            headers: {
              'Content-Type': contentType,
              'Cache-Control': 'public, max-age=86400',
              'X-Content-Type-Options': 'nosniff',
            }
          });
        }
        
        // For text files (HTML, CSS, JS)
        return new Response(asset, {
          headers: {
            'Content-Type': contentType,
            'Cache-Control': contentType === 'text/html' 
              ? 'public, max-age=3600' 
              : 'public, max-age=86400',
            'X-Content-Type-Options': 'nosniff',
          }
        });
      }
      
      // Try with .html extension if not found
      if (!path.endsWith('.html') && !path.includes('.')) {
        const htmlAsset = await env.SITE_ASSETS.get(kvKey + '.html');
        if (htmlAsset) {
          return new Response(htmlAsset, {
            headers: {
              'Content-Type': 'text/html; charset=utf-8',
              'Cache-Control': 'public, max-age=3600',
            }
          });
        }
      }
      
      // 404 Not Found
      return new Response('404 - Page Not Found', { 
        status: 404,
        headers: {
          'Content-Type': 'text/plain',
        }
      });
      
    } catch (error) {
      // Error handling
      return new Response('Internal Server Error', { 
        status: 500,
        headers: {
          'Content-Type': 'text/plain',
        }
      });
    }
  }
};

function getContentType(path) {
  const ext = path.split('.').pop().toLowerCase();
  const types = {
    'html': 'text/html; charset=utf-8',
    'css': 'text/css; charset=utf-8',
    'js': 'application/javascript; charset=utf-8',
    'json': 'application/json',
    'png': 'image/png',
    'jpg': 'image/jpeg',
    'jpeg': 'image/jpeg',
    'svg': 'image/svg+xml',
    'ico': 'image/x-icon',
    'webp': 'image/webp',
    'gif': 'image/gif'
  };
  return types[ext] || 'application/octet-stream';
}
