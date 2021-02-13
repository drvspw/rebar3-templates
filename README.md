### Templates

`rebar3` custom template for creating
- OTP library
- OTP release
- NIF's using [rustler](https://github.com/hansihe/rustler)

### Installation
1. Create the global variables file in `$HOME/.config/rebar3/templates/globals` with the following contents
```
{variables, [
    {copyright_owner, "YOUR NAME"},
	{gh_owner, "GITHUB OWNER"}
   ]}.
```
2. Download the latest tarball from [Releases](https://github.com/drvspw/rebar3-templates/releases) page and extract into `$HOME/.config/rebar3/templates/` directory. `rebar3` should list the new templates
   - service
   - library
   - rustler

```bash
$ rebar3 new
app (built-in): Complete OTP Application structure.
cmake (built-in): Standalone Makefile for building C/C++ in c_src
escript (built-in): Complete escriptized application structure
lib (built-in): Complete OTP Library application (no processes) structure
library (custom): Complete OTP Library application structure
plugin (built-in): Rebar3 plugin project structure
release (built-in): OTP Release structure for executable programs
rustler (custom): Rust NIF's using rustler in rustler/
service (custom): Complete OTP Release application structure
umbrella (built-in): OTP structure for executable programs (alias of 'release' template)
$
```
For more information on the template please refer to `README.md` in the appropriate directories.
