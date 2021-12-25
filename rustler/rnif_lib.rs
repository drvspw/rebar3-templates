// nif implementations
pub mod {{name}};

rustler::init!("{{name}}_nif", [{{name}}::add]);
