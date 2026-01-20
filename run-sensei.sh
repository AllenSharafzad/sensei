#!/bin/bash
# ========================================
# SENSEI Easy Runner for Linux/Mac
# ========================================

echo ""
echo " ____  _____ _   _ ____  _____ ___ "
echo "/ ___|| ____| \ | |/ ___|| ____| _ |"
echo "\___ \|  _| |  \| |\___ \|  _|  | | "
echo " ___) | |___| |\  | ___) | |___ | | "
echo "|____/|_____|_| \_|____/|_____|___|"
echo ""
echo "Chatbot Testing Made Easy!"
echo ""

# Check if Docker is running
if ! docker info > /dev/null 2>&1; then
    echo "ERROR: Docker is not running!"
    echo "Please start Docker and try again."
    exit 1
fi

# Check for API key
if [ -z "$OPENAI_API_KEY" ]; then
    echo ""
    echo "WARNING: OPENAI_API_KEY is not set!"
    echo ""
    read -p "Enter your OpenAI API Key: " OPENAI_API_KEY
    export OPENAI_API_KEY
fi

echo ""
echo "Choose an option:"
echo "  1. Run chatbot test (generates conversations)"
echo "  2. Check test results (score conversations)"
echo "  3. Start chatbot only (for manual testing)"
echo "  4. Stop all services"
echo "  5. Exit"
echo ""

read -p "Enter choice (1-5): " choice

case $choice in
    1)
        echo ""
        echo "Starting chatbot and running SENSEI tests..."
        docker-compose up --build sensei
        echo ""
        echo "Test complete! Results saved to test_cases folder."
        ;;
    2)
        echo ""
        echo "Checking test results..."
        docker-compose --profile check up --build checker
        ;;
    3)
        echo ""
        echo "Starting chatbot at http://localhost:5000"
        echo "Press Ctrl+C to stop."
        docker-compose up --build chatbot
        ;;
    4)
        echo ""
        echo "Stopping all services..."
        docker-compose down
        echo "Done!"
        ;;
    5)
        exit 0
        ;;
    *)
        echo "Invalid choice!"
        ;;
esac
