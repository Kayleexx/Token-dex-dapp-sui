use std::option;
use sui::url;
use sui::transfer;
use sui::coin;
use sui::tx_context::{Self, TxContext};

struct KAY has drop {}
fun init(witness: KAY, ctx: &mut TxContext) {
  let (treasury_cap, metadata) = coin::create_currency<KAY>(
    witness,
    9,
    b"KAY",
    b"KAY Coin",
    b"Kaylee Native Coin",
    option::some(url::new_unsafe_from_bytes(b"https://s2.coinmarketcap.com/static/img/coins/64x64/1027.png")),
    ctx
  );

  transfer::public_transfer(treasury_cap, tx_context::sender(ctx));

  transfer::public_share_object(metadata);
}

#[test_only]
public fun init_for_testing(ctx: &mut TxContext) {
	  init(KAY {}, ctx);
}
