domains
	list = integer*
	i = integer
	listc = char*
predicates
	nondeterm delete_1(list, list, list)
	nondeterm push_back(i, list, list)
	nondeterm run()
	nondeterm do(char)
clauses
	delete_1([H1, H2|T], L, Result):-
		push_back(H2, L, L2),
		delete_1(T, L2, Result).
	delete_1([], L, L).
	delete_1([_], L, L).
	push_back(X, [H|T], [H|T1]):-
		push_back(X, T, T1).
	push_back(X, [], [X]).
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
		delete_1(List, [], Result),
		write("The result is:\n"),
		write(Result).
	do('0'):-
		write("That's all."), exit.
	do(_):-
		write("Bad value\n\n").
	
goal
	run.
