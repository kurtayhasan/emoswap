import { Clarinet, Tx, Chain, Account, types } from 'https://deno.land/x/clarinet@v1.7.1/index.ts';
import { assertEquals } from 'https://deno.land/std@0.170.0/testing/asserts.ts';

Clarinet.test({
  name: "EmotionFactory: Create emotion token",
  async fn(chain: Chain, accounts: Map<string, Account>) {
    const deployer = accounts.get('deployer')!;
    const user = accounts.get('wallet_1')!;

    // Create emotion token
    const block = chain.mineBlock([
      Tx.contractCall('emotion-factory', 'create-emotion', [
        types.string('Happy')
      ], deployer.address)
    ]);

    assertEquals(block.receipts.length, 1);
    assertEquals(block.receipts[0].result, 'true');
  }
});

Clarinet.test({
  name: "EmotionFactory: Get emotion count",
  async fn(chain: Chain, accounts: Map<string, Account>) {
    const deployer = accounts.get('deployer')!;

    // Get initial count
    const initialCount = chain.callReadOnlyFn('emotion-factory', 'get-emotion-count', [], deployer.address);
    assertEquals(initialCount.result, 'u0');

    // Create emotion and check count
    chain.mineBlock([
      Tx.contractCall('emotion-factory', 'create-emotion', [
        types.string('Happy')
      ], deployer.address)
    ]);

    const newCount = chain.callReadOnlyFn('emotion-factory', 'get-emotion-count', [], deployer.address);
    assertEquals(newCount.result, 'u1');
  }
});

Clarinet.test({
  name: "EmotionFactory: Unauthorized access",
  async fn(chain: Chain, accounts: Map<string, Account>) {
    const user = accounts.get('wallet_1')!;

    // Try to create emotion as non-admin
    const block = chain.mineBlock([
      Tx.contractCall('emotion-factory', 'create-emotion', [
        types.string('Happy')
      ], user.address)
    ]);

    assertEquals(block.receipts[0].result, 'err(u100)'); // ERR-UNAUTHORIZED
  }
});
