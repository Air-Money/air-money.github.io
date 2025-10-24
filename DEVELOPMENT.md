# Development Guide

This Jekyll site has separate configurations for local development and GitHub Pages deployment.

## Local Development

For local development, use the development configuration files:

### Quick Start
```bash
# Run the development server
./scripts/dev.sh
```

### Manual Setup
```bash
# Install development dependencies
BUNDLE_GEMFILE=Gemfile.dev bundle install

# Start Jekyll server with development config
BUNDLE_GEMFILE=Gemfile.dev bundle exec jekyll serve --config _config.dev.yml --livereload
```

### Development Files
- `Gemfile.dev` - Development dependencies (uses just-the-docs gem)
- `_config.dev.yml` - Development configuration (uses theme: "just-the-docs")
- `scripts/dev.sh` - Development server script

## Production Deployment

For GitHub Pages deployment, the main files are used:

### Production Files
- `Gemfile` - Production dependencies (uses remote theme)
- `_config.yml` - Production configuration (uses remote_theme: "just-the-docs/just-the-docs")

## Why Two Configurations?

1. **Local Development**: Uses the `just-the-docs` gem directly, which:
   - Avoids SSL certificate issues when fetching remote themes
   - Provides better performance for local development
   - Allows for easier debugging and customization

2. **GitHub Pages**: Uses remote theme, which:
   - Is compatible with GitHub Pages' gem restrictions
   - Ensures consistent builds in the CI environment
   - Avoids dependency conflicts

## File Structure

```
├── Gemfile                 # Production dependencies (GitHub Pages)
├── Gemfile.dev            # Development dependencies (local)
├── _config.yml            # Production configuration
├── _config.dev.yml        # Development configuration
├── scripts/
│   └── dev.sh             # Development server script
└── DEVELOPMENT.md         # This file
```
