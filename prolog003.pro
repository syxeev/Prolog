
domains
	list = integer*.
	i = integer.
predicates
	nondeterm schet(i, i, i, i, list, list)
	nondeterm counter1(i, i, i, i, list, list)
	nondeterm counter1beg(i, i, i, i, list, list)
	nondeterm push_back(i, list, list)
	nondeterm run()
	nondeterm do(char)
clauses
	schet(M, S, Start, Position, L1, Result):-
		push_back(Position, L1, L2),
		NPosition = (Position + S) mod M,
		NPosition <> Start,
		write(L2), nl,
		schet(M, S, Start, NPosition, L2, Result).
	schet(_, _, Start, Start, Result, Result).
	push_back(X, [H|T], [H|T1]):-
		push_back(X, T, T1).
	push_back(X, [], [X]).
	
	
	
	counter1(M, S, N, Start, L, Result):-
		NewN = (N + S) mod M,
		NewN <> Start,
		write(L),nl,
		counter1(M, S, NewN, Start, [N|L], Result).
	counter1(_, _, Start, Start, L, L).
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
		write("MODUL >>"),
		readint(M),
		write("STEP >>"),
		readint(S),
		write("START>>"),
		readint(Start),
		schet(M, S, Start, Start, [], List),
		write(List).
	do('0'):-
		write("That's all."), exit.
	do(_):-
		write("Bad value\n\n").
	counter1beg(M, S, N, Start, L, Result):-
		counter1(M, S, N, Start, [N|L], Result).
	
goal
	schet(11, 2, 3, 3, [], L).