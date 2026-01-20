# 🤖 SENSEI Docker - Easy Chatbot Testing

Test chatbots without writing code! Just run a simple script.

## Prerequisites

1. **Install Docker Desktop**: [docker.com/products/docker-desktop](https://www.docker.com/products/docker-desktop/)
2. **Get OpenAI API Key**: [platform.openai.com/api-keys](https://platform.openai.com/api-keys)

## Quick Start

### Windows Users
1. Double-click `run-sensei.bat`
2. Enter your OpenAI API key when prompted
3. Choose option `1` to run tests

### Mac/Linux Users
```bash
chmod +x run-sensei.sh
./run-sensei.sh
```

## What It Does

| Option | Description |
|--------|-------------|
| **1. Run Test** | Generates AI conversations with the chatbot |
| **2. Check Results** | Scores the conversations against rules |
| **3. Start Chatbot** | Run chatbot for manual testing |
| **4. Stop** | Shut down all services |

## Output

Test results are saved to `test_cases/` folder as YAML files containing:
- Full conversation transcripts
- Response times
- Error codes
- Extracted data

## Need Help?

See the full [README.md](README.md) for advanced usage.
