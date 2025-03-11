# Python Repository Template

[![License: MIT](https://img.shields.io/badge/license-MIT-brightgreen)](https://github.com/solaegis/python-repo-template/blob/main/LICENSE)
[![Python Version](https://img.shields.io/badge/python-3.8%20%7C%203.9%20%7C%203.10%20%7C%203.11-blue)](https://www.python.org/downloads/)
[![Build tool: Hatch](https://img.shields.io/badge/build%20tool-hatch-4051b5)](https://github.com/pypa/hatch)
[![Package manager: uv](https://img.shields.io/badge/package%20manager-uv-black)](https://github.com/astral-sh/uv)
[![Code style: black](https://img.shields.io/badge/code%20style-black-000000.svg)](https://github.com/psf/black)
[![Imports: isort](https://img.shields.io/badge/%20imports-isort-%231674b1)](https://pycqa.github.io/isort/)
[![Pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit)](https://github.com/pre-commit/pre-commit)
[![Conventional Commits](https://img.shields.io/badge/Conventional%20Commits-1.0.0-yellow.svg)](https://conventionalcommits.org)

A comprehensive and modern template for Python projects with best practices for development, testing, and deployment.

## 🚀 Features

- Modern Python project structure
- Complete CI/CD pipeline using GitHub Actions
- Testing framework with pytest
- Type checking with mypy
- Code formatting with Black and isort
- Linting with flake8
- Pre-commit hooks
- Automated dependency management
- Comprehensive documentation setup
- Virtual environment management
- Development containers for VSCode

## 📋 Prerequisites

- Python 3.8 or higher
- [Git](https://git-scm.com/)
- [Hatch](https://hatch.pypa.io/latest/) for project management
- [uv](https://github.com/astral-sh/uv) for dependency resolution and management

## 🔧 Getting Started

### Creating a New Repository

1. Click the "Use this template" button at the top of this repository
2. Name your repository and set visibility
3. Click "Create repository from template"

### Clone and Setup

```bash
# Clone your new repository
git clone https://github.com/solaegis/python-repo-template.git your-new-repo
cd your-new-repo

# Install dependencies using Hatch with uv backend
hatch env create

# Or using uv directly
uv pip install -e ".[dev]"

# Set up pre-commit hooks
pre-commit install
```

## 📁 Project Structure

```
├── .github/            # GitHub Actions workflows
├── docs/               # Documentation
├── src/                # Source code
│   └── your_package/   # Your package (rename this)
├── tests/              # Test suite
├── .pre-commit-config.yaml  # Pre-commit hooks configuration
├── pyproject.toml      # Project configuration (Hatch and uv settings)
├── README.md           # This file
└── LICENSE             # License file
```

## ⚙️ Configuration

### Renaming the Package

1. Rename the `src/your_package` directory to your desired package name
2. Update references in:
   - `pyproject.toml`
   - `tests/`
   - `.github/workflows/`

### Setting Up Environment Variables

For sensitive information, use GitHub Secrets:

1. Go to your repository settings
2. Navigate to Secrets and Variables > Actions
3. Add necessary secrets for workflows

## 🧪 Development Workflow

### Running Tests

```bash
# Run all tests using Hatch
hatch run test

# Run with coverage report
hatch run test:cov
```

### Formatting and Linting

```bash
# Format code using Hatch
hatch run lint:fmt

# Run linting
hatch run lint:check
hatch run lint:typing
```

### Pre-commit Hooks

Pre-commit hooks run automatically on commit. To run manually:

```bash
pre-commit run --all-files
```

## 📦 Releasing

This template supports automated releasing using GitHub Actions and Hatch:

1. Create a new tag following semantic versioning
2. Push the tag to GitHub
3. The release workflow will:
   - Run tests
   - Build the package using Hatch
   - Publish to PyPI (if configured)
   - Create a GitHub Release

```bash
# Example of creating and pushing a tag
git tag -a v0.1.0 -m "Initial release"
git push origin v0.1.0

# Manual build using Hatch (for local testing)
hatch build
```

## 📚 Documentation

Documentation is generated using [MkDocs](https://www.mkdocs.org/) with the [Material theme](https://squidfunk.github.io/mkdocs-material/), managed through Hatch environments.

```bash
# Build documentation using Hatch
hatch run docs:build

# Serve documentation locally
hatch run docs:serve
```

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 📫 Contact

Project Link: [https://github.com/solaegis/python-repo-template](https://github.com/solaegis/python-repo-template)

---

<p align="center">
  <i>If you found this template useful, please consider giving it a ⭐️!</i>
</p>