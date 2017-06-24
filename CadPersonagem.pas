unit CadPersonagem;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, IBX.IBCustomDataSet,
  IBX.IBQuery, Vcl.StdCtrls, Vcl.DBCtrls, Vcl.ExtCtrls, Vcl.Buttons, Vcl.Grids,
  Vcl.DBGrids, Datasnap.DBClient, Datasnap.Provider, System.UITypes;

type
  TfrmCadPersonagem = class(TForm)
    painel: TPanel;
    edNome: TEdit;
    lbNome: TLabel;
    lbClasse: TLabel;
    lbTitulo: TLabel;
    cbxClasse: TDBLookupComboBox;
    btSalvar: TBitBtn;
    grdPerso: TDBGrid;
    qryGrid: TIBQuery;
    dspGrid: TDataSetProvider;
    cdsGrid: TClientDataSet;
    dtsGrid: TDataSource;
    qryGridPRS_NOME: TIBStringField;
    qryGridCLS_NOME: TIBStringField;
    cdsGridPRS_NOME: TWideStringField;
    cdsGridCLS_NOME: TWideStringField;
    qryGridPRS_CODIGO: TIntegerField;
    cdsGridPRS_CODIGO: TIntegerField;
    procedure FormCreate(Sender: TObject);
    procedure btSalvarClick(Sender: TObject);
    procedure grdPersoKeyDown(Sender: TObject; var Key: Word;
        Shift: TShiftState);
    procedure cbxClasseClick(Sender: TObject);

    procedure attGrid();
    procedure loadClasses();



  private
    { Private declarations }
  public
    { Public declarations }

  end;

var
  frmCadPersonagem: TfrmCadPersonagem;

implementation

{$R *.dfm}

uses DM, unFuncoes;

{ TfrmCadPersonagem }

procedure TfrmCadPersonagem.attGrid;
begin
  cdsGrid.Close;
  qryGrid.Close;
  qryGrid.Open;
  cdsGrid.Open;
end;

procedure TfrmCadPersonagem.btSalvarClick(Sender: TObject);
var
  novoCod : Integer;
  s : String;
begin
  if (edNome.Text = '') or (cbxClasse.keyvalue = null) then
  begin
    showmessage('Preencha todos os campos!');
    if edNome.Text = '' then
      edNome.SetFocus
    else
      cbxClasse.SetFocus;
    exit;
  end;

  if existeTabela('PERSONAGEM', 'PRS_NOME', edNome.Text) then
  begin
    ShowMessage('Este nome de personagem já está cadastrado!');
    exit;
  end;

  with udm.qryAux do
  begin
    Close;
    sql.Clear;
    sql.add('select GEN_ID(PERSONAGEMCOD,1) as COD FROM RDB$DATABASE ');
    Open;
    novoCod := FieldByName('COD').AsInteger;
  end;

  if udm.trsMurLock.inTransaction then
    udm.trsMurLock.Commit;
  udm.trsMurLock.startTransaction;

  with udm.qryMain do
  begin
    Close;
    sql.Clear;
    sql.add('insert into PERSONAGEM values (:COD, :CODCLASSE, :NOME, 0)');
    parambyname('COD').asInteger := novoCod;
    parambyname('CODCLASSE').asInteger := cbxClasse.KeyValue;
    parambyname('NOME').asString := edNome.Text;

    try
      ExecSql;
      udm.trsMurLock.Commit;
    except
      On E : Exception do
      begin
        udm.trsMurLock.Rollback;
        ShowMessage('Erro! '+E.Message);
      end;
    end;

    codPerso := novoCod;
    nomePerso := edNome.Text;
    corPerso  := corClasse(IntToStr(cbxClasse.KeyValue), 'C');

    edNome.clear;
    cbxClasse.keyvalue := null;
    loadClasses;
    attGrid;
    edNome.SetFocus;
  end;
end;

procedure TfrmCadPersonagem.cbxClasseClick(Sender: TObject);
begin
  btSalvar.Font.Color := corClasse(IntToStr(cbxClasse.KeyValue), 'C');
end;

procedure TfrmCadPersonagem.FormCreate(Sender: TObject);
begin
  loadClasses;
  attGrid;
  btSalvar.Font.Color := clBlack;
end;

procedure TfrmCadPersonagem.grdPersoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (key = VK_DELETE) then
  begin
    if  MessageDlg('Tem certeza que deseja excluir o personagem?',mtConfirmation,[mbyes,mbno],0)=mrno then
      exit;

    if udm.trsMurLock.inTransaction then
      udm.trsMurLock.Commit;
    udm.trsMurLock.startTransaction;

    with udm.qryMain do
    begin
      Close;
      sql.Clear;
      sql.add('delete from PERSONAGEM where PRS_CODIGO = :COD');
      parambyname('COD').asInteger := grdPerso.Columns[0].Field.Value;;

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

      edNome.clear;
      cbxClasse.keyvalue := null;
      loadClasses;
      attGrid;
    end;
  end;
end;

procedure TfrmCadPersonagem.loadClasses;
begin
  udm.qryClasses.Close;
  udm.qryClasses.Open;
  udm.qryClasses.FetchAll;
end;



end.


