%%% -*- coding: utf-8 -*-
%%% -*- erlang-indent-level: 2 -*-
%%% -------------------------------------------------------------------
%%% Copyright 2010-2018 Manolis Papadakis <manopapad@gmail.com>,
%%%                     Eirini Arvaniti <eirinibob@gmail.com>
%%%                 and Kostis Sagonas <kostis@cs.ntua.gr>
%%%
%%% This file is part of PropEr.
%%%
%%% PropEr is free software: you can redistribute it and/or modify
%%% it under the terms of the GNU General Public License as published by
%%% the Free Software Foundation, either version 3 of the License, or
%%% (at your option) any later version.
%%%
%%% PropEr is distributed in the hope that it will be useful,
%%% but WITHOUT ANY WARRANTY; without even the implied warranty of
%%% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%%% GNU General Public License for more details.
%%%
%%% You should have received a copy of the GNU General Public License
%%% along with PropEr.  If not, see <http://www.gnu.org/licenses/>.

%%% @copyright 2010-2018 Manolis Papadakis, Eirini Arvaniti and Kostis Sagonas
%%% @version {@version}
%%% @author Manolis Papadakis
%%% @doc Internal header file: This header is included in all PropEr source
%%%      files.

-include("proper_common.hrl").


%%------------------------------------------------------------------------------
%% Random generator selection
%%------------------------------------------------------------------------------

-ifdef(USE_SFMT).
-define(RANDOM_MOD, sfmt).
-define(SEED_NAME, sfmt_seed).

-else.

-ifdef(AT_LEAST_19).
-define(RANDOM_MOD, rand).   %% for 19.x use the 'rand' module
-define(SEED_NAME, rand_seed).
-else.
-define(RANDOM_MOD, random).
-define(SEED_NAME, random_seed).
-endif.
-endif.


%%------------------------------------------------------------------------------
%% Line annotations
%%------------------------------------------------------------------------------

-ifdef(AT_LEAST_19).
-define(anno(L), erl_anno:new(L)).
-else.
-define(anno(L), L).
-endif.


%%------------------------------------------------------------------------------
%% Stacktrace access
%%------------------------------------------------------------------------------

-ifdef(AT_LEAST_21).
-define(STACKTRACE(ErrorType, Error, ErrorStackTrace),
        ErrorType:Error:ErrorStackTrace ->).
-else.
-define(STACKTRACE(ErrorType, Error, ErrorStackTrace),
        ErrorType:Error ->
            ErrorStackTrace = erlang:get_stacktrace(),).
-endif.

%%------------------------------------------------------------------------------
%% Macros
%%------------------------------------------------------------------------------

-define(PROPERTY_PREFIX, "prop_").


%%------------------------------------------------------------------------------
%% Constants
%%------------------------------------------------------------------------------

-define(SEED_RANGE, 4294967296).
-define(MAX_ARITY, 20).
-define(MAX_TRIES_FACTOR, 5).
-define(ANY_SIMPLE_PROB, 3).
-define(ANY_BINARY_PROB, 1).
-define(ANY_EXPAND_PROB, 8).
-define(SMALL_RANGE_THRESHOLD, 16#FFFF).


%%------------------------------------------------------------------------------
%% Common type aliases
%%------------------------------------------------------------------------------

%% TODO: Perhaps these should be moved inside modules.
-type mod_name() :: atom().
-type fun_name() :: atom().
-type size() :: non_neg_integer().
-type length() :: non_neg_integer().
-type position() :: pos_integer().
-type frequency() :: pos_integer().
-type seed() :: {non_neg_integer(), non_neg_integer(), non_neg_integer()}.

-type abs_form()   :: erl_parse:abstract_form().
-type abs_expr()   :: erl_parse:abstract_expr().
-type abs_clause() :: erl_parse:abstract_clause().

-ifdef(AT_LEAST_19).
-type abs_type() :: erl_parse:abstract_type().
-else.
-type abs_type() :: term().
-endif.
%% TODO: Replace abs_rec_field with its proper type once it is exported.
-type abs_rec_field() :: term().	% erl_parse:af_field_decl().

-type loose_tuple(T) :: {} | {T} | {T,T} | {T,T,T} | {T,T,T,T} | {T,T,T,T,T}
		      | {T,T,T,T,T,T} | {T,T,T,T,T,T,T} | {T,T,T,T,T,T,T,T}
		      | {T,T,T,T,T,T,T,T,T} | {T,T,T,T,T,T,T,T,T,T} | tuple().
