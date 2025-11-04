module my_addr::VectorWork {
    use std::debug;
    use std::vector;

    // ============================================
    // 1️⃣ Basic Vector Playground
    // ============================================
    public fun basics() {
        let v = vector::empty<u64>();
        vector::push_back(&mut v, 10);
        vector::push_back(&mut v, 20);
        vector::push_back(&mut v, 30);
        debug::print(&v); // [10, 20, 30]

        let len = vector::length(&v);
        debug::print(&len); // 3

        let second = *vector::borrow(&v, 1); // immutable borrow
        debug::print(&second); // 20

        vector::pop_back(&mut v); // removes last element
        debug::print(&v); // [10, 20]
    }

    // ============================================
    // 2️⃣ Pushing, Removing, and Updating
    // ============================================
    public fun mutate_ops() {
        let v = vector::empty<u64>();
        vector::push_back(&mut v, 1);
        vector::push_back(&mut v, 2);
        vector::push_back(&mut v, 3);
        debug::print(&v); // [1, 2, 3]

        // swap_remove(index) → removes element by swapping it with the last
        let old = vector::swap_remove(&mut v, 1);
        debug::print(&old); // removed value
        debug::print(&v);   // [1, 3]

        // insert(index, value)
        vector::insert(&mut v, 1, 99);
        debug::print(&v); // [1, 99, 3]

        // remove(index)
        vector::remove(&mut v, 0);
        debug::print(&v); // [99, 3]

        // swap(index1, index2)
        vector::swap(&mut v, 0, 1);
        debug::print(&v); // [3, 99]
    }

    // ============================================
    // 3️⃣ Functional Style — map, filter, fold
    // ============================================
    public fun functional_ops() {
        // Create a vector manually
        let nums = vector::empty<u64>();
        vector::push_back(&mut nums, 1);
        vector::push_back(&mut nums, 2);
        vector::push_back(&mut nums, 3);
        vector::push_back(&mut nums, 4);
        vector::push_back(&mut nums, 5);

        // “map”: build a new vector of squares
        let squares = vector::empty<u64>();
        let len = vector::length(&nums);
        let i = 0;
        while (i < len) {
            let n = *vector::borrow(&nums, i);
            vector::push_back(&mut squares, n * n);
            i = i + 1;
        };
        debug::print(&squares); // [1, 4, 9, 16, 25]

        // “filter”: keep only even numbers
        let evens = vector::empty<u64>();
        let j = 0;
        while (j < len) {
            let n = *vector::borrow(&nums, j);
            if (n % 2 == 0) vector::push_back(&mut evens, n);
            j = j + 1;
        };
        debug::print(&evens); // [2, 4]

        // “fold”: sum all numbers
        let sum = 0;
        let k = 0;
        while (k < len) {
            sum = sum + *vector::borrow(&nums, k);
            k = k + 1;
        };
        debug::print(&sum); // 15
    }

    // ============================================
    // 4️⃣ Destroy or Drop a Vector Safely
    // ============================================
    public fun destroy_all(v: vector<u64>) {
        let local = v;
        while (!vector::is_empty(&local)) {
            let _ = vector::pop_back(&mut local);
        };
        // Ownership consumed safely
    }

    // ============================================
    // 5️⃣ Quick Inline Unit Test
    // ============================================
    #[test]
    public fun test_all() {
        basics();
        mutate_ops();
        functional_ops();
    }
}
