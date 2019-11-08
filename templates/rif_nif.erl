-module({{name}}).

%% API Exports
-export([
         add/2
        ]).

-on_load(init/0).

-define(APPNAME, ?MODULE).
-define(LIBNAME, "lib{{name}}").

%%====================================================================
%% API functions - NIFS
%%====================================================================

%% @doc add/2 adds two integers and returns their sum
%%
%% @end
-spec add(A, B) -> {ok, Sum}
        when
        A :: integer(),
        B :: integer(),
        Sum :: integer().
add(A,B) ->
        add_nif(A,B).

%%====================================================================
%% NIFS
%%====================================================================
add_nif(_,_) ->
    not_loaded(?LINE).

%%====================================================================
%%%% Internal functions
%%%%%====================================================================
init() ->
  PrivDir = code:priv_dir(?APPNAME),
  LibFile = lib_file(PrivDir, ?LIBNAME),
  erlang:load_nif(LibFile, 0).

lib_file({error, bad_name}, LibName) ->
  case filelib:is_dir(filename:join(["..", priv])) of
    true ->
      filename:join(["..", priv, LibName]);
    _ ->
      filename:join([priv, LibName])
  end;

lib_file(PrivDir, LibName) ->
  filename:join(PrivDir, LibName).

not_loaded(Line) ->
            exit({not_loaded, [{module, ?MODULE}, {line, Line}]}).
