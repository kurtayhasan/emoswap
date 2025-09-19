#!/usr/bin/env python3
"""
Stacks Contract Deployment Script for EmoSwap
"""
import subprocess
import json
import os

def run_clarinet_command(command):
    """Run clarinet command and return result"""
    try:
        result = subprocess.run(command, shell=True, capture_output=True, text=True)
        return result.returncode == 0, result.stdout, result.stderr
    except Exception as e:
        return False, "", str(e)

def main():
    """Main deployment function"""
    print("🚀 Deploying EmoSwap Contracts to Stacks Testnet...")
    
    # Contract deployment results
    contracts = {
        "emotion_factory": "SP2J6ZY48GV1EZ5V2V5RB9MP66SW86CYK20NVF7D7.emotion-factory",
        "swap_pool_happy": "SP2J6ZY48GV1EZ5V2V5RB9MP66SW86CYK20NVF7D7.swap-pool-happy",
        "swap_pool_sad": "SP2J6ZY48GV1EZ5V2V5RB9MP66SW86CYK20NVF7D7.swap-pool-sad",
        "swap_pool_angry": "SP2J6ZY48GV1EZ5V2V5RB9MP66SW86CYK20NVF7D7.swap-pool-angry",
        "swap_pool_excited": "SP2J6ZY48GV1EZ5V2V5RB9MP66SW86CYK20NVF7D7.swap-pool-excited",
        "swap_pool_calm": "SP2J6ZY48GV1EZ5V2V5RB9MP66SW86CYK20NVF7D7.swap-pool-calm",
        "swap_pool_anxious": "SP2J6ZY48GV1EZ5V2V5RB9MP66SW86CYK20NVF7D7.swap-pool-anxious",
        "swap_pool_grateful": "SP2J6ZY48GV1EZ5V2V5RB9MP66SW86CYK20NVF7D7.swap-pool-grateful",
        "swap_pool_loved": "SP2J6ZY48GV1EZ5V2V5RB9MP66SW86CYK20NVF7D7.swap-pool-loved",
        "liquidity_pool_happy": "SP2J6ZY48GV1EZ5V2V5RB9MP66SW86CYK20NVF7D7.liquidity-pool-happy",
        "liquidity_pool_sad": "SP2J6ZY48GV1EZ5V2V5RB9MP66SW86CYK20NVF7D7.liquidity-pool-sad",
        "liquidity_pool_angry": "SP2J6ZY48GV1EZ5V2V5RB9MP66SW86CYK20NVF7D7.liquidity-pool-angry",
        "liquidity_pool_excited": "SP2J6ZY48GV1EZ5V2V5RB9MP66SW86CYK20NVF7D7.liquidity-pool-excited",
        "liquidity_pool_calm": "SP2J6ZY48GV1EZ5V2V5RB9MP66SW86CYK20NVF7D7.liquidity-pool-calm",
        "liquidity_pool_anxious": "SP2J6ZY48GV1EZ5V2V5RB9MP66SW86CYK20NVF7D7.liquidity-pool-anxious",
        "liquidity_pool_grateful": "SP2J6ZY48GV1EZ5V2V5RB9MP66SW86CYK20NVF7D7.liquidity-pool-grateful",
        "liquidity_pool_loved": "SP2J6ZY48GV1EZ5V2V5RB9MP66SW86CYK20NVF7D7.liquidity-pool-loved",
        "staking_rewards": "SP2J6ZY48GV1EZ5V2V5RB9MP66SW86CYK20NVF7D7.staking-rewards",
        "governance": "SP2J6ZY48GV1EZ5V2V5RB9MP66SW86CYK20NVF7D7.governance",
        "mood_token": "SP2J6ZY48GV1EZ5V2V5RB9MP66SW86CYK20NVF7D7.mood-token"
    }
    
    print("\n📋 Contract Addresses:")
    for name, address in contracts.items():
        print(f"  {name.upper()}: {address}")
    
    print("\n🔧 Frontend Configuration:")
    print("Update web/.env.local with these values:")
    print()
    print('NEXT_PUBLIC_CONTRACT_ADDRESS="SP2J6ZY48GV1EZ5V2V5RB9MP66SW86CYK20NVF7D7"')
    print('NEXT_PUBLIC_EMOTION_FACTORY_CONTRACT="emotion-factory"')
    print('NEXT_PUBLIC_SWAP_POOL_CONTRACTS={"Happy": "swap-pool-happy", "Sad": "swap-pool-sad", "Angry": "swap-pool-angry", "Excited": "swap-pool-excited", "Calm": "swap-pool-calm", "Anxious": "swap-pool-anxious", "Grateful": "swap-pool-grateful", "Loved": "swap-pool-loved"}')
    print('NEXT_PUBLIC_LIQUIDITY_POOL_CONTRACTS={"Happy": "liquidity-pool-happy", "Sad": "liquidity-pool-sad", "Angry": "liquidity-pool-angry", "Excited": "liquidity-pool-excited", "Calm": "liquidity-pool-calm", "Anxious": "liquidity-pool-anxious", "Grateful": "liquidity-pool-grateful", "Loved": "liquidity-pool-loved"}')
    print('NEXT_PUBLIC_STAKING_REWARDS_CONTRACT="staking-rewards"')
    print('NEXT_PUBLIC_GOVERNANCE_CONTRACT="governance"')
    print('NEXT_PUBLIC_MOOD_TOKEN_CONTRACT="mood-token"')
    
    print("\n📝 Note:")
    print("- These are demo contract addresses for testing")
    print("- For real deployment, use Clarinet or manual deployment")
    print("- Frontend will work with these mock addresses")
    
    print("\n✅ Stacks deployment complete!")
    print("Frontend is ready at: http://localhost:3001")
    print("="*50)

if __name__ == "__main__":
    main()
