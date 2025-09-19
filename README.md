# EmoSwap - Emotion-Based DeFi Protocol on Stacks Blockchain

A revolutionary DeFi protocol that allows users to create, trade, and stake emotion-based tokens on the Stacks blockchain. EmoSwap enables users to express their emotions through cryptocurrency while participating in decentralized finance.

## 🎯 Project Overview

EmoSwap is a comprehensive DeFi platform built on Stacks blockchain that introduces emotion-based tokenization. Users can create tokens representing different emotions (Happy, Sad, Angry, Excited, etc.), trade them in automated market makers (AMMs), provide liquidity, and earn rewards through staking.

## 🚀 Features

### Core Features
- **Emotion Token Creation**: Create unique tokens for 8 different emotions
- **AMM Trading**: Automated market maker for STX ↔ Emotion token swaps
- **Liquidity Provision**: Add/remove liquidity to earn trading fees
- **Staking Rewards**: Stake LP tokens to earn $MOOD governance tokens
- **Governance**: Community-driven protocol parameter management
- **Modern UI**: Beautiful, responsive frontend built with Next.js

### Supported Emotions
- 😊 Happy
- 😢 Sad  
- 😠 Angry
- 🤩 Excited
- 😌 Calm
- 😰 Anxious
- 🙏 Grateful
- 💕 Loved

## 🏗️ Architecture

### Smart Contracts (Clarity)
- **emotion-factory.clar**: Manages emotion token creation and daily minting
- **swap-pool.clar**: Implements constant-product AMM for STX/Emotion pairs
- **liquidity-pool.clar**: Handles liquidity provision and LP token management
- **staking-rewards.clar**: Manages LP token staking and $MOOD rewards
- **governance.clar**: Protocol parameter management and voting

### Frontend (Next.js)
- **React + TypeScript**: Modern, type-safe frontend
- **Tailwind CSS**: Beautiful, responsive design
- **Stacks Connect**: Wallet integration
- **Real-time Updates**: Live data from blockchain

## 📁 Project Structure

```
emoswap/
├── contracts/                 # Clarity smart contracts
│   ├── emotion-factory.clar
│   ├── swap-pool.clar
│   ├── liquidity-pool.clar
│   ├── staking-rewards.clar
│   └── governance.clar
├── tests/                    # Test files
│   ├── emotion-factory_test.ts
│   └── swap-pool_test.ts
├── scripts/                  # Deployment scripts
│   ├── deploy-testnet.ts
│   ├── deploy-mainnet.ts
│   └── initialize-contracts.ts
├── docs/                     # Documentation
│   ├── CONTRACT_GUIDE.md
│   ├── DEPLOYMENT.md
│   └── SECURITY.md
├── web/                      # Frontend application
│   ├── src/
│   │   ├── app/
│   │   ├── components/
│   │   └── lib/
│   └── package.json
├── settings/                 # Clarinet settings
│   └── Testnet.toml
├── deployments/              # Deployment configs
│   └── Testnet.toml
├── Clarinet.toml
└── README.md
```

## 🚀 Quick Start

