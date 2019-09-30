domains
	list = integer*.
	i = integer.
predicates
	nondeterm schet(i, i, i, i, list, list)
	nondeterm push_back(i, list, list)
	nondeterm run()
	nondeterm do(char)
clauses
	schet(M, S, Position, Calc, L, Result):-
		push_back(Position, L, L1),
		NPosition = (Position + S) mod M,
		NCalc = Calc - 1,
		NCalc > -1,
		schet(M, S, NPosition, NCalc, L1, Result).
	schet(_, _, _, 0, Result, Result):-!.
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
		write("MODUL >>"),
		readint(M),
		write("STEP >>"),
		readint(S),
		write("START>>"),
		readint(Start),
		schet(M, S, Start, M, [], Result),
		write(Result).
	do('0'):-
		write("That's all."), exit.
	do(_):-
		write("Bad value\n\n").
	
goal
	run.
