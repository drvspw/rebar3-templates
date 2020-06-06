`rebar3` custom templates for OTP libraries.

### Installation
1. Clone this repository
2. Copy all the files in `otp-lib` directory to `~/.config/rebar3/templates/`
3. Check if the templates are available
```
$ rebar3 new
...
otp-lib (custom): Complete OTP Library application structure
...
```

### Usage
1. *xlib* Templates

- Create a new project directory `<libname>`
- Create the project structure
```
$ cd <libname>
$ rebar3 new xlib <libname>
```

This creates the following directory structure
```
.
├── elvis
├── elvis.config
├── include
├── LICENSE
├── Makefile
├── priv
├── README.md
├── rebar.config
├── src
│   ├── <libname>.app.src
│   └── <libname>.erl
└── test
    ├── stubs
    └── suites
        └── <libname>_test_SUITE.erl

6 directories, 9 files
```
