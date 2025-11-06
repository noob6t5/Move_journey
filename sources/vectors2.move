module my_addr::VectorUseCase {
    use std::debug;
    use std::vector;
    use std::signer;
    use std::table;

    /// Stores mapping of address -> allocated tokens
    struct TokenDistribution has key {
        balances: table::Table<address, u64>,
    }

    /// Publish a TokenDistribution resource under the admin's account
    public entry fun init_distribution(admin: &signer) {
        let balances = table::new<address, u64>();
        move_to(admin, TokenDistribution { balances });
        debug::print(&b"TokenDistribution initialized");
    }

    /// Distribute tokens among a list of recipients
    public entry fun distribute_tokens(admin: &signer) {
        let addr = signer::address_of(admin);
        let dist_ref = &mut borrow_global_mut<TokenDistribution>(addr).balances;

        let recipients = vector[
            @0xAAA,
            @0xBBB,
            @0xCCC,
            @0xDDD
        ];
        let shares = vector[50, 30, 10, 10];

        let total = sum(&shares);
        debug::print(&total);
        debug::print(&b"Starting distribution...");

        let  i = 0;
        while (i < vector::length(&recipients)) {
            let recipient = *vector::borrow(&recipients, i);
            let amount = *vector::borrow(&shares, i);
            table::add(dist_ref, recipient, amount);
            debug::print(&recipient);
            debug::print(&amount);
            i = i + 1;
        };

        debug::print(&b"Distribution complete");
    }

    /// Get a specific recipient’s allocated tokens
    public fun get_balance(owner: address, recipient: address): u64 {
        if (!exists<TokenDistribution>(owner)) {
            debug::print(&b"No TokenDistribution found");
            0
        } else {
            let dist_ref = &borrow_global<TokenDistribution>(owner).balances;
            if (table::contains(dist_ref, recipient)) {
                *table::borrow(dist_ref, recipient)
            } else {
                0
            }
        }
    }

    /// Helper function: sum up a vector of u64
    fun sum(v: &vector<u64>): u64 {
        let  total = 0;
        let  i = 0;
        while (i < vector::length(v)) {
            total = total + *vector::borrow(v, i);
            i = i + 1;
        };
        total
    }

    #[test(admin = @0xBEEF)]
    public fun test_distribution(admin: &signer) {
        Self::init_distribution(admin);
        Self::distribute_tokens(admin);

        let balA = Self::get_balance(@0xBEEF, @0xAAA);
        debug::print(&balA);
    }
}
