import_load "../bitset.odin";
import_load "fmt.odin";

proc test_set () {
	test_single();
	test_multiple();
	test_with_append();
	test_with_not_set();
}

proc test_single () {
	var a = create_set();
	set(a, 1);
	set(a, 0);
	set(a, 31);
	assert(len(a.bits) == 1);
	assert(a.bits[0] == 0b1000_0000__0000_0000__0000_0000__0000_0011);
}

proc test_multiple () {
	var a = create_set();
	set(a, 1, 2, 3, 4, 5);
	assert(len(a.bits) == 1);
	assert(a.bits[0] == 0b0000_0000__0000_0000__0000_0000__0011_1110);
}

proc test_with_append () {
	var a = create_set();
	set(a, 1);
	set(a, 2);
	set(a, 33);
	set(a, 34);
	assert(len(a.bits) == 2);
	assert(a.bits[0] == 0b0000_0000__0000_0000__0000_0000__0000_0110);
	assert(a.bits[1] == 0b0000_0000__0000_0000__0000_0000__0000_0110);
}

proc test_with_not_set  () {
	var a = create_set();
	set(a, 32);
	set(a, 22);
	set(a, 0);

	assert(len(a.bits) == 2);
	assert(a.bits[0] == 0b0000_0000__0100_0000__0000_0000__0000_0001);
	assert(a.bits[1] == 0b0000_0000__0000_0000__0000_0000__0000_0001);

	a.is_not_set = true;

	set(a, 22);

	assert(len(a.bits) == 2);
	assert(a.bits[0] == 0b0000_0000__0000_0000__0000_0000__0000_0001);
	assert(a.bits[1] == 0b0000_0000__0000_0000__0000_0000__0000_0001);
}
