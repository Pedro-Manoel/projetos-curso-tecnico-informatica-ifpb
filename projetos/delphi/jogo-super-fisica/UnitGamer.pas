unit UnitGamer;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, Vcl.ExtCtrls,
  Vcl.StdCtrls,Data.DB;

Procedure movimentarPersonagem(personagem,campoDeMovimento:TImage);//Vai movimentar a imagen pelas teclas de movimento do teclado com os limetes
Procedure criarJogo();
Procedure controlerGamer(per:TImage);
Procedure terminarJogo();
procedure movimentarImagem();
procedure controleVida();
Procedure mostrarPontuacao();
Procedure criarJogoPerfil();
Procedure limparJogoPerfil();
Procedure apagarPerfil();

implementation

Uses UnitJogo,UnitUtil,UnitDataPerfil;

Type
  vetor = array [0..7]of integer;
  vetorTImage = array [1..10,1..3]of TImage;

Var
  formulaEscolhida:integer;//armazer o numero da formula escolhida
  vetorImagem:vetorTImage;
  fimDeJogo:boolean;
  imgVerificada:array [1..10]of Boolean;//Para saber quias imagen já foram verificadas
  vetorEscolhas:array [1..10]of integer;//Para verificar os acertos e atribuar a pontuação
  l2:integer;
  pontuacao:integer;//Pontuação do jogador
  acertos:integer;//Quantas posições de formulas foram acertadas
  acertolFormula:boolean;//Vai armazenar TRUE se tiver acerto a formula completa ou armazenar FALSE se tiver errado pelomenos uma posição
  nomeFormula:array [1..7]of string;//Vetor que vai armazenar o nome cada formula usada na aplicação
  vidas:integer;
  auxVidas:integer;
  morreu:boolean;
  jogoPerfil:boolean;

Const
  velocidadePersonagem=12;//velocidade que o pernonagem ira se movimentar para todos os lados
  vk_a=65;// Tecla A
  vk_d=68;// Tecla D
  vk_w=87;// Tecla W
  vk_s=83;// Tecla S

Procedure mostrarPontuacao();
begin
  FormJogo.LabelPontuacao.Caption:=IntToStr(usuario_pontuacao);//  onde sera mostrada a pontuação
  if usuario_pontuacao >= 0 then
    FormJogo.LabelPontuacao.Font.Color:=($0094FF28)
  else
    FormJogo.LabelPontuacao.Font.Color:=($005959FF);
end;

procedure preencherVetor;
 var
  i:integer;
 begin
 vetorImagem[1,1]:=(FormJogo.for1);
 vetorImagem[1,2]:=(FormJogo.img1);
 vetorImagem[1,3]:=(FormJogo.img1_1);

 vetorImagem[2,1]:=(FormJogo.for2);
 vetorImagem[2,2]:=(FormJogo.img2);
 vetorImagem[2,3]:=(FormJogo.img2_2);

 vetorImagem[3,1]:=(FormJogo.for3);
 vetorImagem[3,2]:=(FormJogo.img3);
 vetorImagem[3,3]:=(FormJogo.img3_3);

 vetorImagem[4,1]:=(FormJogo.for4);
 vetorImagem[4,2]:=(FormJogo.img4);
 vetorImagem[4,3]:=(FormJogo.img4_4);

 vetorImagem[5,1]:=(FormJogo.for5);
 vetorImagem[5,2]:=(FormJogo.img5);
 vetorImagem[5,3]:=(FormJogo.img5_5);

 vetorImagem[6,1]:=(FormJogo.for6);
 vetorImagem[6,2]:=(FormJogo.img6);
 vetorImagem[6,3]:=(FormJogo.img6_6);

 vetorImagem[7,1]:=(FormJogo.for7);
 vetorImagem[7,2]:=(FormJogo.img7);
 vetorImagem[7,3]:=(FormJogo.img7_7);

 vetorImagem[8,1]:=(FormJogo.for8);
 vetorImagem[8,2]:=(FormJogo.img8);
 vetorImagem[8,3]:=(FormJogo.img8_8);

 vetorImagem[9,1]:=(FormJogo.for9);
 vetorImagem[9,2]:=(FormJogo.img9);
 vetorImagem[9,3]:=(FormJogo.img9_9);

 vetorImagem[10,1]:=(FormJogo.for10);
 vetorImagem[10,2]:=(FormJogo.img10);
 vetorImagem[10,3]:=(FormJogo.img10_10);


 nomeFormula[1]:=('de Torricelli');
 nomeFormula[2]:=('da Força');
 nomeFormula[3]:=('da Velocidade');
 nomeFormula[4]:=('da Velocidade Média');
 nomeFormula[5]:=('da Distancia');
 nomeFormula[6]:=('do Deslocamento');
 nomeFormula[7]:=('da Aceleração');



end;

Procedure movimentarPersonagem(personagem,campoDeMovimento:TImage);
begin
if fimDeJogo=False then begin
  if (personagem.Left > -8) then//PARA TRAIS
    if (getkeystate(vk_left)<0) or (GetKeyState(vk_a)<0) then begin
      personagem.Left:=personagem.Left-velocidadePersonagem;
    end;

