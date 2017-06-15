 import_load "../bitset.odin";

proc test_unset () {
	var a = create_set(1, 3, 7, 51, 33);

	unset(a, 0);
	unset(a, 1);
	unset(a, 10, 2, 7);

	var ga = get_all(a);

	assert(len(ga) == 3);
	assert(ga[0] == 3);
	assert(ga[1] == 33);
	assert(ga[2] == 51);
}
