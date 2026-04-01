-module(yaerltui_sup).
-behaviour(supervisor).
-export([init/1]). %% supervisor callback
-export([start_link/1]). %% API


-spec init(Args :: term()) -> {ok, {SupFlags :: supervisor:sup_flags(), [ChildSpec :: supervisor:child_spec()]}} | ignore.
init([]) ->
    {ok, {{one_for_one, 3, 10}, []}}.


start_link(Args) ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, Args).
