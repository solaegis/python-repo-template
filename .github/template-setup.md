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
