domains
	i = integer
	list = i*
predicates
	nondeterm member(i, list)
	nondeterm length(list, i)
	nondeterm insert(i, list, list)
	nondeterm insertnd(i, list, list)
	nondeterm tadd_list(list, list)
	nondeterm tpush_back(list, list)
	nondeterm tlist(list)
	nondeterm reverse(list, list)
	nondeterm reverse1(list, list, list)
	nondeterm connect(list, list, list)
	nondeterm push_back(i, list, list)
	nondeterm push_front(i, list, list)
	nondeterm pop_front(i, list, list)
	nondeterm pop_back(list, list)
	nondeterm pop_all(i, list, list)
clauses
/*member*/
	member(X, [X|_]).
	member(X, [_|T]):-
		member(X, T).
/*length*/
	length([], 0).
	length([_|T], L):-
		length(T, Lt),
		L = Lt + 1.
/*insert*/
	insert(X, L, [X|L]).
	insertnd(X, L, L):-
		member(X, L).
	insertnd(X, L, [X|L]).
/*Add to the front from terminal*/
	tadd_list(L, NL):-
		write(">>"),
		readint(H),
		tadd_list([H|L], NL).
	tadd_list(L, L).
/*Add to the end from terminal*/
	tpush_back(L, NL):-
		write(">>"),
		readint(C),
		push_back(C, L, TempL),
		tpush_back(TempL, NL).
	tpush_back(L, L).
/*Create new list from terminal*/
	tlist([H|T]):-
		write(">>"),
		readint(H),
		tlist(T).
	tlist([]).
/*List reverse*/
	reverse(L, Lr):-
		reverse1(L, [], Lr).
	reverse1([], L, L).
	reverse1([H|T], A, Lr):-
		reverse1(T, [H|A], Lr).
/*Connect two lists*/
	connect([], L, L).
	/*Add H to head, until firstl list []*/
	connect([H|T1], L2, [H|T3]):-
		connect(T1, L2, T3).
/*Add to the front of the list*/
	push_front(X, [], [X]).
	push_front(X, L, [X|L]).
/*Add to end of the list*/
	push_back(X, [H|T], [H|T1]):-
		push_back(X, T, T1).
	push_back(X, [], [X]).
/*Deletes first element of the list if not defined X
  otherwise deletes first X element of the list*/
	pop_front(X, [X|T], T):-!.
	pop_front(X, [H|T], [H|T1]):-
		pop_front(X, T, T1).
/*Deletes last element of the list*/
	pop_back([_],[]).
	pop_back([H|T1], [H|T2]):-
		pop_back(T1, T2).
/*Deletes all defined X from the list*/
	pop_all(_, [], []).
	pop_all(X, [X|T], L):-
		pop_all(X, T, L).
	pop_all(X, [H|T], [H|T1]):-
		X <> H,
		pop_all(X, T, T1).
