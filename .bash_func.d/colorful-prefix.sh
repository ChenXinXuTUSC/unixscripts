#!/bin/bash

# Define color codes
RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print INFO logs
info() {
    printf "${GREEN}[INFO]${NC} $1\n"
}

# Function to print WARNING logs
warn() {
    printf "${YELLOW}[WARN]${NC} $1\n"
}

# Function to print ERROR logs
erro() {
    printf "${RED}[ERRO]${NC} $1\n"
}

# Example usage
#info "This is an information message."
#warn "This is a warning message."
#erro "This is an error message."

