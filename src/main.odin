#load "bitset.odin";
#load "fmt.odin";

main :: proc () {
    b := new(Bitset);

    set(b, 0, 420);

    c := copy_bitset(b);
    set(c, 2, 4);

    set(b, 202);
    set(b, 31);

    unset(b, 202);

    d := union_set(c,b);
    e := cut_set(c,d);

    println("b:", get_all(b));
    println("c:", get_all(c));
    println("d:", get_all(d));
    println("e:", get_all(e));
}
