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
