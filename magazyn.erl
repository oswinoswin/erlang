-module(magazyn).
-export([printToys/1]).
%print elements from the list

printToys([]) -> io:format("Koniec ~n");
printToys(Toys) -> 
	io:format("~n~s!",hd(Toys)),
	printToys(tl(Toys)).
