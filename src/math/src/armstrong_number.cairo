use super::{pow, count_digits_of_base};


// For a number to be a armstrong number, sum of its digits power to n(total digits) should be equal to number itself:
// for example: For number 153, n = 3(digit count), therefore, we calculate 1^3 + 5^3 + 3^3, which is 153. therefore number is
// armstrong number

fn is_armstrong_number(mut num: u128) -> bool {
    let mut digits = count_digits_of_base(num, 10);
    let mut remaining_sum = num;

    loop {
        if num == 0 {
            break remaining_sum == 0;
        }

        let last_digit = num % 10;
        let sum = pow(last_digit, digits);
        num = num / 10;
        if sum > remaining_sum {
            break false;
        }
        remaining_sum -= sum;
    }
}
