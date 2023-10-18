row(0..N-1) :- size(N).
col(0..N-1) :- size(N).

adj((X,Y), (X,Y+1)):-row(X), col(Y), col(Y+1).
adj((X,Y), (X+1,Y)):-row(X), row(X+1), col(Y).

{seg(P,P')} :- adj(P,P').

%Cada círculo debe estar unido a dos segmentos.
:- number(P,_), #count{Q:seg(P,Q)} = C1, #count{Q:seg(Q,P)} = C2, C1+C2!=2.

%Cada segmento debe estar unido a otros dos.
:- seg(P,P'), #count{Q:seg(P,Q), Q!=P'} = C1, #count{Q:seg(Q,P)} = C2, #count{Q:seg(P',Q)} = C3, #count{Q:seg(Q,P'), Q!=P} = C4, C1+C2+C3+C4!=2.

aligned((X,Y),(X1,Y1)) :- number((X,Y),_), seg((X,Y),(X1,Y1)).
aligned((X,Y),(X1,Y1)) :- number((X,Y),_), seg((X1,Y1),(X,Y)).

aligned((X,Y),(X,Y2)) :- aligned((X,Y),(X,Y1)), Y<Y1, seg((X,Y1),(X,Y2)).
aligned((X,Y),(X,Y2)) :- aligned((X,Y),(X,Y1)), Y>Y1, seg((X,Y2),(X,Y1)).

aligned((X,Y),(X2,Y)) :- aligned((X,Y),(X1,Y)), X<X1, seg((X1,Y),(X2,Y)).
aligned((X,Y),(X2,Y)) :- aligned((X,Y),(X1,Y)), X>X1, seg((X2,Y),(X1,Y)).

minpoint(P):-#min{Q:number(Q,_)}=P.
connected(P):-minpoint(P).

connected((X1,Y1)):- minpoint(P), seg(P,(X1,Y1)).
connected((X1,Y1)):- minpoint(P), seg((X1,Y1),P).

connected((X2,Y2)):- connected((X1,Y1)), seg((X2,Y2),(X1,Y1)).
connected((X2,Y2)):- connected((X1,Y1)), seg((X1,Y1),(X2,Y2)).

%Debe haber un único ciclo.
:- number(A,_), not connected(A).

%Los círculos blancos deben atravesarse en línea recta
:- number((X,Y),N), N>1, seg((X,Y),(X1,Y1)), seg((X,Y),(X2,Y2)), Y1!=Y2, X1!=X2.
:- number((X,Y),N), N>1, seg((X1,Y1),(X,Y)), seg((X,Y),(X2,Y2)), Y1!=Y2, X1!=X2.
:- number((X,Y),N), N>1, seg((X1,Y1),(X,Y)), seg((X2,Y2),(X,Y)), Y1!=Y2, X1!=X2.

%Los círculos negros no pueden atravesarse en línea recta
:- number((X,Y),N), N<1, seg((X1,Y),(X,Y)), seg((X,Y),(X2,Y)), X1!=X2.
:- number((X,Y),N), N<1, seg((X,Y1),(X,Y)), seg((X,Y),(X,Y2)), Y1!=Y2.

%El número en cada círculo debe ser la suma de las longitudes de las 2 líneas rectas de segmentos que salen de ese círculo
:- number((X,Y),N), #count{S: aligned((X,Y),S)} = N1, N1!=|N|.

#show size/1.
%#show number/2.
#show seg/2.
