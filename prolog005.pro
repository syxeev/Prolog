domains
	i = integer
	list = char*
predicates
	nondeterm to_m_base(i, i, list, list)
	nondeterm run()
	nondeterm do(char)
	nondeterm push_front(char, list, list)
	nondeterm to_hex(char, i)
clauses
	to_m_base(M, Num, L, Result):-
		Num <> 0,
		A = (Num mod M),
		to_hex(H, A),
		push_front(H, L, L1),
		NNum = Num div M,
		to_m_base(M, NNum, L1, Result).
	to_m_base(_, 0, L, L).
	to_hex(H, X):-
		X < 10,
		NX = X + 48,
		char_int(H, NX).
	to_hex(H, X):-
		X > 9,
		NX = X + 55,
		char_int(H, NX).
	push_front(X, L, [X|L]).
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
		write("M>>"),
		readint(M),
		write("Number>>"),
		readint(Num),
		to_m_base(M, Num, [], Result),
		write("Your number in ", M, " base is:\n"),
		write(Result).
	do('0'):-
		write("That's all."), exit.
	do(_):-
		write("Bad value\n\n").
goal
	run.
