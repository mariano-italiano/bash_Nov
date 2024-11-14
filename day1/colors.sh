#!/bin/bash

echo -e "\033[31mTEST ERROR\033[0m";

echo "cos innego"


RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}INFO: Process completed successfully.${NC}"
echo -e "${YELLOW}WARNING: Low disk space.${NC}"
echo -e "${RED}ERROR: File not found.${NC}"
