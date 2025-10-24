#!/bin/bash

# Development script for Jekyll site
# This script uses the development configuration files

echo "Setting up development environment..."

# Install development dependencies
if [ ! -f "Gemfile.dev.lock" ]; then
    echo "Installing development gems..."
    BUNDLE_GEMFILE=Gemfile.dev bundle install
fi

# Start Jekyll server with development configuration
echo "Starting Jekyll development server..."
echo "Site will be available at: http://localhost:4000"
echo "Press Ctrl+C to stop the server"

BUNDLE_GEMFILE=Gemfile.dev bundle exec jekyll serve --config _config.dev.yml --livereload
