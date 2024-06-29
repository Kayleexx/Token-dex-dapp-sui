module dex::usdc {
  use std::option;

  use sui::url;
  use sui::transfer;
  use sui::coin;
  use sui::tx_context::{Self, TxContext};

  struct USDC has drop {}

  
fun init(witness: USDC, ctx: &mut TxContext) {
      
			let (treasury_cap, metadata) = coin::create_currency<USDC>(
            witness, // One time witness
            9, // Decimals of the coin
            b"USDC", // Symbol of the coin
            b"USDC Coin", // Name of the coin
            b"A stable coin issued by Circle", // Description of the coin
            option::some(url::new_unsafe_from_bytes(b"https://s3.coinmarketcap.com/static-gravity/image/5a8229787b5e4c809b5914eef709b59a.png")), // An image of the Coin
            ctx
        );

      // We send the treasury capability to the deployer

      transfer::public_transfer(treasury_cap, tx_context::sender(ctx));

      // Objects defined in different modules need to use the public_ transfer functions
      
			transfer::public_share_object(metadata);
  }

  // ** Test Functions

  #[test_only]
  public fun init_for_testing(ctx: &mut TxContext) {
    init(USDC {}, ctx);
  }
}
