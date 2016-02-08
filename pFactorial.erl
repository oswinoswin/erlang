-module(pFactorial).
-compile(export_all).

factorial(0) -> [1];
factorial(N) -> [N*hd(factorial(N-1)) | factorial(N-1)].

start() ->
  register(wynik,spawn(pFactorial,loop,[[1]] )).

init(N) ->
  silnia(N,1,1).

silnia(0,_,_) ->
  stop(),
  ok;

silnia(N,Nr,S) ->
 % io:format("Proces odpowiedzialny za liczenie silni z ~p:~n",[Nr]),
  Pid = spawn(?MODULE, liczenie,[]),
  Pid ! {self(), Nr, S},
  receive
    {_, Wynik, _}-> Wynik
  end,
  zapisz(Wynik),
  silnia(N -1,Nr+1, Wynik).

liczenie()->
  receive
    {Pid, Nr,S} ->
      Pid ! {self(), Nr*S, ok}
  after 1000 ->
    ok
  end,
liczenie().


loop(Lista) ->
  receive
    stop -> io:format("~p~n",[Lista]),
      ok;
    {Pid, {zapisz,A}} -> Nowa =  [ A  | Lista],
      Pid ! {self(), ok},
      loop(Nowa)
  end.

zapisz(A)->
  wynik ! {self(), {zapisz,A}},
  receive
    {_, C } -> C
  end.

stop() ->
  wynik ! stop.
