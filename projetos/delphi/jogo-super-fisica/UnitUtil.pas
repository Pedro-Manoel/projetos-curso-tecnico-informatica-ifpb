unit UnitUtil;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, Vcl.ExtCtrls,
  Vcl.StdCtrls,Data.DB;

Procedure mudarForm(form1,form2:TForm);//Fazer a transição entre dois forms passados como parametros
Function nomeUsuario():string;//nome do usuario do windows que esta logado no momentoProcedure criarPasta(diretorio:string);//Verificar se a pasta já eziste se não vai criar ela em documentos
Procedure labelMove(label1:TLabel);//Quando o mouse se mover pelo label
Procedure labelLeave(label1:TLabel);//Quando o mouse se move fora do label
Procedure conferirPerfil(form1,form2:TForm);//Verificar se o perfil e se esta correto se estiver vai abri o form
Function perfilCriado():boolean;//Verificar se eziste algum perfil salvo se sim retorna TRUE senão retorna FALSE
Procedure formInvisivel(form:TForm;condicao:boolean);//Deixar o form invisivel colocando o form como parametro e um TRUE ou FALSE para deixar ou para voltar ao normal
Procedure notificacaoGamer(parametro:boolean);//Chamar o form de notificação de acerto ou erro da formula
Procedure notificacaoGamerVida();//Chamar o form de notificação para o aviso de que perdel todas as vidas
Procedure notificacao(texto:string);//Chamar o form de notificação para mostrar o texto do parametro
Function existeCadastros(): Boolean ; // Conferir se existe pelomenus um cadastro na aplicação
procedure interacaoLabel(label1 : TLabel ; habilitar : Boolean); // Para habilitar um desabilitar um label para o usuário
procedure buttonLoginConfere(); // Para habilitar ou desabilitar o butão de entrada dependendo se existem cadastros ou não

var
usuario_nome : string;
usuario_senha : string;
usuario_pontuacao : Integer;

implementation

Uses UnitLogin,UnitDataPerfil,UnitNotificacao,UnitJogo,UnitGamer,UnitMenu;

procedure buttonLoginConfere();
begin
        if existeCadastros then
           interacaoLabel(FormMenu.LabelLogin,True)
        else
           interacaoLabel(FormMenu.LabelLogin,False);
end;

Procedure mudarForm(form1,form2:TForm);
begin

        form1.AlphaBlend:=(True);
        form1.AlphaBlendValue:=(0);
        form2.ShowModal;
        form1.AlphaBlend:=(False);
        buttonLoginConfere();
        form1.AlphaBlendValue:=(255);
end;

Procedure notificacao(texto:string);
begin
  FormNotificacao.LabelNotificacao.Caption:=(texto);
  FormNotificacao.ShowModal;
end;

Procedure notificacaoUper(texto:string;cor:TColor);
begin
  FormNotificacao.LabelNotificacao.Caption:=(texto);
  FormNotificacao.LabelNotificacao.Font.Color:=(cor);
  FormNotificacao.ShowModal;
end;

Function nomeUsuario():string;
var
  I: DWord;
  user: string;
begin
  I := 255;
  SetLength(user, I);
  Winapi.Windows.GetUserName(PChar(user), I);
  user := string(PChar(user));
  Result := user;
end;

Procedure labelMove(label1:TLabel);
begin
label1.Font.Color:=($007D71F4);
end;

Procedure labelLeave(label1:TLabel);
begin
label1.Font.Color:=(clWhite);
end;

Procedure formInvisivel(form:TForm;condicao:boolean);
begin
  if (condicao = True) then begin
    form.AlphaBlend:=(True);
    form.AlphaBlendValue:=(0);
  end
  else begin
  form.AlphaBlend:=(False);
  form.AlphaBlendValue:=(255);
  end;
end;

Function existeCadastros(): Boolean ;
begin

  DataPerfil.Query.SQL.Clear;
  DataPerfil.Query.SQL.Add('select * from perfil');
  DataPerfil.Query.Open();

  if DataPerfil.Query.RecordCount > 0 then
        Result := True // já existem perfies cadastrados na aplicação
  else
        Result := False // Não existem perfies cadastrados na aplicação

end;


Procedure conferirPerfil(form1,form2:TForm);//O parametro é o form que sera chamdo se o perfil ezistir e se estiver correto
  var
    verNome:Boolean;
    verSenha:string;
    nome,senha:string;
begin
  nome:= formLogin.EditNome.Text;
  senha:= formLogin.EditSenha.Text;

  DataPerfil.Query.SQL.Clear;
  DataPerfil.Query.SQL.Add('select * from perfil where nome = :nome');
  DataPerfil.Query.ParamByName('nome').AsString := nome;
  DataPerfil.Query.Open();

  if DataPerfil.Query.RecordCount = 0 then begin
     notificacao('O cadastro não existe');
  end
  else begin
     if (( nome = DataPerfil.Query.FieldByName('nome').AsString)
     and (senha = DataPerfil.Query.FieldByName('senha').AsString))  then begin

             usuario_nome := nome;
             usuario_senha := senha;
             usuario_pontuacao := DataPerfil.Query.FieldByName('pontuacao').AsInteger;

             formInvisivel(form1,True);
             criarJogoPerfil();
             form2.ShowModal;
             form1.Close;

     end
     else begin
        notificacao('nome ou senha inválida');
     end;

  end;

end;

Function perfilCriado():boolean;
begin
  DataPerfil.Query.SQL.Clear;
  DataPerfil.Query.SQL.Add('select * from perfil');
  DataPerfil.Query.Open();

  if DataPerfil.Query.RecordCount > 0 then
    Result:=(True)
  else
    Result:=(False);
end;

procedure interacaoLabel(label1 : TLabel ; habilitar : Boolean);
begin
    if habilitar then begin
        Label1.Font.Style:= [];
        label1.Enabled:=(True)
    end
    else
    begin
        Label1.Font.Style := [fsStrikeOut];
        label1.Enabled:=(False)
    end;
end;

Procedure notificacaoGamer(parametro:boolean);
begin
  if parametro = False then begin
    resultNotificacaoGame(True);
    notificacao('Que pena você errou a formula');
  end;

  if parametro = True then begin
    resultNotificacaoGame(True);
    notificacao('Parabéns a formula esta certa');
  end;

end;

Procedure notificacaoGamerVida();
begin
  resultNotificacaoGame(True);
  notificacao('Que pena você perdeu suas vidas');
end;


end.
