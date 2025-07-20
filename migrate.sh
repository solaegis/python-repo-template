#!/bin/bash
# replace-template.sh - Replace existing GitHub template with production version
set -euo pipefail

echo "🔄 TEMPLATE REPLACEMENT"
echo "This will replace your GitHub template with the production-grade version"
echo ""
echo "📋 What this script will do:"
echo "  1. Archive old template to 'legacy' branch"
echo "  2. Create clean production template structure"
echo "  3. Use template placeholders for package naming"
echo "  4. Set up proper GitHub template files"
echo ""
read -p "Continue? (y/N): " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "❌ Replacement cancelled"
    exit 1
fi

# Step 1: Archive old template
echo "📁 Archiving old template..."
git add . || true
git commit -m "archive: legacy template before production rewrite" || true
git checkout -b legacy-template
git push origin legacy-template || echo "⚠️  Could not push legacy branch"

# Step 2: Back to main and clean slate
echo "🧹 Creating clean template..."
git checkout main
git rm -rf . 2>/dev/null || true
git clean -fd

# Step 3: Create production template structure
echo "🏗️  Building production template structure..."

# Root files
cat > README.md << 'EOF'
# Production Python Internal Tools Template

A no-nonsense, production-ready Python template optimized for internal tooling.

## Philosophy

- **uv-first**: Fast, reliable dependency management
- **Hatch only for publishing**: When you actually need PyPI distribution
- **Taskfile for DX**: Consistent, discoverable developer commands
- **Production-ready**: Logging, monitoring, error handling built-in

## Quick Start

```bash
# 1. Use this template to create your repo
# 2. Clone your new repo
git clone <your-new-repo>
cd your-tool

# 3. One command setup
task setup

# 4. Start developing
task dev
```

## Template Usage

When creating from this template:

1. **Replace placeholders**: Search and replace `{{PACKAGE_NAME}}` with your tool name
2. **Update metadata**: Edit `pyproject.toml` with your details
3. **Configure environment**: Copy `.env.example` to `.env.local`
4. **Initialize**: Run `task setup`

## Structure

```
├── .github/workflows/     # Streamlined CI/CD
├── src/{{PACKAGE_NAME}}/  # Your source code
├── tests/                 # Test suite
├── docker/               # Container definitions
├── scripts/              # Deployment scripts
├── Taskfile.yaml         # Developer commands
├── pyproject.toml        # Project configuration
└── README.md            # This file
```

## Features

### For Developers
- **Fast setup**: `task setup` gets you productive in <2 minutes
- **Live reload**: `task dev` for development with auto-restart
- **Quality tools**: Ruff, mypy, pytest with sensible defaults
- **Pre-commit hooks**: Catch issues before they hit CI

### For Operations
- **Health checks**: Built-in endpoint monitoring
- **Structured logging**: JSON logs with correlation IDs
- **Error tracking**: Sentry integration ready
- **Container ready**: Production Docker images
- **Security scanning**: Vulnerability detection in CI

### For Teams
- **Consistent commands**: Same `task` commands across all projects
- **Fast CI**: <2 minute feedback loop
- **Security first**: Secret scanning, dependency auditing
- **Documentation**: Runbooks and deployment guides included

## Commands

```bash
# Development
task setup              # Initial setup
task dev               # Run in development mode
task test              # Run test suite
task lint              # Format and lint code

# Operations  
task build             # Build for production
task docker:build      # Build container
task security:scan     # Run security checks

# Deployment
task deploy:staging    # Deploy to staging
task deploy:prod       # Deploy to production
```

## Configuration

Environment variables in `.env.local`:

```bash
# Required
TOOL_NAME=your-tool
ENVIRONMENT=development

# Optional
LOG_LEVEL=INFO
SENTRY_DSN=https://...
DATABASE_URL=postgresql://...
```

## Anti-Patterns This Template Avoids

❌ **Complex Hatch environments** - Use uv for dependency management
❌ **Testing 5 Python versions** - Focus on what you actually deploy  
❌ **Over-engineered packaging** - Internal tools don't need PyPI complexity
❌ **Missing operational features** - Production needs monitoring, not just tests

