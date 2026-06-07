% State representation: state(BoysList, GirlsList)

% Final States: If either list is empty, no more transitions can occur.
is_final_state(state([], _)).
is_final_state(state(_, [])).

% Transition 1: Valid pair found (difference <= 1)
transition(state([B | Bs], [G | Gs]), match, state(Bs, Gs)) :-
    abs(B - G) =< 1.

% Transition 2: Boys skill is too low.
transition(state([B | Bs], [G | Gs]), skip_boy, state(Bs, [G | Gs])) :-
    B < G - 1.

% Transition 3: Girls skill is too low.
transition(state([B | Bs], [G | Gs]), skip_girl, state([B | Bs], Gs)) :-
    B > G + 1.

% Automata Execution Engine
run_automata(State, 0) :-
    is_final_state(State), !.

run_automata(State, Pairs) :-
    transition(State, Action, NextState),
    !, % Cut to enforce greedy choice
    run_automata(NextState, NextPairs),
    (Action == match -> Pairs is NextPairs + 1 ; Pairs = NextPairs).

solve_bersu(Boys, Girls, Pairs) :-
    msort(Boys, SortedBoys),
    msort(Girls, SortedGirls),
    run_automata(state(SortedBoys, SortedGirls), Pairs).

% ---------------------------------------------------------
% Simple Test Suite
% ---------------------------------------------------------

test1 :- 
    solve_bersu([1, 2, 4, 6], [1, 5, 5, 7, 9], X),
    write('Test 1 (Standard case) -> Expected: 3, Result: '), write(X), nl.

test2 :- 
    solve_bersu([1, 1, 1, 1], [10, 14, 37, 47], X),
    write('Test 2 (No possible matches) -> Expected: 0, Result: '), write(X), nl.

test3 :- 
    solve_bersu([3, 1, 2], [3, 2, 1], X),
    write('Test 3 (Unsorted inputs) -> Expected: 3, Result: '), write(X), nl.

test4 :- 
    solve_bersu([], [], X),
    write('Test 4 (Empty lists) -> Expected: 0, Result: '), write(X), nl.

test5 :- 
    solve_bersu([1, 2, 3], [], X),
    write('Test 5 (One empty list) -> Expected: 0, Result: '), write(X), nl.

test6 :- 
    solve_bersu([1, 2, 3], [1, 2, 3], X),
    write('Test 6 (Exact matches) -> Expected: 3, Result: '), write(X), nl.

test7 :- 
    solve_bersu([1, 1, 1], [2, 2, 2], X),
    write('Test 7 (Multiple identical/offset by 1) -> Expected: 3, Result: '), write(X), nl.

test8 :- 
    solve_bersu([10, 20, 30], [5, 15, 31], X),
    write('Test 8 (Large gaps, match at end) -> Expected: 1, Result: '), write(X), nl.

% Command to run all tests
run_all_tests :-
    test1, test2, test3, test4, test5, test6, test7, test8.