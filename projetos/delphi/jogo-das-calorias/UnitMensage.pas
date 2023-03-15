unit UnitMensage;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects;

type
  TFormMensage = class(TForm)
    RectangleMsg: TRectangle;
    ImageExit: TImage;
    TextAviso: TText;
    TextDetalhas: TText;
    procedure ImageExitClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormMensage: TFormMensage;

implementation

{$R *.fmx}

procedure TFormMensage.ImageExitClick(Sender: TObject);
begin
        Self.Close;

end;

end.
