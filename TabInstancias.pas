unit TabInstancias;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ComCtrls, Vcl.DBCtrls, Vcl.Mask, Vcl.Samples.Spin, Data.DB,
  IBX.IBCustomDataSet, IBX.IBQuery, Vcl.Grids, Vcl.DBGrids,
  Datasnap.DBClient, Datasnap.Provider, ppDB, ppDBPipe, ppComm, ppRelatv,
  ppProd, ppClass, ppReport, ppCtrls, ppVar, ppPrnabl, ppBands, ppCache,
  ppDesignLayer, ppParameter, raCodMod, ppModule;

type
  TfrmTabInstancias = class(TForm)
    pnFundo: TPanel;
    lbPersonagem: TLabel;
    lbTitulo: TLabel;
    btGerar: TBitBtn;
    gbData: TGroupBox;
    gbIlvl: TGroupBox;
    gbLugar: TGroupBox;
    gbDps: TGroupBox;
    dtI: TDateTimePicker;
    dtF: TDateTimePicker;
    Label1: TLabel;
    spIlvlI: TSpinEdit;
    spIlvlF: TSpinEdit;
    Label2: TLabel;
    edDpsI: TMaskEdit;
    edDpsF: TMaskEdit;
    Label3: TLabel;
    cbxLugar: TDBLookupComboBox;
    cbxDif: TComboBox;
    spPlus: TSpinEdit;
    gbChefes: TGroupBox;
    cbxChefes: TDBLookupComboBox;
    gbDpsChefes: TGroupBox;
    Label4: TLabel;
    edDpsCI: TMaskEdit;
    edDpsCF: TMaskEdit;
    qryLugar: TIBQuery;
    qryLugarLGR_CODIGO: TIntegerField;
    qryLugarLGR_NOME: TIBStringField;
    qryLugarLGR_TIPO: TIBStringField;
    dtsLugar: TDataSource;
    qryChefe: TIBQuery;
    qryChefeCHF_CODIGO: TIntegerField;
    qryChefeCHF_NOME: TIBStringField;
    dtsChefe: TDataSource;
    btLimpar: TBitBtn;
    qryGrid: TIBQuery;
    dspGrid: TDataSetProvider;
    cdsGrid: TClientDataSet;
    dtsGrid: TDataSource;
    qryGridINS: TIntegerField;
    qryGridDPS: TFloatField;
    qryGridLGR: TIBStringField;
    qryGridDIF: TIBStringField;
    qryGridCHF: TIBStringField;
    qryGridDPSCHEFE: TFloatField;
    rpGrid: TppReport;
    cdsGridINS: TIntegerField;
    cdsGridDPS: TFloatField;
    cdsGridLGR: TWideStringField;
    cdsGridDIF: TWideStringField;
    cdsGridCHF: TWideStringField;
    cdsGridDPSCHEFE: TFloatField;
    ppParameterList1: TppParameterList;
    ppDesignLayers1: TppDesignLayers;
    ppDesignLayer1: TppDesignLayer;
    ppHeaderBand1: TppHeaderBand;
    ppDetailBand1: TppDetailBand;
    ppFooterBand1: TppFooterBand;
    ppLabel1: TppLabel;
    ppSystemVariable1: TppSystemVariable;
    ppSystemVariable2: TppSystemVariable;
    pShape: TppShape;
    ppGroup1: TppGroup;
    ppGroupHeaderBand1: TppGroupHeaderBand;
    ppGroupFooterBand1: TppGroupFooterBand;
    ppShape1: TppShape;
    plbPerso: TppLabel;
    ppDBText2: TppDBText;
    ppDBText3: TppDBText;
    ppDBText5: TppDBText;
    ppDBText6: TppDBText;
    ppDBCalc1: TppDBCalc;
    ppLabel2: TppLabel;
    pShape2: TppShape;
    raCodeModule1: TraCodeModule;
    raProgramInfo1: TraProgramInfo;
    pimLogo: TppImage;
    ppLine1: TppLine;
    ppLabel3: TppLabel;
    ppShape2: TppShape;
    ppDBText1: TppDBText;
    ppDBText4: TppDBText;
    ppLabel4: TppLabel;
    ppDBText7: TppDBText;
    qryGridDT: TDateField;
    qryGridILVL: TIntegerField;
    cdsGridDT: TDateField;
    cdsGridILVL: TIntegerField;
    plGrid: TppDBPipeline;
    ppLine2: TppLine;
    procedure edDpsIExit(Sender: TObject);
    procedure edDpsFExit(Sender: TObject);
    procedure edDpsCIExit(Sender: TObject);
    procedure edDpsCFExit(Sender: TObject);
    procedure cbxLugarExit(Sender: TObject);
    procedure cbxDifExit(Sender: TObject);
    procedure cbxLugarKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cbxChefesClick(Sender: TObject);
    procedure btLimparClick(Sender: TObject);

    procedure loadLugar();
    procedure loadChefes();
    procedure limpaCampos();
    procedure mudaCores();
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ppDetailBand1BeforePrint(Sender: TObject);
    procedure btGerarClick(Sender: TObject);
    procedure cbxDifKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure s(Sender: TObject; var Key: Word;
      Shift: TShiftState);


  private
    { Private declarations }
  public
    { Public declarations }

  end;

