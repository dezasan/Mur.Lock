program MurLock;



uses
  Vcl.Forms,
  CadPersonagem in 'CadPersonagem.pas' {frmCadPersonagem},
  DM in 'DM.pas' {udm: TDataModule},
  Main in 'Main.pas' {frmMain},
  unFuncoes in 'unFuncoes.pas',
  CadInstancia in 'CadInstancia.pas' {frmCadInstancia},
  TabInstancias in 'TabInstancias.pas' {frmTabInstancias},
  VerInstancias in 'VerInstancias.pas' {frmVerInstancias};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(Tudm, udm);
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmCadInstancia, frmCadInstancia);
  Application.CreateForm(TfrmTabInstancias, frmTabInstancias);
  Application.CreateForm(TfrmVerInstancias, frmVerInstancias);
  Application.Run;
end.
