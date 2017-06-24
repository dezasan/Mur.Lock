unit DM;

interface

uses
  System.SysUtils, System.Classes, Data.DB, IBX.IBDatabase, IBX.IBCustomDataSet,
  IBX.IBQuery, Vcl.Graphics;

type
  Tudm = class(TDataModule)
    dbMurLock: TIBDatabase;
    trsMurLock: TIBTransaction;
    qryMain: TIBQuery;
    qryAux: TIBQuery;
    dtsMain: TDataSource;
    dtsAux: TDataSource;
    qryClasses: TIBQuery;
    dtsClasses: TDataSource;
    qryClassesCLS_CODIGO: TIntegerField;
    qryClassesCLS_NOME: TIBStringField;
    qryClassesCLS_COR: TIBStringField;
    qryCorClasse: TIBQuery;
    dtsCorClasse: TDataSource;
    qryCorClasseCLS_COR: TIBStringField;
    qryConfigs: TIBQuery;
    dtsConfigs: TDataSource;
    qryConfigsCNF_CODIGO: TIntegerField;
    qryConfigsCNF_USUARIO: TIBStringField;
    qryConfigsCNF_VERSAO: TIBStringField;
    qryConfigsCNF_LOGO: TIBStringField;
    qryConfigsCNF_LOGO16: TIBStringField;
    qryConfigsCNF_LOCALHOST: TIBStringField;
    dtsAuxEx: TDataSource;
    qryAuxEx: TIBQuery;

  private
    { Private declarations }
  public
    { Public declarations }

  end;

var
  udm: Tudm;

  codPerso : integer;
  nomePerso : String;
  corPerso : Tcolor;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ Tudm }

end.
