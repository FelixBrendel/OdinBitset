#load "bitset.odin";
#load "fmt.odin";

main :: proc () {
    b := new(Bitset);

    set(b, 1,2,3,4,10, 40);
    c := not_set(b);


    println("b:", get_all(b));
    println("c:", get_all(c));
}
