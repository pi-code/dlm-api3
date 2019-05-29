object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 846
  ClientWidth = 1387
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object btn1: TButton
    Left = 8
    Top = 374
    Width = 113
    Height = 25
    Caption = 'connect'
    TabOrder = 0
    OnClick = btn1Click
  end
  object pnl1: TPanel
    Left = 8
    Top = 8
    Width = 640
    Height = 360
    Caption = 'pnl1'
    TabOrder = 1
  end
  object mmo1: TMemo
    Left = 8
    Top = 606
    Width = 1371
    Height = 232
    Lines.Strings = (
      'mmo1')
    TabOrder = 2
  end
  object btn2: TButton
    Left = 8
    Top = 405
    Width = 113
    Height = 25
    Caption = 'live'
    TabOrder = 3
    OnClick = btn2Click
  end
  object pnl2: TPanel
    Left = 654
    Top = 8
    Width = 640
    Height = 360
    Caption = 'pnl1'
    TabOrder = 4
  end
  object btn3: TButton
    Left = 654
    Top = 405
    Width = 113
    Height = 25
    Caption = 'live'
    TabOrder = 5
    OnClick = btn3Click
  end
  object btn4: TButton
    Left = 654
    Top = 374
    Width = 113
    Height = 25
    Caption = 'connect'
    TabOrder = 6
    OnClick = btn4Click
  end
  object btn5: TButton
    Left = 8
    Top = 436
    Width = 113
    Height = 25
    Caption = 'disconnect'
    TabOrder = 7
    OnClick = btn5Click
  end
  object btn6: TButton
    Left = 654
    Top = 436
    Width = 113
    Height = 25
    Caption = 'disconnect'
    TabOrder = 8
    OnClick = btn6Click
  end
end
