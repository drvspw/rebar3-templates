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
    SoName = case code:priv_dir(?APPNAME) of
       {error, bad_name} ->
          case filelib:is_dir(filename:join(["..", priv])) of
            true ->
              filename:join(["..", priv, ?LIBNAME]);
            _ ->
              filename:join([priv, ?LIBNAME])
          end;
       Dir ->
          filename:join(Dir, ?LIBNAME)
    end,
    erlang:load_nif(SoName, 0).

not_loaded(Line) ->
	    exit({not_loaded, [{module, ?MODULE}, {line, Line}]}).
