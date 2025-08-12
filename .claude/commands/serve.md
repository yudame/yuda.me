---
description: Launch dev server at localhost:8080 (kills existing)
---

```bash
# Kill any existing server on port 8080
lsof -ti:8080 | xargs -r kill -9 2>/dev/null || true

# Start the server in background
cd dist && python3 -m http.server 8080 &
SERVER_PID=$!
echo "Server started at http://localhost:8080 (PID: $SERVER_PID)"
echo $SERVER_PID > .claude/.server.pid
```