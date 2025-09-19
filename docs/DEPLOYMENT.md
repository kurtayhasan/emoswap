# EmoSwap Deployment Guide

## Prerequisites

1. **Stacks CLI** installed
2. **Clarinet** installed
3. **Testnet ALGO** for deployment
4. **Mainnet STX** for mainnet deployment

## Testnet Deployment

### 1. Setup Environment
```bash
# Install dependencies
npm install

# Setup Clarinet
clarinet init
```

### 2. Deploy Contracts
```bash
# Deploy to testnet
deno run --allow-all scripts/deploy-testnet.ts
```

### 3. Initialize Contracts
```bash
# Initialize all contracts
deno run --allow-all scripts/initialize-contracts.ts
```

## Mainnet Deployment

### 1. Prepare for Mainnet
```bash
# Update configuration for mainnet
# Set mainnet network in Clarinet.toml
```

### 2. Deploy Contracts
```bash
# Deploy to mainnet
deno run --allow-all scripts/deploy-mainnet.ts
```

### 3. Initialize Contracts
```bash
# Initialize all contracts
deno run --allow-all scripts/initialize-contracts.ts
```

## Contract Initialization Parameters

### EmotionFactory
- No initialization required

### SwapPool
- `token-asset-id`: Asset ID of the emotion token

### LiquidityPool
- `token-asset-id`: Asset ID of the emotion token

### StakingRewards
- `emission-rate`: Initial emission rate (default: 100)
- `reward-denominator`: Reward denominator (default: 1000000)

### Governance
- `voting-period`: Voting period in blocks (default: 10080)
- `quorum-threshold`: Quorum threshold (default: 5000)

## Verification

### 1. Check Contract Status
```bash
# Check if contracts are deployed
clarinet console
```

### 2. Run Tests
```bash
# Run all tests
clarinet test
```

### 3. Verify on Explorer
- Check contracts on Stacks Explorer
- Verify contract source code
- Check transaction history

## Post-Deployment

### 1. Set Initial Parameters
- Set emission rates
- Configure voting parameters
- Set initial liquidity

### 2. Create First Proposals
- Create governance proposals
- Set up initial voting

### 3. Monitor
- Monitor contract activity
- Check for errors
- Update parameters as needed

## Troubleshooting

### Common Issues
1. **Deployment fails**: Check ALGO balance
2. **Initialization fails**: Check contract addresses
3. **Tests fail**: Check contract state

### Solutions
1. **Get more ALGO**: Use testnet faucet
2. **Check logs**: Review deployment logs
3. **Reset state**: Clear and redeploy

## Security Checklist

- [ ] All contracts deployed successfully
- [ ] Admin functions protected
- [ ] Emergency pause works
- [ ] Voting mechanism functional
- [ ] Liquidity pools initialized
- [ ] Staking rewards active
- [ ] Governance proposals working
- [ ] All tests passing
- [ ] Contract source verified
- [ ] Documentation complete
