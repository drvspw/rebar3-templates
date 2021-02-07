`rebar3` custom templates for OTP releases.

### Installation
1. Clone this repository
2. Copy all the files in `otprel` directory to `~/.config/rebar3/templates/`
3. Check if the templates are available
```
$ rebar3 new
...
otprel (custom): Complete OTP Release application structure
...
```

### Usage
```
$ rebar3 new otprel <appname>
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

## CAVEAT
Using *xnode* template requires an additional step:
```
$ grep -ilr <appname>_ENV .
```

In each file listed by the above command make `<appname>_ENV` ALL CAPS.
