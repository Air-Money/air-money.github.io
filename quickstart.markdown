---
layout: default
title: Quickstart Guide
nav_order: 1
description: Get started with DEGN development in minutes
---

# DEGN Quickstart Guide

Welcome to the DEGN development platform! This comprehensive guide will walk you through creating and publishing your first decentralized application (dApp) on the DEGN ecosystem.

## Prerequisites

Before you get started, ensure you have:

- **Node.js and npm** – Required for package management and CLI tools
- **Git** – For version control and template cloning
- **DEGN CLI** – See <a href="/degn-cli#installation" target="_blank" rel="noopener">installation instructions</a> to install the DEGN CLI on your system.

---

## 🚀 Quick Demo: See DEGN in Action Instantly!

Curious how a DEGN app looks and feels? Run this to launch a live demo-with no setup required:

```bash
airmoney-cli demo
```

This command will:
- Create a working demo project from the official template
- Install dependencies
- Start the dev server
- Open the simulator with hot reload

For more demo options, see <a href="/degn-cli#demo-command" target="_blank" rel="noopener">DEGN CLI Demo Command</a>.

---

## Getting Started

**1. Developer Setup:**

Get your developer credentials from the <a href="https://dash-devnet.air.fun/" target="_blank" rel="noopener">DEGN Developer Dashboard</a>, then run:

```bash
airmoney-cli setup -u YOUR_WALLET_ADDRESS -k YOUR_API_KEY
```
- `-u` Your wallet address
- `-k` Your API key

See <a href="/degn-cli#setup-command" target="_blank" rel="noopener">DEGN CLI — Setup Command</a> for all options.

**2. Create a New Project:**

```bash
airmoney-cli create -N my-awesome-dapp --template
```
- `-N` Your project name
- `--template` Use the official quickstart template

See <a href="/degn-cli#create-command" target="_blank" rel="noopener">DEGN CLI — Create Command</a> for all options.

**Additional Resources:**
Check out community repos for additional templates and examples:
- <a href="https://github.com/cream-hub/degn-template" target="_blank" rel="noopener">degn-template</a>

**3. Develop Your DEGN App:**

```bash
cd my-awesome-dapp #Go to your root project
npm install #Installs project dependencies
npm run dev #Starts the dev server with HMR (default Vite port
```

In a new terminal, run the DEGN simulator and connect to your dev server:

```bash
airmoney-cli serve --app-url http://localhost:5173
```

This will:
- Start the DEGN simulator in your browser
- Serve your app locally for fast development and feedback

See <a href="/degn-cli#serve-command" target="_blank" rel="noopener">DEGN CLI — Serve Command</a> for all options.

**4. Build and Preview Your DEGN App:**

After development, build your app for production:

```bash
npm run build #Bundles your app for deployment on DEGN hardware
```

Preview your production build in the simulator:

```bash
airmoney-cli serve -f dist # Loads the built app from the dist directory
```

See <a href="/degn-cli#serve-command" target="_blank" rel="noopener">DEGN CLI — Serve Command</a> for all options.

**5. Publish Your DEGN App:**

When you're ready, publish your app to the DEGN Store:

```bash
airmoney-cli upload -f dist # Uploads your production build
```

See <a href="/degn-cli#upload-command" target="_blank" rel="noopener">DEGN CLI — Upload Command</a> for all options.

**6. Register and Submit on the Developer Dashboard:**

After uploading:
1. Go to the <a href="https://dash-devnet.air.fun/" target="_blank" rel="noopener">Developer Dashboard</a>
2. Locate your submitted package
3. Complete the store listing and category
4. Click Register Dapp and Sign/Submit

Your app will be reviewed by the DEGN team before publishing.

## Development Tools

**Controller SDK**  
TypeScript library for device control and blockchain features.  
See <a href="/controller-sdk" target="_blank" rel="noopener">Controller SDK documentation</a> for usage details.

**React UI Library**  
Ready-made React components and utilities for building DEGN apps.  
See <a href="/react-ui-library" target="_blank" rel="noopener">React UI documentation</a> for more information.

## API Reference

**DEGN Service API**  
APIs for interacting with the DEGN platform and services.  
See <a href="/degn-service-api" target="_blank" rel="noopener">DEGN Service API documentation</a> for details.

**Crypto Service API**  
APIs for cryptography, key management, and blockchain integration.  
See <a href="/crypto-service-api" target="_blank" rel="noopener">Crypto Service API documentation</a> for details.

## Wallet Interaction

For applications that need to interact with wallets (generate, sign 
transactions, etc.), you can direct users to the native account app 
on the device:

```typescript
import { goToApp } from '@airmoney-degn/controller-sdk';

// Navigate to the account app for wallet operations
goToApp('account-app');
```

The account app is a native application on the DEGN device that 
provides:
- Wallet generation and management
- Transaction signing
- Address management
- Security features

This approach ensures users can perform wallet operations using the 
device's secure native interface.

