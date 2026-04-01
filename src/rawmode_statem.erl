-module(rawmode_statem).
-behaviour(gen_statem).
-export([init/1, callback_mode/0]).  %% gen_statem callback
-export([start_link/1]).  %% API


-spec init(_Args :: term()) ->
          gen_statem:init_result(gen_statem:state()).
init(_Args) ->
    {ok, on, []}.


-spec callback_mode() ->
          state_functions |
          handle_event_function.
callback_mode() ->
    state_functions.


-spec start_link(Opts :: [gen_statem:start_opt()]) ->
          gen_statem:start_ret().
start_link(Args) ->
    gen_statem:start_link({local, ?MODULE}, ?MODULE, Args, []).
