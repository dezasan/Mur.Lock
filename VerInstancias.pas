unit VerInstancias;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Data.DB,
  IBX.IBCustomDataSet, Datasnap.DBClient, Datasnap.Provider, IBX.IBQuery,
  Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, System.UITypes;

type
  TfrmVerInstancias = class(TForm)
    pnFundo: TPanel;
    lbTitulo: TLabel;
    lbPersonagem: TLabel;
    gdDados: TDBGrid;
    qryGrid: TIBQuery;
    dspGrid: TDataSetProvider;
    cdsGrid: TClientDataSet;
    dtsGrid: TDataSource;
    qryGridINS: TIntegerField;
    qryGridDT: TDateField;
    qryGridILVL: TIntegerField;
    qryGridDPS: TFloatField;
    qryGridLGR: TIBStringField;
    qryGridDIF: TIBStringField;
    cdsGridINS: TIntegerField;
    cdsGridDT: TDateField;
    cdsGridILVL: TIntegerField;
    cdsGridDPS: TFloatField;
    cdsGridLGR: TWideStringField;
    cdsGridDIF: TWideStringField;
    qryGridLGRTIPO: TIBStringField;
    cdsGridLGRTIPO: TWideStringField;
    procedure FormShow(Sender: TObject);

    procedure loadInstancias();
    procedure mudaCores();
    procedure gdDadosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmVerInstancias: TfrmVerInstancias;

implementation

{$R *.dfm}

uses DM, unFuncoes;

procedure TfrmVerInstancias.FormShow(Sender: TObject);
begin
  if codPerso > 0 then
    lbPersonagem.caption := nomePerso
  else
    lbPersonagem.caption := '404 not found :(';

  mudaCores;
  loadInstancias;
end;

procedure TfrmVerInstancias.gdDadosKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (key = VK_DELETE) then
  begin
    if  MessageDlg('Tem certeza que deseja excluir a instância?',mtConfirmation,[mbyes,mbno],0)=mrno then
      exit;

    if udm.trsMurLock.inTransaction then
      udm.trsMurLock.Commit;
    udm.trsMurLock.startTransaction;

    with udm.qryMain do
    begin
      Close;
      sql.Clear;
      sql.add('delete from INSTANCIA where INS_CODIGO = :COD');
      parambyname('COD').asInteger := gdDados.Columns[0].Field.Value;;

      try
        ExecSql;
        udm.trsMurLock.Commit;
      except
        On E : Exception do
        begin
          udm.trsMurLock.Rollback;
          //ShowMessage('Erro! '+E.Message);
          raise Exception.Create('Erro! ');
        end;
      end;

      loadInstancias;
    end;
  end;
end;

procedure TfrmVerInstancias.loadInstancias;
begin
  cdsGrid.Close;
  qryGrid.Close;
  qryGrid.ParamByName('PERSO').AsInteger := codPerso;
  qryGrid.Open;
  cdsGrid.Open;
end;

procedure TfrmVerInstancias.mudaCores;
begin
if codPerso > 0 then
  begin
    lbTitulo.Font.Color := corPerso;
    lbPersonagem.Font.Color := corPerso;
  end
  else
  begin
    lbTitulo.Font.Color := StringToColor('$0000D200');
    lbPersonagem.Font.Color := StringToColor('$000080FF');
  end;
end;

end.
