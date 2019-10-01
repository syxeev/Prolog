domains
	i = integer
	list = i*
predicates
	nondeterm member(i, list)
	nondeterm multimember(list, list)
	nondeterm run()
	nondeterm do(char)
	
clauses
	multimember([X|T], [X|TR]):-
		member(X, T),
		multimember(T, TR).
	multimember([X|T], TR):-
		not(member(X, T)),
		multimember(T, TR).
	multimember([], TR):-TR=[],!.
	member(X, [X|_]).
	member(X, [_|T]):-
		member(X, T).
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
		multimember(L, Result),
		write("The result is:\n", Result, "\n").
	do('0'):-
		write("That's all."), exit.
	do(_):-
		write("Bad value\n\n").
	
goal
	run.