if (campoDeMovimento.Width- personagem.Left >= 83 ) then//PARA FRENTE
   if (getkeystate(vk_Right)<0) or (GetKeyState(vk_d)<0)  then begin
    personagem.Left:=personagem.Left+velocidadePersonagem;
   end;

if (personagem.Top > 0) then//PARA CIMA
  if (getkeystate(vk_up)<0) or (GetKeyState(vk_w)<0) then begin
    personagem.Top:=personagem.top-velocidadePersonagem;
  end;

if (campoDeMovimento.Height- personagem.top >= 88) then//PARA BAIXO
  if (getkeystate(vk_down)<0) or (GetKeyState(vk_s)<0) then begin
    personagem.top:=personagem.top+velocidadePersonagem;
  end;
end
end;

Procedure misturarImagens(repeticao:integer);
 var
  i:integer;
begin
  for i := 1 to repeticao do
    movimentarImagem();
end;

Function bateu(obj1:TImage; obj2:TImage): boolean;//verifica se duas imagens passadas como parametros colidiram
 begin
  Result := true;
   if (obj1.Left+69<obj2.Left) or
    (obj1.Left>69+obj2.Left) or
    (obj1.Top+53<obj2.Top) or
    (obj1.Top>obj2.Top+53) then
    Result := false;
   end;

Procedure verificarEscolha(var num1:integer; num2,rand:integer);
 begin
 randomize;
    if ((num1=num2) or(num1=0)) then begin
      num1:=Random(rand);
      verificarEscolha(num1,num2,rand);
   end
 end;

Procedure criarJogo();
var
  i,aux:integer;
