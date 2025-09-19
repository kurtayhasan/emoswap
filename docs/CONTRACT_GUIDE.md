# EmoSwap Contract Guide

## Overview
EmoSwap is a DeFi protocol built on Stacks that allows users to create, trade, and stake emotion-based tokens.

## Contracts

### 1. EmotionFactory (`emotion-factory.clar`)
Manages emotion token creation and daily minting.

**Functions:**
- `create-emotion(emotion-name: string)` - Create new emotion token
- `get-emotion-asset-id(emotion-name: string)` - Get asset ID for emotion
- `get-emotion-count()` - Get total emotion count
- `set-mint-amount(amount: uint)` - Set mint amount (admin only)
- `set-paused(status: bool)` - Pause/unpause contract (admin only)
- `emergency-pause()` - Emergency pause (admin only)

### 2. SwapPool (`swap-pool.clar`)
Constant-product AMM for emotion/ALGO pairs.

**Functions:**
- `initialize-pool(token-asset-id: uint)` - Initialize pool
- `add-liquidity(algo-amount: uint, asset-amount: uint)` - Add liquidity
- `remove-liquidity(shares: uint)` - Remove liquidity
- `swap-algo-for-asset(algo-amount: uint, min-asset-amount: uint)` - Swap ALGO for asset
- `swap-asset-for-algo(asset-amount: uint, min-algo-amount: uint)` - Swap asset for ALGO
- `get-reserves()` - Get current reserves
- `get-balance(user: principal)` - Get user balance

### 3. LiquidityPool (`liquidity-pool.clar`)
Manages liquidity provision for emotion/ALGO pairs.

**Functions:**
- `initialize-pool(token-asset-id: uint)` - Initialize pool
- `add-liquidity(algo-amount: uint, asset-amount: uint)` - Add liquidity
- `remove-liquidity(lp-token-amount: uint)` - Remove liquidity
- `get-total-liquidity()` - Get total liquidity
- `get-lp-token-supply()` - Get LP token supply
- `get-user-lp-tokens(user: principal)` - Get user LP tokens
- `get-user-liquidity(user: principal)` - Get user liquidity

### 4. StakingRewards (`staking-rewards.clar`)
Manages LP token staking and $MOOD token rewards.

**Functions:**
- `stake(amount: uint)` - Stake LP tokens
- `unstake(amount: uint)` - Unstake LP tokens
- `claim-rewards()` - Claim rewards
- `get-pending-rewards(user: principal)` - Get pending rewards
- `get-staked-balance(user: principal)` - Get staked balance
- `get-total-staked()` - Get total staked
- `set-emission-rate(rate: uint)` - Set emission rate (admin only)
- `update-reward-per-token()` - Update reward per token (admin only)

### 5. Governance (`governance.clar`)
Manages protocol parameters and voting.

**Functions:**
- `create-proposal(description: string-utf8)` - Create proposal
- `vote(proposal-id: uint, support: bool)` - Vote on proposal
- `execute-proposal(proposal-id: uint)` - Execute proposal
- `get-proposal(proposal-id: uint)` - Get proposal details
- `get-proposal-count()` - Get proposal count
- `get-voter-weight(voter: principal)` - Get voter weight
- `set-voter-weight(voter: principal, weight: uint)` - Set voter weight (admin only)
- `set-quorum-threshold(threshold: uint)` - Set quorum threshold (admin only)
- `set-voting-period(period: uint)` - Set voting period (admin only)

## Error Codes

| Contract | Code | Description |
|----------|------|-------------|
| EmotionFactory | u100 | Unauthorized |
| EmotionFactory | u101 | Contract paused |
| EmotionFactory | u102 | Invalid emotion |
| EmotionFactory | u103 | Already exists |
| SwapPool | u200 | Unauthorized |
| SwapPool | u201 | Insufficient liquidity |
| SwapPool | u202 | Insufficient balance |
| SwapPool | u203 | Invalid amount |
| SwapPool | u204 | Slippage exceeded |
| LiquidityPool | u300 | Unauthorized |
| LiquidityPool | u301 | Insufficient liquidity |
| LiquidityPool | u302 | Invalid amount |
| LiquidityPool | u303 | Not initialized |
| StakingRewards | u400 | Unauthorized |
| StakingRewards | u401 | Insufficient balance |
| StakingRewards | u402 | Invalid amount |
| StakingRewards | u403 | No rewards |
| Governance | u500 | Unauthorized |
| Governance | u501 | Proposal not found |
| Governance | u502 | Proposal expired |
| Governance | u503 | Already voted |
| Governance | u504 | Proposal not executable |
| Governance | u505 | Insufficient votes |

## Security Considerations

1. **Access Control**: All admin functions are protected by admin checks
2. **Input Validation**: All functions validate input parameters
3. **Overflow Protection**: Uses safe math operations
4. **Reentrancy Protection**: No external calls in state-changing functions
5. **Pause Mechanism**: Emergency pause functionality for all contracts
6. **Voting Security**: Time-locked voting with quorum requirements
