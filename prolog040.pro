domains
	i = integer
	list = i*
predicates
	nondeterm run()
	nondeterm do(char)
	nondeterm cut_back(list, i, i, list)
	nondeterm length(list, i)
clauses
	cut_back(L, _, K, R):-
		K < 1,
		R=L,!.
	cut_back([_|T1],S, K, R):-
		K > 0,
		S <> K,
		NS = S + 1,
		cut_back(T1, NS, K, R).
	cut_back([_|T], S, K, R):- R=T,!.
	length([], 0).
	length([_|T], L):-
		length(T, Lt),
		L = Lt + 1.
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
		length(L, P),
		Stop = P-K,
		cut_back(L, 1, Stop, Result),
		write("The result is:\n"),
		write(Result).
	do('0'):-
		write("That's all."), exit.
	do(_):-
		write("Bad value\n\n").
	
goal
	run.
