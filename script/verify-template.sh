#!/bin/bash

# =============================================================================
# FORGE VERIFY TEMPLATES
# =============================================================================

# Basic verification template
echo "=== Basic Verification ==="
echo "forge verify-contract <CONTRACT_ADDRESS> <CONTRACT_NAME> --chain <CHAIN_ID> --etherscan-api-key <API_KEY>"
echo ""

# Example for MyOFT contract
echo "=== MyOFT Example ==="
echo "forge verify-contract 0x1234567890123456789012345678901234567890 src/MyOFT.sol:MyOFT \\"
echo "  --chain sepolia \\"
echo "  --etherscan-api-key \$ETHERSCAN_API_KEY \\"
echo "  --constructor-args \$(cast abi-encode \"constructor(string,string,address,address)\" \"MyToken\" \"MTK\" \"0xae92d5aD7583AD66E49A0c67BAd18F6ba52dDDc1\" \"0xYourDelegateAddress\")"
echo ""

# With constructor arguments (multiple methods)
echo "=== Constructor Arguments Examples ==="
echo ""
echo "# Method 1: Inline encoding"
echo "forge verify-contract <CONTRACT_ADDRESS> src/MyOFT.sol:MyOFT \\"
echo "  --chain sepolia \\"
echo "  --etherscan-api-key \$ETHERSCAN_API_KEY \\"
echo "  --constructor-args \$(cast abi-encode \"constructor(string,string,address,address)\" \"MyToken\" \"MTK\" \"0xEndpointAddress\" \"0xDelegateAddress\")"
echo ""

echo "# Method 2: Pre-encoded arguments"
echo "CONSTRUCTOR_ARGS=\"0x000000000000000000000000000000000000000000000000000000000000008000000000000000000000000000000000000000000000000000000000000000c0000000000000000000000000ae92d5ad7583ad66e49a0c67bad18f6ba52dddc1000000000000000000000000your_delegate_address_here\""
echo "forge verify-contract <CONTRACT_ADDRESS> src/MyOFT.sol:MyOFT \\"
echo "  --chain sepolia \\"
echo "  --etherscan-api-key \$ETHERSCAN_API_KEY \\"
echo "  --constructor-args \$CONSTRUCTOR_ARGS"
echo ""

echo "# Method 3: From file"
echo "forge verify-contract <CONTRACT_ADDRESS> src/MyOFT.sol:MyOFT \\"
echo "  --chain sepolia \\"
echo "  --etherscan-api-key \$ETHERSCAN_API_KEY \\"
echo "  --constructor-args-path ./constructor-args.txt"
echo ""

# Different networks
echo "=== Network Examples ==="
echo ""
echo "# Ethereum Mainnet"
echo "forge verify-contract <CONTRACT_ADDRESS> <CONTRACT_NAME> --chain mainnet --etherscan-api-key \$ETHERSCAN_API_KEY"
echo ""
echo "# Ethereum Sepolia Testnet"
echo "forge verify-contract <CONTRACT_ADDRESS> <CONTRACT_NAME> --chain sepolia --etherscan-api-key \$ETHERSCAN_API_KEY"
echo ""
echo "# Polygon"
echo "forge verify-contract <CONTRACT_ADDRESS> <CONTRACT_NAME> --chain polygon --verifier-url https://api.polygonscan.com/api --etherscan-api-key \$POLYGONSCAN_API_KEY"
echo ""
echo "# Arbitrum"
echo "forge verify-contract <CONTRACT_ADDRESS> <CONTRACT_NAME> --chain arbitrum --verifier-url https://api.arbiscan.io/api --etherscan-api-key \$ARBISCAN_API_KEY"
echo ""
echo "# Optimism"
echo "forge verify-contract <CONTRACT_ADDRESS> <CONTRACT_NAME> --chain optimism --verifier-url https://api-optimistic.etherscan.io/api --etherscan-api-key \$OPTIMISM_API_KEY"
echo ""
echo "# Base"
echo "forge verify-contract <CONTRACT_ADDRESS> <CONTRACT_NAME> --chain base --verifier-url https://api.basescan.org/api --etherscan-api-key \$BASESCAN_API_KEY"
echo ""
echo "# Avalanche"
echo "forge verify-contract <CONTRACT_ADDRESS> <CONTRACT_NAME> --chain avalanche --verifier-url https://api.snowtrace.io/api --etherscan-api-key \$SNOWTRACE_API_KEY"
echo ""

