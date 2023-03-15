unit UnitMenu;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, Vcl.ExtCtrls,
  Vcl.StdCtrls;

type
  TFormMenu = class(TForm)
    ImageTemplate: TImage;
    LabelTitulo: TLabel;
    LabelNovoPerfil: TLabel;
    LabelLogin: TLabel;
    LabelSemPerfil: TLabel;
    LabelCreditos: TLabel;
    LabelVersao: TLabel;
    procedure LabelNovoPerfilClick(Sender: TObject);
    procedure LabelLoginClick(Sender: TObject);
    procedure LabelNovoPerfilMouseLeave(Sender: TObject);
    procedure LabelNovoPerfilMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure LabelLoginMouseLeave(Sender: TObject);
    procedure LabelLoginMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure LabelSemPerfilMouseLeave(Sender: TObject);
    procedure LabelSemPerfilMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure LabelCreditosMouseLeave(Sender: TObject);
    procedure LabelCreditosMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure LabelSemPerfilClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure LabelCreditosClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormMenu: TFormMenu;

implementation

Uses UnitLogin,UnitUtil,UnitNovoPerfil,UnitDataPerfil,UnitJogo,UnitGamer,UnitNotificacao,UnitCredito;


{$R *.dfm}

procedure TFormMenu.FormCreate(Sender: TObject);
var
        caminhoArquivoBD : string;
begin

        try
          // Atribuindo caminho do banco de dados para a coneção
          caminhoArquivoBD := GetCurrentDir() + '\date\date.db';
          DataPerfil.Connection.Params.Database := caminhoArquivoBD;
          // Criando conexão com banco de dados
          DataPerfil.Connection.Connected := True;
          DataPerfil.Query.Active := True;
        except
          Application.MessageBox('Erro na conexão com o banco de dados, verifique se a pasta, "date", se encontra no mesmo local, do executável do jogo.',O JOGO NÃO PODE SER INICIADO')
          //Application.me
          //msgErro('O JOGO NÃO PODE SER INICIADO','Erro na conexão com o banco de dados, verifique se a pasta, "date", se encontra no mesmo local, do executável do jogo.');
          Halt(0);// Fechando jogo
        end;

        buttonLoginConfere();
end;

procedure TFormMenu.LabelCreditosClick(Sender: TObject);
begin
mudarForm(FormMenu,FormCredito);
end;

procedure TFormMenu.LabelCreditosMouseLeave(Sender: TObject);
begin
labelLeave(LabelCreditos);
end;

procedure TFormMenu.LabelCreditosMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
labelMove(LabelCreditos);
end;

procedure TFormMenu.LabelLoginClick(Sender: TObject);
begin
formInvisivel(FormLogin,False);
FormLogin.close;
mudarForm(FormMenu,FormLogin);
end;

procedure TFormMenu.LabelLoginMouseLeave(Sender: TObject);
begin
labelLeave(LabelLogin);
end;

procedure TFormMenu.LabelLoginMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
labelMove(LabelLogin);
end;

procedure TFormMenu.LabelNovoPerfilClick(Sender: TObject);
begin
    mudarForm(FormMenu,FormNovoPerfil);
end;

procedure TFormMenu.LabelNovoPerfilMouseLeave(Sender: TObject);
begin
labelLeave(LabelNovoPerfil);
end;

procedure TFormMenu.LabelNovoPerfilMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
labelMove(LabelNovoPerfil);
end;

procedure TFormMenu.LabelSemPerfilClick(Sender: TObject);
begin
limparJogoPerfil();
terminarJogo;
resultNotificacaoGame(True);
FormNotificacao.Close;
mudarForm(FormMenu,FormJogo);
end;

procedure TFormMenu.LabelSemPerfilMouseLeave(Sender: TObject);
begin
labelLeave(LabelSemPerfil);
end;

procedure TFormMenu.LabelSemPerfilMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
labelMove(LabelSemPerfil);
end;

end.
