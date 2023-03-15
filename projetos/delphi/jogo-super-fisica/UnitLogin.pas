unit UnitLogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, Vcl.ExtCtrls,
  Vcl.StdCtrls,Data.DB;

type
  TFormLogin = class(TForm)
    ImageTemplate: TImage;
    LabelTitulo: TLabel;
    LabelNome: TLabel;
    LabelSenha: TLabel;
    EditNome: TEdit;
    EditSenha: TEdit;
    LabelEntrar: TLabel;
    procedure LabelEntrarMouseLeave(Sender: TObject);
    procedure LabelEntrarMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure LabelEntrarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormLogin: TFormLogin;

implementation

Uses UnitUtil,UnitDataPerfil,UnitJogo,UnitNotificacao;

{$R *.dfm}

procedure TFormLogin.FormShow(Sender: TObject);
begin
FormLogin.EditNome.Clear;
FormLogin.EditSenha.Clear;
EditNome.SetFocus;
end;

procedure TFormLogin.LabelEntrarClick(Sender: TObject);
begin
  conferirPerfil(FormLogin,FormJogo);
  if FormNotificacao.LabelNotificacao.Caption = 'Senha inválida' then begin
    EditSenha.Clear;
    EditSenha.SetFocus;
  end
  else begin
    EditNome.Clear;
    EditSenha.Clear;
    EditNome.SetFocus;
  end;
end;

procedure TFormLogin.LabelEntrarMouseLeave(Sender: TObject);
begin
labelLeave(LabelEntrar);
end;

procedure TFormLogin.LabelEntrarMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
labelMove(LabelEntrar);
end;

end.
