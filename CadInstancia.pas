unit CadInstancia;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.DBCtrls,
  Vcl.ComCtrls, Vcl.Samples.Spin, Data.DB, IBX.IBCustomDataSet, IBX.IBQuery,
  Vcl.Imaging.pngimage, Vcl.Buttons, Datasnap.Provider, Vcl.Grids, Vcl.DBGrids,
  Datasnap.DBClient, Vcl.Mask, Vcl.AppAnalytics, System.UITypes;

type
  TfrmCadInstancia = class(TForm)
    Panel1: TPanel;
    lbTitulo: TLabel;
    lbPersonagem: TLabel;
    qryLugar: TIBQuery;
    dtsLugar: TDataSource;
    qryLugarLGR_CODIGO: TIntegerField;
    qryLugarLGR_NOME: TIBStringField;
    pnChefes: TPanel;
    Image1: TImage;
    lbChefe: TLabel;
    cbxChefe: TDBLookupComboBox;
    lbDps: TLabel;
    btSalvar: TBitBtn;
    qryChefe: TIBQuery;
    dtsChefe: TDataSource;
    qryChefeCHF_CODIGO: TIntegerField;
    qryChefeCHF_NOME: TIBStringField;
    btSvChefe: TBitBtn;
    cdsGrid: TClientDataSet;
    grdChefes: TDBGrid;
    dspGrid: TDataSetProvider;
    dtsGrid: TDataSource;
    qryGrid: TIBQuery;
    edDpsChf: TMaskEdit;
    pnInst: TPanel;
    lbDpsMED: TLabel;
    edDpsMed: TMaskEdit;
    lbPlus: TLabel;
    spPlus: TSpinEdit;
    lbDif: TLabel;
    cbxDif: TComboBox;
    lbLugar: TLabel;
    cbxLugar: TDBLookupComboBox;
    lbIlvl: TLabel;
    spIlvl: TSpinEdit;
    dtData: TDateTimePicker;
    lbData: TLabel;
    cdsGridINS_CODIGO: TIntegerField;
    cdsGridCHF_CODIGO: TIntegerField;
    cdsGridCHF_NOME: TWideStringField;
    cdsGridCIN_DANO: TFloatField;
    qryLugarLGR_TIPO: TIBStringField;
    qryGridINS_CODIGO: TIntegerField;
    qryGridCHF_CODIGO: TIntegerField;
    qryGridCHF_NOME: TIBStringField;
    qryGridCIN_DANO: TFloatField;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btSalvarClick(Sender: TObject);
    procedure btSvChefeClick(Sender: TObject);
    procedure edDpsMedExit(Sender: TObject);
    procedure edDpsChfExit(Sender: TObject);
    procedure dtDataExit(Sender: TObject);
    procedure spIlvlExit(Sender: TObject);
    procedure cbxDifChange(Sender: TObject);
    procedure lbPersonagemDblClick(Sender: TObject);
    procedure edDpsMedKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edDpsChfKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cbxLugarExit(Sender: TObject);

    procedure editando(inst_chefe : String);
    procedure attGrdChefes();
    procedure loadLugar();
    procedure loadChefes();
    procedure limpaCampos();
    procedure mudaCores();


  private
    { Private declarations }
  public
    { Public declarations }
    codIns : Integer;

  end;

var
  frmCadInstancia: TfrmCadInstancia;

implementation

{$R *.dfm}

uses DM, unFuncoes;


procedure TfrmCadInstancia.attGrdChefes;
begin
  cdsGrid.Close;
  qryGrid.Close;
  if codIns > 0 then
    qryGrid.ParamByName('INST').AsInteger := codIns;
  qryGrid.Open;
  cdsGrid.Open;
end;

procedure TfrmCadInstancia.btSvChefeClick(Sender: TObject);
var
  atChefe : Integer;
