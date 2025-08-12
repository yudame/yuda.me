---
description: Kill the running dev server
---

```bash
# Kill server using saved PID if available
if [ -f .claude/.server.pid ]; then
    kill $(cat .claude/.server.pid) 2>/dev/null && echo "Server stopped" || echo "Server not running"
    rm .claude/.server.pid
else
    # Fallback: kill any process on port 8080
    lsof -ti:8080 | xargs -r kill -9 2>/dev/null && echo "Killed process on port 8080" || echo "No server running on port 8080"
fi
```