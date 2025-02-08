unit uArbolBB;

{$mode ObjFPC}{$H+}

interface

USES
  uElementoTwitter, uElementoString;

TYPE
  TArbolBB = ^TNodo;
  TNodo = RECORD
    raiz : TElementoTwitter;
    hi : TArbolBB;  //Semánticamente tiene más sentido ya que cada hijo es a su vez un árbol (se entiende mejor la recursividad así
    hd : TArbolBB;
  end;

PROCEDURE CrearArbolBinarioVacio(VAR a : TArbolBB);
FUNCTION  EsArbolBinarioVacio(a : TArbolBB) : Boolean;
PROCEDURE ConstruirArbolBinario(VAR a : TArbolBB; i : TArbolBB; r : TElementoTwitter; d : TArbolBB);
PROCEDURE Raiz(a : TArbolBB; VAR r : TElementoTwitter);
PROCEDURE HijoIzquierdo(a : TArbolBB; VAR h : TArbolBB);
PROCEDURE HijoDerecho(a : TArbolBB; VAR h : TArbolBB);
PROCEDURE Insertar(VAR a : TArbolBB; e : TElementoTwitter);
PROCEDURE Minimo(a : TArbolBB; VAR e : TElementoTwitter);
FUNCTION  Pertenece(a : TArbolBB; e : TElementoTwitter) : Boolean;
PROCEDURE DestruirArbolBinario(VAR a : TArbolBB);
PROCEDURE InsertarTweet(VAR arb : TArbolBB; VAR ht : string; VAR tw : string);

implementation

PROCEDURE CrearArbolBinarioVacio(VAR a : TArbolBB);
BEGIN
  a := NIL;
END;

FUNCTION EsArbolBinarioVacio(a : TArbolBB) : Boolean;
BEGIN
  EsArbolBinarioVacio := a = NIL;
END;

PROCEDURE ConstruirArbolBinario(VAR a : TArbolBB; i : TArbolBB; r : TElementoTwitter; d : TArbolBB);
BEGIN
  new(a);
  asignar(a^.raiz, r);
  a^.hi := i;
  a^.hd := d;
END;

PROCEDURE Raiz(a : TArbolBB; VAR r : TElementoTwitter);
BEGIN
  if not EsArbolBinarioVacio(a) then
    asignar(r, a^.raiz);
END;

PROCEDURE HijoIzquierdo(a : TArbolBB; VAR h : TArbolBB);
BEGIN
  if not EsArbolBinarioVacio(a) then
    h := a^.hi;
END;

PROCEDURE HijoDerecho(a : TArbolBB; VAR h : TArbolBB);
BEGIN
  if not EsArbolBinarioVacio(a) then
    h := a^.hd;
END;

PROCEDURE Insertar(VAR a : TArbolBB; e : TElementoTwitter);
VAR
  aux : TArbolBB;
  r : TElementoTwitter;
BEGIN
  if EsArbolBinarioVacio(a) then
  begin
    CrearArbolBinarioVacio(aux);
    ConstruirArbolBinario(a, aux, e, aux);
  end
  else
  begin
    raiz(a, r);
    if EsMenor(e, r) then
    begin
      insertar(a^.hi, e)
    end
    else if not EsMenor(e, r) then
    begin
      insertar(a^.hd, e);
    end;
  end;
END;

PROCEDURE InsertarTweet(VAR arb : TArbolBB; VAR ht : string; VAR tw : string);
VAR
  r : TElementoTwitter;
  i, d : TArbolBB;
  hashtagRaiz : string;
BEGIN
  if not EsArbolBinarioVacio(arb) then
  begin
    raiz(arb, r);
    hashtagRaiz := HashtagElemento(r);
    if EsIgualS(HashtagRaiz, ht) then
      InsertarTweetLista(arb^.raiz, tw)
    else if EsMenorS(ht, hashtagRaiz) then
      InsertarTweet(arb^.hi, ht, tw)
    else
      InsertarTweet(arb^.hd, ht, tw);
  end;
end;

PROCEDURE Minimo(a : TArbolBB; VAR e : TElementoTwitter);
VAR
  i : TArbolBB;
BEGIN
  if not EsArbolBinarioVacio(a) then
  begin
    hijoIzquierdo(a, i);
    if EsArbolBinarioVacio(i) then
      raiz(a, e)
    else
      Minimo(i, e);
  end;
end;

FUNCTION Pertenece(a : TArbolBB; e : TElementoTwitter) : Boolean;
VAR
  r : TElementoTwitter;
  i, d : TArbolBB;
BEGIN
  if EsArbolBinarioVacio(a) then
    Pertenece := false
  else
  begin
    raiz(a, r);
    if EsIgual(e, r) then
      pertenece := true
    else if EsMenor(e, r) then
    begin
      hijoIzquierdo(a, i);
      pertenece := pertenece(i, e);
    end
    else
    begin
      HijoDerecho(a, d);
      pertenece := pertenece(d, e);
    end;
  end;
end;

PROCEDURE DestruirArbolBinario(VAR a : TArbolBB);
BEGIN
  if not EsArbolBinarioVacio(a) then
  begin
    DestruirElemento(a^.raiz);
    DestruirArbolBinario(a^.hi);
    DestruirArbolBinario(a^.hd);
    dispose(a);
  end;
end;

{PROCEDURE BorrarElemento(VAR a : TArbolBB; e : TElementoTwitter);
VAR

BEGIN
  if not EsArbolBinarioVacio(a) then
  raiz(a, r);
  if esIgual(r, e) then

end;}

end.
                                                 
