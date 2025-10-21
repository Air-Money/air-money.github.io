---
layout: default
title: Quickstart Guide
nav_order: 2
description: Get started with Airmoney development in minutes
---

# Airmoney Quickstart Guide

Welcome to the Airmoney development platform! This comprehensive guide will walk you through creating and publishing your first decentralized application (dApp) on the Airmoney ecosystem.

## Prerequisites

Before you begin, ensure you have the following tools installed:

- **Node.js and npm** - Required for package management and CLI tools
- **Solana Wallet Extension** - Browser extension for wallet authentication
- **Git** - For version control and template cloning

## Getting Started

### Step 1: Request Developer Access

To access the Airmoney development platform, you'll need to be whitelisted:

1. Contact the Airmoney team through our official channels
2. Provide your Solana wallet address for whitelist verification
3. Wait for confirmation of your developer access

### Step 2: Install the Airmoney CLI

Install the official Airmoney command-line interface globally:

```bash
npm install -g @airmoney-degn/airmoney-cli
```

Verify the installation by checking the version:

```bash
airmoney-cli --version
```

### Step 3: Developer Registration

1. Navigate to the [Airmoney Developer Dashboard](https://dash-devnet.air.fun/)
2. Connect your browser wallet to authenticate
3. Complete the developer profile registration
4. Generate your API key from the dashboard

Configure your development environment:

```bash
airmoney-cli setup --user <wallet-address> --key <api-key>
```

> **Important:** API keys expire after 24 hours for security purposes. You'll need to generate a new key from the dashboard when your current key expires.

## Project Development

### Creating a New Project

The Airmoney CLI provides a comprehensive project creation system with multiple options:

```bash
Usage: airmoney-cli create [options]

Initialize a new project

Options:
  -N, --name <string>      Project name
  -n, --network <string>   Network: devnet|mainnet (default: "devnet")
  -f, --app-path <string>  Path where project will be created
  --template               Initialize project based on git quickstart template
  -h, --help               Display help for command
```

#### Quick Start with Template

For rapid development, use our pre-configured template:

```bash
airmoney-cli create -N my-awesome-dapp --template
```

This command will:
- Clone the official quickstart repository
- Set up the project structure
- Install necessary dependencies
- Configure build tools

#### Project Configuration

After project creation, update the `metadata.json` file with your application details:

```json
{
  "name": "my-awesome-dapp",
  "displayName": "My Awesome dApp",
  "identifier": "com.yourcompany.my-awesome-dapp",
  "author": "Your Name",
  "maintainer": "Your Name",
  "url": "https://github.com/yourusername/my-awesome-dapp",
  "themeColor": "#C4C4C4",
  "version": "0.1.0",
  "whatsNew": "Initial release",
  "buildNumber": "1",
  "commitHash": "",
  "buildDate": ""
}
```

**Key Configuration Fields:**
- `identifier`: Must be unique across the platform (reverse domain notation recommended)
- `displayName`: User-facing name in the dApp store
- `themeColor`: Primary color for your application's theme
- `version`: Semantic versioning (e.g., 1.0.0)

## Development Workflow

### Building Your Application

1. Install project dependencies:
   ```bash
   npm install
   ```

2. Build your application:
   ```bash
   npm run build
   ```

The build process compiles and bundles your application into a single HTML file, optimized for the Airmoney hardware platform. The output is stored in the `dist` directory.

### Local Development with Simulator

The Airmoney Simulator is a powerful development tool that replicates the hardware device behavior in your browser, enabling rapid iteration and testing.

#### Basic Simulator Usage

Serve a pre-built application:

```bash
npm run serve
```

Or using the CLI directly:

```bash
airmoney-cli serve -f dist
```

#### Advanced Development Setup

For active development with Hot Module Replacement (HMR):

```bash
airmoney-cli serve -u http://localhost:5173
```

**Important:** When using HMR, configure your development server to use a specific port to avoid conflicts with the simulator's WebSocket connection.

Example Vite configuration:

```javascript
export default {
  server: {
    hmr: { port: 5173 }
  }
}
```

#### Simulator Command Reference

```bash
Usage: airmoney-cli serve [options]

Serve locally in the simulator

Options:
  -p, --port <number>            Port (default: "4040")
  -f, --index-app-path <string>  Path for the index.html (default: "./")
  --no-browser                   Prevent browser from opening automatically
  -i, --button-image <string>    Path for custom button images (default: "assets")
  -u, --app-url <string>         URL where the app is running (for HMR)
  -h, --help                     Display help for command
```

> **Current Limitations:** The simulator focuses on UI/UX simulation including screen displays and button interactions. Hardware-specific features like camera, fingerprint sensor, and NFC are not yet implemented but are planned for future releases.

## Publishing Your dApp

### Submission Process

Once your application is built and tested, submit it to the Airmoney dApp Store:

```bash
npm run upload
```

Or using the CLI directly:

```bash
airmoney-cli upload -f dist
```

### Store Registration

After successful submission, complete the store listing:

1. Navigate to the [Developer Dashboard](https://dash-devnet.air.fun/)
2. Locate your submitted package
3. Select the appropriate category for your dApp
4. Click **Register Dapp** to create the store listing
5. Review and click **Sign and Submit** to finalize the submission

Your dApp will be reviewed by the Airmoney team before being published to the store.

## Development Tools

### Simulator Controls

The Airmoney Simulator supports keyboard controls that mimic the hardware device:

| Key | Function |
|-----|----------|
| `←` (Left Arrow) | Left button |
| `→` (Right Arrow) | Right button |
| `↑` (Up Arrow, hold) | Balance button |
| `↓` (Down Arrow) | Mute toggle |
| `Enter` | Rotary knob press |
| `[` | Clockwise rotary rotation |
| `]` | Counter-clockwise rotary rotation |

### Best Practices

- **Testing:** Always test your dApp thoroughly in the simulator before submission
- **Performance:** Optimize your application for the hardware constraints
- **User Experience:** Design with the device's unique interface in mind
- **Security:** Follow security best practices for blockchain applications
- **Documentation:** Provide clear user documentation for your dApp

## Next Steps

- Explore the [API Documentation](/api-reference) for advanced features
- Join our [Developer Community](/community) for support and collaboration
- Check out [Sample Projects](/examples) for inspiration
- Review [Publishing Guidelines](/publishing) for store requirements
