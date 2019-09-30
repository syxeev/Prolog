domains
	list = integer*
	i = integer

predicates
	nondeterm replace_all(i, i, list, list, list)
	nondeterm reverse(list, list)
	nondeterm reverse1(list, list, list)
	nondeterm run()
	nondeterm do(char)
clauses
	replace_all(A, X, [X|T], B, Result):-
		replace_all(A, X, T, [A|B], Result).
	replace_all(A, X, [H|T], B, Result):-
		replace_all(A, X, T, [H|B], Result).
	replace_all(A, X, [], B, Result):-
		reverse(B, Result), !.
	reverse(L, Lr):-
		reverse1(L, [], Lr).
	reverse1([], L, L).
	reverse1([H|T], A, Lr):-
		reverse1(T, [H|A], Lr).
	run:-
		write("\n******Enter******\n"),
		write(" 1 to start\n"),
		write(" 0 to EXIT\n"),
		write("*****************\n"),
		write(">>"),
		readchar(X),
		write(X),
		nl,
		do(X),
		run.
	do('1'):-
		write("Enter your list>>"),
		readterm(list, List),
		write("Change what>>"),
		readint(X),
		write("Change for>>"),
		readint(A),
		replace_all(A, X, List, [], Result),
		write("The result is:\n"),
		write(Result).
	do('0'):-
		write("That's all."), exit.
	do(_):-
		write("Bad value\n\n").
	
goal
	run.