begin
  Randomize;
  preencherVetor;
  aux:=(formulaEscolhida);
  formulaEscolhida:=(Random(8));
  verificarEscolha(formulaEscolhida,aux,8);

  FormJogo.LabelFormula.Caption:=(nomeFormula[formulaEscolhida]);

  for i:= 1 to 10 do
    vetorImagem[i,2].Picture:=FormJogo.imageAux.Picture;

  if jogoPerfil = True then begin
    FormJogo.LabelApagarPerfil.Font.Style := [];
    FormJogo.LabelApagarPerfil.Enabled:=(True);
  end;

  misturarImagens(10);

  if (formulaEscolhida = 1)then begin
    FormJogo.ImageList_Torricelli.GetBitmap(0,FormJogo.img1.Picture.Bitmap);
    FormJogo.ImageList_Torricelli.GetBitmap(1,FormJogo.img2.Picture.Bitmap);
    FormJogo.ImageList_Torricelli.GetBitmap(2,FormJogo.img3.Picture.Bitmap);
    FormJogo.ImageList_Torricelli.GetBitmap(3,FormJogo.img4.Picture.Bitmap);
    FormJogo.ImageList_Torricelli.GetBitmap(4,FormJogo.img5.Picture.Bitmap);
    FormJogo.ImageList_Torricelli.GetBitmap(5,FormJogo.img6.Picture.Bitmap);
    FormJogo.ImageList_Torricelli.GetBitmap(6,FormJogo.img7.Picture.Bitmap);
    FormJogo.ImageList_Torricelli.GetBitmap(7,FormJogo.img8.Picture.Bitmap);
    FormJogo.ImageList_Torricelli.GetBitmap(8,FormJogo.img9.Picture.Bitmap);

    FormJogo.ImageListComponentes.GetBitmap(0,FormJogo.img10.Picture.Bitmap);

    FormJogo.ImageList_Torricelli_For.GetBitmap(0,FormJogo.img1_1.Picture.Bitmap);
    FormJogo.ImageList_Torricelli_For.GetBitmap(1,FormJogo.img2_2.Picture.Bitmap);
    FormJogo.ImageList_Torricelli_For.GetBitmap(2,FormJogo.img3_3.Picture.Bitmap);
    FormJogo.ImageList_Torricelli_For.GetBitmap(3,FormJogo.img4_4.Picture.Bitmap);
    FormJogo.ImageList_Torricelli_For.GetBitmap(4,FormJogo.img5_5.Picture.Bitmap);
    FormJogo.ImageList_Torricelli_For.GetBitmap(5,FormJogo.img6_6.Picture.Bitmap);
    FormJogo.ImageList_Torricelli_For.GetBitmap(6,FormJogo.img7_7.Picture.Bitmap);
    FormJogo.ImageList_Torricelli_For.GetBitmap(7,FormJogo.img8_8.Picture.Bitmap);
    FormJogo.ImageList_Torricelli_For.GetBitmap(8,FormJogo.img9_9.Picture.Bitmap);
  end

  else if (formulaEscolhida = 2)then begin
    FormJogo.ImageList_Forca.GetBitmap(0,FormJogo.img1.Picture.Bitmap);
    FormJogo.ImageList_Forca.GetBitmap(1,FormJogo.img2.Picture.Bitmap);
    FormJogo.ImageList_Forca.GetBitmap(2,FormJogo.img3.Picture.Bitmap);
    FormJogo.ImageList_Forca.GetBitmap(3,FormJogo.img4.Picture.Bitmap);
    FormJogo.ImageList_Forca.GetBitmap(4,FormJogo.img5.Picture.Bitmap);

    FormJogo.ImageListComponentes.GetBitmap(0,FormJogo.img6.Picture.Bitmap);
    FormJogo.ImageListComponentes.GetBitmap(0,FormJogo.img7.Picture.Bitmap);
    FormJogo.ImageListComponentes.GetBitmap(0,FormJogo.img8.Picture.Bitmap);
    FormJogo.ImageListComponentes.GetBitmap(0,FormJogo.img9.Picture.Bitmap);
    FormJogo.ImageListComponentes.GetBitmap(0,FormJogo.img10.Picture.Bitmap);

    FormJogo.ImageList_Forca_For.GetBitmap(0,FormJogo.img1_1.Picture.Bitmap);
    FormJogo.ImageList_Forca_For.GetBitmap(1,FormJogo.img2_2.Picture.Bitmap);
    FormJogo.ImageList_Forca_For.GetBitmap(2,FormJogo.img3_3.Picture.Bitmap);
    FormJogo.ImageList_Forca_For.GetBitmap(3,FormJogo.img4_4.Picture.Bitmap);
    FormJogo.ImageList_Forca_For.GetBitmap(4,FormJogo.img5_5.Picture.Bitmap);
  end

  else if (formulaEscolhida = 3)then begin
    FormJogo.ImageList_Velocidade.GetBitmap(0,FormJogo.img1.Picture.Bitmap);
    FormJogo.ImageList_Velocidade.GetBitmap(1,FormJogo.img2.Picture.Bitmap);
    FormJogo.ImageList_Velocidade.GetBitmap(2,FormJogo.img3.Picture.Bitmap);
    FormJogo.ImageList_Velocidade.GetBitmap(3,FormJogo.img4.Picture.Bitmap);
    FormJogo.ImageList_Velocidade.GetBitmap(4,FormJogo.img5.Picture.Bitmap);
    FormJogo.ImageList_Velocidade.GetBitmap(5,FormJogo.img6.Picture.Bitmap);
    FormJogo.ImageList_Velocidade.GetBitmap(6,FormJogo.img7.Picture.Bitmap);

    FormJogo.ImageListComponentes.GetBitmap(0,FormJogo.img8.Picture.Bitmap);
    FormJogo.ImageListComponentes.GetBitmap(0,FormJogo.img9.Picture.Bitmap);
    FormJogo.ImageListComponentes.GetBitmap(0,FormJogo.img10.Picture.Bitmap);

    FormJogo.ImageList_Velocidade_For.GetBitmap(0,FormJogo.img1_1.Picture.Bitmap);
    FormJogo.ImageList_Velocidade_For.GetBitmap(1,FormJogo.img2_2.Picture.Bitmap);
    FormJogo.ImageList_Velocidade_For.GetBitmap(2,FormJogo.img3_3.Picture.Bitmap);
    FormJogo.ImageList_Velocidade_For.GetBitmap(3,FormJogo.img4_4.Picture.Bitmap);
    FormJogo.ImageList_Velocidade_For.GetBitmap(4,FormJogo.img5_5.Picture.Bitmap);
    FormJogo.ImageList_Velocidade_For.GetBitmap(5,FormJogo.img6_6.Picture.Bitmap);
    FormJogo.ImageList_Velocidade_For.GetBitmap(6,FormJogo.img7_7.Picture.Bitmap);

  end

  else if (formulaEscolhida = 4)then begin
    FormJogo.ImageList_vm.GetBitmap(0,FormJogo.img1.Picture.Bitmap);
    FormJogo.imageList_vm.GetBitmap(1,FormJogo.img2.Picture.Bitmap);
    FormJogo.imageList_vm.GetBitmap(2,FormJogo.img3.Picture.Bitmap);
    FormJogo.imageList_vm.GetBitmap(3,FormJogo.img4.Picture.Bitmap);
    FormJogo.imageList_vm.GetBitmap(4,FormJogo.img5.Picture.Bitmap);

    FormJogo.ImageListComponentes.GetBitmap(0,FormJogo.img6.Picture.Bitmap);
    FormJogo.ImageListComponentes.GetBitmap(0,FormJogo.img7.Picture.Bitmap);
    FormJogo.ImageListComponentes.GetBitmap(0,FormJogo.img8.Picture.Bitmap);
    FormJogo.ImageListComponentes.GetBitmap(0,FormJogo.img9.Picture.Bitmap);
    FormJogo.ImageListComponentes.GetBitmap(0,FormJogo.img10.Picture.Bitmap);

    FormJogo.imageList_vm_for.GetBitmap(0,FormJogo.img1_1.Picture.Bitmap);
    FormJogo.imageList_vm_for.GetBitmap(1,FormJogo.img2_2.Picture.Bitmap);
    FormJogo.imageList_vm_for.GetBitmap(2,FormJogo.img3_3.Picture.Bitmap);
    FormJogo.imageList_vm_for.GetBitmap(3,FormJogo.img4_4.Picture.Bitmap);
    FormJogo.imageList_vm_for.GetBitmap(4,FormJogo.img5_5.Picture.Bitmap);

  end

  else if (formulaEscolhida = 5)then begin
    FormJogo.imageList_distancia.GetBitmap(0,FormJogo.img1.Picture.Bitmap);
    FormJogo.imageList_distancia.GetBitmap(1,FormJogo.img2.Picture.Bitmap);
    FormJogo.imageList_distancia.GetBitmap(2,FormJogo.img3.Picture.Bitmap);
    FormJogo.imageList_distancia.GetBitmap(3,FormJogo.img4.Picture.Bitmap);
    FormJogo.imageList_distancia.GetBitmap(4,FormJogo.img5.Picture.Bitmap);
    FormJogo.imageList_distancia.GetBitmap(5,FormJogo.img6.Picture.Bitmap);
    FormJogo.imageList_distancia.GetBitmap(6,FormJogo.img7.Picture.Bitmap);
    FormJogo.imageList_distancia.GetBitmap(7,FormJogo.img8.Picture.Bitmap);
    FormJogo.imageList_distancia.GetBitmap(8,FormJogo.img9.Picture.Bitmap);

    FormJogo.ImageListComponentes.GetBitmap(0,FormJogo.img10.Picture.Bitmap);

    FormJogo.imageList_distancia_for.GetBitmap(0,FormJogo.img1_1.Picture.Bitmap);
    FormJogo.imageList_distancia_for.GetBitmap(1,FormJogo.img2_2.Picture.Bitmap);
    FormJogo.imageList_distancia_for.GetBitmap(2,FormJogo.img3_3.Picture.Bitmap);
    FormJogo.imageList_distancia_for.GetBitmap(3,FormJogo.img4_4.Picture.Bitmap);
    FormJogo.imageList_distancia_for.GetBitmap(4,FormJogo.img5_5.Picture.Bitmap);
    FormJogo.imageList_distancia_for.GetBitmap(5,FormJogo.img6_6.Picture.Bitmap);
    FormJogo.imageList_distancia_for.GetBitmap(6,FormJogo.img7_7.Picture.Bitmap);
    FormJogo.imageList_distancia_for.GetBitmap(7,FormJogo.img8_8.Picture.Bitmap);
    FormJogo.imageList_distancia_for.GetBitmap(8,FormJogo.img9_9.Picture.Bitmap);

  end

  else if (formulaEscolhida = 6)then begin
    FormJogo.imageList_deslocamento.GetBitmap(0,FormJogo.img1.Picture.Bitmap);
    FormJogo.imageList_deslocamento.GetBitmap(1,FormJogo.img2.Picture.Bitmap);
    FormJogo.imageList_deslocamento.GetBitmap(2,FormJogo.img3.Picture.Bitmap);
    FormJogo.imageList_deslocamento.GetBitmap(3,FormJogo.img4.Picture.Bitmap);
    FormJogo.imageList_deslocamento.GetBitmap(4,FormJogo.img5.Picture.Bitmap);
    FormJogo.imageList_deslocamento.GetBitmap(5,FormJogo.img6.Picture.Bitmap);
    FormJogo.imageList_deslocamento.GetBitmap(6,FormJogo.img7.Picture.Bitmap);

    FormJogo.ImageListComponentes.GetBitmap(0,FormJogo.img8.Picture.Bitmap);
    FormJogo.ImageListComponentes.GetBitmap(0,FormJogo.img9.Picture.Bitmap);
    FormJogo.ImageListComponentes.GetBitmap(0,FormJogo.img10.Picture.Bitmap);

    FormJogo.imageList_deslocamento_for.GetBitmap(0,FormJogo.img1_1.Picture.Bitmap);
    FormJogo.imageList_deslocamento_for.GetBitmap(1,FormJogo.img2_2.Picture.Bitmap);
    FormJogo.imageList_deslocamento_for.GetBitmap(2,FormJogo.img3_3.Picture.Bitmap);
    FormJogo.imageList_deslocamento_for.GetBitmap(3,FormJogo.img4_4.Picture.Bitmap);
    FormJogo.imageList_deslocamento_for.GetBitmap(4,FormJogo.img5_5.Picture.Bitmap);
    FormJogo.imageList_deslocamento_for.GetBitmap(5,FormJogo.img6_6.Picture.Bitmap);
    FormJogo.imageList_deslocamento_for.GetBitmap(6,FormJogo.img7_7.Picture.Bitmap);

  end

  else if (formulaEscolhida = 7)then begin
    FormJogo.imageList_aceleracao.GetBitmap(0,FormJogo.img1.Picture.Bitmap);
    FormJogo.imageList_aceleracao.GetBitmap(1,FormJogo.img2.Picture.Bitmap);
    FormJogo.imageList_aceleracao.GetBitmap(2,FormJogo.img3.Picture.Bitmap);
    FormJogo.imageList_aceleracao.GetBitmap(3,FormJogo.img4.Picture.Bitmap);
    FormJogo.imageList_aceleracao.GetBitmap(4,FormJogo.img5.Picture.Bitmap);

    FormJogo.ImageListComponentes.GetBitmap(0,FormJogo.img6.Picture.Bitmap);
    FormJogo.ImageListComponentes.GetBitmap(0,FormJogo.img7.Picture.Bitmap);
    FormJogo.ImageListComponentes.GetBitmap(0,FormJogo.img8.Picture.Bitmap);
    FormJogo.ImageListComponentes.GetBitmap(0,FormJogo.img9.Picture.Bitmap);
    FormJogo.ImageListComponentes.GetBitmap(0,FormJogo.img10.Picture.Bitmap);

    FormJogo.imageList_aceleracao_for.GetBitmap(0,FormJogo.img1_1.Picture.Bitmap);
    FormJogo.imageList_aceleracao_for.GetBitmap(1,FormJogo.img2_2.Picture.Bitmap);
    FormJogo.imageList_aceleracao_for.GetBitmap(2,FormJogo.img3_3.Picture.Bitmap);
    FormJogo.imageList_aceleracao_for.GetBitmap(3,FormJogo.img4_4.Picture.Bitmap);
    FormJogo.imageList_aceleracao_for.GetBitmap(4,FormJogo.img5_5.Picture.Bitmap);
  end;

   FormJogo.ImageVida1.Visible:=True;
   FormJogo.ImageVida2.Visible:=True;
   FormJogo.ImageVida3.Visible:=True;


   FormJogo.ImageListComponentes.GetBitmap(1,FormJogo.ImageVida1.Picture.Bitmap);
   FormJogo.ImageListComponentes.GetBitmap(1,FormJogo.ImageVida2.Picture.Bitmap);
   FormJogo.ImageListComponentes.GetBitmap(1,FormJogo.ImageVida3.Picture.Bitmap);


