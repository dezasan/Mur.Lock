object frmCadPersonagem: TfrmCadPersonagem
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Mur.Lock - Novo personagem'
  ClientHeight = 263
  ClientWidth = 484
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object painel: TPanel
    Left = 0
    Top = 0
    Width = 484
    Height = 263
    Align = alClient
    BevelInner = bvLowered
    TabOrder = 0
    object lbNome: TLabel
      Left = 15
      Top = 59
      Width = 27
      Height = 13
      Caption = 'Nome'
    end
    object lbClasse: TLabel
      Left = 231
      Top = 59
      Width = 31
      Height = 13
      Caption = 'Classe'
    end
    object lbTitulo: TLabel
      Left = 15
      Top = 15
      Width = 148
      Height = 38
      Caption = 'Personagem'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 53760
      Font.Height = -35
      Font.Name = 'LifeCraft'
      Font.Style = []
      ParentFont = False
    end
    object edNome: TEdit
      Left = 15
      Top = 78
      Width = 210
      Height = 21
      TabOrder = 0
    end
    object cbxClasse: TDBLookupComboBox
      Left = 231
      Top = 78
      Width = 142
      Height = 21
      DropDownRows = 5
      KeyField = 'CLS_CODIGO'
      ListField = 'CLS_NOME'
      ListSource = udm.dtsClasses
      TabOrder = 1
      OnClick = cbxClasseClick
    end
    object btSalvar: TBitBtn
      Left = 379
      Top = 70
      Width = 94
      Height = 37
      Caption = 'Salvar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -24
      Font.Name = 'LifeCraft'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = btSalvarClick
    end
    object grdPerso: TDBGrid
      Left = 15
      Top = 117
      Width = 458
      Height = 135
      DataSource = dtsGrid
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      TabOrder = 3
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      OnKeyDown = grdPersoKeyDown
      Columns = <
        item
          Expanded = False
          FieldName = 'PRS_CODIGO'
          Title.Alignment = taCenter
          Title.Caption = 'COD.'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'PRS_NOME'
          Title.Caption = ' NOME'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 275
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'CLS_NOME'
          Title.Alignment = taCenter
          Title.Caption = 'CLASSE'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 148
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
      'select P.PRS_CODIGO, P.PRS_NOME, C.CLS_NOME '
      ''
      'from PERSONAGEM P'
      'left outer join CLASSE C on C.CLS_CODIGO = P.CLS_CODIGO'
      ''
      'order by P.PRS_NOME ASC')
    Left = 248
    Top = 192
    object qryGridPRS_CODIGO: TIntegerField
      FieldName = 'PRS_CODIGO'
      Origin = '"PERSONAGEM"."PRS_CODIGO"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryGridPRS_NOME: TIBStringField
      FieldName = 'PRS_NOME'
      Origin = '"PERSONAGEM"."PRS_NOME"'
      Required = True
      Size = 30
    end
    object qryGridCLS_NOME: TIBStringField
      FieldName = 'CLS_NOME'
      Origin = '"CLASSE"."CLS_NOME"'
      Size = 30
    end
  end
  object dspGrid: TDataSetProvider
    DataSet = qryGrid
    Left = 280
    Top = 192
  end
  object cdsGrid: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspGrid'
    Left = 312
    Top = 192
    object cdsGridPRS_CODIGO: TIntegerField
      FieldName = 'PRS_CODIGO'
      Origin = '"PERSONAGEM"."PRS_CODIGO"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object cdsGridPRS_NOME: TWideStringField
      FieldName = 'PRS_NOME'
      Origin = '"PERSONAGEM"."PRS_NOME"'
      Required = True
      Size = 30
    end
    object cdsGridCLS_NOME: TWideStringField
      FieldName = 'CLS_NOME'
      Origin = '"CLASSE"."CLS_NOME"'
      Size = 30
    end
  end
  object dtsGrid: TDataSource
    DataSet = cdsGrid
    Left = 344
    Top = 192
  end
end
