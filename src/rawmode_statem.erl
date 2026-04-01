-module(rawmode_statem).
-behaviour(gen_statem).
-export([init/1, callback_mode/0, terminate/3, code_change/4]).  %% gen_statem callback
-export([on/3, off/3]).  %% gen_statem callback
-export([start_link/0, switch_rawmode/0]).  %% API


-spec init(_Args :: [term()]) ->
          gen_statem:init_result(gen_statem:state()).
init([]) ->
    {ok, on, []}.


-spec callback_mode() ->
          state_functions |
          handle_event_function.
callback_mode() ->
    state_functions.


-spec start_link() ->
          gen_statem:start_ret().
start_link() ->
    gen_statem:start_link({local, ?MODULE}, ?MODULE, [], []).


switch_rawmode() ->
    gen_statem:call(?MODULE, switch_rawmode).


off({call, From}, switch_rawmode, Data) ->
    {next_state, on, Data, [{reply, From, switched_on}]};
off(EventType, EventContent, Data) ->
    handle_event(EventType, EventContent, Data).


on({call, From}, switch_rawmode, Data) ->
    {next_state, off, Data, [{reply, From, switched_off}]};
on(EventType, EventContent, Data) ->
    handle_event(EventType, EventContent, Data).


%% --- Common Handlers ---


handle_event(_EventType, _EventContent, Data) ->
    {keep_state, Data}.


terminate(_Reason, _State, _Data) ->
    void.


code_change(_OldVsn, State, Data, _Extra) ->
    {ok, State, Data}.
