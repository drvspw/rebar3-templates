# rustler_template
`rebar3` custom template for creating NIF's using [rustler](https://github.com/hansihe/rustler)

### Installation
1. Clone this repository
2. Copy all the files in `templates` directory to `~/.config/rebar3/templates/`
3. Check if the templates are available
```
$ rebar3 new
...
rif (custom): Rust NIF's using rustler in rs_src
...
```

### Usage
1. Create a new OTP project using `rebar3`
```
  $ rebar3 new lib <lib name>
```

2. Create NIF from template
```
$ cd <lib name>
$ rebar3 new rif <name>
```

This creates the following files in the current directory:

```
├── rebar.config
├── rs_src
│   ├── Cargo.toml
│   ├── Makefile
│   └── src
│       └── <name>.rs
└── src
    ├── <name>.erl	
```

3. Add the following hooks to `rebar.config`
```erlang
{pre_hooks,
  [{"(linux|darwin|solaris)", compile, "make -C rs_src"},
   {"(freebsd)", compile, "gmake -C rs_src"}]}.
{post_hooks,
  [{"(linux|darwin|solaris)", clean, "make -C rs_src clean"},
   {"(freebsd)", clean, "gmake -C rs_src clean"}]}.
```

4. Complile and Test
The template implements a NIF `add()` to add two integers.

```
$ rebar3 compile
$ rebar3 shell
Erlang/OTP 20 [erts-9.3] [source] [64-bit] [smp:2:2] [ds:2:2:10] [async-threads:1] [hipe] [kernel-poll:false]

Eshell V9.3  (abort with ^G)
1> <name>:add(10, 11).
{ok,21}
2> 
```


