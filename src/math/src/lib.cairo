mod aliquot_sum;
mod armstrong_number;

use armstrong_number::{is_armstrong_number};

#[cfg(test)]
mod tests;


fn pow(base: u128, exp: u128) -> u128 {
    if exp == 0 {
        1
    } else if exp == 1 {
        base
    } else if exp % 2 == 0 {
        pow(base * base, exp / 2)
    } else {
        base * pow(base * base, (exp - 1) / 2)
    }
}


fn count_digits_of_base(mut num: u128, base: u128) -> u128 {
    let mut res = 0;
    loop {
        if num == 0 {
            break res;
        } else {
            num = num / base;
        }
        res += 1;
    }
}
