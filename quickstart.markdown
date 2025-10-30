---
layout: default
title: Quickstart Guide
nav_order: 1
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

**Additional Resources:**
Check out community repos for additional templates and examples:
- [degn-template](https://github.com/cream-hub/degn-template)

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

- `name`: Application name
- `displayName`: User-facing name in the dApp store
- `identifier`: Must be unique across the platform (reverse domain notation recommended)
- `author`: Developer name
- `maintainer`: Maintainer name
- `url`: Project URL
- `themeColor`: Primary color for your application's theme
- `version`: Semantic versioning (e.g., 1.0.0)
- `whatsNew`: Description of what's new in this version
- `buildNumber`: Build number for this release
- `commitHash`: Git commit hash
- `buildDate`: Build date

## Development Workflow

### Development Tools

**Controller SDK**
The AirMoney Controller SDK provides TypeScript APIs for device control and blockchain operations:

```bash
npm install @airmoney-degn/controller-sdk
```

Key features:
- Device screen control and image display
- Cryptographic operations (EVM, Solana, Bitcoin)
- Key event handling and button management
- Utility functions for navigation and validation

**React UI Library**
A comprehensive React UI library with pre-built components and hooks:

```bash
npm install @airmoney-degn/react-ui
```

Key features:
- Pre-built UI components (Keyboard, Layout, Forms)
- Custom hooks for device integration
- State management utilities
- Tailwind CSS styling with custom theming

### Wallet Interactions

For applications that need to interact with wallets (generate, sign transactions, etc.), you can direct users to the native account app on the device:

```typescript
import { goToApp } from '@airmoney-degn/controller-sdk';

// Navigate to the account app for wallet operations
goToApp('account-app');
```

The account app is a native application on the AirMoney device that provides:
- Wallet generation and management
- Transaction signing
- Address management
- Security features

This approach ensures users can perform wallet operations using the device's secure native interface.

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

#### Expected Output Structure

After building your application, the `dist` directory should contain at minimum the following structure:

```
dist/
├── assets/           # Static assets (CSS, JS, images, button images)
├── dapp-logo.png     # Application logo/icon
├── index.html        # Main application file
└── metadata.json     # Application metadata
```

**Required Files:**

- `index.html`: Your compiled application - this is the main entry point
- `metadata.json`: Contains application configuration and metadata
- `dapp-logo.png`: Your application's icon (recommended size: 512x512px)
- `assets/`: Directory containing all bundled CSS, JavaScript, static resources, and button images for the simulator

> **Note:** This structure shows the minimum required files. Your application folder can contain additional files and directories as needed for your specific dApp functionality.

### Local Development with Simulator

The Airmoney Simulator is a powerful development tool that replicates the hardware device behavior in your browser, enabling rapid iteration and testing.

#### Development Setup

For active development with Hot Module Replacement (HMR), use the `--app-url` option:

```bash
airmoney-cli serve -u http://localhost:5173
```

#### Preview your app

Preview your built application in the simulator:

```bash
airmoney-cli serve -f dist
```

**Important:** When using HMR, configure your development server to use a specific port to avoid conflicts with the simulator's WebSocket connection.

**Simulator Controls:**
- `←` (Left Arrow) - Left button
- `→` (Right Arrow) - Right button  
- `↑` (Up Arrow, hold) - Balance button
- `↓` (Down Arrow) - Mute toggle
- `Enter` - Rotary knob press
- `[` - Clockwise rotary rotation
- `]` - Counter-clockwise rotary rotation

Example Vite configuration:

```javascript
export default {
  server: {
    hmr: { port: 5173 },
  },
};
```

#### Simulator Command Reference

```bash
Usage: airmoney-cli serve [options]

Serve locally in the simulator

Options:
  -f, --index-app-path <string>  Path for the index.html (default: "./")
  --no-browser                   Prevent browser from opening automatically
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
