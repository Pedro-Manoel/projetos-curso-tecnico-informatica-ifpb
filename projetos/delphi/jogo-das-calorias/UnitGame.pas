unit UnitGame;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls,Data.DB;

Procedure MoveComida(circuloComida1,circuloComida2:TCircle);//Quando o mouse se mover por uma imagem de uma comida
Procedure esconderComida(circuloComida1,circuloComida2:TCircle);//esconder a seleção das comidas quando não estiferem se movendo por elas
Procedure criarJogo();// Para criar todo o sistema e jogatina do jogo
Procedure conferirEscolha(numComidaEscolhida : Integer);// Verificando se a comida escolhida e a correta e atribuindo os acertos e erros
Procedure comidasTotal();// Atribuindo Número total de comidas armazenado no banco de dados a variavel numComidasTotal
Procedure zerarJogo();// Para zerar o número de acertos e erros
Procedure msgErro(strErro,strAv:string);// Para chamar o form de mensagem constentando algum erro

Var
        escolheu : Boolean; // se o usuário já fez a escolha da comida
        acertol : Boolean; // se o usuário acertol a comida

implementation

Uses
        UnitDate,UnitJogo,UnitMensage;

Var
        numAcertos,numErros : integer;
        caloriasComida1,caloriasComida2 : integer;
        numComidasTotal : integer;

Procedure MoveComida(circuloComida1,circuloComida2:TCircle);
begin
        if escolheu = False then begin
        circuloComida1.Visible := (True);
        circuloComida2.Visible := (False);
        end;
end;

Procedure esconderComida(circuloComida1,circuloComida2:TCircle);
begin
        if escolheu = False then begin
        circuloComida1.Visible := (False);
        circuloComida2.Visible := (False);
        end;
end;

Procedure comidasTotal();
begin
        numComidasTotal := Date.Query.RecordCount;
end;

Procedure comidaOpen(numComidaBD,numComidaJogo : Integer);
var
        fotoComida : TStream;
begin

        Date.Query.SQL.Clear;
        Date.Query.SQL.Add('select * from comida where num like :num');
        Date.Query.ParamByName('num').AsInteger := numComidaBD; // fazendo busca no banco de dados pelo número da comida
        Date.Query.Open();

        // atribuindo os os dados da comida aos campos do jogo

        if numComidaJogo = 1 then begin

         FormJogo.TextComida1_nome.Text := Date.Query.FieldByName('nome').AsString;
         FormJogo.TextComida1_porcao.Text := Date.Query.FieldByName('porcao').AsString;
         FormJogo.TextComida1_caloria.Text := Date.Query.FieldByName('calorias').AsString;
         fotoComida := Date.Query.CreateBlobStream( Date.Query.FieldByName('foto'), TBlobStreamMode.bmRead );
         FormJogo.CircleComida1.Fill.Bitmap.Bitmap.LoadFromStream( fotoComida );
         caloriasComida1 := Date.Query.FieldByName('calorias').AsInteger;

        end
        else begin

         FormJogo.TextComida2_nome.Text := Date.Query.FieldByName('nome').AsString;
         FormJogo.TextComida2_porcao.Text := Date.Query.FieldByName('porcao').AsString;
         FormJogo.TextComida2_caloria.Text := Date.Query.FieldByName('calorias').AsString;
         fotoComida := Date.Query.CreateBlobStream( Date.Query.FieldByName('foto'), TBlobStreamMode.bmRead );
         FormJogo.CircleComida2.Fill.Bitmap.Bitmap.LoadFromStream( fotoComida );
         caloriasComida2 := Date.Query.FieldByName('calorias').AsInteger;

        end;

end;

Procedure escolheComidas();
var
        numComida1,numComida2 : integer;

begin
        repeat  // um loop que continuara ate os números escolhidos forem diferentes

         numComida1 := Random( numComidasTotal + 1 );// Fazendo uma escolha aleatoria de um número entre o total de comidas
         numComida2 := Random( numComidasTotal + 1 );


        until ( (numComida1 <> numComida2) and ((numComida1 <> 0) and (numComida2 <> 0)) ); // se o número das comidas forem inguais

        // depois que os números forem escolhidos sera atribuido no campo do jogo os dados das comidas

         comidaOpen(numComida1,1);
         comidaOpen(numComida2,2);

end;

Procedure conferirEscolha(numComidaEscolhida : Integer);
var
        numComidaCerta : Integer;

begin

        // conferindo qual comida possue mais calorias
        if caloriasComida1 > caloriasComida2 then
         numComidaCerta := 1
        else begin
         numComidaCerta := 2;
        end;

        // verificando se a comida escolhida e a certa
        if numComidaEscolhida = numComidaCerta then begin
         numAcertos := numAcertos + 1;
         acertol := True;
        end
        else begin
         numErros := numErros + 1;
         acertol := False;
        end;

        FormJogo.TextAcertos.Text := numAcertos.ToString();
        FormJogo.TextErros.Text := numErros.ToString();

        escolheu := True;

end;

Procedure zerarJogo();
begin
        numAcertos := 0;
        numErros := 0;

end;

Procedure criarJogo();
begin

        escolheu := False;
        FormJogo.TextResultado.Visible := False;

        FormJogo.SpeedButtonContinuar.Visible := False;
        FormJogo.SpeedButtonContinuar.Enabled := False;

        FormJogo.RoundRectComida1.Visible := False;
        FormJogo.RoundRectComida2.Visible := False;

        FormJogo.CircleSelecaoComida1.Fill.Color := corPadraoCircleSelecao;
        FormJogo.CircleSelecaoComida2.Fill.Color := corPadraoCircleSelecao;

        FormJogo.CircleSelecaoComida1.Visible := False;
        FormJogo.CircleSelecaoComida2.Visible := False;

        FormJogo.TextAcertos.Text := numAcertos.ToString();
        FormJogo.TextErros.Text := numErros.ToString();


        escolheComidas();


end;

Procedure msgErro(strErro,strAv:string);
begin
        FormMensage.TextAviso.Text := strErro;
        FormMensage.TextDetalhas.Text := strAv;
        FormMensage.ShowModal;
end;

end.

