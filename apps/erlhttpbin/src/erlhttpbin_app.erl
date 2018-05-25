%%%-------------------------------------------------------------------
%% @doc erlhttpbin public API
%% @end
%%%-------------------------------------------------------------------

-module(erlhttpbin_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

%%====================================================================
%% API
%%====================================================================

start(_Type, _Args) ->
    Dispatch = cowboy_router:compile([
        {'_', [
            {"/ip", ip_handler, []},
            {"/headers", headers_handler, []},
            {"/user-agent", useragent_handler, []},
            {'_', notfound_handler, []}
        ]}
    ]),
    {ok, _} = cowboy:start_clear(http, [{port, 9000}], #{
        env => #{dispatch => Dispatch}
    }),
    erlhttpbin_sup:start_link().

%%--------------------------------------------------------------------
stop(_State) ->
    ok.

%%====================================================================
%% Internal functions
%%====================================================================
