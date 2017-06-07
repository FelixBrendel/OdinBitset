#load "fmt.odin";

Bitset :: struct {
	bits : [dynamic] u32,
}

create_set :: proc () -> ^Bitset {
	return new(Bitset);
}

destroy_set :: proc (using b : ^Bitset) {
	free(bits);
}

set :: proc (using b : ^Bitset, pos : ..uint) {
	for p in pos {
		for uint(len(bits)) * 32 <= p {
			append(bits, 0);
		}
		bits[p >> 5] |= 1 << (p % 32);
	}
}

unset :: proc (using b : ^Bitset, pos : ..uint) {
	for p in pos {
		if uint(len(bits)) * 32 < p {
			return;
		}
		bits[p >> 5] &~= 1 << (p % 32);
	}
}

get :: proc (using b : ^Bitset, pos : uint) -> bool {
	if uint(len(bits)) * 32 < pos {
		return false;
	}
	return bits[pos >> 5] & (1 << (pos % 32)) != 0;
}

get_all :: proc (using b : ^Bitset) -> []uint {
	ret : [dynamic]uint;
	for i in 0..<uint(32 * len(bits)) {
		// skipping bounds check by not calling get
		if bits[i >> 5] & (1 << (i % 32)) != 0 {
			append(ret, i);
		}
	}
	return ret[..];
}

copy_bitset :: proc (using b : ^Bitset) -> ^Bitset {
	ret := new(Bitset);
	for _u32 in bits {
		append(ret.bits, _u32);
	}
	return ret;
}


union_set :: proc (a : ^Bitset, b : ^Bitset) -> ^Bitset {
	if len(a.bits) < len(b.bits) {
		a, b = b, a;
	}
	ret := copy_bitset(a);
	for _u32, idx in b.bits {
		ret.bits[idx] |= _u32;
	}
	return ret;
}

cut_set ::  proc (a : ^Bitset, b : ^Bitset) -> ^Bitset {
	if len(a.bits) < len(b.bits) {
		a, b = b, a;
	}
	ret := copy_bitset(b);
	for _, idx in b.bits {
		ret.bits[idx] &= a.bits[idx];
	}
	return ret;
}
