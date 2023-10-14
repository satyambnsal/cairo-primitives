use cairo_primitives_math::{is_armstrong_number};


#[test]
#[available_gas(2000000)]
fn one_digit_armstrong_number() {
    assert(is_armstrong_number(1), 'invalid result');
}


#[test]
#[available_gas(2000000)]
fn two_digit_not_armstrong_number() {
    assert(!is_armstrong_number(15), 'invalid result');
}

#[test]
#[available_gas(2000000)]
fn three_digit_armstrong_number() {
    assert(is_armstrong_number(153), 'invalid result');
}

#[test]
#[available_gas(2000000)]
fn three_digit_not_armstrong_number() {
    assert(!is_armstrong_number(154), 'invalid result');
}
