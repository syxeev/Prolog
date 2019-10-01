domains
	i = integer
	list = i*
predicates
	nondeterm run()
	nondeterm do(char)
	nondeterm phordiagram(list)
	nondeterm plinex(i)
	nondeterm pchar(i, char)
clauses
	phordiagram([H|T]):-
		plinex(H),
		phordiagram(T).
	phordiagram([]):-!.
	pchar(S, C):-
		S>0,
		write(C),
		NS = S-1,
		pchar(NS, C).
	pchar(0, _).
	plinex(0):-
		pchar(50,'0'),
		pchar(1, '1'),
		pchar(50,'0'), nl.
	plinex(X):-
		X>0,
		Sp = 51 - X,
		pchar(50,'0'),
		pchar(X, '1'),
		pchar(Sp,'0'), nl.
	plinex(X):-
		Sp = 51 + X,
		NX = -X,
		pchar(Sp,'0'),
		pchar(NX, '1'),
		pchar(50,'0'), nl.
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
		write("The result is:\n"),
		phordiagram(L), nl.
	do('0'):-
		write("That's all."), exit.
	do(_):-
		write("Bad value\n\n").
	
goal
	run.
