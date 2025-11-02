module my_addr::ConstAndSigner {
    use std::debug;
    use std::signer;

    const BASE_FEE: u64 = 100;
    const MULTIPLIER: u64 = 3;

    /// Computes total fee and prints who’s paying
    public fun total_fee(user: &signer, user_count: u64): u64 {
        let addr = signer::address_of(user);
        debug::print(&addr);
        let total = BASE_FEE + (user_count * MULTIPLIER);
        debug::print(&total);
        total
    }

    #[test(user = @0xCAFE)]
    public fun test_fee_calc(user: &signer) {
        let result = Self::total_fee(user, 5);
        debug::print(&result);
        // Expect printed values: @0xcafe, 115, 115
    }
}