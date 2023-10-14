

fn aliquot_sum(number: u128) -> u128 {
    if number == 0 || number == 1{
        return 0;
    }

    let limit = (number / 2) + 1;
    let mut index = 1;
    let mut res = 0;

    loop {
        if index == limit {
            break res;
        }

        if number % index == 0 {
            res += index;
        }
        index +=1 ;
    }
}