.PHONY: all compile clean test shell

all: compile

compile:
	@rebar3 compile

clean:
	@rebar3 clean

test:
	@rebar3 eunit

shell:
	@rebar3 shell

docs:
	@rebar3 ex_doc
