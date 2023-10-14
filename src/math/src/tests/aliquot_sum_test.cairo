use cairo_primitives_math::aliquot_sum::aliquot_sum;

#[test]
#[available_gas(200000)]
fn zero_test() {
    assert(aliquot_sum(0) == 0, 'sum should be zero');
}

#[test]
#[available_gas(2000000)]
fn one_test() {
    assert(aliquot_sum(1) == 0, 'sum should be zero');
}

#[test]
#[available_gas(2000000)]
fn one_digit_number_test() {
    assert(aliquot_sum(6) == 6, 'sum should be 6');
}


#[test]
#[available_gas(200000000)]
fn two_digit_number_test() {
    assert(aliquot_sum(15) == 9, 'sum should be 9');
    assert(aliquot_sum(343) == 57, 'sum should be 57');
    assert(aliquot_sum(17) == 1, 'sum should be 1');
}
