-module(rawmode_statem).
-behaviour(gen_statem).
-export([init/1, callback_mode/0, terminate/3, code_change/4]).  %% gen_statem callback
-export([on/3, off/3]).  %% gen_statem callback
-export([start_link/0, switch_rawmode/0, show_rawmode/0]).  %% API


-spec init(_Args :: [term()]) ->
          gen_statem:init_result(R)
              when R :: atom().
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


-spec show_rawmode() -> R
              when R :: atom().
show_rawmode() ->
    gen_statem:call(?MODULE, show_rawmode).


-spec switch_rawmode() -> R
              when R :: atom().
switch_rawmode() ->
    gen_statem:call(?MODULE, switch_rawmode).


-spec off(EventType :: gen_statem:event_type(), EventContent :: atom(), Data :: term()) ->
          gen_statem:event_handler_result(atom()).
off({call, From}, switch_rawmode, Data) ->
    {next_state, on, Data, [{reply, From, on}]};
off({call, From}, show_rawmode, Data) ->
    {keep_state, Data, [{reply, From, off}]};
off(EventType, EventContent, Data) ->
    handle_event(EventType, EventContent, Data).


-spec on(EventType :: gen_statem:event_type(), EventContent :: atom(), Data :: term()) ->
          gen_statem:event_handler_result(atom()).
on({call, From}, switch_rawmode, Data) ->
    {next_state, off, Data, [{reply, From, off}]};
on({call, From}, show_rawmode, Data) ->
    {keep_state, Data, [{reply, From, on}]};
on(EventType, EventContent, Data) ->
    handle_event(EventType, EventContent, Data).


%% --- Common Handlers ---


handle_event(_EventType, _EventContent, Data) ->
    {keep_state, Data}.


terminate(_Reason, _State, _Data) ->
    void.


code_change(_OldVsn, State, Data, _Extra) ->
    {ok, State, Data}.
