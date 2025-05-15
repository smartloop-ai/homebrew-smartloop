# Homebrew Tap for SmartLoop CLI

This is the official Homebrew tap for [SmartLoop CLI](https://github.com/smartloop-ai/smartloop).

## About SmartLoop

SmartLoop is an AI platform that simplifies the creation, deployment, and management of AI applications. The SmartLoop CLI provides a command-line interface to interact with the SmartLoop platform.

## Installation

To install the SmartLoop CLI using Homebrew:

```bash
# Add the SmartLoop tap
brew tap smartloop-ai/smartloop

# Install the SmartLoop CLI
brew install smartloop
```

## Upgrading

To upgrade to the latest version:

```bash
brew update
brew upgrade smartloop
```

## Usage

After installation, you can use the SmartLoop CLI with the following commands:

```bash
# View available commands
smartloop --help

# Log in to your SmartLoop account
smartloop login

# View your projects
smartloop projects list
```

For more detailed usage instructions, please visit the [SmartLoop Documentation](https://github.com/smartloop-ai/smartloop).

## Requirements

- macOS or Linux
- Python 3.11 or later (installed automatically via Homebrew)

## License

SmartLoop CLI is distributed under the MIT License.

