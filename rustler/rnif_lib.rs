#[macro_use] extern crate rustler;
//#[macro_use] extern crate lazy_static;

use rustler::{Env, Term};

// nif implementations
mod {{name}};

rustler_export_nifs! {
    "{{name}}_nif", // module name
    [("add", 2, {{name}}::add)], // nif functions
    Some(on_load) // on_load callback
}

// callback: called on loading nif library
fn on_load(_env: Env, _info: Term) -> bool {
    true
}
