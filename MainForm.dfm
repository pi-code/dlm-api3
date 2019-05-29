object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 614
  ClientWidth = 993
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
    Left = 720
    Top = 64
    Width = 75
    Height = 25
    Caption = 'btn1'
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
    Top = 374
    Width = 977
    Height = 232
    Lines.Strings = (
      'mmo1')
    TabOrder = 2
  end
end