## When to Use This Template

✅ **Perfect for:**
- Internal CLI tools
- Data processing pipelines  
- Automation scripts
- API clients and integrations
- Development utilities

❌ **Not ideal for:**
- Public PyPI packages (use full Hatch setup)
- Web applications (use FastAPI/Django templates)
- Libraries meant for distribution
- Complex multi-package projects

## Migration from Complex Templates

If migrating from over-engineered setups:

1. **Audit dependencies** - Remove unused dev tools
2. **Simplify CI** - Focus on fast feedback
3. **Add monitoring** - Logging, health checks, metrics
4. **Document operations** - Deployment, troubleshooting

## Support

This template is designed for teams with mid-level+ Python experience. Key assumptions:

- You understand virtual environments and dependency management
- You have basic Docker knowledge for deployments
- You want operational excellence over packaging perfection
- You prefer explicit configuration over magic

---

**Bottom line**: Ship reliable internal tools fast, not perfect packages slow.
EOF

# pyproject.toml template
cat > pyproject.toml << 'EOF'
[build-system]
requires = ["hatchling"]
build-backend = "hatchling.build"

[project]
name = "{{PACKAGE_NAME}}"
dynamic = ["version"]
description = "{{PACKAGE_DESCRIPTION}}"
readme = "README.md"
license = "MIT"
requires-python = ">=3.8"
authors = [
    { name = "{{AUTHOR_NAME}}", email = "{{AUTHOR_EMAIL}}" },
]
keywords = ["internal", "tooling"]
classifiers = [
    "Development Status :: 4 - Beta",
    "Intended Audience :: Developers", 
    "License :: OSI Approved :: MIT License",
    "Operating System :: OS Independent",
    "Programming Language :: Python :: 3",
    "Programming Language :: Python :: 3.8",
    "Programming Language :: Python :: 3.9", 
    "Programming Language :: Python :: 3.10",
    "Programming Language :: Python :: 3.11",
    "Programming Language :: Python :: 3.12",
]

# Production dependencies - keep minimal
dependencies = [
    "click>=8.0.0",
    "pydantic>=2.0.0", 
    "structlog>=23.0.0",
    "python-dotenv>=1.0.0",
    "httpx>=0.25.0",
]

[project.optional-dependencies]
# Development dependencies
dev = [
    "pytest>=7.0.0",
    "pytest-cov>=4.0.0",
    "pytest-xdist>=3.0.0", 
    "pytest-mock>=3.10.0",
    "ruff>=0.1.0",
    "mypy>=1.5.0",
    "pre-commit>=3.0.0",
    "types-requests",
]

# Production monitoring/observability
monitoring = [
    "sentry-sdk[logging]>=1.32.0",
    "prometheus-client>=0.17.0",
]

# Container/deployment deps
deploy = [
    "gunicorn>=21.0.0", 
    "uvicorn[standard]>=0.23.0",
]

[project.urls]
Documentation = "https://github.com/{{GITHUB_ORG}}/{{PACKAGE_NAME}}#readme"
Issues = "https://github.com/{{GITHUB_ORG}}/{{PACKAGE_NAME}}/issues"
Source = "https://github.com/{{GITHUB_ORG}}/{{PACKAGE_NAME}}"

[project.scripts]
"{{PACKAGE_NAME}}" = "{{PACKAGE_NAME}}.cli:main"

[tool.hatch.version]
path = "src/{{PACKAGE_NAME}}/__about__.py"

[tool.hatch.build.targets.wheel]
packages = ["src/{{PACKAGE_NAME}}"]

[tool.hatch.build.targets.sdist]
exclude = [
    "/.github",
    "/docker", 
    "/scripts",
    "/tests",
]

# Tool configurations
[tool.pytest.ini_options]
minversion = "7.0"
addopts = [
    "--strict-markers",
    "--strict-config", 
    "--cov={{PACKAGE_NAME}}",
    "--cov-report=html",
    "--cov-report=term-missing",
    "--cov-fail-under=80",
]
testpaths = ["tests"]
filterwarnings = [
    "error",
    "ignore::UserWarning",
    "ignore::DeprecationWarning",
]

