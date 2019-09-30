domains
	list = integer*
	i = integer
predicates
	nondeterm run()
	nondeterm do(char)
	nondeterm summ_1(i, i, list)
clauses
	summ_1(Summ, Result, [H1, H2|T]):-
		NSumm = Summ + H1,
		summ_1(NSumm, Result, T).
	summ_1(Summ, Result, [X]):-
		Result = Summ + X.
	summ_1(Result, Result, []).
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
		summ_1(0, Result, List),
		write("The result is:\n"),
		write(Result).
	do('0'):-
		write("That's all."), exit.
	do(_):-
		write("Bad value\n\n").
	
goal
	run.
