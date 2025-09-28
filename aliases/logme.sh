#!/bin/bash
LOG_DIR="$HOME/term_logs"
mkdir -p "$LOG_DIR"
LOG_FILE="$LOG_DIR/term_$(date +%Y%m%d_%H%M%S)_$(head -c 4 /dev/urandom | base64 | tr -dc 'a-zA-Z0-9').log"

script -af "$LOG_FILE"
