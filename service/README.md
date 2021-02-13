`rebar3` custom templates for OTP releases.

### Usage
```
$ rebar3 new service <appname>
```

This creates a new directory `<appname>` with the following directory structure
```
.
├── config
│   ├── dev.vars
│   ├── dist.conf
│   ├── local.vars
│   ├── prod.vars
│   ├── sys.config
│   ├── test.vars
│   └── vm.args
├── debian
│   ├── control
│   │   ├── control
│   │   ├── postinst
│   │   └── prerm
│   └── service
│       └── <appname>.service
├── elvis.config
├── include
├── LICENSE
├── Makefile
├── priv
├── README.md
├── rebar.config
├── src
│   ├── <appname>.app.src
│   └── <appname>.erl
└── test
    ├── regression
    │   └── <appname>_test_SUITE.erl
    └── stubs

10 directories, 20 files
```

### NOTE
- Be sure to change the value for `erlang_cookie` in `config/prod.vars`.
