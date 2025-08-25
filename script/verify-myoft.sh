#!/bin/bash

# =============================================================================
# MyOFT Contract Verification Script
# =============================================================================

# Load environment variables
if [ -f .env ]; then
    source .env
fi

# Configuration - UPDATE THESE VALUES
CONTRACT_ADDRESS="0x1234567890123456789012345678901234567890"  # Replace with your deployed contract address
CHAIN="sepolia"  # Change to your target chain
CONTRACT_NAME="src/MyOFT.sol:MyOFT"

# Constructor parameters - UPDATE THESE VALUES
TOKEN_NAME="MyToken"
TOKEN_SYMBOL="MTK"
LZ_ENDPOINT="0xae92d5aD7583AD66E49A0c67BAd18F6ba52dDDc1"  # Sepolia LZ endpoint
DELEGATE_ADDRESS="0xYourDelegateAddress"  # Replace with your delegate address

# Check if API key is set
if [ -z "$ETHERSCAN_API_KEY" ]; then
    echo "❌ Error: ETHERSCAN_API_KEY not set in environment"
    echo "Please add ETHERSCAN_API_KEY=your_api_key to your .env file"
    exit 1
fi

echo "🔍 Verifying MyOFT contract..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📍 Contract Address: $CONTRACT_ADDRESS"
echo "🌐 Chain: $CHAIN"
echo "📄 Contract: $CONTRACT_NAME"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# Encode constructor arguments
echo "🔧 Encoding constructor arguments..."
CONSTRUCTOR_ARGS=$(cast abi-encode "constructor(string,string,address,address)" "$TOKEN_NAME" "$TOKEN_SYMBOL" "$LZ_ENDPOINT" "$DELEGATE_ADDRESS")

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
    --etherscan-api-key $ETHERSCAN_API_KEY \
    --constructor-args $CONSTRUCTOR_ARGS \
    --watch

if [ $? -eq 0 ]; then
    echo ""
    echo "🎉 Contract verified successfully!"
    echo "🔗 View on explorer: https://sepolia.etherscan.io/address/$CONTRACT_ADDRESS"
else
    echo ""
    echo "❌ Contract verification failed!"
    echo ""
    echo "💡 Troubleshooting tips:"
    echo "1. Check if the contract address is correct"
    echo "2. Ensure constructor arguments match deployment exactly"
    echo "3. Wait a few minutes and try again (indexing delay)"
    echo "4. Verify the contract was compiled with the same Solidity version"
    exit 1
fi
