unit uListaEnlazadaSimple;

{$mode ObjFPC}{$H+}

interface      //Seccion donde se encuentra lo que el usuario puede utilizar cuando implemente la unidad

uses
  uElementoString;

  TYPE
  TLista = ^TNodo;
  TNodo = RECORD
    info: TElemento;
    sig:^TNodo;
  END;

PROCEDURE  CrearListaVacia(VAR l:TLista);  //Constructora generadora
PROCEDURE  Construir(VAR l:TLista; e:TElemento);  //Constructora generadora
PROCEDURE  Primero(l:TLista; VAR e:TElemento);   //Observadora selectora
PROCEDURE  Resto(VAR l:TLista);  //Observadora selectora
FUNCTION   EsListaVacia(l:TLista):Boolean;  //Como ultimo no es parte de la lista segun nuestra definicion (primero y resto) la operacion ultimo es observadora no selectora
FUNCTION   Pertenece (l:TLista; e:TElemento):Boolean;
PROCEDURE  DestruirLista(VAR l: TLista);
PROCEDURE  BorrarElemento(VAR l:TLista; e:TElemento);
PROCEDURE  Copiar (VAR c : TLista; VAR l : TLista);
PROCEDURE  BorrarFinal (VAR l:TLista);
FUNCTION   Longitud(l:TLista):Integer;
PROCEDURE  Ultimo(l:TLista; VAR e:TElemento);
PROCEDURE  InsertarFinal (VAR l:TLista; e:TElemento);
PROCEDURE  MostrarLista(VAR l : TLista);

