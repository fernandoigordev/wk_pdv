object frmViewSearch: TfrmViewSearch
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  ClientHeight = 332
  ClientWidth = 594
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 594
    Height = 73
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Panel1'
    Color = 6332174
    ParentBackground = False
    ShowCaption = False
    TabOrder = 0
    object lbTitle: TLabel
      AlignWithMargins = True
      Left = 10
      Top = 3
      Width = 581
      Height = 67
      Margins.Left = 10
      Align = alClient
      Caption = 'Clientes Cadastrados'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      Layout = tlCenter
      ExplicitWidth = 172
      ExplicitHeight = 19
    end
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 73
    Width = 594
    Height = 259
    Align = alClient
    DataSource = dsSearch
    Options = [dgTitles, dgIndicator, dgColLines, dgTabs, dgRowSelect, dgCancelOnExit, dgMultiSelect, dgTitleClick, dgTitleHotTrack]
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnDblClick = DBGrid1DblClick
    OnKeyUp = DBGrid1KeyUp
  end
  object dsSearch: TDataSource
    Left = 304
    Top = 168
  end
end
