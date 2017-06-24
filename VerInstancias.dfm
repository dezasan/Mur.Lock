object frmVerInstancias: TfrmVerInstancias
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Mur.Lock - Ver inst'#226'ncias'
  ClientHeight = 327
  ClientWidth = 595
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnFundo: TPanel
    Left = 0
    Top = 0
    Width = 595
    Height = 327
    Align = alClient
    BevelInner = bvLowered
    TabOrder = 0
    object lbTitulo: TLabel
      Left = 20
      Top = 15
      Width = 184
      Height = 38
      Caption = 'Ver Instancias'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 53760
      Font.Height = -35
      Font.Name = 'LifeCraft'
      Font.Style = []
      ParentFont = False
    end
    object lbPersonagem: TLabel
      Left = 458
      Top = 21
      Width = 116
      Height = 30
      Alignment = taRightJustify
      Caption = 'Personagem'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 1871359
      Font.Height = -27
      Font.Name = 'LifeCraft'
      Font.Style = []
      ParentFont = False
    end
    object gdDados: TDBGrid
      Left = 2
      Top = 59
      Width = 591
      Height = 266
      Align = alBottom
      DataSource = dtsGrid
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      OnKeyDown = gdDadosKeyDown
      Columns = <
        item
          Expanded = False
          FieldName = 'INS'
          Title.Alignment = taCenter
          Title.Caption = 'C'#211'D.'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 40
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'DT'
          Title.Alignment = taCenter
          Title.Caption = 'DATA'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 70
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'LGRTIPO'
          Title.Alignment = taCenter
          Title.Caption = 'TIPO'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 35
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'DIF'
          Title.Alignment = taCenter
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 55
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'LGR'
          Title.Caption = ' LUGAR'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 230
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'ILVL'
          Title.Alignment = taCenter
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 45
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DPS'
          Title.Alignment = taCenter
          Title.Caption = 'DPS (k)'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 77
          Visible = True
        end>
    end
  end
  object qryGrid: TIBQuery
    Database = udm.dbMurLock
    Transaction = udm.trsMurLock
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'select'
      '    I.INS_CODIGO as INS,'
      '    I.INS_DATA as DT,'
      '    I.INS_ILVL as ILVL,'
      '    I.INS_DANO as DPS,'
      '    L.LGR_NOME as LGR,'
      '    L.LGR_TIPO as LGRTIPO,'
      '    I.INS_DIFICULDADE||coalesce(I.INS_PLUS,'#39' '#39') as DIF'
      ''
      'from INSTANCIA I'
      'left outer join LUGAR L on L.LGR_CODIGO = I.LGR_CODIGO'
      ''
      'where I.PRS_CODIGO = :PERSO'
      ''
      'order by I.INS_DATA DESC, L.LGR_TIPO ASC, L.LGR_NOME')
    Left = 454
    Top = 125
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PERSO'
        ParamType = ptUnknown
      end>
    object qryGridINS: TIntegerField
      FieldName = 'INS'
      Origin = '"INSTANCIA"."INS_CODIGO"'
      Required = True
    end
    object qryGridDT: TDateField
      FieldName = 'DT'
      Origin = '"INSTANCIA"."INS_DATA"'
    end
    object qryGridILVL: TIntegerField
      FieldName = 'ILVL'
      Origin = '"INSTANCIA"."INS_ILVL"'
    end
    object qryGridDPS: TFloatField
      FieldName = 'DPS'
      Origin = '"INSTANCIA"."INS_DANO"'
      Required = True
    end
    object qryGridLGR: TIBStringField
      FieldName = 'LGR'
      Origin = '"LUGAR"."LGR_NOME"'
      Size = 60
    end
    object qryGridLGRTIPO: TIBStringField
      FieldName = 'LGRTIPO'
      Origin = '"LUGAR"."LGR_TIPO"'
      Size = 2
    end
    object qryGridDIF: TIBStringField
      FieldName = 'DIF'
      ProviderFlags = []
      Size = 16
    end
  end
  object dspGrid: TDataSetProvider
    DataSet = qryGrid
    Left = 485
    Top = 125
  end
  object cdsGrid: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspGrid'
    Left = 516
    Top = 125
    object cdsGridINS: TIntegerField
      FieldName = 'INS'
      Required = True
    end
    object cdsGridDT: TDateField
      FieldName = 'DT'
    end
    object cdsGridILVL: TIntegerField
      FieldName = 'ILVL'
    end
    object cdsGridDPS: TFloatField
      FieldName = 'DPS'
      Required = True
    end
    object cdsGridLGR: TWideStringField
      FieldName = 'LGR'
      Size = 60
    end
    object cdsGridLGRTIPO: TWideStringField
      FieldName = 'LGRTIPO'
      Size = 2
    end
    object cdsGridDIF: TWideStringField
      FieldName = 'DIF'
      Size = 16
    end
  end
  object dtsGrid: TDataSource
    DataSet = cdsGrid
    Left = 547
    Top = 125
  end
end