for i:= 1 to 10 do //preenchendo o vetor com false
 imgVerificada[i]:=(False);

 if (fimDeJogo = True) or (morreu = False) then begin
   for i:= 1 to 10 do begin
    vetorImagem[i,2].Visible:=True;
    vetorImagem[i,2].Enabled:=False;
    vetorImagem[i,1].Picture:=FormJogo.imageAux.Picture;
    vidas:=3;
    auxVidas:=0;
   end;
   fimDeJogo:=False;
   l2:=0;
 end;

 FormJogo.ImageJogador.Left:=372;
 FormJogo.ImageJogador.top:=205;

 FormJogo.controleDoJogo.Enabled:=True;
 FormJogo.movimentoDasImagens.Enabled:=True;
 FormJogo.movimentoDoPersonagem.Enabled:=True;

end;


procedure verificarAcertos;
  var
   i:integer;
begin

  if formulaEscolhida=1 then begin
    for i:= 1 to 9 do begin
      if (vetorEscolhas[i]=(i)) then begin
        usuario_pontuacao:= usuario_pontuacao+2;
        acertos:=acertos+1;
      end
      else begin
        usuario_pontuacao:= usuario_pontuacao-3;
        acertolFormula:=False;
      end;
    if((vetorEscolhas[6]=8)and(vetorEscolhas[8]=6)) and (acertos=7) then
      acertos:=9;
    end;
    if acertos=9 then
      acertolFormula:=True;
  end;

  if formulaEscolhida=2 then begin
   for i:= 1 to 5 do begin
    if (vetorEscolhas[i]=(i)) then begin
      usuario_pontuacao:= usuario_pontuacao+2;
      acertos:=acertos+1;
    end
    else begin
      usuario_pontuacao:= usuario_pontuacao-3;
      acertolFormula:=False;
    end;
  end;
  if acertos=5 then
    acertolFormula:=True;
  end;

  if formulaEscolhida=3 then begin
   for i:= 1 to 7 do  begin
    if (vetorEscolhas[i]=(i)) then begin
      usuario_pontuacao:= usuario_pontuacao+2;
      acertos:=acertos+1;
    end
    else begin
      usuario_pontuacao:= usuario_pontuacao-3;
      acertolFormula:=False;
    end;
  end;
  if acertos=7 then
   acertolFormula:=True;
  end;

  if formulaEscolhida=4 then begin
   for i:= 1 to 5 do  begin
    if (vetorEscolhas[i]=(i)) then begin
      usuario_pontuacao:= usuario_pontuacao+2;
      acertos:=acertos+1;
    end
    else begin
      usuario_pontuacao:= usuario_pontuacao-3;
      acertolFormula:=False;
    end;
  end;
  if acertos=5 then
   acertolFormula:=True;
  end;

  if formulaEscolhida=5 then begin
   for i:= 1 to 9 do  begin
    if (vetorEscolhas[i]=(i)) then begin
      usuario_pontuacao:= usuario_pontuacao+2;
      acertos:=acertos+1;
    end
    else begin
      usuario_pontuacao:= usuario_pontuacao-3;
      acertolFormula:=False;
    end;
   if((vetorEscolhas[4]=8)and(vetorEscolhas[8]=4)) and (acertos=7) then
    acertos:=9;
   end;
   if acertos=9 then
    acertolFormula:=True;
  end;

  if formulaEscolhida=6 then begin
   for i:= 1 to 7 do  begin
    if (vetorEscolhas[i]=(i)) then begin
      usuario_pontuacao:= usuario_pontuacao+2;
      acertos:=acertos+1;
    end
    else begin
      usuario_pontuacao:= usuario_pontuacao-3;
      acertolFormula:=False;
    end;
  end;
  if acertos=7 then
    acertolFormula:=True;
  end;

  if formulaEscolhida=7 then begin
   for i:= 1 to 5 do  begin
    if (vetorEscolhas[i]=(i)) then begin
      usuario_pontuacao:= usuario_pontuacao+2;
      acertos:=acertos+1;
    end
    else begin
      usuario_pontuacao:= usuario_pontuacao-3;
      acertolFormula:=False;
    end;
  end;
  if acertos=5 Then
   acertolFormula:=True;
  end;
  mostrarPontuacao();
