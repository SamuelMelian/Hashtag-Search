program PracticaTwitter;

USES
  uArbolBB, uElementoTwitter, uElementoString, strutils;
VAR
  ficheroHashtags : text;
  ficheroTweets : text;
  arbol : TarbolBB;
  hashtagusuario : string;

PROCEDURE LlenarArbol(VAR a : TArbolBB; VAR f : text);
VAR
  hashtag : string;
  e : TElementoTwitter;
  i : integer;
BEGIN
  i := 0;
  {$I-}
  reset(f);
  {$I+}
  if ioresult = 0 then
  begin
    while not EOF(f) do
    begin
      readln(f, hashtag);
      //writeln('X',hashtag,'X');
      CrearElementoTwitter(hashtag, e);
      Insertar(a, e);
    end;
    close(f);
  end;
END;

PROCEDURE EtiquetarTweets(VAR a : TArbolBB; VAR f : text);
VAR
  tweet, tweetaux, hashtag : string;
  e : TElementoTwitter;
  pos : integer;
BEGIN
  {$I-}
  reset(f);
  {$I+}
  if ioresult = 0 then
  begin
    while not EOF(f) do
    begin
      readln(f, tweet);
      tweetaux := tweet;
      pos := posEx('#', tweet);
      if pos <> 0 then
        hashtag := ExtractSubstr(tweet, pos, [' ']);
      while (pos <> 0) and (hashtag <> '') do
      begin
        //writeln('X', hashtag, 'X');
        insertarTweet(a, hashtag, tweet);
        delete(tweetaux, pos - length(hashtag) - 1, length(hashtag));
        pos := posEx('#', tweetaux);
        if pos <> 0 then
          hashtag := ExtractSubstr(tweetaux, pos, [' ']);
      end;
    end;
    close(f);
  end;
END;

PROCEDURE MostrarTweets(a : TArbolBB; hashtag : string);
VAR
  r : TElementoTwitter;
  i, d : TArbolBB;
  hashtagRaiz : string;
BEGIN
  if not EsArbolBinarioVacio(a) then
  begin
    raiz(a, r);
    hashtagRaiz := HashtagElemento(r);
    if EsIgualS(Hashtag, hashtagraiz) then
    begin
      MostrarTweetsLista(r);
    end
    else if EsMenorS(hashtag, hashtagRaiz) then
    begin
      HijoIzquierdo(a, i);
      MostrarTweets(i, hashtag);
    end
    else
    begin
      HijoDerecho(a, d);
      MostrarTweets(d, hashtag);
    end;
  end
  else
    writeln('No hay ningun tweet que contenga ese hashtag');
end;

PROCEDURE Recorrido(a : TArbolBB);
VAR
  r : TElementoTwitter;
  i, d : TArbolBB;
BEGIN
  if not EsArbolBinarioVacio(a) then
  begin
    raiz(a, r);
    HijoIzquierdo(a, i);
    HijoDerecho(a, d);
    recorrido(i);
    recorrido(d);
  end;
END;

begin
  assign(ficheroHashtags, './hashtags.txt');
  assign(ficheroTweets, './tweets.txt');
  LlenarArbol(arbol, ficheroHashtags);
  EtiquetarTweets(arbol, ficheroTweets);
  writeln('Introduzca un hashtag');
  readln(hashtagUsuario);
  mostrarTweets(arbol, hashtagUsuario);
  DestruirArbolBinario(arbol);
  readln;
end.

