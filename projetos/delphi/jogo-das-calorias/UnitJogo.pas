unit UnitJogo;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls;

type
  TFormJogo = class(TForm)
    LabelPergunta: TLabel;
    CircleComida1: TCircle;
    CircleComida2: TCircle;
    TextComida1_nome: TText;
    TextComida1_porcao: TText;
    TextComida1_caloria: TText;
    RoundRectComida1: TRoundRect;
    CircleSelecaoComida1: TCircle;
    TextComida2_nome: TText;
    TextComida2_porcao: TText;
    RoundRectComida2: TRoundRect;
    TextComida2_caloria: TText;
    CircleSelecaoComida2: TCircle;
    TextResultado: TText;
    SpeedButtonContinuar: TSpeedButton;
    TextLabAcertos: TText;
    TextLabErro: TText;
    TextAcertos: TText;
    TextErros: TText;
    ImageExit: TImage;
    TimerControle: TTimer;
    procedure CircleComida1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Single);
    procedure CircleComida2MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Single);
    procedure ImageExitClick(Sender: TObject);
    procedure CircleComida1MouseLeave(Sender: TObject);
    procedure CircleComida2MouseLeave(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CircleComida1Click(Sender: TObject);
    procedure CircleComida2Click(Sender: TObject);
    procedure TimerControleTimer(Sender: TObject);
    procedure SpeedButtonContinuarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormJogo: TFormJogo;
  corPadraoCircleSelecao : TAlphaColor;

implementation

Uses
        UnitGame,UnitDate;

Var
        numEscolha : Integer;

{$R *.fmx}

procedure TFormJogo.CircleComida1Click(Sender: TObject);
begin
        if escolheu = False then begin
         numEscolha := 1;
         conferirEscolha(numEscolha);
        end;
end;

procedure TFormJogo.CircleComida1MouseLeave(Sender: TObject);
begin
        esconderComida(CircleSelecaoComida1,CircleSelecaoComida2);
end;

procedure TFormJogo.CircleComida1MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Single);
begin
        MoveComida(CircleSelecaoComida1,CircleSelecaoComida2);
end;

procedure TFormJogo.CircleComida2Click(Sender: TObject);
begin
        if escolheu = False then begin
         numEscolha := 2;
         conferirEscolha(numEscolha);
        end;
end;

procedure TFormJogo.CircleComida2MouseLeave(Sender: TObject);
begin
        esconderComida(CircleSelecaoComida2,CircleSelecaoComida1);
end;

procedure TFormJogo.CircleComida2MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Single);
begin
        MoveComida(CircleSelecaoComida2,CircleSelecaoComida1);
end;

procedure TFormJogo.FormCreate(Sender: TObject);
var
        caminhoArquivoBD : string; // caminho do arquivo de banco de dados
begin

        try
          // Atribuindo caminho do banco de dados para a coneção
          caminhoArquivoBD := GetCurrentDir() + '\date\date.db';
          Date.Connection.Params.Database := caminhoArquivoBD;
          // Criando conexão com banco de dados
          Date.Connection.Connected := True;
          Date.Query.Active := True;
        except
          msgErro('O JOGO NÃO PODE SER INICIADO','Erro na conexão com o banco de dados, verifique se a pasta, "date", se encontra no mesmo local, do executável do jogo.');
          Halt(0);// Fechando jogo
        end;


        comidasTotal();// Determinando no inicio da aplicação o numero total de comidas armazenadas no banco de dados
        corPadraoCircleSelecao := CircleSelecaoComida1.Fill.Color;

end;

procedure TFormJogo.FormShow(Sender: TObject);
begin
        zerarJogo();
        criarJogo();

end;

procedure TFormJogo.ImageExitClick(Sender: TObject);
begin
        Self.Close;
end;

procedure TFormJogo.SpeedButtonContinuarClick(Sender: TObject);
begin
        criarJogo();
end;

procedure TFormJogo.TimerControleTimer(Sender: TObject);
begin
        if escolheu then begin

           if acertol then begin
             TextResultado.Text := (' Acertou ');
             TextResultado.TextSettings.FontColor := ( SpeedButtonContinuar.TextSettings.FontColor );
             CircleSelecaoComida1.Fill.Color := SpeedButtonContinuar.TextSettings.FontColor;
             CircleSelecaoComida2.Fill.Color := SpeedButtonContinuar.TextSettings.FontColor;
           end

           else begin
             TextResultado.Text := (' Errou ');
             TextResultado.TextSettings.FontColor := ( TAlphaColors.Red );
             CircleSelecaoComida1.Fill.Color := TAlphaColors.Red;
             CircleSelecaoComida2.Fill.Color := TAlphaColors.Red;
           end;

         TextResultado.Visible := True;

         FormJogo.SpeedButtonContinuar.Visible := True;
         FormJogo.SpeedButtonContinuar.Enabled := True;

         FormJogo.TextComida1_caloria.Visible := True;
         FormJogo.TextComida2_caloria.Visible := True ;


         FormJogo.RoundRectComida1.Visible := True;
         FormJogo.RoundRectComida2.Visible := True;

        end;
end;

end.
