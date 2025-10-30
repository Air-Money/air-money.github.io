---
layout: default
title: DEGN CLI
nav_order: 2
description: Complete guide to the DEGN command-line interface for dApp development
---

# DEGN CLI

The DEGN CLI is your all-in-one command-line tool for developing, testing, and publishing decentralized applications (dApps) on the DEGN platform. It simplifies the entire development workflow from project creation to store publication.

## Installation

### Prerequisites

Before installing the CLI, make sure you have:
- **Node.js** (version 16 or higher)
- **npm** (comes with Node.js)
- **Git** (for template projects)

### Install the CLI

Install the DEGN CLI globally on your system:

```bash
npm install -g @airmoney-degn/airmoney-cli
```

### Verify Installation

Check that the CLI is installed correctly:

```bash
airmoney-cli --version
```

You should see the current version number (e.g., `0.13.2`).

## Complete Command Reference

### Demo Command

Serve a ready-to-run demo app with hot reloading in the simulator:

```bash
airmoney-cli demo [-N <project-name>] [-f <path>]
```

What it does:
- Clones the official quickstart template
- Installs dependencies and starts the dev server
- Launches the simulator pointed at `http://localhost:5173`

### Setup Command

Configure your development environment:

```bash
airmoney-cli setup -u <wallet-address> -k <api-key> [-n <network>]
```

**What it does:**
- Saves your developer credentials securely
- Sets up the development environment
- Required before using other commands

### Create Command

Initialize a new dApp project:

```bash
airmoney-cli create -N <project-name> [-f <path>] [--template]
```

**What it does:**
- Creates a new project folder with basic structure
- Generates `metadata.json` with project information
- Optionally clones the official template
- Sets up basic HTML, CSS, and JavaScript files

**Project Structure Created:**
```
my-dapp/
├── index.html          # Main app file
├── metadata.json       # Project configuration
└── assets/            # Static assets folder
    ├── main.js        # JavaScript code
    └── style.css      # Styling
```

**Project Configuration (metadata.json):**

Your project's `metadata.json` file contains important configuration:

```json
{
  "name": "my-awesome-dapp",
  "displayName": "My Awesome dApp",
  "identifier": "com.degn.my-awesome-dapp",
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

### Serve Command

Test your dApp locally with the simulator:

```bash
airmoney-cli serve [-f <path>] [--no-browser] [-u <url>]
```

**Options:**
- `-f, --index-app-path <string>` - Path to your app files (default: `./`)
- `--no-browser` - Don't open browser automatically
- `-u, --app-url <string>` - Use external development server URL

Note: `--index-app-path` and `--app-url` are mutually exclusive.

**What it does:**
- Starts the DEGN simulator
- Serves your dApp for testing
- Provides device simulation (buttons, screens, etc.)
- Supports hot reloading for development

**Simulator Controls:**
- `←` (Left Arrow) - Left button
- `→` (Right Arrow) - Right button  
- `↑` (Up Arrow) - Balance button
- `↓` (Down Arrow) - Mute toggle
- `Enter` - Rotary knob press
- `[` - Clockwise rotary rotation
- `]` - Counter-clockwise rotary rotation

**Navigation Shortcuts:**
- `←` + `→` - Back
- `↑` + `←` + `→` - Go to device home

### Upload Command

Publish your dApp to the DEGN store:

```bash
airmoney-cli upload [-n <network-endpoint>] [-f <path>] [-i <button-images>]
```

**Options:**
- `-n, --network <string>` - Network endpoint (default: `https://rpc-dev.air.fun`)
- `-f, --index-app-path <string>` - Path to your app files (default: `./`)
- `-i, --button-image <string>` - Path to button images (default: `assets`)

**What it does:**
- Packages your dApp into a distributable format
- Uploads to the DEGN dApp store
- Provides upload confirmation and store link

### Wallet Commands

Manage crypto wallets for different blockchains:

```bash
airmoney-cli wallet [options] [-c <chain>]
```

**Chain Options:**
- `evm` - Ethereum and EVM-compatible chains (default)
- `svm` - Solana
- `btc` - Bitcoin

**Wallet Operations:**

**List all wallets:**
```bash
airmoney-cli wallet -l -c evm
```

**Generate new wallet:**
```bash
airmoney-cli wallet -g -c evm
```

**Import existing wallet:**
```bash
airmoney-cli wallet -i <private-key> -c evm
```

**Export wallet private key:**
```bash
airmoney-cli wallet -e <wallet-address> -c evm
```

**Set default wallet:**
```bash
airmoney-cli wallet -sd <wallet-address> -c evm
```

**Get default wallet:**
```bash
airmoney-cli wallet -gd -c evm
```

**Delete wallet:**
```bash
airmoney-cli wallet -d <wallet-address> -c evm
```
