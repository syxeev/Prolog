domains
	i=integer
	l=i*
	bi_t = tree(i, bi_t, bi_t); nil
predicates
	nondeterm run
	nondeterm menu(bi_t)
	nondeterm num_leafs(bi_t, i)
	nondeterm generate(bi_t, bi_t)
	nondeterm insert(i,bi_t,bi_t)
	nondeterm solve(char, bi_t)
	nondeterm write_tree(bi_t)
	nondeterm height(bi_t,integer)
	nondeterm m_t(bi_t,integer,integer)
	nondeterm out_t(bi_t,integer,integer)
	nondeterm w_t(integer,i,i)
	nondeterm max(i,i,i)
	nondeterm level(integer, bi_t, integer, integer)
	nondeterm print_result(integer)
clauses
	menu(T):-
		write("Enter: "),nl,
		write(" 1 - Get the level of the element"),nl,
		write(" 2 - New binary dictionary"), nl,
		write(" 0 - exit"),nl,
		write("> "), readchar(X), write(X), nl,
		solve(X,T),
		nl,nl,
		menu(T).
	solve('1', T):-
		write("Enter the element: "),
		readint(X),
		level(X, T, 1, Result),
		print_result(Result).
	solve('2',_):-
		run.
	solve('0',_):-
		exit.
	solve(_,T):-
		menu(T).
	run:-
		write("Create binary dictionary:"),nl,
		generate(nil, T), nl, nl, nl,
		write_tree(T),
		menu(T).
		
	print_result(R):-
		R > -1,
		writef("Level: %d\n", R).
	print_result(_):-
		write("No such element in the tree").
	level(_, nil, _, -1).
	level(X, tree(X, _, _), C, C).
	level(X, tree(A, L, _), C, Res):-
		X < A,
		NC = C + 1,
		level(X, L, NC, Res).
	level(X, tree(A, _, R), C, Res):-
		X > A,
		NC = C + 1,
		level(X, R, NC, Res).
	num_leafs(nil, 0).
	num_leafs(tree(_, nil, nil), 1).
	num_leafs(tree(_, L, R), Result):-
		num_leafs(L, R1),
		num_leafs(R, R2),
		Result = R1 + R2.

	generate(Tree, NewTree):-
		write("Enter number: "),
		readint(X),
		insert(X,Tree,TempTree),
		generate(TempTree, NewTree).
	generate(Tree, Tree).

	insert(X, nil, tree(X,nil,nil)).
	insert(X, tree(X,L,R), tree(X,L,R)):-!. %If same do nothing
	insert(X, tree(K,L,R), tree(K,L1,R)):-
		X<K,!,
		insert(X, L, L1).
	insert(X,tree(K,L,R),tree(K,L,R1)):-
		insert(X, R, R1).

	max(X,Y,X):-X>Y.
	max(_,Y,Y).

	height(nil,0):-!.
	height(tree(_,Left,Right),H):-
		height(Left,H1),
		height(Right,H2),
		max(H1,H2,Max),
		H=Max+1.

	write_tree(Tree) :-
		height(Tree, Height),
		m_t(Tree, 0, Height).

	m_t(_, Level, Height) :- Level>Height, !.
	m_t(Tree, Level, Height) :-
		out_t(Tree, Level, 0), nl,
		NewLevel=Level+1,
		m_t(Tree, NewLevel, Height).
	out_t(nil,_,_).
	out_t(tree(E,Left,Right), Level, Depth) :-
		NewDepth=Depth+1,
		out_t(Left, Level, NewDepth),
		w_t(E, Level, Depth),
		out_t(Right, Level, NewDepth).
	w_t(E, Level, Level) :- !, writef("%5", E).
	w_t(_,_,_):- writef("%5"," ").

goal
	run.
