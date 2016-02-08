-module(myFunctions).
-export([power/2,divisibleBy/2,contains/2,duplicateElements/1,toBinary/1]).
%implements simple mathematical functions

power(A,0) -> 1;
power(A,1) -> A;
power(A,N) -> A*power(A,N-1).

divisibleBy(Lista,0) -> null;
divisibleBy([],Dzielnik) -> null;
divisibleBy(Lista,1) -> Lista;
divisibleBy(Lista,Dzielnik) -> [X || X<- Lista, X rem Dzielnik =:=0].

contains([],A) -> false;
contains(List,A) when hd(List) =/= A -> contains(tl(List),A);
contains(List,A) -> true.

duplicateElements([]) -> [];
duplicateElements(List) -> [hd(List),hd(List)] ++ duplicateElements(tl(List)).

toBinary(0) -> [0];
toBinary(1) -> [1];
toBinary(N) -> [ toBinary( N div 2 ) | N rem 2].
