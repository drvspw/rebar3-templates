`rebar3` custom templates for OTP releases.

### Installation
1. Clone this repository
2. Copy all the files in `otp-rel` directory to `~/.config/rebar3/templates/`
3. Check if the templates are available
```
$ rebar3 new
...
otp-rel (custom): Complete OTP Release application structure
...
```

### Usage
- Create a new project directory `<appname>`
- Create project structure
```
$ cd <appname>
$ rebar3 new otp-rel <appname>
```

This creates the following files in the current directory

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
├── elvis
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
