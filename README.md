### Templates

`rebar3` custom template for creating
- OTP library
- OTP application
- NIF's using [rustler](https://github.com/hansihe/rustler)

### Installation
1. Create the global variables file in `$HOME/.config/rebar3/templates/globals` with the following contents
```
{variables, [
    {copyright_owner, "YOUR NAME"},
	{gh_owner, "GITHUB OWNER"}
   ]}.
```
2. Follow instructions from README in each of the directories
