module my_addr::varss {
    use std::debug;

       public fun shadow_demo() {
        let x = 5;         // original x
        debug::print(&x);

        let x = x + 2;     // new x shadows old x
        debug::print(&x);

        let x = x * 3;     // shadow again
        debug::print(&x);

        let y = 10;
        let y = 100;       // shadow y immediately
        _ = y;    
        debug::print(&y); 
    }

    #[test]
    public fun test_shadow_demo() {
        Self::shadow_demo();
    }

    } 