implementation

  PROCEDURE  CrearListaVacia(VAR l:TLista);
  BEGIN
    l:=NIL;  //Como no se puede saber si la lista esta vacía, lo implementamos sin condición y dependera del programador no llamar a esta funcion con una lista que no esté vacía
  END;

  PROCEDURE  Construir(VAR l:TLista; e:TElemento);
  VAR
    aux: ^TNodo;
  BEGIN
    new(aux);  //Como aux tiene espacio, no hace falta comprobar que la referencia al campo info de aux se puede realizar
    asignarS(aux^.info, e);
    aux^.sig := l;
    l := aux;
  END;

  PROCEDURE  Primero(l:TLista; VAR e:TElemento);  //No es una funcion porque devuelve un TElemento y no sabemos si TElemento se puede devolver
  BEGIN
    IF (NOT EsListaVacia(l)) THEN
      asignarS(e, l^.info);  //Siempre que hay un circunflejo, hay que comprobar si está vacía
  END;

  PROCEDURE Resto(VAR l:TLista);
  VAR
    aux: ^TNodo;
  BEGIN
    IF (NOT EsListaVacia(l)) THEN
      begin
        aux := l;  //Aux apunta a lista
        l := l^.sig;  //l apunta al segundo elemento de la lista
        dispose(aux);//Borramos aux, que apunta a la lista inicial;
        aux := NIL;
      end;
  END;

  FUNCTION EsListaVacia(l:TLista):Boolean;
  begin
    EsListaVacia:= l = NIL
  END;

  PROCEDURE DestruirLista(VAR l: TLista);   //La funcion destruir lista es igual para cualquier lista que implementemos, por lo que se podria implementar en el programa principal o en una unidad que fuera de extensiones de operaciones
  BEGIN
    WHILE NOT EsListaVacia(l) DO
    begin
      Resto(l);
    end;
  END;

  PROCEDURE MostrarLista(VAR l : TLista);
  VAR
    aux : ^Tnodo;
  BEGIN
    aux := l;
    while not EsListaVacia(l) do
    begin
      mostrarS(l^.info);
      l := l^.sig;
    end;
  end;

  {FUNCTION Pertenece (l:TLista; e:TElemento):Boolean;  //Pertenece en listas es O(n)
   VAR
    aux : ^TNodo;
    encontrado : boolean;
  BEGIN
    encontrado := false;
    aux:=l;  //No es necesario hacer la implementacion con la variable aux pues estamos haciendo una copia de la lista al pasarla por valor, por lo que podriamos hacer todo directamente con l
    while ((aux <> NIL) and (not encontrado)) do
      begin
      encontrado := EsIgual(aux^.info, e);
      aux:=aux^.sig;  //Siempre hay que asegurarse que se puede acceder a la referencia (^) mediante alguna comprobacion. En este caso se comprueba en el while
      end;
    pertenece := encontrado;
  END; }

  //Segunda version pertenece
  FUNCTION Pertenece (l: TLista; e:TElemento): Boolean;
  VAR
    aux : ^TNodo;
  BEGIN
    aux := l;
    while ((not EsListaVacia(aux)) and (not esigualS(aux^.info, e))) do
      aux := aux^.sig;
    pertenece := not EsListaVacia(aux);  //Ya que depende de la condicion por la que haya salido
  END;

  PROCEDURE BorrarElemento(VAR l:TLista; e:TElemento);
  VAR
    aux : ^TNodo;
    aux2 : ^TNodo;
    encontrado:boolean;
  BEGIN
    encontrado:=false;
    if (not EsListaVacia(l)) then
    begin
      if EsIgualS(l^.info, e) then  //Hay que separar el caso de que sea el primero
        resto(l)
      else
      begin
        aux2 := l;
        aux := aux2^.sig;  //No hace falta comprobar nada porque sabemos que l no es vacia y por tanto el campo sig de aux2 (l) apunta a algo.
        while (not EsListaVacia(aux)) and (not esigualS(aux^.info, e)) do  //Importante hacer primero la comprobación de que no es vacia para poder acceder al campo info de aux
        begin
          aux2 := aux;
          aux := aux2^.sig;
        end;
        if (not EsListaVacia(aux)) then
        begin
          aux2^.sig := aux^.sig;  //Aux2 siempre apunta a un elemento válido por comprobar siempre aux
          dispose(aux);
        end;
      end;
    end;
  END;

  PROCEDURE InsertarFinal (VAR l:TLista; e:TElemento);
  VAR
    aux,aux2 : ^TNodo;
  BEGIN
    new(aux2);
    asignarS(aux2^.info, e);
    aux2^.sig := NIL;
    aux := l;
    if (EsListaVacia(aux)) then
      l:=aux2
    else
    begin
      while (not EsListaVacia(aux^.sig)) do
        aux := aux^.sig;
      aux^.sig := aux2;
    end;
    dispose(aux2);
    aux2 := NIL;
  END;

  PROCEDURE Ultimo(l:TLista; VAR e:TElemento);
  BEGIN
    if (not EsListaVacia(l)) then
    begin
      while (not EsListaVacia(l^.sig)) do
        l := l^.sig;
      asignarS(e, l^.info);
    end;
  END;

  FUNCTION Longitud(l:TLista):Integer;
  VAR
    cont : integer;
  BEGIN
    cont:=0;
    while (not EsListaVacia(l)) do
      begin
        l := l^.sig;
        cont := cont + 1;
      end;
    Longitud := cont;
  END;

  PROCEDURE BorrarFinal (VAR l:TLista);
  VAR
    aux,aux2 : ^TNodo;
  BEGIN
    if (not EsListaVacia(l)) then
    begin
      aux := l;
      if (l^.sig = NIL) then
      begin
        l := NIL;
        dispose(aux);
      end
      else
      begin
        aux2 := aux^.sig;
        while (not EsListaVacia(aux2) and (aux2^.sig <> NIL)) do
        begin
          aux := aux2;
          aux2  := aux2^.sig;
        end;
        if (not EsListaVacia(aux2)) then
        begin
          aux^.sig := NIL;
          dispose(aux2);
        end;
      end;
    end;
  END;

  PROCEDURE Destruir (VAR l : TLista);
  BEGIN
    while (not EsListaVacia(l)) do
      resto(l);
  END;

  PROCEDURE Copiar(VAR c : TLista; VAR l : TLista);
  VAR
    auxl, auxc, aux3 : ^TNodo;
  BEGIN
    auxl := l;
    IF (NOT EsListaVacia(auxl)) THEN
    BEGIN
      new(c);
      AsignarS(c^.info, auxl^.info);
      c^.sig := NIL;
      auxc := c;
      auxl := auxl^.sig;
    END;
    WHILE (NOT EsListaVacia(auxl)) DO
    BEGIN
      new(aux3);
      asignarS(aux3^.info, auxl^.info);
      aux3^.sig := NIL;
      auxc^.sig := aux3;
      auxc := auxc^.sig;
      auxl := auxl^.sig;
    END;
  END;

  PROCEDURE Concatenar(VAR l3 : Tlista; VAR l1, l2 : TLista);  //O(n) siendo n la longitud de la lista 1
  VAR
    aux : ^TNodo;
  BEGIN
    if (EsListaVacia(l1)) then
      l3 := l2
    else if (EsListaVacia(l2)) then
      l3 := l1
    else
    begin
      aux := l1;
      while (not EsListaVacia(aux^.sig)) do
        aux := aux^.sig;
      aux^.sig := l2;
      l3 := l1;  //El proceimiento consiste en que el ultimo de l1 apunta a l2 y l3 apunta a l1
    end;
  END;

END.

