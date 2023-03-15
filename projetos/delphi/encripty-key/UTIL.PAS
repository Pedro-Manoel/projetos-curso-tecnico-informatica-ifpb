unit Util;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls;

Function EXTarquivo(caminho_arq:string):string;
Function MemoryStreamToString(M:TMemoryStream):string;
Function Crypt(Texto, senha:string):string;
function TamArquivo(Arquivo: string): string;
Function NomeArquivo(caminho_arq:string):string;
Procedure AjustarLabel(var lab:TLabel);
Function NomeArquivoSave(arquivo:string):string;
Procedure ExcluirArquivo (arquivo:String);
Function NomeArquivoSaveSenha(arquivo:string):string;
Procedure moveOpcoes(img:TImage; texto:TLabel; leftNormal:Integer );
Procedure leaveOpcoes(img:TImage; texto:TLabel; leftNormal:Integer );
implementation

Procedure ExcluirArquivo (arquivo:String);
 begin
  if FileExists(arquivo)then
   DeleteFile(arquivo);
end;

Procedure AjustarLabel(var lab:TLabel);
 begin
  if lab.Width > 520 then begin
    lab.Font.Size:=lab.Font.Size-1;
    AjustarLabel(lab);
  end
end;

function TamArquivo(Arquivo: string): string;
 var
   tamanho_num,aux:double;//armazenar o tamanho do arquivo
   tamanho_tot,i:integer;//variaveis auxiliadoras 1
   aux1,aux2:string;//variaveis auxiliadoras 2
begin

 with TFileStream.Create(Arquivo, fmOpenRead or fmShareExclusive) do
   try
    tamanho_num := Size;
    aux:= Size
   finally
    Free;
   end;

  aux2:=FloatToStr(tamanho_num);
  tamanho_tot:=Length(aux2);//numero de components



  if (tamanho_tot = 1) or (tamanho_tot = 2) or (tamanho_tot = 3)  then begin
   aux1:=FloatToStr(aux);
   Result:=(aux1)+(' bytes');
  end;

  if tamanho_tot = 4 then begin
   aux:=aux/1024;
   aux1:=FloatToStr(aux);
   Delete(aux1,5,50);
   Result:=(aux1)+(' KB');
  end;

  if tamanho_tot = 5 then begin
    aux:=aux/1024;
    aux1:=FloatToStr(aux);
    Delete(aux1,5,50);
    Result:=(aux1)+(' KB');
  end;

  if tamanho_tot = 6 then begin
    aux:=aux/1024;
    aux1:=FloatToStr(aux);
    Delete(aux1,4,50);
    Result:=(aux1)+(' KB');
  end;

  if tamanho_tot = 7 then begin
   for i:= 1 to 2 do
    aux:=aux/1024;
    aux1:=FloatToStr(aux);
    Delete(aux1,5,50);
    Result:=(aux1)+(' MB');
  end;

  if tamanho_tot = 8 then begin
   for i:= 1 to 2 do
    aux:=aux/1024;
    aux1:=FloatToStr(aux);
    Delete(aux1,5,50);
    Result:=(aux1)+(' MB');
  end;

  if tamanho_tot = 9 then begin
   for i:= 1 to 2 do
    aux:=aux/1024;
    aux1:=FloatToStr(aux);
    Delete(aux1,4,50);
    Result:=(aux1)+(' MB');
  end;

  if tamanho_tot = 10 then begin
   for i:= 1 to 3 do
    aux:=aux/1024;
    aux1:=FloatToStr(aux);
    Delete(aux1,5,50);
    Result:=(aux1)+(' GB');
  end;

  if tamanho_tot = 11 then begin
   for i:= 1 to 3 do
    aux:=aux/1024;
    aux1:=FloatToStr(aux);
    Delete(aux1,5,50);
    Result:=(aux1)+(' GB');
  end;

  if tamanho_tot = 12 then begin
   for i:= 1 to 3 do
    aux:=aux/1024;
    aux1:=FloatToStr(aux);
    Delete(aux1,4,50);
    Result:=(aux1)+(' GB');
  end;
end;

Function EXTarquivo(caminho_arq:string):string;
begin

  caminho_arq:=ExtractFileExt(caminho_arq);
  Delete(caminho_arq,1,1);
  Result:=caminho_arq;
end;

Function NomeArquivo(caminho_arq:string):string;
 var
  caracteres:array [1..350]of string;
  num_posisao:integer;
  aux2,i:integer;//variaveis auxiliadoras
begin

caminho_arq:=ExtractFileName(caminho_arq);
aux2:=Length(caminho_arq);

 for i:= 1 to aux2 do
   caracteres[i]:=caminho_arq[i];
 for i:= 1 to aux2 do
   if caracteres[i]=('.')then
    num_posisao:=i;


  Delete(caminho_arq,num_posisao,50);

 Result:=caminho_arq;
end;

Function Crypt(Texto, senha:string):string;
 var
  x, y:Integer;
  Novo:string;

 begin
   for x := 1 to Length(senha) do begin
     Novo:= ('');
     for y := 1 to Length(Texto) do
      Novo := Novo + Chr((Ord(senha[x]) xor Ord(Texto[y])));
      Texto:= Novo;
   end;
   Result:= Texto;
end;

Function MemoryStreamToString(M: TMemoryStream):string ;
 begin
  SetString(Result, PChar(M.Memory), M.Size div SizeOf(Char));
 end;
Function NomeArquivoSave(arquivo:string):string;
 var
  extensao:string;
  nomeARQ:string;
  novoARQ:string;
 begin
   extensao:=ExtractFileExt(arquivo);
   nomeARQ:=NomeArquivo(arquivo);

   novoARQ:='Cript('+nomeARQ+')'+extensao;

   Result:=novoARQ;

 end;
Function NomeArquivoSaveSenha(arquivo:string):string;
 var
  nomeARQ:string;
  novoARQ:string;
 begin
   nomeARQ:=NomeArquivo(arquivo);

   novoARQ:='Senha('+nomeARQ+')'+'.txt';

   Result:=novoARQ;

 end;
Procedure moveOpcoes(img:TImage; texto:TLabel; leftNormal:Integer );
var
   corMoveTexto : TColor;

begin

     corMoveTexto:= ($005151FF);

     texto.Font.Color := corMoveTexto;

     img.Left:= leftNormal - 8;
     img.Width:= 510;

     img.Height:= 74;
     img.Width:= 74;



end;
Procedure leaveOpcoes(img:TImage; texto:TLabel; leftNormal:Integer );
var
   corLeaveTexto : TColor;

begin

      corLeaveTexto:= (clAqua);

      texto.Font.Color := corLeaveTexto;

      img.Left:= leftNormal;
      img.Width:= 520;

      img.Height:= 64;
      img.Width:= 64;





end;

end.

