module my_addr::Perms {
    use std::debug::print;

    const READ: u8 = 1;   // 0001
    const WRITE: u8 = 2;  // 0010
    const DELETE: u8 = 4; // 0100

    // give user permissions
    public fun grant_permissions(): u8 {
        let perms = 0;            // start: 0000
        let perms = perms | READ;   // turn ON bit0 → 0001
        let perms = perms | DELETE; // turn ON bit2 → 0101
        print(&perms);              // prints 5
        perms
    }

    // check if user has a specific permission
    public fun has_read(perms: u8): bool {
        (perms & READ) != 0          // true if bit0 is ON
    }

    public fun has_write(perms: u8): bool {
        (perms & WRITE) != 0         // true if bit1 is ON
    }

    public fun has_delete(perms: u8): bool {
        (perms & DELETE) != 0        // true if bit2 is ON
    }

    // flip permission — XOR
    public fun toggle_delete(perms: u8): u8 {
        perms ^ DELETE
    }

    #[test]
    fun test_permissions() {
        let p = grant_permissions();        
        print(&has_read(p));                
        print(&has_write(p));              
        print(&has_delete(p));             

        let toggled = toggle_delete(p);
        print(&has_delete(toggled));        
    }
}
