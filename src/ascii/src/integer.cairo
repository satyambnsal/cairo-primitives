use option::OptionTrait;
use alexandria_data_structures::array_ext::ArrayTraitExt;
use array::{ArrayTrait, SpanTrait};
use traits::{Into, TryInto, DivRem};
use zeroable::Zeroable;

trait ToAsciiTrait<T,U> {
    fn to_ascii(self: T) -> U;
}

trait ToAsciiArrayTrait<T> {
    fn to_ascii_array(self: T) -> Array<felt252>;
    fn to_inverse_ascii_array(self: T) -> Array<felt252>;
}

impl ToAsciiArrayTraitImpl<
T,
impl TPartialOrd: PartialOrd<T>,
impl TInto: Into<T, felt252>,
impl TDivRem: DivRem<T>,
impl TryInto: TryInto<felt252, T>,
impl TTryIntoZero: TryInto<T, NonZero<T>>,
impl TZeroable: Zeroable<T>,
impl TDrop: Drop<T>,
impl TCopy: Copy<T>
> of ToAsciiArrayTrait<T> {
    fn to_inverse_ascii_array(self: T) -> Array<felt252> {
        let mut new_arr = ArrayTrait::new();
        if self <= 9.try_into().unwrap() {
            new_arr.append(self.into() + 48);
            return new_arr;
        }

        let mut num = self;
        loop {
            if num.is_zero() {
                break;
            }

            let (quotient, remainder) = DivRem::div_rem(
                num, TryInto::<felt252,T>::try_into(10).unwrap().try_into().expect('Division by 0')
            );

            new_arr.append(remainder.into() + 48);
            num = quotient;
        };
        new_arr
    }

    fn to_ascii_array(self: T) -> Array<felt252> {
        let mut new_arr = self.to_inverse_ascii_array();
        new_arr.reverse();
        new_arr
    }
}

impl SmallIntegerToAsciiTraitImpl<
T,
impl TPartialOrd: PartialOrd<T>,
impl TDivRem: DivRem<T>,
impl TInto: Into<T, felt252>,
impl TTryInto: TryInto<felt252, T>,
impl TTryIntoZero: TryInto<T, NonZero<T>>,
impl TZeroable: Zeroable<T>,
impl TDrop: Drop<T>,
impl TCopy: Copy<T>
> of ToAsciiTrait<T, felt252> {
    fn to_ascii(self: T) -> felt252 {
        if self <= 9.try_into().unwrap() {
            return self.into() + 48;
        }

        let mut inverse_ascii_arr = self.to_inverse_ascii_array().span();
        let mut ascii:felt252 = 0;

        loop {
            match inverse_ascii_arr.pop_back() {
                Option::Some(val) => { ascii = ascii * 256 + *val;},
                Option::None(_) => {break;}
            };
        };
        ascii
    }
}

impl BigIntegerToAsciiTraitImpl<
T,
impl TPartialOrd: PartialOrd<T>,
impl TDivRem: DivRem<T>,
impl TInto: Into<T, felt252>,
impl TTryInto: TryInto<felt252, T>,
impl TTryIntoZero: TryInto<T, NonZero<T>>,
impl TZeroable: Zeroable<T>,
impl TDrop: Drop<T>,
impl TCopy: Copy<T>
> of ToAsciiTrait<T, Array<felt252>> {
    fn to_ascii(self: T) -> Array<felt252> {
        let mut data = ArrayTrait::new();
        if self <= 9.try_into().unwrap() {
            data.append(self.into() + 48);
            return data;
        }

        let mut inverse_ascii_arr = self.to_inverse_ascii_array().span();
        let mut ascii: felt252 = 0;
        let mut index = 0;

        loop {
            match inverse_ascii_arr.pop_back() {
                Option::Some(val) => {
                    let new_ascii = ascii * 256 + *val;

                    ascii = if index == 30 {
                        data.append(new_ascii);
                        0
                    } else {
                        new_ascii
                    };
                },
                Option::None(_) => {
                    if ascii.is_non_zero() {
                        data.append(ascii)
                    }
                    break;
                }
            };
            index +=1;
        };

        data
    }
}


impl U256ToAsciiArrayTraitImpl of ToAsciiArrayTrait<u256> {
    fn to_inverse_ascii_array(self: u256) -> Array<felt252> {
        let mut new_arr = ArrayTrait::new();
        if self <= 9 {
            new_arr.append(self.try_into().expect('number overflow felt252') + 48);
            return new_arr;
        }

        let mut num = self;

        loop {
            if num.is_zero() {
                break;
            }

            let (quotient, remainder) = DivRem::div_rem(num, 10_u256.try_into().expect('Division by 0'));

            new_arr.append(remainder.try_into().expect('number overflow felt252') + 48);
            num = quotient;
        };
        new_arr
    }

    fn to_ascii_array(self: u256) -> Array<felt252> {
        let mut new_arr = self.to_inverse_ascii_array();
        new_arr.reverse();
        new_arr
    }
}


impl U256ToAsciiTraitImpl of ToAsciiTrait<u256, Array<felt252>> {
    fn to_ascii(self: u256) -> Array<felt252> {
        let mut data = ArrayTrait::new();
        if self <= 9 {
            data.append(self.try_into().expect('number overflow felt252') + 48);
            return data;
        }

        let mut inverse_ascii_arr = self.to_inverse_ascii_array().span();
        let mut ascii: felt252 = 0;
        let mut index = 0;

        loop {
            match inverse_ascii_arr.pop_back() {
                Option::Some(val) => {
                    let new_ascii = ascii * 256 + *val;

                    ascii = if index == 30 || index == 61 {
                        data.append(new_ascii);
                        0
                    } else {
                        new_ascii
                    };
                },
                Option::None(_) => {
                    if ascii.is_non_zero() {
                        data.append(ascii)
                    }
                    break;
                }
            };
            index +=1;
        };

        data
    }
}