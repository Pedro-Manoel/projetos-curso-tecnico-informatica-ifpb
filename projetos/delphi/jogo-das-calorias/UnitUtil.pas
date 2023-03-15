unit UnitUtil;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls;

Procedure textMove(text:TText);//Quando o mouse se mover pelo Text
Procedure textLeave(text:TText);//Quando o mouse se move fora do Text


implementation

Uses UnitMenu;

Procedure textMove(text:TText);
begin
        text.TextSettings.FontColor := (4294598446); // vermelho personalizado
end;

Procedure textLeave(text:TText);
begin
        text.TextSettings.FontColor := (4294611246); // Laranja personalizado
end;

end.

