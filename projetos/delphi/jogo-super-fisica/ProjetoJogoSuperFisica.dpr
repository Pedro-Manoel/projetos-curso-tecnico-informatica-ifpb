program ProjetoJogoSuperFisica;

uses
  Vcl.Forms,
  UnitDataPerfil in 'UnitDataPerfil.pas' {DataPerfil: TDataModule},
  UnitUtil in 'UnitUtil.pas',
  UnitMenu in 'UnitMenu.pas' {FormMenu},
  UnitNovoPerfil in 'UnitNovoPerfil.pas' {FormNovoPerfil},
  UnitLogin in 'UnitLogin.pas' {FormLogin},
  UnitJogo in 'UnitJogo.pas' {FormJogo},
  UnitGamer in 'UnitGamer.pas',
  UnitNotificacao in 'UnitNotificacao.pas' {FormNotificacao},
  UnitCredito in 'UnitCredito.pas' {FormCredito};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDataPerfil, DataPerfil);
  Application.CreateForm(TFormMenu, FormMenu);
  Application.CreateForm(TFormNovoPerfil, FormNovoPerfil);
  Application.CreateForm(TFormLogin, FormLogin);
  Application.CreateForm(TFormJogo, FormJogo);
  Application.CreateForm(TFormNotificacao, FormNotificacao);
  Application.CreateForm(TFormCredito, FormCredito);
  Application.Run;
end.
