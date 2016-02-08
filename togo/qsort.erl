-module(qsort).
-export([lessThan/2,grtEqThan/2,qs/1,randomElems/3,compareSpeeds/3]).
%implements quick sort and compaers speed

lessThan([],Arg) -> [];
lessThan(List,Arg) -> [X || X <- List, X < Arg].

grtEqThan([], Arg) -> [];
grtEqThan(List, Arg) -> [X || X <- List, X >= Arg].

qs([]) -> [];
qs([Pivot|Tail]) -> qs( lessThan(Tail,Pivot) ) ++ [Pivot] ++ qs(grtEqThan(Tail,Pivot) ).

randomElems(N,Min,Max)-> [ random:uniform(Max - Min) + Min || _<- lists:seq(1,N)].

compareSpeeds(List, Fun1, Fun2) -> 
		{Czas1, _} =  timer:tc(Fun1,[List]),
		{Czas2, _} =  timer:tc(Fun2,[List]),
		Czas1 > Czas2.
