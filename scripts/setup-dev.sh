#!/bin/bash
set -euo pipefail

echo "🚀 Setting up development environment..."

# Check prerequisites
command -v uv >/dev/null 2>&1 || { 
    echo "❌ uv is required but not installed. Install from: https://github.com/astral-sh/uv"
    exit 1
}
command -v task >/dev/null 2>&1 || { 
    echo "❌ Task is required but not installed. Install from: https://taskfile.dev"
    exit 1
}

# Run setup
task setup

echo "✅ Development environment setup complete!"
echo ""
echo "Next steps:"
echo "1. Edit .env.local with your configuration"
echo "2. Run 'task dev' to start developing"
echo "3. Run 'task test' to run tests"
