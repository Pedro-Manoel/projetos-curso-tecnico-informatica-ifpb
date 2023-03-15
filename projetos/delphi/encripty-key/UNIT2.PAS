unit Unit2;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ComCtrls, ExtCtrls, ActnList, Menus;

type

  { Tconfig }

  Tconfig = class(TForm)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Panel1: TPanel;
    Ra_salv1: TRadioButton;
    Ra_salv2: TRadioButton;
    Ra_exl1: TRadioButton;
    Ra_exl2: TRadioButton;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormCreate(Sender: TObject);
    procedure Label3MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer
      );
    procedure Label5MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer
      );
    procedure PageControl1Change(Sender: TObject);
    procedure TabControl1Change(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  config: Tconfig;
    salva_arquivo_local:Boolean;
    excluir_arquivo_original:Boolean;

implementation

{$R *.lfm}

{ Tconfig }

procedure Tconfig.TabControl1Change(Sender: TObject);
begin

end;

procedure Tconfig.PageControl1Change(Sender: TObject);
begin

end;

procedure Tconfig.Label3MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin

end;

procedure Tconfig.FormCreate(Sender: TObject);
begin
 Ra_salv1.Checked:=True;
 Ra_exl2.Checked:=True;

  if Ra_salv1.Checked=True then begin
   salva_arquivo_local:=True;
 end
 else begin
   salva_arquivo_local:=False;
 end;

 if Ra_exl1.Checked=True then begin
   excluir_arquivo_original:=True;
 end
 else begin
   excluir_arquivo_original:=False;
 end;

end;

procedure Tconfig.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
 if Ra_salv1.Checked=True then begin
  salva_arquivo_local:=True;
end
else begin
  salva_arquivo_local:=False;
end;

if Ra_exl1.Checked=True then begin
  excluir_arquivo_original:=True;
end
else begin
  excluir_arquivo_original:=False;
end;
end;

procedure Tconfig.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin

end;

procedure Tconfig.Label5MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin

end;

end.

