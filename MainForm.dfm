object FormMain: TFormMain
  Left = 0
  Top = 0
  Caption = 'FormMain'
  ClientHeight = 618
  ClientWidth = 1113
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 16
    Top = 477
    Width = 75
    Height = 25
    Caption = #1057#1090#1072#1088#1090
    TabOrder = 0
    OnClick = Button1Click
  end
  object Edit1: TEdit
    Left = 16
    Top = 508
    Width = 1089
    Height = 21
    TabOrder = 1
    Text = 'Edit1'
  end
  object Button2: TButton
    Left = 793
    Top = 477
    Width = 312
    Height = 25
    Caption = 'Parse - '#1042#1099#1073#1080#1088#1072#1077#1090' '#1088#1077#1082#1083#1072#1084#1085#1099#1077' '#1089#1089#1099#1083#1082#1080
    TabOrder = 2
    OnClick = Button2Click
  end
  object Edit2: TEdit
    Left = 16
    Top = 535
    Width = 1089
    Height = 21
    TabOrder = 3
    Text = 'Edit2'
  end
  object Edit3: TEdit
    Left = 16
    Top = 562
    Width = 1089
    Height = 21
    TabOrder = 4
    Text = 'Edit3'
  end
  object Edit4: TEdit
    Left = 16
    Top = 589
    Width = 1089
    Height = 21
    TabOrder = 5
    Text = 'Edit4'
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 1113
    Height = 471
    ActivePage = TabSheet2
    Align = alTop
    TabOrder = 6
    object TabSheet2: TTabSheet
      Caption = 'Log'
      ImageIndex = 1
      ExplicitWidth = 281
      ExplicitHeight = 165
      object Memo2: TMemo
        Left = 19
        Top = 16
        Width = 1070
        Height = 424
        ScrollBars = ssBoth
        TabOrder = 0
      end
    end
    object TabSheet1: TTabSheet
      Caption = 'Html code'
      ExplicitHeight = 169
      object Memo1: TMemo
        Left = 19
        Top = 16
        Width = 1070
        Height = 424
        ScrollBars = ssVertical
        TabOrder = 0
      end
    end
  end
  object Button3: TButton
    Left = 475
    Top = 477
    Width = 312
    Height = 25
    Caption = 'Parse - '#1042#1099#1073#1080#1088#1072#1077#1090' '#1089#1089#1099#1083#1082#1091' '#1089' '#1084#1086#1080#1084' '#1089#1072#1081#1090#1086#1084' '#1085#1072' '#1087#1088#1086#1082#1089#1080'-'#1089#1072#1081#1090
    TabOrder = 7
    OnClick = Button3Click
  end
end
