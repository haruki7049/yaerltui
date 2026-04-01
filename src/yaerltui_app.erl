-module(yaerltui_app).
-behaviour(application).
-export([start/2, stop/1]).  %% application callback


-spec start(StartType :: application:start_type(), StartArgs :: term()) ->
          {ok, pid()} |
          {ok, pid(), State :: term()} |
          {error, Reason :: term()}.
start(_StartType, StartArgs) ->
    yaerltui_sup:start_link(StartArgs).


-spec stop(State :: term()) -> term().
stop(_State) ->
    ok.
