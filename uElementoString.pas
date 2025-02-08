unit uElementoString;

{$mode ObjFPC}{$H+}


interface

USES
  sysutils;

TYPE
  TElemento = string;

PROCEDURE AsignarS(VAR e1 : TElemento; VAR e2 : TElemento);
PROCEDURE MostrarS(VAR e : TElemento);
PROCEDURE InsertarElementoS(VAR e : TElemento; VAR s : string);
FUNCTION EsIgualS(VAR e1 : TElemento ; VAR e2 : TElemento) : Boolean;
FUNCTION EsMenorS(VAR e1 : TElemento; VAR e2 : TElemento) : Boolean;

implementation

  PROCEDURE AsignarS(VAR e1 : TElemento; VAR e2 : TElemento);
  BEGIN
    e1 := e2;
  end;

  PROCEDURE MostrarS(VAR e : TElemento);
  BEGIN
    writeln(e);
  end;

  PROCEDURE InsertarElementoS(VAR e : TElemento; VAR s : string);
  BEGIN
    e := s;  //Diferente a asignar porque aquí se inserta un elemento en otro
  end;

  FUNCTION EsIgualS(VAR e1 : TElemento ; VAR e2 : TElemento) : Boolean;
  BEGIN
    EsIgualS:= e1 = e2;
  end;

  FUNCTION EsMenorS(VAR e1 : TElemento ; VAR e2 : TElemento) : Boolean;
  BEGIN
    EsMenorS := AnsiCompareText(e1, e2) < 0
  end;

end.


