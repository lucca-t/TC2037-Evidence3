% Base Cases: If either list of dancers is empty, 0 pairs can be made.
max_pairs([], _, 0).
max_pairs(_, [], 0).

% Recursive Step 1: Valid pair found (difference <= 1)
% Consume both heads, add 1 to the result, and cut (!) to prevent backtracking.
max_pairs([B | Bs], [G | Gs], Pairs) :-
    abs(B - G) =< 1,
    !, 
    max_pairs(Bs, Gs, NextPairs),
    Pairs is NextPairs + 1.

% Recursive Step 2: Boys skill is significantly less than the Girls.
% Drop the boys head and continue testing the rest of the boys against the girls.
max_pairs([B | Bs], [G | Gs], Pairs) :-
    B < G - 1,
    !,
    max_pairs(Bs, [G | Gs], Pairs).

% Recursive Step 3: Girls skill is significantly less than the Boys.
% Drop the girls head and continue testing the boys against the rest of the girls.
max_pairs([B | Bs], [G | Gs], Pairs) :-
    B > G + 1,
    max_pairs([B | Bs], Gs, Pairs).

% Wrapper function to sort the arrays before executing the greedy matching
solve_bersu(Boys, Girls, Pairs) :-
    msort(Boys, SortedBoys),
    msort(Girls, SortedGirls),
    max_pairs(SortedBoys, SortedGirls, Pairs).

% ---------------------------------------------------------
% Test cases based on Codeforces sample inputs
% ---------------------------------------------------------

test1 :- 
    write('Test case 1:'), nl,
    write('Boys: [1, 2, 4, 6]'), nl,
    write('Girls: [1, 5, 5, 7, 9]'), nl,
    write('Expected: 3'), nl,
    solve_bersu([1, 2, 4, 6], [1, 5, 5, 7, 9], X),
    write('Result: '), write(X), nl.

test2 :- 
    write('Test case 2:'), nl,
    write('Boys: [1, 1, 1, 1]'), nl,
    write('Girls: [10, 14, 37, 47]'), nl,
    write('Expected: 0'), nl,
    solve_bersu([1, 1, 1, 1], [10, 14, 37, 47], X),
    write('Result: '), write(X), nl, nl.
    
test3 :- 
    write('Test case 3 (Unsorted input):'), nl,
    write('Boys: [3, 1, 2]'), nl,
    write('Girls: [3, 2, 1]'), nl,
    write('Expected: 3'), nl,
    solve_bersu([3, 1, 2], [3, 2, 1], X),
    write('Result: '), write(X), nl, nl.