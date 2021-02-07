`rebar3` custom templates for OTP libraries.

### Usage
```
$ rebar3 new library <libname>
```

This creates a new directory `<libname>` with the following directory structure
```
.
├── ebump
├── ebump.config
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
