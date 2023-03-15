unit UnitNovoPerfil;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls,Data.DB;

type
  TFormNovoPerfil = class(TForm)
    ImageTemplate: TImage;
    LabelNome: TLabel;
    LabelSenha: TLabel;
    LabelTitulo: TLabel;
    LabelSalvar: TLabel;
    EditNome: TEdit;
    EditSenha: TEdit;
    procedure LabelSalvarMouseLeave(Sender: TObject);
    procedure LabelSalvarMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure LabelSalvarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormNovoPerfil: TFormNovoPerfil;

implementation

Uses UnitDataPerfil,UnitUtil,UnitMenu,UnitJogo,UnitGamer;

{$R *.dfm}


procedure TFormNovoPerfil.FormShow(Sender: TObject);
begin
        EditNome.Text := '';
        EditSenha.Text := '';
        EditNome.SetFocus;

end;

procedure TFormNovoPerfil.LabelSalvarClick(Sender: TObject);
begin

  if (EditNome.Text=('')) or (EditSenha.Text=(''))then begin
    Notificacao('Preencha todos os campos');
  end

  else begin

   try
        DataPerfil.Query.SQL.Clear;
        DataPerfil.Query.SQL.Add('insert into perfil(nome,senha) values(:nome, :senha)');
        DataPerfil.Query.ParamByName('nome').AsString := EditNome.Text;
        DataPerfil.Query.ParamByName('senha').AsString := EditSenha.Text;
        DataPerfil.Query.ExecSQL;

        Close;

        usuario_nome := EditNome.Text;;
        usuario_senha := EditSenha.Text;;
        usuario_pontuacao := 0;

        criarJogoPerfil;
        FormJogo.ShowModal;



   except
        Notificacao('Já existe um perfil com este nome');

   end;
  end;
end;

procedure TFormNovoPerfil.LabelSalvarMouseLeave(Sender: TObject);
begin
labelLeave(LabelSalvar);
end;

procedure TFormNovoPerfil.LabelSalvarMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
labelMove(LabelSalvar);
end;

end.