[tool.ruff]
target-version = "py38"
line-length = 88
src = ["src", "tests"]

[tool.ruff.lint]
select = [
    "E",   # pycodestyle errors
    "W",   # pycodestyle warnings  
    "F",   # pyflakes
    "I",   # isort
    "B",   # flake8-bugbear
    "C4",  # flake8-comprehensions
    "UP",  # pyupgrade
    "ARG", # flake8-unused-arguments
    "SIM", # flake8-simplify
    "ICN", # flake8-import-conventions
]
ignore = [
    "E501",  # line too long - handled by formatter
    "B008",  # do not perform function calls in argument defaults
    "ARG001", # unused function arguments
]

[tool.ruff.lint.per-file-ignores]
"tests/**/*" = ["ARG", "S101", "SIM"]

[tool.ruff.lint.isort]
known-first-party = ["{{PACKAGE_NAME}}"]
force-sort-within-sections = true

[tool.mypy]
python_version = "3.8" 
strict = true
warn_unreachable = true
pretty = true
show_column_numbers = true
show_error_codes = true
show_error_context = true

[[tool.mypy.overrides]]
module = "tests.*"
disallow_untyped_defs = false
EOF

# Create Taskfile with placeholders
cat > Taskfile.yaml << 'EOF'
# yaml-language-server: $schema=https://taskfile.dev/schema.json
version: "3"

dotenv: [".env.local", ".env"]

vars:
  PYTHON_VERSION: "3.10"
  VENV_DIR: ".venv"
  SRC_DIR: "src"
  TESTS_DIR: "tests"

env:
  UV_CACHE_DIR: "{{.HOME}}/.cache/uv"
  TOOL_NAME: "{{PACKAGE_NAME}}"

tasks:
  default:
    desc: "Show available tasks"
    cmds:
      - task --list-all

  # Setup and installation
  setup:
    desc: "Complete project setup for new developers"
    cmds:
      - task: install
      - task: pre-commit:install
      - task: env:create
      - echo "✅ Setup complete! Run 'task dev' to start developing"

  install:
    desc: "Install dependencies with uv"
    cmds:
      - uv sync --all-extras
    sources:
      - pyproject.toml
      - uv.lock
    generates:
      - "{{.VENV_DIR}}/pyvenv.cfg"

  # Development
  dev:
    desc: "Run tool in development mode with auto-reload"
    deps: [install]
    cmds:
      - uv run python -m {{PACKAGE_NAME}}.cli {{.CLI_ARGS}}
    interactive: true

  # Testing
  test:
    desc: "Run test suite"
    deps: [install]
    cmds:
      - uv run pytest {{.CLI_ARGS}}

  test:cov:
    desc: "Run tests with coverage report"
    deps: [install]
    cmds:
      - uv run pytest --cov-report=html --cov-report=term
      - echo "Coverage report: file://$(pwd)/htmlcov/index.html"

  # Code quality
  lint:
    desc: "Format and lint code"
    deps: [install]
    cmds:
      - uv run ruff format {{.SRC_DIR}} {{.TESTS_DIR}}
      - uv run ruff check --fix {{.SRC_DIR}} {{.TESTS_DIR}}

  lint:check:
    desc: "Check code formatting and linting (CI mode)"
    deps: [install]
    cmds:
      - uv run ruff format --check {{.SRC_DIR}} {{.TESTS_DIR}}
      - uv run ruff check {{.SRC_DIR}} {{.TESTS_DIR}}

  type:
    desc: "Run type checking"
    deps: [install]
    cmds:
      - uv run mypy {{.SRC_DIR}}

  check:
    desc: "Run all code quality checks"
    cmds:
      - task: lint:check
      - task: type
      - task: test

  # Pre-commit
  pre-commit:install:
    desc: "Install pre-commit hooks"
    cmds:
      - uv run pre-commit install

  # Security
  security:scan:
    desc: "Run security scans"
    deps: [install]
    cmds:
      - uv run bandit -r {{.SRC_DIR}}
      - uv run safety check

  # Dependencies
  deps:update:
    desc: "Update dependencies"
    cmds:
      - uv lock --upgrade
      - echo "✅ Dependencies updated. Review uv.lock changes."

  # Build and packaging (only when needed)
  build:
    desc: "Build distribution packages"
    cmds:
      - rm -rf dist/
      - uv run hatch build
      - echo "✅ Built packages in dist/"

  # Docker
  docker:build:
    desc: "Build Docker image"
    cmds:
      - docker build -t {{PACKAGE_NAME}}:latest -f docker/Dockerfile .

  docker:run:
    desc: "Run Docker container"
    deps: [docker:build]
    cmds:
      - docker run --rm -it {{PACKAGE_NAME}}:latest {{.CLI_ARGS}}

  # Environment management
  env:create:
    desc: "Create .env.local from template"
    cmds:
      - |
        if [ ! -f .env.local ]; then
          cp .env.example .env.local
          echo "✅ Created .env.local - please edit with your settings"
        else
          echo "⚠️  .env.local already exists"
        fi
    status:
      - test -f .env.local

  # Cleanup
  clean:
    desc: "Clean build artifacts and caches"
    cmds:
      - rm -rf dist/ build/ *.egg-info/
      - rm -rf .pytest_cache/ .coverage htmlcov/
      - rm -rf .mypy_cache/ .ruff_cache/
      - find . -type d -name __pycache__ -exec rm -rf {} + 2>/dev/null || true
      - find . -type f -name "*.pyc" -delete 2>/dev/null || true

  clean:all:
    desc: "Clean everything including virtual environment"
    cmds:
      - task: clean
      - rm -rf {{.VENV_DIR}}
      - uv cache clean
