domains
	i = integer
	list = i*
	listc = char*
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
	nondeterm to_hex(char, i)
	nondeterm to_m_base(i, i, listc, listc)
	nondeterm even(list, list)
	nondeterm uneven(list, list)
	nondeterm cut_front(list, i, list)
	nondeterm cut_back(list, i, i, list)
	nondeterm multimember(list, list)
	nondeterm makenlist(i, i, list)
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
/*Get list of first K elements*/
	cut_front([H|T1], K, [H|T2]):-
		K<>1,
		NK=K-1,
		cut_front(T1, NK, T2).
	cut_front([H|_], 1, [H]):-!.
	cut_front([], _, R):-R=[],!.
/*Get list of last K elements(K = length - K)*/
	cut_back(L, _, K, R):-
		K < 1,
		R=L,!.
	cut_back([_|T1],S, K, R):-
		K > 0,
		S <> K,
		NS = S + 1,
		cut_back(T1, NS, K, R).
	cut_back([_|T], S, K, R):- R=T,!.
/*Cut in K-1 and tail*/
	cut_K([H|T1], K, [H|T2], TR):-
		K<>1,
		NK=K-1,
		cut_K(T1, NK, T2, TR).
	cut_K(L, 1, L1, L2):-
		L1=[],
		L2=L,!.
	cut_K([], _, R, RT):-
		R=[],
		RT=[],!.
/*Turn integer to hex character*/
	to_hex(H, X):-
		X < 10,
		NX = X + 48,
		char_int(H, NX).
	to_hex(H, X):-
		X > 9,
		NX = X + 55,
		char_int(H, NX).
/*Lists of even/uneven elements*/
	even([_, H2|T], [H2|T2]):-
		even(T, T2).
	even([], R):- R=[],!.
	even([_], R):- R=[],!.
	uneven([H1, _|T], [H1|T2]):-
		uneven(T, T2).
	uneven([], R):- R=[],!.
	uneven([X], R):- R=[X],!.
/*Searches if every element of one list is within the second*/
	within([H|T], L):-
		member(H, L),
		within(T, L).
	within([],_):-!.
/*List of multimembers*/
	multimember([X|T], [X|TR]):-
		member(X, T),
		multimember(T, TR).
	multimember([X|T], TR):-
		not(member(X, T)),
		multimember(T, TR).
	multimember([], TR):-TR=[],!.
/*Create list of S length of C*/
	makenlist(S, C, [C|T]):-
		S<>1,
		NS = S-1,
		makenlist(NS, C, T).
	makenlist(1, C, [C]):-!.

/*****************************************************************/
/******************Done*******************************************/

/*Counter*/
/*schet(M, S, Start, M, [], Result)*/
	schet(M, S, Position, Calc, L, Result):-
		push_back(Position, L, L1),
		NPosition = (Position + S) mod M,
		NCalc = Calc - 1,
		NCalc > -1,
		schet(M, S, NPosition, NCalc, L1, Result).
	schet(_, _, _, 0, Result, Result):-!.
/*Turn number to base M (list of characters)*/
	to_m_base(M, Num, L, Result):-
		Num <> 0,
		A = (Num mod M),
		to_hex(H, A),
		push_front(H, L, L1),
		NNum = Num div M,
		to_m_base(M, NNum, L1, Result).
	to_m_base(_, 0, L, L).