var
  frmTabInstancias: TfrmTabInstancias;

implementation

{$R *.dfm}

uses DM, unFuncoes;

{ TfrmVerInstancias }

procedure TfrmTabInstancias.btGerarClick(Sender: TObject);
var
  sSql, sFil, sOrd : String; //sql, filtro e order by;
begin
  sSql := 'select I.INS_CODIGO as INS, I.INS_DATA as DT, '+
      'I.INS_ILVL as ILVL, I.INS_DANO as DPS, L.LGR_NOME as LGR, '+
      'I.INS_DIFICULDADE||coalesce(I.INS_PLUS,'' '') as DIF, '+
      'C.CHF_NOME as CHF, CI.CIN_DANO as DPSCHEFE '+
      'from INSTANCIA I '+
      'left outer join LUGAR L on L.LGR_CODIGO = I.LGR_CODIGO '+
      'left outer join CHF_INSTANCIA CI on CI.INS_CODIGO = I.INS_CODIGO '+
      'left outer join CHEFE C on C.CHF_CODIGO = CI.CHF_CODIGO '+
      'where PRS_CODIGO = :PERSO ';

  cdsGrid.Close;

  with qryGrid do
  begin
    Close;
    sql.Clear;

    sFil := 'and I.INS_DATA between :DI and :DF ';

    if (spIlvlI.Value > 0) and (spIlvlF.Value > 0)  then
      sFil := sFil + 'and I.INS_ILVL between :ILVLI and :ILVLF ';

    if (edDpsI.Text <> '') and (edDpsF.Text <> '')  then
      sFil := sFil + 'and I.INS_DANO between :DPSI and :DPSF ';

    if cbxLugar.KeyValue <> null  then
      sFil := sFil + 'and I.LGR_CODIGO = :LUGAR ';

    if cbxDif.ItemIndex > -1  then
    begin
      sFil := sFil + 'and I.INS_DIFICULDADE = :DIF ';

      if cbxDif.Text = 'M+' then
        sFil := sFil + 'and I.INS_PLUS = :PLUS ';
    end;

    if cbxChefes.KeyValue <> null then
    begin
      sFil := sFil + 'and CI.CHF_CODIGO = :CHF ';

      if (edDpsCI.Text <> '') and (edDpsCF.Text <> '')  then
        sFil := sFil + 'and CI.CIN_DANO between :CDPSI and :CDPSF ';
    end;

    sOrd := 'order by I.INS_DATA DESC ';

    sql.Add(sSql+sFil+sOrd);

    //Parâmetros:

    ParamByName('PERSO').AsInteger := codPerso;
    ParamByName('DI').AsDateTime := dtI.DateTime;
    ParamByName('DF').AsDateTime := dtF.DateTime;

    if (spIlvlI.Value > 0) and (spIlvlF.Value > 0)  then
    begin
      ParamByName('ILVLI').AsInteger := spIlvlI.Value;
      ParamByName('ILVLF').AsInteger := spIlvlF.Value
    end;

    if (edDpsI.Text <> '') and (edDpsF.Text <> '')  then
    begin
      ParamByName('DPSI').AsFloat := StrToFloat(edDpsI.Text);
      ParamByName('DPSF').AsFloat := StrToFloat(edDpsF.Text);
    end;

    if cbxLugar.KeyValue <> null  then
      ParamByName('LUGAR').AsInteger := cbxLugar.KeyValue;

    if cbxDif.ItemIndex > -1  then
    begin
      ParamByName('DIF').AsString := Trim(cbxDif.Text);

      if Trim(cbxDif.Text) = 'M+' then
        ParamByName('PLUS').AsInteger := spPlus.Value;
    end;

    if cbxChefes.KeyValue <> null then
    begin
      ParamByName('CHF').AsInteger := cbxChefes.KeyValue;

      if (edDpsCI.Text <> '') and (edDpsCF.Text <> '')  then
      begin
        ParamByName('CDPSI').AsFloat := StrToFloat(edDpsCI.Text);
        ParamByName('CDPSF').AsFloat := StrToFloat(edDpsCF.Text);
      end;
    end;

    Open;
  end;

  cdsGrid.Open;

  if cdsGridINS.IsNull then
  begin
    ShowMessage('Não foram encontradas entradas correspondentes!');
    exit;
  end;

  udm.qryConfigs.Close;
  udm.qryConfigs.Open;
  pimLogo.Picture.LoadFromFile(udm.qryConfigsCNF_LOGO.AsString);  
  udm.qryConfigs.Close;
  
  plbPerso.Caption := nomePerso;

  rpGrid.Print;
end;

procedure TfrmTabInstancias.btLimparClick(Sender: TObject);
begin
  limpaCampos;
