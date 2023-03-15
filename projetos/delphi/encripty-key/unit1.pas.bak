unit unit1;

{$mode objfpc}{$H+}

interface

uses
  Util,Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls;

type

  { Tuprincipal }

  Tuprincipal = class(TForm)
    Edsenha: TEdit;
    GroupBox1: TGroupBox;
    ImageCarregarArq: TImage;
    ImageCredito: TImage;
    ImageCriptografar: TImage;
    ImageConfiguracoes: TImage;
    Img_salvar: TImage;
    img_arq: TImage;
    icones: TImageList;
    Label1: TLabel;
    LabelCarregarArq: TLabel;
    LabelCredito: TLabel;
    LabelCriptografar: TLabel;
    LabelConfiguracoes: TLabel;
    LabelSalvarSenha: TLabel;
    Label6: TLabel;
    label_2: TLabel;
    label_tam: TLabel;
    label_arq1TAM: TLabel;
    label_arq1EXT: TLabel;
    label_ext: TLabel;
    lab_notifiq: TLabel;
    lab_notifiq1: TLabel;
    lab_senha: TLabel;
    opencarregar: TOpenDialog;
    label_arq: TLabel;
    opensalvar: TSaveDialog;
    Select_past: TSelectDirectoryDialog;
    Select_past_senha: TSelectDirectoryDialog;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ControleTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure GroupBox1Click(Sender: TObject);
    procedure ImageCarregarArqClick(Sender: TObject);
    procedure ImageCarregarArqMouseLeave(Sender: TObject);
    procedure ImageCarregarArqMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ImageConfiguracoesMouseLeave(Sender: TObject);
    procedure ImageConfiguracoesMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure ImageCreditoClick(Sender: TObject);
    procedure ImageCreditoMouseLeave(Sender: TObject);
    procedure ImageCreditoMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ImageCriptografarClick(Sender: TObject);
    procedure ImageConfiguracoesClick(Sender: TObject);
    procedure ImageCriptografarMouseLeave(Sender: TObject);
    procedure ImageCriptografarMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure Img_salvarClick(Sender: TObject);
    procedure Img_salvarMouseLeave(Sender: TObject);
    procedure Img_salvarMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure TanimationTimer(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  uprincipal: Tuprincipal;

implementation
 uses
   Unit2,Unit3;
 var
   caminho,caminho_save,nome_ARQ_save:string;
   carregado:Boolean;
{$R *.lfm}

{ Tuprincipal }


procedure Tuprincipal.ImageCarregarArqClick(Sender: TObject);
begin
if opencarregar.Execute then begin
  caminho:= opencarregar.FileName;
  carregado:=True;
end;

if carregado=True then begin
  lab_notifiq1.Visible:=False;
  lab_notifiq.Caption:=('O arquivo foi carregado com sucesso');
 icones.GetBitmap(1,img_arq.Picture.Bitmap);
 label_arq.Caption:=NomeArquivo(caminho);
  label_arq.Font.Size:=18;
   if label_arq.Width > 520 then
    AjustarLabel(label_arq);
 label_arq1TAM.Caption:=TamArquivo(caminho);
 label_arq1EXT.Caption:=EXTarquivo(caminho);
end;

if carregado=True then begin
label_arq1TAM.Visible:=True;
label_arq1EXT.Visible:=True;
end;

end;

procedure Tuprincipal.ImageCarregarArqMouseLeave(Sender: TObject);
begin
  leaveOpcoes(ImageCarregarArq,LabelCarregarArq,232);
end;

procedure Tuprincipal.ImageCarregarArqMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  moveOpcoes(ImageCarregarArq,LabelCarregarArq,232);
end;

procedure Tuprincipal.ImageConfiguracoesMouseLeave(Sender: TObject);
begin
   leaveOpcoes(ImageConfiguracoes,LabelConfiguracoes,728);
end;

procedure Tuprincipal.ImageConfiguracoesMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  moveOpcoes(ImageConfiguracoes,LabelConfiguracoes,728);
end;

procedure Tuprincipal.ImageCreditoClick(Sender: TObject);
begin
  Form1.ShowModal;
end;

procedure Tuprincipal.ImageCreditoMouseLeave(Sender: TObject);
begin
  leaveOpcoes(ImageCredito,LabelCredito,920);
end;

procedure Tuprincipal.ImageCreditoMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
     moveOpcoes(ImageCredito,LabelCredito,920);
end;

procedure Tuprincipal.ImageCriptografarClick(Sender: TObject);
 var
 arquivo: TMemoryStream;
 arquivoString: string;
 begin

 nome_ARQ_save:=NomeArquivoSave(caminho);

   if FileExists(caminho) then begin
     lab_notifiq1.Visible:=False;
     lab_notifiq.Caption:=('...............');

      if Edsenha.Text = '' then begin
         lab_notifiq1.Visible:=True;
         lab_notifiq1.Caption:=('ERRO');
         lab_notifiq.Caption:=('A senha não foi enformada');
      end
      else begin

    arquivo:= TMemoryStream.Create;
    arquivo.LoadFromFile(caminho);
    arquivoString:= MemoryStreamToString(arquivo);
    arquivoString:= Crypt(arquivoString, Edsenha.Text);
    arquivo.Free;
    arquivo:= TMemoryStream.Create;
    arquivo.WriteBuffer(Pointer(arquivoString)^, Length(arquivoString));

    lab_notifiq.Caption:=('O arquivo foi criptografado ou descriptografado com sucesso');

    if salva_arquivo_local=True then begin
     caminho_save:=ExtractFilePath(caminho);
      arquivo.SaveToFile(caminho_save+nome_ARQ_save);
       if excluir_arquivo_original=True then
          ExcluirArquivo(caminho);
    end
    else begin
     if Select_past.Execute then
      arquivo.SaveToFile(Select_past.FileName+'\'+nome_ARQ_save);
       if (excluir_arquivo_original=True) and (Select_past.FileName<>(''))and (FileExists(Select_past.FileName+'\'+nome_ARQ_save)) then
         ExcluirArquivo(caminho);
    end;
      arquivo.Free;
      arquivoString:= ('');
   end;
  end
    else begin
     lab_notifiq1.Visible:=True;
     lab_notifiq1.Font.Color:=(clRed);
     lab_notifiq1.Caption:=('ERRO');
     lab_notifiq.Caption:=('Verifique se o arquivo está com nome original e no caminho correto');
    end;
   end;

procedure Tuprincipal.ImageConfiguracoesClick(Sender: TObject);
begin
  config.ShowModal;
end;

procedure Tuprincipal.ImageCriptografarMouseLeave(Sender: TObject);
begin
  leaveOpcoes(ImageCriptografar,LabelCriptografar,424);
end;

procedure Tuprincipal.ImageCriptografarMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  moveOpcoes(ImageCriptografar,LabelCriptografar,424);
end;

Procedure Tuprincipal.Img_salvarClick(Sender: TObject);
 var
  arquivo:TMemoryStream;
  senha:string;
begin

 senha:=Edsenha.Text;
   if senha<>('')then begin
     lab_notifiq1.Visible:=False;
     lab_notifiq.Caption:=('...............');
    if Select_past_senha.Execute then
       if carregado=True then begin
         lab_notifiq1.Visible:=False;
         lab_notifiq.Caption:=('...............');
        arquivo:=TMemoryStream.Create;
        arquivo.WriteAnsiString(senha);
        arquivo.SaveToFile(Select_past_senha.FileName+'\'+NomeArquivoSaveSenha(caminho));
        arquivo.Free;
        lab_notifiq.Caption:=('Senha salva');
       end
       else begin
       lab_notifiq1.Visible:=True;
       lab_notifiq1.Font.Color:=(clRed);
       lab_notifiq1.Caption:=('ERRO');
       lab_notifiq.Caption:=('A senha será salva após inserção do arquivo');
       end;
     end
  else begin
     lab_notifiq1.Visible:=True;
     lab_notifiq1.Font.Color:=(clRed);
     lab_notifiq1.Caption:=('ERRO');
     lab_notifiq.Caption:=('A senha não foi enformada');
  end;
end;

procedure Tuprincipal.Img_salvarMouseLeave(Sender: TObject);
begin
   leaveOpcoes(Img_salvar,LabelSalvarSenha,608);
end;

procedure Tuprincipal.Img_salvarMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  moveOpcoes(Img_salvar,LabelSalvarSenha,608);
end;

procedure Tuprincipal.TanimationTimer(Sender: TObject);
begin

end;

procedure Tuprincipal.FormShow(Sender: TObject);
begin

if carregado=False then begin
  icones.GetBitmap(0,img_arq.Picture.Bitmap);
  label_arq.Caption:=('Sem arquivo');
 end;

end;

procedure Tuprincipal.GroupBox1Click(Sender: TObject);
begin

end;

procedure Tuprincipal.FormCreate(Sender: TObject);
begin
 label_arq.Caption:=('Sem arquivo');
 label_arq1TAM.Visible:=False;
 label_arq1EXT.Visible:=False;

 lab_notifiq.Caption:=('Carregue o arquivo para descriptografar ou criptografar');
 lab_notifiq.Font.Color:=($0057A303);

end;

procedure Tuprincipal.ControleTimer(Sender: TObject);
begin



end;

procedure Tuprincipal.Button1Click(Sender: TObject);
begin

end;

procedure Tuprincipal.Button2Click(Sender: TObject);
begin

end;

end.

