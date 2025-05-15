# Homebrew Tap for SmartLoop CLI

This repository contains Homebrew formulae for installing the [SmartLoop CLI](https://github.com/smartloop-ai/smartloop) and related tools.

## What is SmartLoop?

SmartLoop is an AI platform that simplifies the creation, deployment, and management of AI applications. The SmartLoop CLI provides a command-line interface to interact with the SmartLoop platform.

## Installation

To install the SmartLoop CLI using Homebrew:

```bash
# Add the SmartLoop tap
brew tap smartloop-ai/smartloop

# Install the SmartLoop CLI
brew install smartloop
```

## Updating

To update to the latest version:

```bash
brew update
brew upgrade smartloop
```

## Usage

After installation, you can use the SmartLoop CLI by running the `smartloop` command:

```bash
# Display help
smartloop --help

# Check the installed version
smartloop --version

# Login to SmartLoop
smartloop login

# List your projects
smartloop projects list
```

## Requirements

- macOS or Linux
- Python 3.11 or later (installed automatically by Homebrew)

## Documentation

For detailed documentation on SmartLoop CLI usage, visit [the SmartLoop documentation](https://github.com/smartloop-ai/smartloop).

## License

The SmartLoop CLI is distributed under the MIT License.

