# Homebrew Tap for Smartloop

This is the official Homebrew tap for Smartloop. It is an agentic orchestration framework to extract information and generate content on edge devices

## Installation

```bash
# Add the Smartloop tap
brew tap smartloop-ai/smartloop

# Install the Smartloop CLI
brew install smartloop

## Upgrading

```bash
brew update
brew upgrade smartloop
```

## Usage

```bash
# View available commands
slp --help

# Initialize a new project
slp init -t <developer_token>

# Add a document for training
slp add document.pdf

# Run interactive chat
slp run
```

### Project Management

```bash
slp projects create <name>
slp projects list
slp projects switch <name>
slp status
```

### Server Management

Smartloop includes a background API server compatible with OpenAI's chat completion format:

```bash
slp server start
slp server stop
slp server status
```

The server can also be managed via `brew services`:

```bash
brew services start smartloop
brew services stop smartloop
```

## Requirements

- macOS or Linux
- Python 3.11 or later (installed automatically via Homebrew)
- CMake (installed automatically via Homebrew)

## License

Smartloop is distributed under the Apache 2.0 License.
