unit UnitMensage;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, Vcl.ExtCtrls,
  Vcl.StdCtrls;

type
  TFormMensage = class(TForm)
    LabelAviso: TLabel;
    ImageClose: TImage;
    MemoTxt: TMemo;
    procedure ImageCloseClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormMensage: TFormMensage;

implementation

{$R *.dfm}

procedure TFormMensage.FormKeyPress(Sender: TObject; var Key: Char);
begin
        if((key = #13) or (key = #27))then begin // Tecla ENTER e ESQ
          Self.Close;
        end;
end;

procedure TFormMensage.ImageCloseClick(Sender: TObject);
begin
        Self.Close;
end;

end.
