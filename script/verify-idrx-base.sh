#!/bin/bash

# =============================================================================
# MyOFTIDRX Contract Verification Script - Base Sepolia
# =============================================================================

# Load environment variables
if [ -f .env ]; then
    source .env
fi

# Configuration
CONTRACT_ADDRESS="0x47E64F8615718d1A3FA34efe7E7b96aA9ac8B7F4"
CHAIN="base-sepolia"
CONTRACT_NAME="src/MyOFTIDRX.sol:MyOFTIDRX"
VERIFIER_URL="https://api.basescan.org/api"

# Constructor parameters
TOKEN_NAME="IDRX"
TOKEN_SYMBOL="IDRX"
OWNER_ADDRESS="0xa5ea1cb1033f5d3bd207bf6a2a2504cf1c3e9f42"

# Check if API key is set
if [ -z "$BASESCAN_API_KEY" ]; then
    echo "❌ Error: BASESCAN_API_KEY not set in environment"
    echo "Please add BASESCAN_API_KEY=your_api_key to your .env file"
    echo "Get your API key from: https://basescan.org/apis"
    exit 1
fi

echo "🔍 Verifying MyOFTIDRX contract on Base Sepolia..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📍 Contract Address: $CONTRACT_ADDRESS"
echo "🌐 Chain: $CHAIN"
echo "📄 Contract: $CONTRACT_NAME"
echo "👤 Owner: $OWNER_ADDRESS"
echo "🏷️  Token: $TOKEN_NAME ($TOKEN_SYMBOL)"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# Encode constructor arguments
echo "🔧 Encoding constructor arguments..."
CONSTRUCTOR_ARGS=$(cast abi-encode "constructor(string,string,address)" "$TOKEN_NAME" "$TOKEN_SYMBOL" "$OWNER_ADDRESS")

if [ $? -ne 0 ]; then
    echo "❌ Failed to encode constructor arguments"
    exit 1
fi

echo "✅ Constructor args encoded: $CONSTRUCTOR_ARGS"
echo ""

# Verify the contract
echo "🚀 Starting verification..."
forge verify-contract $CONTRACT_ADDRESS $CONTRACT_NAME \
    --chain $CHAIN \
    --verifier-url $VERIFIER_URL \
    --etherscan-api-key $BASESCAN_API_KEY \
    --constructor-args $CONSTRUCTOR_ARGS \
    --watch

if [ $? -eq 0 ]; then
    echo ""
    echo "🎉 Contract verified successfully!"
    echo "🔗 View on BaseScan: https://sepolia.basescan.org/address/$CONTRACT_ADDRESS"
else
    echo ""
    echo "❌ Contract verification failed!"
    echo ""
    echo "💡 Troubleshooting tips:"
    echo "1. Check if the contract address is correct"
    echo "2. Ensure constructor arguments match deployment exactly"
    echo "3. Wait a few minutes and try again (indexing delay)"
    echo "4. Verify the contract was compiled with the same Solidity version"
    echo "5. Make sure you have the correct BASESCAN_API_KEY"
    exit 1
fi
