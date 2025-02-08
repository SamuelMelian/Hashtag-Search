unit uElementoTwitter;

{$mode ObjFPC}{$H+}

interface

uses
  uListaEnlazadaSimple, uElementoString;

TYPE
  TElementoTwitter = RECORD
    hashtag : string;
    listaTweets : TLista;
  end;

PROCEDURE Asignar(VAR e1 : TElementoTwitter; VAR e2 : TElementoTwitter);
FUNCTION  EsMenor(VAR e1 : TElementoTwitter; VAR e2 : TElementoTwitter) : Boolean;
FUNCTION  EsIgual(VAR e1 : TElementoTwitter; VAR e2 : TElementoTwitter) : Boolean;
PROCEDURE CrearElementoTwitter(VAR s : string; VAR e : TElementoTwitter);
PROCEDURE InsertarTweetLista(VAR e : TElementoTwitter; VAR s : string);
PROCEDURE DestruirElemento(VAR e : TElementoTwitter);
FUNCTION  HashtagElemento(VAR e : TElementoTwitter) : string;
PROCEDURE MostrarTweetsLista(VAR e : TElementoTwitter);

implementation

FUNCTION EsIgual(VAR e1 : TElementoTwitter; VAR e2 : TElementoTwitter) : Boolean;
BEGIN
  EsIgual := e1.hashtag = e2.hashtag;
end;

PROCEDURE Asignar(VAR e1 : TElementoTwitter; VAR e2 : TElementoTwitter);
BEGIN
  e1 := e2;
end;

FUNCTION EsMenor(VAR e1 : TElementoTwitter; VAR e2 : TElementoTwitter) : Boolean;
BEGIN
  EsMenor := EsMenorS(e1.hashtag, e2.hashtag);
end;

PROCEDURE CrearElementoTwitter(VAR s : string; VAR e : TElementoTwitter);
BEGIN
  e.hashtag := s;
  crearListaVacia(e.listaTweets);
END;

FUNCTION HashtagElemento(VAR e : TElementoTwitter) : string;
BEGIN
  HashtagElemento := e.hashtag;
END;

PROCEDURE InsertarTweetLista(VAR e : TElementoTwitter; VAR s : string);
VAR
  e1 : TElemento;
BEGIN
  InsertarElementoS(e1, s);
  Construir(e.listaTweets, e1);
end;

PROCEDURE MostrarTweetsLista(VAR e : TElementoTwitter);
VAR
  e1 : TElemento;
BEGIN
  mostrarlista(e.listatweets);
end;

PROCEDURE DestruirElemento(VAR e : TElementoTwitter);
BEGIN
  DestruirLista(e.listaTweets);
end;

end.