# With library linking
echo "=== With Libraries ==="
echo "forge verify-contract <CONTRACT_ADDRESS> <CONTRACT_NAME> \\"
echo "  --chain sepolia \\"
echo "  --etherscan-api-key \$ETHERSCAN_API_KEY \\"
echo "  --libraries src/MyLibrary.sol:MyLibrary:0xLibraryAddress"
echo ""

# Flatten and verify (alternative method)
echo "=== Flatten and Verify (Alternative) ==="
echo "# First flatten the contract"
echo "forge flatten src/MyOFT.sol > MyOFT_flattened.sol"
echo ""
echo "# Then verify using flattened file"
echo "forge verify-contract <CONTRACT_ADDRESS> MyOFT_flattened.sol:MyOFT \\"
echo "  --chain sepolia \\"
echo "  --etherscan-api-key \$ETHERSCAN_API_KEY"
echo ""

# Environment variables setup
echo "=== Environment Variables Setup ==="
echo "# Add to your .env file:"
echo "ETHERSCAN_API_KEY=your_etherscan_api_key_here"
echo "POLYGONSCAN_API_KEY=your_polygonscan_api_key_here"
echo "ARBISCAN_API_KEY=your_arbiscan_api_key_here"
echo "OPTIMISM_API_KEY=your_optimism_api_key_here"
echo "BASESCAN_API_KEY=your_basescan_api_key_here"
echo "SNOWTRACE_API_KEY=your_snowtrace_api_key_here"
echo ""
echo "# Load environment variables:"
echo "source .env"
echo ""

# Complete example with error handling
echo "=== Complete Example with Error Handling ==="
cat << 'EOF'
#!/bin/bash

# Load environment variables
source .env

# Check if required variables are set
if [ -z "$ETHERSCAN_API_KEY" ]; then
    echo "Error: ETHERSCAN_API_KEY not set"
    exit 1
fi

CONTRACT_ADDRESS="0x1234567890123456789012345678901234567890"
CONTRACT_NAME="src/MyOFT.sol:MyOFT"
CHAIN="sepolia"

# Constructor arguments
NAME="MyToken"
SYMBOL="MTK"
LZ_ENDPOINT="0xae92d5aD7583AD66E49A0c67BAd18F6ba52dDDc1"
DELEGATE="0xYourDelegateAddress"

# Encode constructor arguments
CONSTRUCTOR_ARGS=$(cast abi-encode "constructor(string,string,address,address)" "$NAME" "$SYMBOL" "$LZ_ENDPOINT" "$DELEGATE")

echo "Verifying contract..."
echo "Address: $CONTRACT_ADDRESS"
echo "Contract: $CONTRACT_NAME"
echo "Chain: $CHAIN"
echo "Constructor args: $CONSTRUCTOR_ARGS"

# Verify the contract
forge verify-contract $CONTRACT_ADDRESS $CONTRACT_NAME \
    --chain $CHAIN \
    --etherscan-api-key $ETHERSCAN_API_KEY \
    --constructor-args $CONSTRUCTOR_ARGS

if [ $? -eq 0 ]; then
    echo "✅ Contract verified successfully!"
else
    echo "❌ Contract verification failed!"
    exit 1
fi
EOF

echo ""
echo "=== Additional Tips ==="
echo "1. Always double-check the contract address"
echo "2. Ensure constructor arguments match exactly what was used in deployment"
echo "3. Use 'cast abi-encode' to properly encode constructor arguments"
echo "4. Some explorers may take time to index the contract before verification"
echo "5. Use --watch flag to monitor verification status"
echo "6. For proxy contracts, you may need to verify both implementation and proxy"
