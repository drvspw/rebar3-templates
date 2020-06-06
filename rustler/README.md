`rebar3` custom template for creating NIF's using [rustler](https://github.com/hansihe/rustler)

### Installation
1. Clone this repository
2. Copy all the files in `rustler` directory to `~/.config/rebar3/templates/`
3. Check if the templates are available
```
$ rebar3 new
...
rnif (custom): Rust NIF's using rustler
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
$ rebar3 new rnif <name>
```

This creates the following files in the current directory:

```
├── rebar.config
├── rebar.config.script
├── rustler
│   ├── Cargo.toml
│   ├── Makefile
│   └── src
│       └── <lib>.rs
│       └── <name>.rs
└── src
    ├── <name>_nif.erl
```

3. `rebar.config.script` file dynamically adds `pre_hooks` and `post_hooks` to build rust code as part of `rebar3` build process. If you are adding rust nif's to an existing project that already has a `rebar.config.script` file, then this template would not create `rebar.config.script` file. You have to add following hooks to `rebar.config`
```erlang
{pre_hooks,
  [{"(linux|darwin|solaris)", compile, "make -C rustler"},
   {"(freebsd)", compile, "gmake -C rustler"}]}.
{post_hooks,
  [{"(linux|darwin|solaris)", clean, "make -C rustler clean"},
   {"(freebsd)", clean, "gmake -C rustler clean"}]}.
```

4. Complile and Test
The template implements a NIF `add()` to add two integers.

```
$ rebar3 compile
$ rebar3 shell
Erlang/OTP 20 [erts-9.3] [source] [64-bit] [smp:2:2] [ds:2:2:10] [async-threads:1] [hipe] [kernel-poll:false]

Eshell V9.3  (abort with ^G)
1> <name>_nif:add(10, 11).
{ok,21}
2>
```