end;

Procedure atribuirImagem(var img:vetorTImage; imgAux:TImage; limit:Integer);
 var
   i:integer;
begin
  if l2 < limit then begin
    fimDeJogo:=False;
    for i:= 1 to limit do begin
      if bateu(imgAux,img[i,2])and (imgVerificada[i]=(False))then begin
        l2:=l2+1;
        vetorEscolhas[l2]:=(i);
        img[l2,1].Picture:=(img[i,3].Picture);
        img[i,2].Visible:=(False);
        img[i,2].Enabled:=(True);
        imgVerificada[i]:=(True);
      end;
    end;
  end

  else begin
   fimDeJogo:=True;
   verificarAcertos;
  end;
end;

Procedure controlerGamer(per:TImage);
begin
  if fimDeJogo = False then begin
    if formulaEscolhida = 1 then begin
      atribuirImagem(vetorImagem,per,9);
    end
    else if formulaEscolhida = 2 then begin
      atribuirImagem(vetorImagem,per,5);
    end
    else if formulaEscolhida = 3 then begin
      atribuirImagem(vetorImagem,per,7);
    end
    else if formulaEscolhida = 4 then begin
      atribuirImagem(vetorImagem,per,5);
    end
    else if formulaEscolhida = 5 then begin
     atribuirImagem(vetorImagem,per,9);
    end
    else if formulaEscolhida = 6 then begin
      atribuirImagem(vetorImagem,per,7);
    end
    else if formulaEscolhida = 7 then begin
      atribuirImagem(vetorImagem,per,5);
    end;

  end;


