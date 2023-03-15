unit UnitMenu;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Ani, FMX.ScrollBox, FMX.Memo;

type
  TFormMenu = class(TForm)
    logo1: TImage;
    TextJogar: TText;
    CircleMenu: TCircle;
    TextSair: TText;
    logo2: TImage;
    TextCreditos: TText;
    TextVercao: TText;
    procedure TextJogarMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Single);
    procedure TextJogarMouseLeave(Sender: TObject);
    procedure TextJogarClick(Sender: TObject);
    procedure TextSairMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Single);
    procedure TextSairMouseLeave(Sender: TObject);
    procedure TextSairClick(Sender: TObject);
    procedure TextCreditosMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Single);
    procedure TextCreditosMouseLeave(Sender: TObject);
    procedure TextCreditosClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormMenu: TFormMenu;

implementation

Uses UnitUtil,UnitJogo,UnitCredito;

{$R *.fmx}


procedure TFormMenu.TextCreditosClick(Sender: TObject);
begin
        FormMenu.Visible := False;
        FormCredito.ShowModal;
end;

procedure TFormMenu.TextCreditosMouseLeave(Sender: TObject);
begin
        textLeave(TextCreditos);
end;

procedure TFormMenu.TextCreditosMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Single);
begin
        textMove(TextCreditos);
end;

procedure TFormMenu.TextJogarClick(Sender: TObject);
begin
        FormJogo.ShowModal;
end;

procedure TFormMenu.TextJogarMouseLeave(Sender: TObject);
begin
        textLeave(TextJogar);
end;

procedure TFormMenu.TextJogarMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Single);
begin
        textMove(TextJogar);
end;

procedure TFormMenu.TextSairClick(Sender: TObject);
begin
        Self.Close;
end;

procedure TFormMenu.TextSairMouseLeave(Sender: TObject);
begin
        textLeave(TextSair);
end;

procedure TFormMenu.TextSairMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Single);
begin
        textMove(TextSair);
end;

end.
