`rebar3` custom templates for OTP libraries.

### Installation
1. Clone this repository
2. Copy all the files in `otp-lib` directory to `~/.config/rebar3/templates/`
3. Check if the templates are available
```
$ rebar3 new
...
otplib (custom): Complete OTP Library application structure
...
```

### Usage
```
$ rebar3 new otplib <libname>
```

This creates a new directory `<libname>` with the following directory structure
```
.
├── ebump
├── ebump.config
├── elvis
├── elvis.config
├── include
├── LICENSE
├── Makefile
├── priv
├── README.md
├── rebar.config
├── src
│   ├── <libname>.app.src
│   └── <libname>.erl
└── test
    ├── stubs
    │   ├── <libname>_ct.erl
    │   └── sys.config	
    └── suites
        └── <libname>_test_SUITE.erl

6 directories, 13 files
```