end;

Procedure limparJogoPerfil();
begin
  FormJogo.LabelNomePerfil.Caption:=('........................');
  usuario_pontuacao:=0;
  jogoPerfil:=False;

  interacaoLabel(FormJogo.LabelApagarPerfil,False);
end;

Procedure terminarJogo();
begin
  if ((fimDeJogo = True) or(morreu = True)) then begin
    FormJogo.ImageJogador.Left:=372;
    FormJogo.ImageJogador.top:=205;
    acertos:=0;
    FormJogo.controleDoJogo.Enabled:=False;
    FormJogo.MovimentoDoPersonagem.Enabled:=False;
    FormJogo.movimentoDasImagens.Enabled:=False;
    if ((fimDeJogo = False) and (morreu = True)) then begin
      morreu:= False;
      usuario_pontuacao:=usuario_pontuacao-6;
      notificacaoGamerVida();
    end
    else begin
      notificacaoGamer(acertolFormula);
    end;
    if jogoPerfil = True then begin

        DataPerfil.query.SQL.Clear;
        DataPerfil.query.SQL.Add('update perfil set pontuacao = :pontuacao where nome = :nome');
        DataPerfil.query.ParamByName('pontuacao').AsInteger := usuario_pontuacao;
        DataPerfil.query.ParamByName('nome').AsString := usuario_nome;
        DataPerfil.query.ExecSQL;
    end;
    acertolFormula:=False;
 end;
end;

procedure movimentarImagem();
  var
    aux1,aux2,aux3,aux4:integer;
    imagens:array[1..10,1..2]of integer;//array que vai armazenar os lefs e tops das imagens para poder deslocalas
begin

  Randomize;

  aux1:=random(11);
  aux2:=random(11);


  imagens[1,1]:=FormJogo.img1.Left;
  imagens[1,2]:=FormJogo.img1.Top;

  imagens[2,1]:=FormJogo.img2.Left;
  imagens[2,2]:=FormJogo.img2.Top;

  imagens[3,1]:=FormJogo.img3.Left;
  imagens[3,2]:=FormJogo.img3.Top;

  imagens[4,1]:=FormJogo.img4.Left;
  imagens[4,2]:=FormJogo.img4.Top;

  imagens[5,1]:=FormJogo.img5.Left;
  imagens[5,2]:=FormJogo.img5.Top;

  imagens[6,1]:=FormJogo.img6.Left;
  imagens[6,2]:=FormJogo.img6.Top;

  imagens[7,1]:=FormJogo.img7.Left;
  imagens[7,2]:=FormJogo.img7.Top;

  imagens[8,1]:=FormJogo.img8.Left;
  imagens[8,2]:=FormJogo.img8.Top;

  imagens[9,1]:=FormJogo.img9.Left;
  imagens[9,2]:=FormJogo.img9.Top;

  imagens[10,1]:=FormJogo.img10.Left;
  imagens[10,2]:=FormJogo.img10.Top;

