object Date: TDate
  OldCreateOrder = False
  Height = 168
  Width = 248
  object Connection: TFDConnection
    Params.Strings = (
      
        'Database=C:\Users\Pedro\Documents\Jogos e projetos Melhorados\Jo' +
        'go das Calorias\Win32\Debug\date\date.db'
      'DriverID=sQLite')
    LoginPrompt = False
    Left = 48
    Top = 64
  end
  object Query: TFDQuery
    Connection = Connection
    SQL.Strings = (
      'select * from comida')
    Left = 160
    Top = 64
  end
end
