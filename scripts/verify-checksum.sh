#!/bin/bash

# Vesus Pairings (Desktop) Checksum Verification Script
# This script helps verify the integrity of downloaded executables

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Helper functions
log_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

# Display usage information
usage() {
    echo "Usage: $0 <executable-file> <checksum-file>"
    echo "  <executable-file>  Path to the downloaded executable"
    echo "  <checksum-file>    Path to the file containing SHA256 checksums"
    echo ""
    echo "Example:"
    echo "  $0 pairingchecker-linux-x64 checksums.txt"
    echo "  $0 pairingchecker-windows-x64.exe checksums-linux-x64.txt"
    exit 1
}

# Check arguments
if [[ $# -ne 2 ]]; then
    log_error "Incorrect number of arguments"
    usage
fi

EXECUTABLE="$1"
CHECKSUM_FILE="$2"

# Check if files exist
if [[ ! -f "$EXECUTABLE" ]]; then
    log_error "Executable file '$EXECUTABLE' not found"
    exit 1
fi

if [[ ! -f "$CHECKSUM_FILE" ]]; then
    log_error "Checksum file '$CHECKSUM_FILE' not found"
    exit 1
fi

# Get the filename of the executable (for matching in checksum file)
EXECUTABLE_BASENAME=$(basename "$EXECUTABLE")

log_info "Verifying checksum for: $EXECUTABLE_BASENAME"
log_info "Using checksum file: $CHECKSUM_FILE"

# Extract the expected checksum for this file
# Use -w to match whole word (exact filename), avoid partial matches
EXPECTED_CHECKSUM=$(grep -w "$EXECUTABLE_BASENAME" "$CHECKSUM_FILE" | head -1 | awk '{print $1}')

if [[ -z "$EXPECTED_CHECKSUM" ]]; then
    log_error "No checksum found for '$EXECUTABLE_BASENAME' in '$CHECKSUM_FILE'"
    exit 1
fi

log_info "Expected checksum: $EXPECTED_CHECKSUM"

# Calculate the actual checksum based on the OS
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS
    ACTUAL_CHECKSUM=$(shasum -a 256 "$EXECUTABLE" | awk '{print $1}')
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    # Linux
    ACTUAL_CHECKSUM=$(sha256sum "$EXECUTABLE" | awk '{print $1}')
elif [[ "$OSTYPE" == "msys" || "$OSTYPE" == "cygwin" || "$OSTYPE" == "win32" ]]; then
    # Windows (using CertUtil in PowerShell or bash subsystem)
    if command -v shasum &> /dev/null; then
        ACTUAL_CHECKSUM=$(shasum -a 256 "$EXECUTABLE" | awk '{print $1}')
    elif command -v sha256sum &> /dev/null; then
        ACTUAL_CHECKSUM=$(sha256sum "$EXECUTABLE" | awk '{print $1}')
    else
        log_error "Neither shasum nor sha256sum is available. Please install one of them."
        exit 1
    fi
else
    log_error "Unsupported operating system: $OSTYPE"
    exit 1
fi

log_info "Actual checksum:   $ACTUAL_CHECKSUM"

# Compare checksums
if [[ "$EXPECTED_CHECKSUM" == "$ACTUAL_CHECKSUM" ]]; then
    log_success "Checksum verification PASSED"
    echo ""
    echo "The executable '$EXECUTABLE_BASENAME' is authentic and has not been tampered with."
    exit 0
else
    log_error "Checksum verification FAILED"
    echo ""
    echo "The executable '$EXECUTABLE_BASENAME' may be corrupted or tampered with."
    echo "Expected: $EXPECTED_CHECKSUM"
    echo "Got:      $ACTUAL_CHECKSUM"
    exit 1
fi