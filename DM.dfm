object udm: Tudm
  OldCreateOrder = False
  Height = 283
  Width = 515
  object dbMurLock: TIBDatabase
    Connected = True
    DatabaseName = 'D:\MurLock\MURLOCK.FDB'
    Params.Strings = (
      'user_name=murlock'
      'password=masterkey')
    LoginPrompt = False
    DefaultTransaction = trsMurLock
    ServerType = 'IBServer'
    Left = 24
    Top = 16
  end
  object trsMurLock: TIBTransaction
    DefaultDatabase = dbMurLock
    Left = 64
    Top = 16
  end
  object qryMain: TIBQuery
    Database = dbMurLock
    Transaction = trsMurLock
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Left = 120
    Top = 16
  end
  object qryAux: TIBQuery
    Database = dbMurLock
    Transaction = trsMurLock
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Left = 24
    Top = 64
  end
  object dtsMain: TDataSource
    DataSet = qryMain
    Left = 152
    Top = 16
  end
  object dtsAux: TDataSource
    DataSet = qryAux
    Left = 56
    Top = 64
  end
  object qryClasses: TIBQuery
    Database = dbMurLock
    Transaction = trsMurLock
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'select CLS_CODIGO, CLS_NOME, CLS_COR'
      'from CLASSE '
      ''
      'order by CLS_NOME ASC')
    Left = 24
    Top = 120
    object qryClassesCLS_CODIGO: TIntegerField
      FieldName = 'CLS_CODIGO'
      Origin = '"CLASSE"."CLS_CODIGO"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryClassesCLS_NOME: TIBStringField
      FieldName = 'CLS_NOME'
      Origin = '"CLASSE"."CLS_NOME"'
      Required = True
      Size = 30
    end
    object qryClassesCLS_COR: TIBStringField
      FieldName = 'CLS_COR'
      Origin = '"CLASSE"."CLS_COR"'
      Size = 10
    end
  end
  object dtsClasses: TDataSource
    DataSet = qryClasses
    Left = 56
    Top = 120
  end
  object qryCorClasse: TIBQuery
    Database = dbMurLock
    Transaction = trsMurLock
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'select CLS_COR from CLASSE where CLS_NOME = :NOME')
    Left = 24
    Top = 168
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'NOME'
        ParamType = ptUnknown
      end>
    object qryCorClasseCLS_COR: TIBStringField
      FieldName = 'CLS_COR'
      Origin = '"CLASSE"."CLS_COR"'
      Size = 10
    end
  end
  object dtsCorClasse: TDataSource
    DataSet = qryCorClasse
    Left = 56
    Top = 168
  end
  object qryConfigs: TIBQuery
    Database = dbMurLock
    Transaction = trsMurLock
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'select * from CONFIGS where CNF_CODIGO = 1')
    Left = 200
    Top = 16
    object qryConfigsCNF_CODIGO: TIntegerField
      FieldName = 'CNF_CODIGO'
      Origin = '"CONFIGS"."CNF_CODIGO"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryConfigsCNF_USUARIO: TIBStringField
      FieldName = 'CNF_USUARIO'
      Origin = '"CONFIGS"."CNF_USUARIO"'
      Size = 30
    end
    object qryConfigsCNF_VERSAO: TIBStringField
      FieldName = 'CNF_VERSAO'
      Origin = '"CONFIGS"."CNF_VERSAO"'
      Size = 10
    end
    object qryConfigsCNF_LOGO: TIBStringField
      FieldName = 'CNF_LOGO'
      Origin = '"CONFIGS"."CNF_LOGO"'
      Size = 350
    end
    object qryConfigsCNF_LOGO16: TIBStringField
      FieldName = 'CNF_LOGO16'
      Origin = '"CONFIGS"."CNF_LOGO16"'
      Size = 350
    end
    object qryConfigsCNF_LOCALHOST: TIBStringField
      FieldName = 'CNF_LOCALHOST'
      Origin = '"CONFIGS"."CNF_LOCALHOST"'
      Size = 350
    end
  end
  object dtsConfigs: TDataSource
    DataSet = qryConfigs
    Left = 232
    Top = 16
  end
  object dtsAuxEx: TDataSource
    DataSet = qryAuxEx
    Left = 128
    Top = 64
  end
  object qryAuxEx: TIBQuery
    Database = dbMurLock
    Transaction = trsMurLock
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Left = 96
    Top = 64
  end
end