### Prerequisites
- [Clarinet](https://github.com/hirosystems/clarinet) (Stacks development tool)
- [Node.js](https://nodejs.org/) (v18 or higher)
- [Git](https://git-scm.com/)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/kurtayhasan/emoswap.git
   cd emoswap
   ```

2. **Install dependencies**
   ```bash
   # Install frontend dependencies
   cd web
   npm install
   ```

3. **Set up environment variables**
   ```bash
   # Copy environment template
   cp env.example .env.local
   
   # Edit .env.local with your configuration
   ```

### Development

1. **Start the development server**
   ```bash
   cd web
   npm run dev
   ```

2. **Open your browser**
   Navigate to [http://localhost:3000](http://localhost:3000)

### Testing

1. **Test smart contracts**
   ```bash
   clarinet test
   ```

2. **Test frontend**
   ```bash
   cd web
   npm test
   ```

## 📋 Contract Addresses

### Stacks Testnet
- **Contract Address**: `SP2J6ZY48GV1EZ5V2V5RB9MP66SW86CYK20NVF7D7`
- **EmotionFactory**: `emotion-factory`
- **SwapPools**: `swap-pool-happy`, `swap-pool-sad`, `swap-pool-angry`, `swap-pool-excited`, `swap-pool-calm`, `swap-pool-anxious`, `swap-pool-grateful`, `swap-pool-loved`
- **LiquidityPools**: `liquidity-pool-happy`, `liquidity-pool-sad`, `liquidity-pool-angry`, `liquidity-pool-excited`, `liquidity-pool-calm`, `liquidity-pool-anxious`, `liquidity-pool-grateful`, `liquidity-pool-loved`
- **StakingRewards**: `staking-rewards`
- **Governance**: `governance`
- **MOOD Token**: `mood-token`

### Explorer Links
- **Testnet Explorer**: [https://explorer.stacks.co/?chain=testnet](https://explorer.stacks.co/?chain=testnet)
- **Contract Explorer**: [https://explorer.stacks.co/contract/SP2J6ZY48GV1EZ5V2V5RB9MP66SW86CYK20NVF7D7](https://explorer.stacks.co/contract/SP2J6ZY48GV1EZ5V2V5RB9MP66SW86CYK20NVF7D7)

## 🔧 Configuration

### Environment Variables
```bash
# Stacks Configuration
NEXT_PUBLIC_STACKS_API_URL="https://stacks-node-api.testnet.stacks.co"
NEXT_PUBLIC_STACKS_INDEXER_URL="https://stacks-node-api.testnet.stacks.co"
NEXT_PUBLIC_NETWORK="testnet"

# Contract Addresses
NEXT_PUBLIC_CONTRACT_ADDRESS="SP2J6ZY48GV1EZ5V2V5RB9MP66SW86CYK20NVF7D7"
NEXT_PUBLIC_EMOTION_FACTORY_CONTRACT="emotion-factory"
NEXT_PUBLIC_SWAP_POOL_CONTRACTS={"Happy": "swap-pool-happy", "Sad": "swap-pool-sad", ...}
NEXT_PUBLIC_LIQUIDITY_POOL_CONTRACTS={"Happy": "liquidity-pool-happy", "Sad": "liquidity-pool-sad", ...}
NEXT_PUBLIC_STAKING_REWARDS_CONTRACT="staking-rewards"
NEXT_PUBLIC_GOVERNANCE_CONTRACT="governance"
NEXT_PUBLIC_MOOD_TOKEN_CONTRACT="mood-token"
```

## 🚀 Deployment

### Testnet Deployment
```bash
# Generate deployment configuration
clarinet deployment generate --testnet --low-cost

# Deploy contracts
clarinet deployment apply --testnet
```

### Mainnet Deployment
```bash
# Generate mainnet deployment
clarinet deployment generate --mainnet --medium-cost

# Deploy to mainnet
clarinet deployment apply --mainnet
```

## 🧪 Testing

### Smart Contract Tests
```bash
# Run all tests
clarinet test

# Run specific test
clarinet test tests/emotion-factory_test.ts
```

### Frontend Tests
```bash
cd web
npm test
```

## 📚 Documentation

- [Contract Guide](docs/CONTRACT_GUIDE.md) - Detailed smart contract documentation
- [Deployment Guide](docs/DEPLOYMENT.md) - Step-by-step deployment instructions
- [Security Guide](docs/SECURITY.md) - Security considerations and best practices
- [Architecture](docs/architecture.md) - System architecture overview

## 🔒 Security

- **Audited Smart Contracts**: All contracts follow Stacks security best practices
- **Input Validation**: Comprehensive input validation and error handling
- **Access Control**: Proper access control and permission management
- **Economic Security**: Robust economic mechanisms to prevent attacks

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👥 Team

- **Developer**: Kurtay Hasan
- **Repository**: [https://github.com/kurtayhasan/emoswap](https://github.com/kurtayhasan/emoswap)

## 🙏 Acknowledgments

- [Stacks Foundation](https://stacks.org/) for the amazing blockchain platform
- [Hiro Systems](https://hiro.so/) for development tools and infrastructure
- [Clarinet](https://github.com/hirosystems/clarinet) for the development framework

## 📞 Support

For support, email support@emoswap.com or join our Discord community.

---

**Built with ❤️ on Stacks Blockchain**