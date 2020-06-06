use rustler::{NifResult, Encoder, Term, Env};

mod atoms {
    rustler_atoms! {
        atom ok;
    }
}

pub fn add<'a>(env: Env<'a>, args: &[Term<'a>]) -> NifResult<Term<'a>> {
    let num1: i64 = args[0].decode()?;
    let num2: i64 = args[1].decode()?;

    Ok((atoms::ok(), num1 + num2).encode(env))
}
