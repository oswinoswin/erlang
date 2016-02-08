-module(addressBook).
-author("Maria Uchwat").

%% API
-export([createAddressBook/0,addContact/3, addEmail/4,addPhone/4,addAddress/6,removeContact/3,removeEmail/2,removePhone/2,getEmails/3,getPhones/3,findByEmail/2,findByPhone/2,findByCity/2]).
-record(address, {street, number, city}).
-record(contact, {name=null,lastname=null, phone=null, email=null, adr=#address{street = null, number = null, city = null}}).


createAddressBook() ->
  dict:new().

addContact(Imie, Nazwisko , D) ->
  Nowy = #contact{name=Imie, lastname=Nazwisko},
  dict:store(Imie ++  Nazwisko,Nowy,D).

addEmail(Imie, Nazwisko, Email, D) ->
  Nowy = #contact{name=Imie, lastname=Nazwisko, email = Email},
  dict:update(Imie ++  Nazwisko,fun(Old) -> Old#contact{email = Email} end, Nowy,D).

addPhone(Imie, Nazwisko, Tel, D) ->
  Nowy = #contact{name=Imie, lastname=Nazwisko, phone = Tel},
  dict:update(Imie ++  Nazwisko,fun(Old) -> Old#contact{phone = Tel} end, Nowy,D).


removeContact(Imie, Nazwisko, D) ->
  dict:erase(Imie ++ Nazwisko,D).

removeEmail(Email, D) ->
  {Imie,Nazwisko} = findByEmail(Email,D),
  addEmail(Imie,Nazwisko,null,D).


removePhone(Phone, D) ->
  {Imie,Nazwisko} = findByPhone(Phone,D),
  addPhone(Imie,Nazwisko,null,D).

getEmails(Imie, Nazwisko, D) ->
  Ten = dict:fetch(Imie ++ Nazwisko,D),
  Ten2 = hd(Ten),
  Ten2#contact.email.

getPhones(Imie, Nazwisko, D) ->
  Ten = dict:fetch(Imie ++ Nazwisko,D),
  Ten2 = hd(Ten),
  Ten2#contact.phone.

findByEmail(Email, D) ->
  D1 = dict:filter( fun(Key,Val) -> Val#contact.email == Email end, D),
  {_,A} = hd(dict:to_list(D1)),
  {_,Imie, Nazwisko,_,_,_}=A,
  {Imie,Nazwisko}.



findByPhone(Tel, D) ->
  D1 = dict:filter( fun(Key,Val) -> Val#contact.phone == Tel end, D),
  {_,A} = hd(dict:to_list(D1)),
  {_,Imie, Nazwisko,_,_,_}=A,
  {Imie,Nazwisko}.

addAddress(Imie, Nazwisko, Ulica, Numer, Miasto, D) ->
  NowyAddress = #address{street = Ulica, number = Numer, city = Miasto},
  Nowy = #contact{name = Imie, lastname = Nazwisko, adr = NowyAddress},
  dict:update(Imie ++  Nazwisko,fun(Old) -> Old#contact{adr = NowyAddress} end, Nowy,D).

findByCity(Miasto,D) ->
  D1 = dict:filter( fun(Key,Val) -> Val#contact.adr#address.city == Miasto end, D),
  {_,A} = hd(dict:to_list(D1)),
  {_,Imie, Nazwisko,_,_,_}=A,
  {Imie,Nazwisko}.