# Homebrew Tap for Smartloop

This is the official Homebrew tap for Smartloop. It is a low-code LLM framework for fine-tuning and running models on edge devices.

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
slp init --model=gemma3_1b -t <developer_token>

# Add a document for training
slp add document.pdf

# Run interactive chat
slp run
```

### Project Management

```bash
slp projects create <name> [--model MODEL]
slp projects list
slp projects switch <name>
slp status
```

### Server Management

SLP includes a background API server compatible with OpenAI's chat completion format:

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

### Supported Models

| Model | Base Model | Size |
|-------|-----------|------|
| `gemma3_1b` | google/gemma-3-1b-it | 1B |
| `gemma3_4b` | google/gemma-3-4b-it | 4B |
| `gemma3_27b` | google/gemma-3-27b-it | 27B |
| `llama3_1b` | meta-llama/Llama-3.2-1B-Instruct | 1B |
| `llama3_3b` | meta-llama/Llama-3.2-3B-Instruct | 3B |
| `phi4_mini` | microsoft/phi-4-mini | 4B |

## Requirements

- macOS or Linux
- Python 3.11 or later (installed automatically via Homebrew)
- CMake (installed automatically via Homebrew)

## License

SLP is distributed under the Apache 2.0 License.
