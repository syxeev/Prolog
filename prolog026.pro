domains
	i = integer
	list = i*
	listc = char*
predicates
	nondeterm convert_position(i, i, list, list, list)
	nondeterm reverse(list, list)
	nondeterm reverse1(list, list, list)
	nondeterm run()
	nondeterm do(char)
clauses
	convert_position(Position, X, [H|T], L, Result):-
		Position <> 1,
		NPosition = Position - 1,
		convert_position(NPosition, X, T, [H|L], Result).
	convert_position(Position, X, [H|T], L, Result):-
		NPosition = Position - 1,
		convert_position(NPosition, X, T, [X|L], Result).
	convert_position(_, _, [], L, Result):-
		reverse(L, Result).
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
		write("Enter position>>"),
		readint(Position),
		write("Enter your number>>"),
		readint(X),
		convert_position(Position, X, Source, [], Result),
		write(Result).
	do('0'):-
		write("That's all."), exit.
	do(_):-
		write("Bad value\n\n").
goal
	run.
