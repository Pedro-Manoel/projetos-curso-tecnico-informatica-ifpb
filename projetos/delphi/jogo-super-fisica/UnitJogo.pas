unit UnitJogo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, Vcl.ExtCtrls,
  System.ImageList, Vcl.ImgList, Vcl.StdCtrls;

type
  TFormJogo = class(TForm)
    ImageTemplate: TImage;
    ImageJogo: TImage;
    ImageList_Torricelli: TImageList;
    ImageJogador: TImage;
    movimentoDoPersonagem: TTimer;
    ImageList_Forca: TImageList;
    ImageList_Velocidade: TImageList;
    ImageList_Deslocamento: TImageList;
    ImageList_Distancia: TImageList;
    ImageList_Vm: TImageList;
    ImageList_Aceleracao: TImageList;
    Img1: TImage;
    Img2: TImage;
    Img3: TImage;
    Img4: TImage;
    Img5: TImage;
    Img6: TImage;
    Img7: TImage;
    Img8: TImage;
    Img9: TImage;
    Img10: TImage;
    PanelImagensFormulas: TPanel;
    for1: TImage;
    for2: TImage;
    for3: TImage;
    for4: TImage;
    for5: TImage;
    for6: TImage;
    for7: TImage;
    for8: TImage;
    for9: TImage;
    for10: TImage;
    Img2_2: TImage;
    Img3_3: TImage;
    Img4_4: TImage;
    Img5_5: TImage;
    Img6_6: TImage;
    Img7_7: TImage;
    Img8_8: TImage;
    Img9_9: TImage;
    Img10_10: TImage;
    img1_1: TImage;
    ImageList_Torricelli_For: TImageList;
    ImageList_Forca_For: TImageList;
    ImageList_Velocidade_For: TImageList;
    ImageList_Vm_For: TImageList;
    ImageList_Distancia_For: TImageList;
    ImageList_Deslocamento_For: TImageList;
    ImageList_Aceleracao_For: TImageList;
    ImageListComponentes: TImageList;
    controleDoJogo: TTimer;
    LabelTituloPontuacao: TLabel;
    LabelPontuacao: TLabel;
    ImageAux: TImage;
    LabelFormula: TLabel;
    movimentoDasImagens: TTimer;
    ImageVida1: TImage;
    ImageVida2: TImage;
    ImageVida3: TImage;
    LabelNomePerfil: TLabel;
    PanelAux: TPanel;
    LabelTituloFormula: TLabel;
    LabelApagarPerfil: TLabel;
    procedure movimentoDoPersonagemTimer(Sender: TObject);
    procedure controleDoJogoTimer(Sender: TObject);
    procedure movimentoDasImagensTimer(Sender: TObject);
    procedure LabelApagarPerfilMouseLeave(Sender: TObject);
    procedure LabelApagarPerfilMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure LabelApagarPerfilClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormJogo: TFormJogo;

implementation

{$R *.dfm}

Uses UnitGamer,UnitUtil, UnitDataPerfil;

procedure TFormJogo.controleDoJogoTimer(Sender: TObject);
begin
controlerGamer(ImageJogador);
controleVida();
mostrarPontuacao();
terminarJogo();
end;

procedure TFormJogo.LabelApagarPerfilClick(Sender: TObject);
begin
apagarPerfil();
end;

procedure TFormJogo.LabelApagarPerfilMouseLeave(Sender: TObject);
begin
labelLeave(LabelApagarPerfil);
end;

procedure TFormJogo.LabelApagarPerfilMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
labelMove(LabelApagarPerfil);
end;

procedure TFormJogo.movimentoDoPersonagemTimer(Sender: TObject);
begin
movimentarPersonagem(ImageJogador,imageJogo);
end;

procedure TFormJogo.movimentoDasImagensTimer(Sender: TObject);
begin
movimentarImagem();
end;

end.
