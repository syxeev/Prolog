domains
	i = integer
	list = i*
predicates
	nondeterm run()
	nondeterm do(char)
	nondeterm insertlist(list, i, i, i, list)
	nondeterm makenlist(i, i, list)
	nondeterm cut_K(list, i, list, list)
	nondeterm connect(list, list, list)
clauses
	insertlist(L, N, K, C, Result):-
		cut_K(L, N, L1, L3),
		makenlist(K, C, L2),
		connect(L1, L2, L12),
		connect(L12, L3, Result).
	makenlist(S, C, [C|T]):-
		S<>1,
		NS = S-1,
		makenlist(NS, C, T).
	makenlist(1, C, [C]):-!.
	cut_K([H|T1], K, [H|T2], TR):-
		K<>1,
		NK=K-1,
		cut_K(T1, NK, T2, TR).
	cut_K(L, 1, L1, L2):-
		L1=[],
		L2=L,!.
	cut_K([], _, R, RT):-
		R=[],
		RT=[],!.
	connect([], L, L).
	connect([H|T1], L2, [H|T3]):-
		connect(T1, L2, T3).
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
		write("Position to insert>>"),
		readint(N),
		write("Number of elements to insert>>"),
		readint(K),
		write("Number to insert>>"),
		readint(C),
		insertlist(L, N, K, C, Result),
		write("The result is:\n", Result,"\n").
	do('0'):-
		write("That's all."), exit.
	do(_):-
		write("Bad value\n\n").
	
goal
	run.
