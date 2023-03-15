unit UnitNotificacao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, Vcl.ExtCtrls,
  Vcl.StdCtrls;

  Procedure resultNotificacaoGame(parametro:boolean);

type
  TFormNotificacao = class(TForm)
    ImageTemplate: TImage;
    LabelNotificacao: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormNotificacao: TFormNotificacao;

implementation

Uses UnitUtil,UnitGamer;

Var
  notificacaoGameClose:boolean;//se a notificação solicitada é do form, se for executar o criar jogo no form close;



{$R *.dfm}

procedure TFormNotificacao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if notificacaoGameClose = True then begin
    criarJogo;
    notificacaoGameClose:= False;
  end;
LabelNotificacao.Font.Color:=clWhite;
end;

procedure TFormNotificacao.FormKeyPress(Sender: TObject; var Key: Char);
begin
if key = #13 then
  Close;
end;

Procedure resultNotificacaoGame(parametro:boolean);
begin
  if parametro = True then
    notificacaoGameClose:= True
  else
    notificacaoGameClose:= False
end;

end.
