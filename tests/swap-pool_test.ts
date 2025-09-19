import { Clarinet, Tx, Chain, Account, types } from 'https://deno.land/x/clarinet@v1.7.1/index.ts';
import { assertEquals } from 'https://deno.land/std@0.170.0/testing/asserts.ts';

Clarinet.test({
  name: "SwapPool: Initialize pool",
  async fn(chain: Chain, accounts: Map<string, Account>) {
    const deployer = accounts.get('deployer')!;

    // Initialize pool
    const block = chain.mineBlock([
      Tx.contractCall('swap-pool', 'initialize-pool', [
        types.uint(123)
      ], deployer.address)
    ]);

    assertEquals(block.receipts.length, 1);
    assertEquals(block.receipts[0].result, 'true');
  }
});

Clarinet.test({
  name: "SwapPool: Add liquidity",
  async fn(chain: Chain, accounts: Map<string, Account>) {
    const deployer = accounts.get('deployer')!;

    // Initialize pool first
    chain.mineBlock([
      Tx.contractCall('swap-pool', 'initialize-pool', [
        types.uint(123)
      ], deployer.address)
    ]);

    // Add liquidity
    const block = chain.mineBlock([
      Tx.contractCall('swap-pool', 'add-liquidity', [
        types.uint(1000000), // 1 ALGO
        types.uint(2000000)  // 2 tokens
      ], deployer.address)
    ]);

    assertEquals(block.receipts.length, 1);
    assertEquals(block.receipts[0].result, 'true');
  }
});

Clarinet.test({
  name: "SwapPool: Get reserves",
  async fn(chain: Chain, accounts: Map<string, Account>) {
    const deployer = accounts.get('deployer')!;

    // Initialize and add liquidity
    chain.mineBlock([
      Tx.contractCall('swap-pool', 'initialize-pool', [
        types.uint(123)
      ], deployer.address),
      Tx.contractCall('swap-pool', 'add-liquidity', [
        types.uint(1000000),
        types.uint(2000000)
      ], deployer.address)
    ]);

    // Get reserves
    const reserves = chain.callReadOnlyFn('swap-pool', 'get-reserves', [], deployer.address);
    assertEquals(reserves.result, 'true');
  }
});
