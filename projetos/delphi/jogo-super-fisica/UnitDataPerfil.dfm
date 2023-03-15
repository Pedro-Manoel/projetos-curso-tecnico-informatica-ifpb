object DataPerfil: TDataPerfil
  OldCreateOrder = False
  Height = 251
  Width = 366
  object DataSourceNovoPerfil: TDataSource
    DataSet = Query
    Left = 208
    Top = 80
  end
  object Connection: TFDConnection
    Params.Strings = (
      
        'Database=C:\Users\Pedro\Documents\Jogos e projetos Melhorados\Jo' +
        'go SuperF'#237'sica\date.db'
      'ConnectionDef=SQLite_Demo')
    LoginPrompt = False
    Left = 152
    Top = 16
  end
  object Query: TFDQuery
    Connection = Connection
    SQL.Strings = (
      'select * from perfil')
    Left = 88
    Top = 80
  end
end
