//use rustler::{NifResult, Encoder, Term, Env};

#[rustler::nif]
fn add(a: i64, b: i64) -> i64 {
    a + b
}