end;

procedure TfrmTabInstancias.cbxChefesClick(Sender: TObject);
begin
  if cbxChefes.KeyValue = null then
    gbDpsChefes.Enabled := FALSE
  else
    gbDpsChefes.Enabled := TRUE;
end;

procedure TfrmTabInstancias.s(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_DELETE then
    cbxChefes.KeyValue := null;
end;

procedure TfrmTabInstancias.cbxDifExit(Sender: TObject);
begin
  if cbxDif.Text = 'M+' then
  begin
    spPlus.Enabled := TRUE;
    spPlus.Visible := TRUE;
  end
  else
  begin
    spPlus.Enabled := FALSE;
    spPlus.Visible := FALSE;
  end;
end;

procedure TfrmTabInstancias.cbxDifKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_DELETE then
    cbxDif.ItemIndex := -1;
end;

procedure TfrmTabInstancias.cbxLugarExit(Sender: TObject);
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

  loadChefes;
end;

procedure TfrmTabInstancias.cbxLugarKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_DELETE then
    cbxLugar.KeyValue := null;
end;

procedure TfrmTabInstancias.edDpsCFExit(Sender: TObject);
begin
  edDpsCF.Text := SoNumero(edDpsCF.Text);

  if (edDpsI.Text <> '') and (StrToFloat(edDpsCF.Text) < 0) then
    edDpsCF.Text := '';
end;

procedure TfrmTabInstancias.edDpsCIExit(Sender: TObject);
begin
  edDpsCI.Text := SoNumero(edDpsCI.Text);

  if (edDpsI.Text <> '') and (StrToFloat(edDpsCI.Text) < 0) then
    edDpsCI.Text := '0';
end;

procedure TfrmTabInstancias.edDpsFExit(Sender: TObject);
begin
  edDpsF.Text := SoNumero(edDpsF.Text);

  if (edDpsI.Text <> '') and (StrToFloat(edDpsF.Text) < 0) then
    edDpsF.Text := '';
end;

procedure TfrmTabInstancias.edDpsIExit(Sender: TObject);
begin  
  edDpsI.Text := SoNumero(edDpsI.Text);

  if (edDpsI.Text <> '') and (StrToFloat(edDpsI.Text) < 0) then
    edDpsI.Text := '0';
end;

procedure TfrmTabInstancias.FormCreate(Sender: TObject);
begin
  loadLugar;
end;

procedure TfrmTabInstancias.FormShow(Sender: TObject);
begin
  if codPerso > 0 then
    lbPersonagem.caption := nomePerso
  else
    lbPersonagem.caption := '404 not found :(';

  mudaCores;
  limpaCampos;
end;

procedure TfrmTabInstancias.limpaCampos;
var
i : Integer;
begin
  for i := 0 to frmTabInstancias.ComponentCount-1 do
  begin
    //if frmTabInstancias.Components[i] is TDateTimePicker then
    //  TDateTimePicker(Components[i]).DateTime := null;
    dtI.DateTime := StrToDate('23/11/2014');
    dtF.DateTime := date;
    
    if frmTabInstancias.Components[i] is TSpinEdit then
      TSpinEdit(Components[i]).value := 0;

    if frmTabInstancias.Components[i] is TMaskEdit then
      TMaskEdit(Components[i]).Text := '';

    if frmTabInstancias.Components[i] is TDBLookupComboBox then
      TDBLookupComboBox(Components[i]).KeyValue := null;

    if frmTabInstancias.Components[i] is TComboBox then
      TComboBox(Components[i]).ItemIndex := -1;
  end;
end;

procedure TfrmTabInstancias.loadChefes;
begin
  qryChefe.Close;
  qryChefe.ParamByName('LUGAR').AsInteger := cbxLugar.KeyValue;
  qryChefe.Open;
  qryChefe.FetchAll;
end;

procedure TfrmTabInstancias.loadLugar;
begin
  qryLugar.Close;
  qryLugar.Open;
  qryLugar.FetchAll;
end;

procedure TfrmTabInstancias.mudaCores;
begin
  if codPerso > 0 then
  begin
    lbTitulo.Font.Color := corPerso;
    lbPersonagem.Font.Color := corPerso;
    btGerar.Font.Color := corPerso;
    btLimpar.Font.Color := corPerso;
  end
  else
  begin
    lbTitulo.Font.Color := StringToColor('$0000D200');
    lbPersonagem.Font.Color := StringToColor('$000080FF');
    btGerar.Font.Color := clBlack;
    btLimpar.Font.Color := clBlack;
  end;
end;

procedure TfrmTabInstancias.ppDetailBand1BeforePrint(Sender: TObject);
begin
//  if tag = 0 then
//  begin
//    ppShape.Brush.Color := clSilver;
//    tag := 1;
//  end
//  else
//  begin
//    ppShape.Brush.Color := clWhite;
//    tag := 0;
//  end;
//  pShape.visible := not pShape2.visible;
end;

end.
