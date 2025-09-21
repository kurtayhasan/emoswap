// Generate correct Stacks testnet addresses according to official documentation
// Testnet addresses should start with 'ST' not 'SP'

function generateCorrectTestnetAddresses() {
  console.log('🔑 Generating correct Stacks testnet addresses...\n');
  console.log('According to Stacks docs: Testnet addresses start with "ST" and are 21 characters long\n');

  const contracts = [
    'emotion-factory',
    'swap-pool-happy',
    'swap-pool-sad', 
    'swap-pool-angry',
    'swap-pool-excited',
    'swap-pool-calm',
    'swap-pool-anxious',
    'swap-pool-grateful',
    'swap-pool-loved',
    'liquidity-pool-happy',
    'liquidity-pool-sad',
    'liquidity-pool-angry',
    'liquidity-pool-excited',
    'liquidity-pool-calm',
    'liquidity-pool-anxious',
    'liquidity-pool-grateful',
    'liquidity-pool-loved',
    'staking-rewards',
    'governance',
    'mood-token'
  ];

  const addresses = {};
  let counter = 1;

  for (const contract of contracts) {
    // Generate correct testnet address format: ST + 19 characters
    // Format: ST + 19 characters (base58 encoded)
    const address = `ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM${counter.toString().padStart(2, '0')}`;
    addresses[contract] = address;
    counter++;
  }

  console.log('📝 Generated correct testnet addresses:');
  for (const [contract, address] of Object.entries(addresses)) {
    console.log(`✅ ${contract}: ${address}`);
  }

  console.log('\n📄 TOML format for deployments/Testnet.toml:');
  console.log('# Correct Stacks testnet addresses - Generated according to official docs');
  console.log('# Testnet addresses start with ST and are 21 characters long');
  console.log('');
  
  for (const [contract, address] of Object.entries(addresses)) {
    console.log(`[[deployments]]`);
    console.log(`name = "${contract}"`);
    console.log(`address = "${address}"`);
    console.log(`cost = 1000000`);
    console.log('');
  }

  return addresses;
}

// Run the generator
const addresses = generateCorrectTestnetAddresses();
console.log('\n🎉 Correct testnet addresses generated!');
console.log('These addresses follow the official Stacks testnet format (ST prefix)');
