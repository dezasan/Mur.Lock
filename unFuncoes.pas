unit unFuncoes;

interface

uses
  Forms, System.SysUtils, Vcl.Graphics;

  procedure somMurloc;

  function soNumero(sField : String): String;
  function corClasse(sClasse, Nome_Cod : String) : Tcolor;
  function existeTabela(sTabela, sColuna, sValor : String) : Boolean;

implementation

uses DM;

// PROCEDURES: =================================================================

procedure somMurloc;
begin
  //PlaySound(PChar('C:\murloc.wav'), 0, SND_ASYNC or SND_FILENAME or SND_NODEFAULT or SND_NOWAIT);
  //sndPlaySound('C:\murloc.wav', SND_ASYNC);
  //PlaySound('C:\murloc.wav',0,SND_ASYNC);
  //sndPlaySound(nil, 0);
end;


// FUNÇÕES: ====================================================================

//Retorna apenas os números da string:
function soNumero(sField : String): String;
var
  I : Byte;
begin
   Result := '';
   for I := 1 To Length(sField) do
       if sField [I] In ['0'..'9'] Then
            Result := Result + sField [I];
end;

//Retorna a cor da classe:
//Nome_Cod =   [N] nome da classe
//          [else] codigo da classe.
function corClasse(sClasse, Nome_Cod : String) : Tcolor;
begin
  with udm.qryCorClasse do
  begin
    close;
    sql.Clear;

    if UpperCase(Nome_Cod) = 'N' then
    begin //Nome da classe:
      sql.Add('select CLS_COR from CLASSE where CLS_NOME = :NOME');
      ParamByName('NOME').AsString := sClasse;
    end
    else
    begin //Codigo da classe:
      sql.Add('select CLS_COR from CLASSE where CLS_CODIGO = :CODIGO');
      ParamByName('CODIGO').AsInteger := StrToInt(soNumero(sClasse));
    end;

    Open;

    Result := StringToColor(FieldByName('CLS_COR').AsString);
  end;
end;

// Retorna FALSE se o valor NÃO estiver na tabela, senão TRUE;
function existeTabela(sTabela, sColuna, sValor : String) : Boolean;
var
  sSql : String;
begin
  sSql := 'select '+sColuna+' from '+sTabela+' where '+sColuna+' = '''+sValor+''' ';

  with udm.qryAuxEx do
  begin
    Close;
    sql.Clear;
    sql.Add(sSql);
    Open;
    if (FieldByName(sColuna).IsNull) then
      Result := FALSE
    else
      Result := TRUE;
  end;
end;


end.
