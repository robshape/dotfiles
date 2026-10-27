#!/bin/bash
# Wrapper to invoke TypeScript statusline script
exec npx tsx "$(dirname "$0")/statusline.ts"
