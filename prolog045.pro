domains
	i = integer
	list = i*
predicates
	nondeterm member(i, list)
	nondeterm run()
	nondeterm do(char)
	nondeterm equality_n(list, list)
	nondeterm within(list, list)
clauses
	equality_n(L1, L2):-
		within(L1, L2),
		within(L2, L1),
		write("Equal\n"),!.
	equality_n(_, _):-
		write("Not equal\n"),!.
	within([H|T], L):-
		member(H, L),
		within(T, L).
	within([],_):-!.
	member(X, [X|_]).
	member(X, [_|T]):-
		member(X, T).
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
		write("Enter your 1 list>>"),
		readterm(list, L1),
		write("Enter your 2 list>>"),
		readterm(list, L2),
		write("The result is:\n"),
		equality_n(L1, L2).
	do('0'):-
		write("That's all."), exit.
	do(_):-
		write("Bad value\n\n").
	
goal
	run.