begin
  if (cbxChefe.KeyValue = null) or (edDpsChf.Text = '') then
  begin
    showmessage('Preencha todos os campos!');
    if cbxChefe.KeyValue = null then
      cbxChefe.SetFocus
    else
      edDpsChf.SetFocus;
    exit;
  end;

  atChefe := cbxChefe.KeyValue;

  if udm.trsMurLock.inTransaction then
    udm.trsMurLock.Commit;
  udm.trsMurLock.startTransaction;

  with udm.qryMain do
  begin
    Close;
    sql.Clear;
    sql.add('insert into CHF_INSTANCIA values (:INST, :CHEFE, :DANO)');
    parambyname('INST').asInteger  := codIns;
    parambyname('CHEFE').asInteger := cbxChefe.KeyValue;
    parambyname('DANO').asFloat    := StrToFloat(edDpsChf.Text);

    try
      ExecSql;
      udm.trsMurLock.Commit;
    except
      On E : Exception do
      begin
        udm.trsMurLock.Rollback;
        raise E.create(E.message);
        exit;
      end;
    end;

    //salvou...
    try
      cbxChefe.KeyValue := atChefe + 1;
    except
    end;
    edDpsChf.Text := '';

    attGrdChefes;
    loadChefes;
    if cbxChefe.KeyValue = null then
      cbxChefe.SetFocus
    else
      edDpsChf.SetFocus;
  end;
end;

procedure TfrmCadInstancia.btSalvarClick(Sender: TObject);
var
  novoCod : Integer;
begin
  if ((dtData.date = null) or (spIlvl.Value <=0) or (cbxLugar.KeyValue = null)
      or (cbxDif.ItemIndex < 0) or (edDpsMed.Text = '')) then
  begin
    showmessage('Preencha todos os campos!');
    dtData.SetFocus;
    exit;
  end;

  with udm.qryAux do
  begin
    Close;
    sql.Clear;
    sql.add('select GEN_ID(INSTANCIACOD,1) as COD FROM RDB$DATABASE ');
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
    sql.add('insert into INSTANCIA (INS_CODIGO, LGR_CODIGO, PRS_CODIGO, '+
            'INS_DANO, INS_ILVL, INS_DIFICULDADE, INS_PLUS, INS_DATA) values '+
            '(:COD, :LUGARCOD, :PERSOCOD, :DPS, :ILVL, :DIF, :PLUS, :DATA)');
    parambyname('COD').asInteger      := novoCod;
    parambyname('LUGARCOD').asInteger := cbxLugar.KeyValue;
    parambyname('PERSOCOD').asInteger := codPerso;
    parambyname('DPS').asFloat        := StrToFloat(edDpsMed.Text);
    parambyname('ILVL').AsInteger     := spIlvl.Value;
    parambyname('DIF').AsString       := cbxDif.Text;
    if cbxDif.Text = 'M+' then
      parambyname('PLUS').AsInteger     := spPlus.Value
    else
      parambyname('PLUS').IsNull;
    parambyname('DATA').AsDateTime    := dtData.DateTime;

    try
      ExecSql;
      udm.trsMurLock.Commit;
    except
      On E : Exception do
      begin
        udm.trsMurLock.Rollback;
        raise E.create(E.message);
        exit;
      end;
    end;

    //salvou...
    codIns := novoCod;
    attGrdChefes;
    loadChefes;
    cbxChefe.KeyValue := 0;
    editando('C');
    cbxChefe.SetFocus;
  end;
end;

procedure TfrmCadInstancia.cbxDifChange(Sender: TObject);
begin
  if cbxDif.ItemIndex = 4 then
  begin
    lbPlus.Enabled := TRUE;
    lbPlus.Visible := TRUE;
    spPlus.Enabled := TRUE;
    spPlus.Visible := TRUE;
  end
  else
  begin
    lbPlus.Enabled := FALSE;
    lbPlus.Visible := FALSE;
    spPlus.Enabled := FALSE;
    spPlus.Visible := FALSE;
  end;
end;

