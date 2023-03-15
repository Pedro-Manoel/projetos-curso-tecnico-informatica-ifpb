program ProjetoJogoDasCalorias;

uses
  System.StartUpCopy,
  FMX.Forms,
  UnitMenu in 'UnitMenu.pas' {FormMenu},
  UnitUtil in 'UnitUtil.pas',
  UnitJogo in 'UnitJogo.pas' {FormJogo},
  UnitGame in 'UnitGame.pas',
  UnitDate in 'UnitDate.pas' {Date: TDataModule},
  UnitCredito in 'UnitCredito.pas' {FormCredito},
  UnitMensage in 'UnitMensage.pas' {FormMensage};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TDate, Date);
  Application.CreateForm(TFormMenu, FormMenu);
  Application.CreateForm(TFormMensage, FormMensage);
  Application.CreateForm(TFormJogo, FormJogo);
  Application.CreateForm(TFormCredito, FormCredito);
  Application.Run;
end.
