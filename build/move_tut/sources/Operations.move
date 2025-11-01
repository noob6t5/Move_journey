module my_addr::Operations{
    use std::debug::print;

    fun arithmetic_operations(a:u64,b:u64)
    {
        let ans=a+b;    print(&ans);
        let ans=a-b;    print(&ans);
        let ans=a*b;    print(&ans);
        let ans=a/b;    print(&ans);
        let ans=a%b;    print(&ans);
    }

    fun bitwise_operations(c:u64,d:u64){
        let ans= c|d;   print(&ans);
        let ans= c&d;   print(&ans);
        let ans= c^d;   print(&ans);
    }


     fun bitshift_operations(a:u64){
        let ans=a>>2;       print(&ans);
        let ans=a<<2;       print(&ans);

    }

    #[test]
    fun test_arithmetic() {
        arithmetic_operations(12,5);
    }
    #[test]
    fun test_bitwise() {
        bitwise_operations(2,4);
    }

    #[test]
    fun test_shift() {
        bitshift_operations(4);
    }

}