-module(utils).
-author("正小歪").
-export([make_response/1]).

make_response({ok, Content}) when is_binary(Content) ->
    {200, Content};
make_response({ok, Content}) when is_map(Content) ->
    {200, jsx:encode(Content)};
make_response({ok, Content}) when is_list(Content) ->
    {200, list_to_binary(Content)};
make_response({error, invalid_params}) ->
    {400, <<"{\"error\": \"invalid params!\"}">>};
make_response({error, requested_resource_not_found}) ->
    {404, <<"{\"error\": \"requested resource not found!\"}">>};
make_response({error, not_allowed_method}) ->
    {415, <<"{\"error\": \"not_allowed_method!\"}">>};
make_response(_) ->
    {500, <<"{\"error\": \"unknown error!\"}">>}.