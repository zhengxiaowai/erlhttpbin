%%%-------------------------------------------------------------------
%%% @author 正小歪
%%% @copyright (C) 2018, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 22. 五月 2018 18:23
%%%-------------------------------------------------------------------
-module(ip_handler).
-author("正小歪").
-export([
  init/2
]).

%% API

init(Req, State) ->
  {Response, State1} = handle(cowboy_req:method(Req), Req, State),
  {ok, Response, State1}.


handle(<<"GET">>, Req, State) ->
  {IP, _} = cowboy_req:peer(Req),
  ResponseHeader = #{<<"content-type">> => <<"application/json">>},
  RawContent = jsx:encode([{<<"origin">>, list_to_binary(inet_parse:ntoa(IP))}]),
  {HTTPCode, Content} = utils:make_response({ok, RawContent}),
  {cowboy_req:reply(HTTPCode, ResponseHeader, Content, Req), State};


handle(_, Req, State) ->
  ResponseHeader = #{<<"content-type">> => <<"application/json">>},
  {HTTPCode, Content} = utils:make_response({error, not_allowed_method}),
  {cowboy_req:reply(HTTPCode, ResponseHeader, Content, Req), State}.