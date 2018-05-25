-module(notfound_handler).
-export([init/2]).

% API

init(Req, State) -> 
    {Response, State1} = handle(cowboy_req:method(Req), Req, State),
    {ok, Response, State1}.

% internal function

handle(_, Req, State) ->
    ResponseHeader = #{<<"content-type">> => <<"application/json">>},
    {HTTPCode, Content} = utils:make_response({error, requested_resource_not_found}),
    {cowboy_req:reply(HTTPCode, ResponseHeader, Content, Req), State}.