if fimDeJogo=False then begin
 if (aux1 <> aux2) and (aux1<>0) and (aux2<>0) then begin
  aux3:=imagens[aux1,1];
  aux4:=imagens[aux1,2];
  imagens[aux1,1]:=imagens[aux2,1];
  imagens[aux1,2]:=imagens[aux2,2];
  imagens[aux2,1]:=aux3;
  imagens[aux2,2]:=aux4;


    if aux1=1 then begin
     FormJogo.img1.Left:=imagens[aux1,1];
     FormJogo.img1.Top:=imagens[aux1,2];
    end
    else if aux1=2 then begin
     FormJogo.img2.Left:=imagens[aux1,1];
     FormJogo.img2.Top:=imagens[aux1,2];
    end
    else if aux1=3 then begin
     FormJogo.img3.Left:=imagens[aux1,1];
     FormJogo.img3.Top:=imagens[aux1,2];
    end
    else if aux1=4 then begin
     FormJogo.img4.Left:=imagens[aux1,1];
     FormJogo.img4.Top:=imagens[aux1,2];
    end
    else if aux1=5 then begin
     FormJogo.img5.Left:=imagens[aux1,1];
     FormJogo.img5.Top:=imagens[aux1,2];
    end
    else if aux1=6 then begin
     FormJogo.img6.Left:=imagens[aux1,1];
     FormJogo.img6.Top:=imagens[aux1,2];
    end
    else if aux1=7 then begin
     FormJogo.img7.Left:=imagens[aux1,1];
     FormJogo.img7.Top:=imagens[aux1,2];
    end
    else if aux1=8 then begin
     FormJogo.img8.Left:=imagens[aux1,1];
     FormJogo.img8.Top:=imagens[aux1,2];
    end
    else if aux1=9 then begin
     FormJogo.img9.Left:=imagens[aux1,1];
     FormJogo.img9.Top:=imagens[aux1,2];
    end
    else if aux1=10 then begin
     FormJogo.img10.Left:=imagens[aux1,1];
     FormJogo.img10.Top:=imagens[aux1,2];
    end;

    if aux2=1 then begin
      FormJogo.img1.Left:=imagens[aux2,1];
      FormJogo.img1.Top:=imagens[aux2,2];
    end
    else if aux2=2 then begin
      FormJogo.img2.Left:=imagens[aux2,1];
      FormJogo.img2.Top:=imagens[aux2,2];
    end
    else if aux2=3 then begin
      FormJogo.img3.Left:=imagens[aux2,1];
      FormJogo.img3.Top:=imagens[aux2,2];
    end
    else if aux2=4 then begin
      FormJogo.img4.Left:=imagens[aux2,1];
      FormJogo.img4.Top:=imagens[aux2,2];
    end
    else if aux2=5 then begin
      FormJogo.img5.Left:=imagens[aux2,1];
      FormJogo.img5.Top:=imagens[aux2,2];
    end
    else if aux2=6 then begin
      FormJogo.img6.Left:=imagens[aux2,1];
      FormJogo.img6.Top:=imagens[aux2,2];
    end
    else if aux2=7 then begin
      FormJogo.img7.Left:=imagens[aux2,1];
      FormJogo.img7.Top:=imagens[aux2,2];
    end
    else if aux2=8 then begin
      FormJogo.img8.Left:=imagens[aux2,1];
      FormJogo.img8.Top:=imagens[aux2,2];
    end
    else if aux2=9 then begin
      FormJogo.img9.Left:=imagens[aux2,1];
      FormJogo.img9.Top:=imagens[aux2,2];
    end
    else if aux2=10 then begin
      FormJogo.img10.Left:=imagens[aux2,1];
      FormJogo.img10.Top:=imagens[aux2,2];
    end;
 end;
end;
end;


