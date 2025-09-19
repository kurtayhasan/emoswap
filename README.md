# EmoSwap - Emotion-based DeFi Protocol

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

EmoSwap is a decentralized finance protocol built on Algorand that lets users express and trade emotions as digital assets. Users can mint daily emotion tokens, swap them through AMM pools, provide liquidity, and earn governance rewards.

## Features

- 🎭 Daily emotion token minting
- 💱 Constant-product AMM swaps (x*y=k)
- 🌊 Liquidity provision with LP rewards
- 🏆 Stake LP tokens to earn $MOOD governance token
- 🏛️ Protocol parameter governance (admin MVP)

## Tech Stack

- **Blockchain**: Algorand Testnet
- **Smart Contracts**: PyTeal + Beaker
- **Frontend**: Next.js + TypeScript
- **Styling**: Tailwind CSS
- **Wallet**: Pera Wallet (Testnet)
- **Testing**: Python unittest, Jest

## Getting Started

### Prerequisites

- Python 3.9+
- Node.js 18+
- Pera Wallet (Testnet)
- Testnet ALGOs ([AlgoFaucet](https://bank.testnet.algorand.network/))

### Installation

1. Clone repo & install Python dependencies:
```bash
git clone https://github.com/yourusername/emoswap
cd emoswap
python -m venv .venv
source .venv/bin/activate  # Windows: .venv\Scripts\activate
pip install -r requirements.txt
```

2. Install frontend dependencies:
```bash
cd web
npm install
```

3. Set up environment:
```bash
# Root .env
DEPLOYER_MNEMONIC="your testnet mnemonic here"

# web/.env.local
NEXT_PUBLIC_ALGOD_SERVER="https://testnet-api.algonode.cloud"
NEXT_PUBLIC_ALGOD_PORT=""
NEXT_PUBLIC_ALGOD_TOKEN=""
```

### Deployment

1. Compile contracts:
```bash
python scripts/compile_teal.py
```

2. Deploy contracts:
```bash
# Deploy EmotionFactory
python scripts/deploy_emotion_factory.py

# Deploy SwapPool for an emotion
python scripts/deploy_swap_pool.py <emotion_asset_id>

# Deploy $MOOD & Governance
python scripts/deploy_liquidity_and_stake.py
```

3. Update frontend config:
- Copy Application IDs to `web/lib/config.ts`

4. Run frontend:
```bash
cd web
npm run dev
```

## Usage

1. **Daily Mint**
   - Connect Pera Wallet
   - Select emotion to mint
   - Receive emotion tokens

2. **Swap**
   - Choose input/output token
   - Enter amount
   - Swap with 0.3% fee

3. **Liquidity**
   - Add ALGO + emotion token
   - Receive LP tokens
   - Remove liquidity anytime

4. **Stake**
   - Stake LP tokens
   - Earn $MOOD rewards
   - Claim rewards

## Stacks Testnet Contracts

Contract Address: SP2J6ZY48GV1EZ5V2V5RB9MP66SW86CYK20NVF7D7
- EmotionFactory: emotion-factory
- SwapPool: swap-pool  
- LiquidityPool: liquidity-pool
- StakingRewards: staking-rewards
- Governance: governance

Explorer: https://explorer.stacks.co/?chain=testnet

## Development

Test contracts:
```bash
# Deploy all contracts
clarinet deployment generate --testnet --low-cost

# Or test contracts
clarinet test
```

Test frontend:
```bash
cd web
npm test
```

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contact

Your Name - [@yourtwitter](https://twitter.com/yourtwitter)

Project Link: [https://github.com/yourusername/emoswap](https://github.com/yourusername/emoswap)
