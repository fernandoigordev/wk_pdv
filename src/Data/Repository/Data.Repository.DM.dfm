object DM: TDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 232
  Width = 408
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=C:\Repositories\wk_pdv\dataBase.sqlite'
      'DriverID=SQLite')
    LoginPrompt = False
    Left = 56
    Top = 40
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 232
    Top = 24
  end
  object FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink
    Left = 256
    Top = 120
  end
  object QSearchCustomer: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'select * from customer')
    Left = 48
    Top = 104
    object QSearchCustomercode: TFDAutoIncField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'code'
      Origin = 'code'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object QSearchCustomername: TWideStringField
      DisplayLabel = 'Nome'
      DisplayWidth = 30
      FieldName = 'name'
      Origin = 'name'
      Required = True
      Size = 50
    end
    object QSearchCustomercity: TWideStringField
      DisplayLabel = 'Cidade'
      DisplayWidth = 20
      FieldName = 'city'
      Origin = 'city'
      Required = True
      Size = 50
    end
    object QSearchCustomeruf: TWideStringField
      DisplayLabel = 'Estado'
      DisplayWidth = 10
      FieldName = 'uf'
      Origin = 'uf'
      Required = True
      Size = 50
    end
  end
  object QSearchOrder: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'select * from "order"')
    Left = 40
    Top = 168
    object QSearchOrdercode: TIntegerField
      FieldName = 'code'
      Origin = 'code'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object QSearchOrdercompleted_date: TWideStringField
      DisplayWidth = 20
      FieldName = 'completed_date'
      Origin = 'completed_date'
      Required = True
      Size = 32767
    end
    object QSearchOrdertotal: TFloatField
      FieldName = 'total'
      Origin = 'total'
      Required = True
      currency = True
    end
  end
end
