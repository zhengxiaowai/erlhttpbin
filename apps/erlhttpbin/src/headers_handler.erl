-module(headers_handler).

-author([27491, 23567, 27498]).

-export([init/2]).

%% API

init(Req, Opts) ->
    AllHeaders = cowboy_req:headers(Req),
    {HTTPCode, Content} = utils:make_response({ok,
					       #{<<"headers">> => AllHeaders}}),
    ResponseHeader = #{<<"content-type">> =>
			   <<"application/json">>},
    Response = cowboy_req:reply(HTTPCode, ResponseHeader,
				Content, Req),
    {ok, Response, Opts}.
