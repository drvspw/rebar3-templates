-module({{name}}_test_SUITE).

-include_lib("common_test/include/ct.hrl").
-include_lib("eunit/include/eunit.hrl"). % Eunit macros for convenience

-export([all/0
        ,groups/0
        ,init_per_suite/1, end_per_suite/1
        ,init_per_group/2, end_per_group/2
         %%,init_per_testcase/2, end_per_testcase/2
        ]).

-export([
         {{name}}_test/1
        ]).

%%=================================================
%% Test Setup
%%=================================================
all() ->
  [{group, {{name}}_tests}].

groups() ->
  [{{{name}}_tests, [], [{{name}}_test]}].

init_per_suite(Config) ->
  application:ensure_all_started({{name}}),
  Config.

end_per_suite(_Config) ->
  application:stop({{name}}),
  ok.

init_per_group({{name}}_tests, Config) ->
  %% test setup for group {{name}}_tests
  Config;

init_per_group(_, Config) ->
  Config.

end_per_group({{name}}_tests, _Config) ->
  %% teardown test setup for group {{name}}_tests
  ok;

end_per_group(_Name, _Config) ->
  ok.


%%=================================================
%% Test Cases
%%=================================================
{{name}}_test(_Config) ->
  ?assert(false).
