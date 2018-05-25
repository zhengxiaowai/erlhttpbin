%%%-------------------------------------------------------------------
%%% @author 正小歪
%%% @copyright (C) 2018, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 22. 五月 2018 18:23
%%%-------------------------------------------------------------------
-module(notfound_handler).
-author("正小歪").
-export([init/2]).

%% API

init(Req, Opts) ->
    {HTTPCode, Content} = utils:make_response({error, requested_resource_not_found}),
    ResponseHeader = #{
        <<"content-type">> => <<"application/json">>
    },
    Response = cowboy_req:reply(HTTPCode, ResponseHeader, Content, Req),
    {ok, Response, Opts}.