procedure TfrmCadInstancia.cbxLugarExit(Sender: TObject);
begin
  if cbxLugar.KeyValue = null then
  begin
    cbxDif.Items.Clear;
    exit;
  end;

  if qryLugarLGR_TIPO.AsString = 'D' then
  begin //Dungeon:
    cbxDif.Items.Clear;
    cbxDif.Items.Add('LF');
    cbxDif.Items.Add('N');
    cbxDif.Items.Add('H');
    cbxDif.Items.Add('M');
    cbxDif.Items.Add('M+');
  end
  else
  begin //Raid:
    cbxDif.Items.Clear;
    cbxDif.Items.Add('LF');
    cbxDif.Items.Add('N');
    cbxDif.Items.Add('H');
    cbxDif.Items.Add('M');
  end;
end;

procedure TfrmCadInstancia.dtDataExit(Sender: TObject);
begin
  if dtData.DateTime > date then
    dtData.DateTime := null;
end;

procedure TfrmCadInstancia.edDpsChfExit(Sender: TObject);
begin
  edDpsChf.Text := SoNumero(edDpsChf.Text);

  if StrToFloat(edDpsChf.Text) < 0 then
    edDpsChf.Text := '0';
end;

procedure TfrmCadInstancia.edDpsChfKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_RETURN then
    btSvChefe.SetFocus;
end;

procedure TfrmCadInstancia.edDpsMedExit(Sender: TObject);
begin
  edDpsMed.Text := SoNumero(edDpsMed.Text);

  if StrToFloat(edDpsMed.Text) < 0 then
    edDpsMed.Text := '0';
end;

procedure TfrmCadInstancia.edDpsMedKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_RETURN then
    btSalvar.SetFocus;
end;

procedure TfrmCadInstancia.editando(inst_chefe: String);
begin
  if upperCase(inst_chefe) = 'I' then
  begin
    pnInst.Enabled   := TRUE;
    pnChefes.Enabled := FALSE;
  end
  else
  begin
    pnInst.Enabled   := FALSE;
    pnChefes.Enabled := TRUE;
  end;
end;

procedure TfrmCadInstancia.FormCreate(Sender: TObject);
begin
  loadLugar;
end;

procedure TfrmCadInstancia.FormShow(Sender: TObject);
begin
  if codPerso > 0 then
    lbPersonagem.caption := nomePerso
  else
    lbPersonagem.caption := '404 not found :(';

  mudaCores;
  limpaCampos;
  attGrdChefes;
  editando('I');
end;

procedure TfrmCadInstancia.lbPersonagemDblClick(Sender: TObject);
begin
  if  MessageDlg('Cadastrar nova instância?',mtConfirmation,[mbyes,mbno],0)=mrno then
    exit;

  codIns := -1;
  limpaCampos;
  attGrdChefes;
  editando('I');
  dtData.SetFocus;
end;

procedure TfrmCadInstancia.limpaCampos;
begin
  dtData.DateTime := date;
  spIlvl.Value := 0;
  cbxLugar.KeyValue := null;
  cbxDif.ItemIndex := -1;
  edDpsMed.Text := '';

  cbxChefe.KeyValue := null;
  edDpsChf.Text := '';
end;

procedure TfrmCadInstancia.loadChefes;
begin
  qryChefe.Close;
  qryChefe.ParamByName('LUGAR').AsInteger := cbxLugar.KeyValue;
  qryChefe.Open;
  qryChefe.FetchAll;
end;

procedure TfrmCadInstancia.loadLugar;
begin
  qryLugar.Close;
  qryLugar.Open;
  qryLugar.FetchAll;
end;

procedure TfrmCadInstancia.mudaCores;
begin
  if codPerso > 0 then
  begin
    lbTitulo.Font.Color := corPerso;
    lbPersonagem.Font.Color := corPerso;
    btSalvar.Font.Color := corPerso;
    btSvChefe.Font.Color := corPerso;
  end
  else
  begin
    lbTitulo.Font.Color := StringToColor('$0000D200');
    lbPersonagem.Font.Color := StringToColor('$000080FF');
    btSalvar.Font.Color := clBlack;
    btSvChefe.Font.Color := clBlack;
  end;
end;

procedure TfrmCadInstancia.spIlvlExit(Sender: TObject);
begin
  if spIlvl.Value < 0 then
    spIlvl.Value := 0;
end;

end.
