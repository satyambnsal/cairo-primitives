use array::{ArrayTrait};
use cairo_primitives_ascii::ToAsciiTrait;
use integer::BoundedInt;



#[test]
#[available_gas(20000000)]
fn u256_to_ascii() {

    // max 256 int in cairo: 115792089237316195423570985008687907853269984665640564039457584007913129639935

    let num: u256 = BoundedInt::max();
    let ascii_arr: Array<felt252> = num.to_ascii();

    assert(ascii_arr.len() == 3, 'max u256 wrong length');
    assert(*ascii_arr.at(0) == '1157920892373161954235709850086', 'max u256 wrong first felt');
    assert(*ascii_arr.at(1) == '8790785326998466564056403945758', 'max u256 wrong second felt');
    assert(*ascii_arr.at(2) == '4007913129639935', 'max u256 wrong third felt');

    let num:u256 = BoundedInt::min();
    let ascii: Array<felt252> = num.to_ascii();
    assert(ascii.len() == 1, 'min u256 wrong len');
    assert(*ascii.at(0) == '0', 'min u256 wrong felt');
}

#[test]
#[available_gas(20000000)]
fn u128_to_ascii() {
    let num: u128 = BoundedInt::max();
    let ascii_arr: Array<felt252> = num.to_ascii();

    assert(ascii_arr.len() == 2, 'max u128 wrong length');
    assert(*ascii_arr.at(0) == '3402823669209384634633746074317', 'max u128 wrong first felt');
    assert(*ascii_arr.at(1) == '68211455', 'max u128 wrong second felt');

    let num:u128 = BoundedInt::min();
    let ascii: Array<felt252> = num.to_ascii();
    assert(ascii.len() == 1, 'min u128 wrong len');
    assert(*ascii.at(0) == '0', 'min u128 wrong felt');

    let ascii: Array<felt252> = 3402823669209384634633746074317_u128.to_ascii();
    assert(ascii.len() == 1, 'u128 31 char wrong len');
    assert(*ascii.at(0) == '3402823669209384634633746074317', '31 char u128 wrong felt');
}

#[test]
#[available_gas(20000000)]
fn u64_to_ascii() {
    let num: u64 = BoundedInt::max();

    assert(num.to_ascii() == '18446744073709551615', 'incorrect u64 max felt');
    let num: u64 = BoundedInt::min();
    assert(num.to_ascii() == '0', 'incorrect u64 min felt');
}


#[test]
#[available_gas(20000000)]
fn u32_to_ascii() {
    let num: u32 = BoundedInt::max();

    assert(num.to_ascii() == '4294967295', 'incorrect u32 max felt');
    let num: u32 = BoundedInt::min();
    assert(num.to_ascii() == '0', 'incorrect u32 min felt');
}

#[test]
#[available_gas(20000000)]
fn u16_to_ascii() {
    let num: u16 = BoundedInt::max();

    assert(num.to_ascii() == '65535', 'incorrect u16 max felt');
    let num: u16 = BoundedInt::min();
    assert(num.to_ascii() == '0', 'incorrect u16 min felt');
}

#[test]
#[available_gas(20000000)]
fn u8_to_ascii() {
    let num: u8 = BoundedInt::max();

    assert(num.to_ascii() == '255', 'incorrect u8 max felt');
    let num: u8 = BoundedInt::min();
    assert(num.to_ascii() == '0', 'incorrect u8 min felt');
}


