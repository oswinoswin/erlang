-module(magazyn).
-export([printToys/1]).

printToys([]) -> io:format("Koniec ~n");
printToys(Toys) -> 
	io:format("~n~s!",hd(Toys)),
	printToys(tl(Toys)).