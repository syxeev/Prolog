domains
	i = integer
	list = i*
predicates
	nondeterm run()
	nondeterm do(char)
	nondeterm cut_front(list, i, list)
clauses
	
	cut_front([H|T1], K, [H|T2]):-
		K<>1,
		NK=K-1,
		cut_front(T1, NK, T2).
	cut_front([H|_], 1, [H]):-!.
	cut_front([], _, R):-R=[],!.
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
		readterm(list, L),
		write("Enter K>"),
		readint(K),
		cut_front(L, K, Result),
		write("The result is:\n"),
		write(Result).
	do('0'):-
		write("That's all."), exit.
	do(_):-
		write("Bad value\n\n").
	
goal
	run.
