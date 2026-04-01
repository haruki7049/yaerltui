-module(yaerltui_sup).
-behaviour(supervisor).
-export([init/1]).  %% supervisor callback
-export([start_link/1]).  %% API


-spec init(Args :: term()) ->
          {ok, {SupFlags :: supervisor:sup_flags(), [ChildSpec :: supervisor:child_spec()]}} |
          ignore.
init([]) ->
    ChildSpecs = [#{
                    id => rawmode_statem,
                    start => {rawmode_statem, start_link, []},
                    restart => permanent
                   }],

    SupFlags = #{
                 strategy => one_for_one,
                 intensity => 1,
                 period => 5
                },

    {ok, {SupFlags, ChildSpecs}}.


-spec start_link(Args :: term()) ->
          supervisor:startlink_ret().
start_link(Args) ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, Args).