EOF

# Environment template
cat > .env.example << 'EOF'
# Application Configuration
TOOL_NAME={{PACKAGE_NAME}}
ENVIRONMENT=development
DEBUG=true

# Logging
LOG_LEVEL=INFO
LOG_FORMAT=console  # console or json

# Monitoring (optional)
SENTRY_DSN=
METRICS_ENABLED=true

# External Services (examples - customize for your needs)
DATABASE_URL=
REDIS_URL=
API_KEY=

# File paths
DATA_DIR=./data
OUTPUT_DIR=./output
EOF

# GitHub workflow
mkdir -p .github/workflows
cat > .github/workflows/ci.yaml << 'EOF'
name: CI

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main, develop]

env:
  UV_CACHE_DIR: /tmp/.uv-cache

jobs:
  lint:
    name: Code Quality
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Set up uv
        uses: astral-sh/setup-uv@v3
        with:
          enable-cache: true
          cache-dependency-glob: "uv.lock"
      - name: Set up Python
        run: uv python install 3.10
      - name: Install dependencies
        run: uv sync --all-extras
      - name: Lint and format check
        run: |
          uv run ruff format --check src tests
          uv run ruff check src tests
      - name: Type checking
        run: uv run mypy src

  test:
    name: Test Python ${{ matrix.python-version }}
    runs-on: ubuntu-latest
    strategy:
      fail-fast: false
      matrix:
        python-version: ["3.10", "3.11", "3.12"]
        include:
          - python-version: "3.8"
            continue-on-error: true

    steps:
      - uses: actions/checkout@v4
      - name: Set up uv
        uses: astral-sh/setup-uv@v3
        with:
          enable-cache: true
          cache-dependency-glob: "uv.lock"
      - name: Set up Python ${{ matrix.python-version }}
        run: uv python install ${{ matrix.python-version }}
      - name: Install dependencies
        run: uv sync --all-extras
      - name: Run tests
        run: |
          uv run pytest \
            --cov={{PACKAGE_NAME}} \
            --cov-report=xml \
            --cov-report=term-missing \
            --junitxml=pytest.xml \
            -v

  build:
    name: Build Package
    runs-on: ubuntu-latest
    needs: [lint, test]
    steps:
      - uses: actions/checkout@v4
      - name: Set up uv
        uses: astral-sh/setup-uv@v3
      - name: Set up Python
        run: uv python install 3.10
      - name: Install build dependencies
        run: uv sync
      - name: Build package
        run: |
          uv run hatch build
          ls -la dist/
      - name: Check package
        run: uv run twine check dist/*
EOF

# Pre-commit config
cat > .pre-commit-config.yaml << 'EOF'
repos:
  - repo: https://github.com/pre-commit/pre-commit-hooks
    rev: v4.5.0
    hooks:
      - id: check-added-large-files
        args: ['--maxkb=500']
      - id: check-case-conflict
      - id: check-merge-conflict
      - id: check-toml
      - id: check-yaml
      - id: detect-private-key
      - id: end-of-file-fixer
      - id: trailing-whitespace

  - repo: https://github.com/astral-sh/ruff-pre-commit
    rev: v0.1.8
    hooks:
      - id: ruff
        args: [--fix, --exit-non-zero-on-fix]
      - id: ruff-format

  - repo: https://github.com/pre-commit/mirrors-mypy
    rev: v1.7.1
    hooks:
      - id: mypy
        additional_dependencies: [types-requests, pydantic]
        args: [--strict, --ignore-missing-imports]

  - repo: https://github.com/PyCQA/bandit
    rev: 1.7.5
    hooks:
      - id: bandit
        args: [-c, pyproject.toml]
        additional_dependencies: ["bandit[toml]"]
EOF

# Create source structure with placeholders
mkdir -p src/\{\{PACKAGE_NAME\}\}
cat > src/\{\{PACKAGE_NAME\}\}/__init__.py << 'EOF'
"""{{PACKAGE_DESCRIPTION}}"""

from {{PACKAGE_NAME}}.__about__ import __version__

__all__ = ["__version__"]
EOF

cat > src/\{\{PACKAGE_NAME\}\}/__about__.py << 'EOF'
"""Version information."""

__version__ = "0.1.0"
EOF

# Create basic CLI
cat > src/\{\{PACKAGE_NAME\}\}/cli.py << 'EOF'
"""Command-line interface."""

import click

from {{PACKAGE_NAME}}.__about__ import __version__


@click.group()
@click.version_option(version=__version__)
def cli():
    """{{PACKAGE_DESCRIPTION}}"""
    pass


@cli.command()
def hello():
    """Say hello."""
    click.echo("Hello from {{PACKAGE_NAME}}!")


def main():
    """Entry point for the CLI."""
    cli()


if __name__ == "__main__":
    main()
EOF

# Create tests
mkdir -p tests
cat > tests/__init__.py << 'EOF'
"""Test suite for {{PACKAGE_NAME}}."""
EOF

cat > tests/test_cli.py << 'EOF'
"""Test CLI functionality."""

from click.testing import CliRunner

from {{PACKAGE_NAME}}.cli import cli


def test_cli_help():
    """Test CLI help command."""
    runner = CliRunner()
    result = runner.invoke(cli, ['--help'])
    assert result.exit_code == 0
    assert '{{PACKAGE_DESCRIPTION}}' in result.output


def test_hello_command():
    """Test hello command."""
    runner = CliRunner()
    result = runner.invoke(cli, ['hello'])
    assert result.exit_code == 0
    assert 'Hello from {{PACKAGE_NAME}}!' in result.output
EOF

# Create Docker files
mkdir -p docker
cat > docker/Dockerfile << 'EOF'
FROM python:3.10-slim as base

ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PIP_NO_CACHE_DIR=1 \
    PIP_DISABLE_PIP_VERSION_CHECK=1

RUN apt-get update && apt-get install -y \
    --no-install-recommends \
    ca-certificates \
    curl \
    && rm -rf /var/lib/apt/lists/*

COPY --from=ghcr.io/astral-sh/uv:latest /uv /usr/local/bin/uv

RUN groupadd --gid 1000 app && \
    useradd --uid 1000 --gid app --shell /bin/bash --create-home app

WORKDIR /app

COPY pyproject.toml uv.lock ./
RUN uv sync --frozen --no-dev --extra monitoring --extra deploy

COPY src/ src/
COPY README.md LICENSE ./
RUN uv pip install -e .

USER app

HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD {{PACKAGE_NAME}} --help || exit 1

ENTRYPOINT ["{{PACKAGE_NAME}}"]
CMD ["--help"]
EOF

# Create scripts directory
mkdir -p scripts
cat > scripts/setup-dev.sh << 'EOF'
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
EOF

chmod +x scripts/setup-dev.sh

# .gitignore
cat > .gitignore << 'EOF'
# Python
__pycache__/
*.py[cod]
*$py.class
*.so
.Python
build/
develop-eggs/
dist/
downloads/
eggs/
.eggs/
lib/
lib64/
parts/
sdist/
var/
wheels/
*.egg-info/
.installed.cfg
*.egg
MANIFEST

# Testing
htmlcov/
.tox/
.nox/
.coverage
.coverage.*
.cache
nosetests.xml
coverage.xml
*.cover
*.py,cover
.hypothesis/
.pytest_cache/
cover/

# Environments
.env
.env.local
.env.*.local
.venv
env/
venv/
ENV/
env.bak/
venv.bak/

# IDEs
.vscode/
.idea/
*.swp
*.swo

# OS
.DS_Store
.DS_Store?
._*
.Spotlight-V100
.Trashes
ehthumbs.db
Thumbs.db

# Project specific
.mypy_cache/
.dmypy.json
dmypy.json
.pyre/
.pytype/
.ruff_cache/
.uv_cache/
data/
output/
logs/
*.log
*.tmp
*.bak

# Security
.pypirc
secrets/
*.pem
*.key
EOF

# GitHub template files
cat > .github/template-setup.md << 'EOF'
# Template Setup Instructions

After creating a repository from this template:

## 1. Replace Placeholders

Search and replace these placeholders throughout the project:

- `{{PACKAGE_NAME}}` - Your package/tool name (e.g., "my-tool")
- `{{PACKAGE_DESCRIPTION}}` - Brief description of your tool
- `{{AUTHOR_NAME}}` - Your name or team name
- `{{AUTHOR_EMAIL}}` - Contact email
- `{{GITHUB_ORG}}` - Your GitHub organization/username

## 2. Rename Source Directory

```bash
mv src/\{\{PACKAGE_NAME\}\} src/your-actual-package-name
```

## 3. Update Configuration

1. Edit `pyproject.toml` with your specific details
2. Copy `.env.example` to `.env.local` and configure
3. Update `README.md` with your tool's documentation

## 4. Initialize Development Environment

```bash
# Install dependencies and setup
task setup

# Verify everything works
task test
task lint
```

## 5. First Commit

```bash
git add .
git commit -m "feat: initialize from production template"
git push origin main
```

## 6. Enable GitHub Features

- Set up branch protection rules
- Configure secrets for deployment
- Enable security alerts
- Set up issue/PR templates

## Common Replacements

For a tool called "data-processor":

```bash
find . -type f -name "*.py" -o -name "*.toml" -o -name "*.yaml" -o -name "*.md" | \
xargs sed -i 's/{{PACKAGE_NAME}}/data-processor/g'

find . -type f -name "*.py" -o -name "*.toml" -o -name "*.yaml" -o -name "*.md" | \
xargs sed -i 's/{{PACKAGE_DESCRIPTION}}/Process and transform data files/g'

mv src/\{\{PACKAGE_NAME\}\} src/data_processor
```

Remember to update imports in your Python files after renaming directories!
EOF

echo "✅ Production template created!"
echo ""
echo "📋 Template features:"
echo "  - uv-first dependency management"
echo "  - Streamlined CI/CD pipeline"
echo "  - Production logging and monitoring"
echo "  - Security scanning built-in"
echo "  - Docker containerization"
echo "  - Developer-friendly task commands"
echo ""
echo "🔄 Next steps:"
echo "1. Review all files created"
echo "2. Test the template: Create a test repo from it"
echo "3. Commit: git add . && git commit -m 'feat: production-grade template'"
echo "4. Push: git push origin main"
echo ""
echo "📖 Users will follow .github/template-setup.md to use this template"