procedure controleVida();
begin
  if formulaEscolhida=1 then begin
    if bateu(FormJogo.ImageJogador,FormJogo.img10)then begin
      vidas:=(vidas-1);
      auxVidas:=auxVidas+1;
      FormJogo.imageJogador.Left:=372;
      FormJogo.imageJogador.Top:=205;
     if auxVidas=1 then
      FormJogo.ImageVida1.Visible:=False
     else if auxVidas=2 then
      FormJogo.ImageVida2.Visible:=False
     else if auxVidas=3 then begin
      FormJogo.ImageVida3.Visible:=False;
      morreu:=True;
     end;
    end;
  end


    else if formulaEscolhida=2 then begin
      if bateu(FormJogo.imageJogador,FormJogo.img6)or bateu(FormJogo.imageJogador,FormJogo.img7)
      or bateu(FormJogo.imageJogador,FormJogo.img8)or bateu(FormJogo.imageJogador,FormJogo.img9)or bateu(FormJogo.imageJogador,FormJogo.img10)then begin
      vidas:=(vidas-1);
       auxVidas:=auxVidas+1;
      FormJogo.imageJogador.Left:=372;
      FormJogo.imageJogador.Top:=205;
       if auxVidas=1 then
        FormJogo.ImageVida1.Visible:=False
       else if auxVidas=2 then
        FormJogo.ImageVida2.Visible:=False
       else if auxVidas=3 then begin
        FormJogo.ImageVida3.Visible:=False;
        morreu:=True;
       end;
      end;
    end


    else if formulaEscolhida=3 then begin
      if bateu(FormJogo.imageJogador,FormJogo.img8)or bateu(FormJogo.imageJogador,FormJogo.img9)or bateu(FormJogo.imageJogador,FormJogo.img10)then begin
       vidas:=(vidas-1);
       auxVidas:=auxVidas+1;
       FormJogo.imageJogador.Left:=372;
       FormJogo.imageJogador.Top:=205;
       if auxVidas=1 then
        FormJogo.ImageVida1.Visible:=False
       else if auxVidas=2 then
        FormJogo.ImageVida2.Visible:=False
       else if auxVidas=3 then begin
        FormJogo.ImageVida3.Visible:=False;
        morreu:=True;
       end;
      end;
    end

   else if formulaEscolhida=4 then begin
    if bateu(FormJogo.imageJogador,FormJogo.img6)or bateu(FormJogo.imageJogador,FormJogo.img7)
    or bateu(FormJogo.imageJogador,FormJogo.img8)or bateu(FormJogo.imageJogador,FormJogo.img9)or bateu(FormJogo.imageJogador,FormJogo.img10)then begin
     vidas:=(vidas-1);
     auxVidas:=auxVidas+1;
     FormJogo.imageJogador.Left:=372;
     FormJogo.imageJogador.Top:=205;
    if auxVidas=1 then
    FormJogo.ImageVida1.Visible:=False
    else if auxVidas=2 then
    FormJogo.ImageVida2.Visible:=False
    else if auxVidas=3 then begin
    FormJogo.ImageVida3.Visible:=False;
    morreu:=True;
    end;
   end;
end

   else if formulaEscolhida=5 then begin
  if bateu(FormJogo.imageJogador,FormJogo.img10)then begin
   vidas:=(vidas-1);
   auxVidas:=auxVidas+1;
   FormJogo.imageJogador.Left:=372;
   FormJogo.imageJogador.Top:=205;
   if auxVidas=1 then
    FormJogo.ImageVida1.Visible:=False
   else if auxVidas=2 then
    FormJogo.ImageVida2.Visible:=False
   else if auxVidas=3 then begin
    FormJogo.ImageVida3.Visible:=False;
    morreu:=True;
   end;
  end;
end

 else if formulaEscolhida=6 then begin
  if bateu(FormJogo.imageJogador,FormJogo.img8)or bateu(FormJogo.imageJogador,FormJogo.img9)or bateu(FormJogo.imageJogador,FormJogo.img10)then begin
   vidas:=(vidas-1);
   auxVidas:=auxVidas+1;
   FormJogo.imageJogador.Left:=372;
   FormJogo.imageJogador.Top:=205;
   if auxVidas=1 then
    FormJogo.ImageVida1.Visible:=False
   else if auxVidas=2 then
    FormJogo.ImageVida2.Visible:=False
   else if auxVidas=3 then begin
    FormJogo.ImageVida3.Visible:=False;
    morreu:=True;
   end;
  end;
end

  else if formulaEscolhida=7 then begin
  if bateu(FormJogo.imageJogador,FormJogo.img6)or bateu(FormJogo.imageJogador,FormJogo.img7)
  or bateu(FormJogo.imageJogador,FormJogo.img8)or bateu(FormJogo.imageJogador,FormJogo.img9)or bateu(FormJogo.imageJogador,FormJogo.img10)then begin
   vidas:=(vidas-1);
   auxVidas:=auxVidas+1;
   FormJogo.imageJogador.Left:=372;
   FormJogo.imageJogador.Top:=205;
   if auxVidas=1 then
    FormJogo.ImageVida1.Visible:=False
   else if auxVidas=2 then
    FormJogo.ImageVida2.Visible:=False
   else if auxVidas=3 then begin
    FormJogo.ImageVida3.Visible:=False;
    morreu:=True;
   end;
  end;
end;
end;

Procedure criarJogoPerfil();
begin
  FormJogo.LabelPontuacao.Caption:= IntToStr(usuario_pontuacao);
  FormJogo.LabelNomePerfil.Caption:= usuario_nome;
  jogoPerfil:=True;
  criarJogo;
end;

Procedure apagarPerfil();

begin

        DataPerfil.Query.SQL.Clear;
        DataPerfil.Query.SQL.Add('delete from perfil where nome = :nome');
        DataPerfil.Query.ParamByName('nome').AsString := usuario_nome;
        DataPerfil.Query.ExecSQL;
        FormJogo.Close;
end;

end.
