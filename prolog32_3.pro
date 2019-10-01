domains
	i = integer
	list = i*
	listc = char*
predicates
	nondeterm run()
	nondeterm do(char)
	nondeterm connect(list, list, list)
	nondeterm even(list, list)
	nondeterm uneven(list, list)
	nondeterm con_eu(list, list, list)
clauses
	con_eu(S1, S2, Result):-
		even(S1, E),
		uneven(S2, U),
		connect(E, U, Result).
	even([_, H2|T], [H2|T2]):-
		even(T, T2).
	even([], R):- R=[],!.
	even([_], R):- R=[],!.
	uneven([H1, _|T], [H1|T2]):-
		uneven(T, T2).
	uneven([], R):- R=[],!.
	uneven([X], R):- R=[X],!.
	connect([], L, L).
	connect([H|T1], L, [H|T2]):-
		connect(T1, L, T2).
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
		con_eu(L1, L2, Result),
		write("The result is:\n"),
		write(Result).
	do('0'):-
		write("That's all."), exit.
	do(_):-
		write("Bad value\n\n").
	
goal
	run.
