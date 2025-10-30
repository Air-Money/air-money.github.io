---
layout: default
title: DEGN CLI
nav_order: 2
description: Complete guide to the DEGN command-line interface for dApp development
---

# DEGN CLI

The DEGN CLI is your all-in-one command-line tool for developing, testing, and publishing decentralized applications (dApps) on the DEGN platform. It simplifies the entire development workflow from project creation to store publication.

## What You Can Do

- **Set up your development environment** with your developer credentials
- **Create new dApp projects** from scratch or using templates
- **Test your apps locally** with the built-in simulator
- **Manage crypto wallets** for EVM, Solana, and Bitcoin
- **Publish your dApps** to the DEGN store

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

## Getting Started

### Step 1: Developer Setup

Before you can use the CLI, you need to set up your developer credentials:

1. **Get your developer credentials** from the <a href="https://dash-devnet.air.fun/" target="_blank" rel="noopener">DEGN Developer Dashboard</a>
2. **Run the setup command** with your details:

```bash
airmoney-cli setup -u YOUR_WALLET_ADDRESS -k YOUR_API_KEY
```

**Options:**
- `-u, --user <string>` - Your Solana wallet address (required)
- `-k, --key <string>` - Your API key from the dashboard (required)
- `-n, --network <string>` - Network: `devnet` or `mainnet` (default: `devnet`)

**Example:**
```bash
airmoney-cli setup -u 9WzDXwBbmkg8ZTbNMqUxvQRAyrZzDsGYdLVL9zYtAWWM -k abc123def456 -n devnet
```

This creates a `.env` file in your system's config directory with your credentials.

### Step 2: Create Your First Project

Create a new dApp project:

```bash
airmoney-cli create -N my-awesome-dapp
```

**Options:**
- `-N, --name <string>` - Project name (required)
- `-n, --network <string>` - Network: `devnet` or `mainnet` (default: `devnet`)
- `-f, --app-path <string>` - Custom folder path for the project
- `--template` - Use the official quickstart template

**Examples:**
```bash
# Create a basic project
airmoney-cli create -N my-dapp
```

```bash
# Create with template (recommended for beginners)
airmoney-cli create -N my-dapp --template
```

```bash
# Create in a specific folder
airmoney-cli create -N my-dapp -f /path/to/my-projects
```

### Step 3: Test Your Project

Navigate to your project folder and start the local simulator:

```bash
cd my-awesome-dapp
airmoney-cli serve
```

This will:
- Start the DEGN simulator in your browser
- Serve your dApp locally for testing
- Provide real-time development feedback

## Complete Command Reference

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
airmoney-cli create -N <project-name> [-n <network>] [-f <path>] [--template]
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

### Serve Command

Test your dApp locally with the simulator:

```bash
airmoney-cli serve [-f <path>] [--no-browser] [-u <url>]
```

**Options:**
- `-f, --index-app-path <string>` - Path to your app files (default: `./`)
- `--no-browser` - Don't open browser automatically
- `-u, --app-url <string>` - Use external development server URL

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
airmoney-cli upload [-n <network>] [-f <path>] [-i <button-images>]
```

**Options:**
- `-n, --network <string>` - Network endpoint (default: devnet)
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
