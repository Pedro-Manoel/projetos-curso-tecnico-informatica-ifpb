unit UnitDataPerfil;

interface

uses
  System.SysUtils, System.Classes, Data.DB, dbf, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TDataPerfil = class(TDataModule)
    DataSourceNovoPerfil: TDataSource;
    Connection: TFDConnection;
    Query: TFDQuery;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DataPerfil: TDataPerfil;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
