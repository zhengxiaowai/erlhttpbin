-module(headers_handler).
-export([init/2]).

% API

init(Req, State) -> 
    {Response, State1} = handle(cowboy_req:method(Req), Req, State),
    {ok, Response, State1}.

% internal function

handle(<<"GET">>, Req, State) ->
    ResponseHeader = #{<<"content-type">> => <<"application/json">>},
    AllHeaders = cowboy_req:headers(Req),
    {HTTPCode, Content} = utils:make_response({ok, #{<<"headers">> => AllHeaders}}),
    {cowboy_req:reply(HTTPCode, ResponseHeader, Content, Req), State};

handle(_, Req, State) ->
    ResponseHeader = #{<<"content-type">> => <<"application/json">>},
    {HTTPCode, Content} = utils:make_response({error, not_allowed_method}),
    {cowboy_req:reply(HTTPCode, ResponseHeader, Content, Req), State}.

