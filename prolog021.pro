domains
	i = integer
	list = i*
	listc = char*
predicates
	nondeterm divide_list(list, list, list, list, list)
	nondeterm reverse(list, list)
	nondeterm reverse1(list, list, list)
	nondeterm run()
	nondeterm do(char)
clauses
	divide_list([H|T], L1, L2, R1, R2):-
		H>-1,
		divide_list(T, [H|L1], L2, R1, R2).
	divide_list([H|T], L1, L2, R1, R2):-
		divide_list(T, L1, [H|L2], R1, R2).
	divide_list([], L1, L2, R1, R2):-
		reverse(L1, R1),
		reverse(L2, R2),
		!.
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
		readterm(list, Source),
		divide_list(Source, [], [], R1, R2),
		write(R1, "\n", R2).
	do('0'):-
		write("That's all."), exit.
	do(_):-
		write("Bad value\n\n").
goal
	run.
