unit UnitCredito;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects;

type
  TFormCredito = class(TForm)
    EllipseCredito: TEllipse;
    TextNome: TText;
    ImageExit: TImage;
    TextGit: TText;
    TextGitLink: TText;
    TextDataLancamento: TText;
    ImageLogoCredito: TImage;
    procedure ImageExitClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormCredito: TFormCredito;

implementation

Uses
        UnitMenu;

{$R *.fmx}

procedure TFormCredito.ImageExitClick(Sender: TObject);
begin
        FormMenu.Visible := True;
        self.Close;
end;

end.
