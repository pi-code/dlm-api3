unit MainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DavidDISAPI, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    btn1: TButton;
    pnl1: TPanel;
    mmo1: TMemo;
    pnl2: TPanel;
    btn5: TButton;
    grdpnl1: TGridPanel;
    pnl3: TPanel;
    pnl4: TPanel;
    pnl5: TPanel;
    pnl6: TPanel;
    pnl7: TPanel;
    pnl8: TPanel;
    pnl9: TPanel;
    pnl10: TPanel;
    pnl11: TPanel;
    pnl12: TPanel;
    pnl13: TPanel;
    pnl14: TPanel;
    pnl15: TPanel;
    pnl16: TPanel;
    pnl17: TPanel;
    pnl18: TPanel;
    pnl19: TPanel;
    pnl20: TPanel;
    pnl21: TPanel;
    pnl22: TPanel;
    pnl23: TPanel;
    pnl24: TPanel;
    pnl25: TPanel;
    procedure btn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn5Click(Sender: TObject);
  private
    SessionIDs : Array[1..25] of Integer;
  public
    procedure DlmCallback(pParameters: pointer; pResult: pointer; pInput: pointer); stdcall;
  end;

  procedure callback(pParameters: pointer; pResult: pointer; pInput: pointer);stdcall;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses
  System.IniFiles,
  uLogging;


procedure Log(Msg : String);
begin
  try
    Form1.mmo1.Lines.Add(Msg);
  except

  end;
end;

procedure TForm1.btn1Click(Sender: TObject);
var
  ret : Integer;
  i : Integer;
  c : TPanel;
  ini : TIniFile;
  pnlName : string;
  Recorder, Password : AnsiString;
  Camera : Integer;
begin
  try
    ret := dlm_config(-1, '<DlmSDK><DlmConfig><Information AppName="Triple-M" /></DlmConfig></DlmSDK>');
    Log('SetAppName: ' + IntToStr(ret));
    ret := dlm_config(-1, '<DlmSDK><DlmConfig><Display UseDirect3D="1" /></DlmConfig></DlmSDK>');
    Log('UseDirect3D: ' + IntToStr(ret));

    ini := TIniFile.Create(IniFileName);

    for i := Low(SessionIDs) to High(SessionIDs) do
    begin
      pnlName := Format('pnl%d', [i]);

      if not ini.SectionExists(pnlName) then break;

      c := TPanel(FindComponent(pnlName));

      Recorder := ini.ReadString(pnlName, 'Recorder', '127.0.0.1');
      Password := ini.ReadString(pnlName, 'Password', '3');
      Camera := ini.ReadInteger(pnlName, 'Camera', 1);

      SessionIDs[i] := dlm_connect(c.Handle, PAnsiChar(Recorder), '', PAnsiChar(Password), '', '', @callback, nil);
      ret := dlm_config(SessionIDs[i], '<DlmSDK><DlmConfig><Video EnableGPUDecoder="1" /></DlmConfig></DlmSDK>');
      Log('EnableGPUDecoder: ' + IntToStr(ret));
      ret := dlm_config(SessionIDs[i], '<DlmSDK><DlmConfig><Live use_multicast="1" /><Display ShowStreamInfo="1" /></DlmConfig></DlmSDK>');
      ret := dlm_showLive(SessionIDs[i], Camera, @Callback, nil);
    end;
  except

  end;
end;

procedure TForm1.btn5Click(Sender: TObject);
var
  i : Integer;
begin
    for i := Low(SessionIDs) to High(SessionIDs) do
    begin
      try
        dlm_disconnect(SessionIDs[i], nil, nil);
        TPanel(FindComponent(Format('pnl%d', [i]))).Refresh;
      except
      end;
    end;
end;

procedure TForm1.DlmCallback(pParameters, pResult, pInput: pointer);
var
  p: PConnectCallbackData;
  p2: PNavigateTrackCallbackData;
  p4: PSearchResultXML;
begin

  try

  try

    p:= pParameters;

    Log('Callback API -> FuncID='+inttostr(p.ulFunctionID)+' Result:'+inttostr(pInteger(pResult)^));

    case p.ulFunctionID of

      1: if pInteger(pResult)^=0 then begin

        Log('APIState:= isConnected');

        //iInternalState:= isConnected;

      end else begin

        Log('APIState:= isConnectingError');

        //iInternalState:= isConnectingError;

        //inc(iConnectingTrials);

      end;

      5: begin

           //iInternalState:= isClosed;

        p4 := pResult;

        Log('APIState:= isConnectionClosed ' + IntToStr(p4.ResultCode));


      end;

      100: if pInteger(pResult) ^= 0 then begin
        p4 := pResult;
        Log('ShowRecorderInfo: ' + p4.XML);
      end;

      200: if pInteger(pResult)^=0 then begin

        Log('APIState:= isLive');

        //iInternalState:= isLive;

      end else begin

        Log('APIState:= isConnected');

        //iInternalState:= isConnected;

      end;

      300: if pInteger(pResult)^=0 then begin

        Log('APIState:= isPlay');

        //iInternalState:= isPlay;

      end else begin

        Log('APIState:= isConnected');

        //iInternalState:= isConnected;

      end;

      301: if pInteger(pResult)^=0 then begin

        Log('APIState:= isNavigated');

        //iInternalState:= isNavigated;

      end else begin

        Log('APIState:= isNavigatingFailed');

        //iInternalState:= isNavigatedFailed;

        //inc(iNavigatingTrials);

      end;

      600: begin

        //Smartfinder-Result

        Log('Smartfinder-Result');

        p4:= pResult;

        if (p4.ResultCode=0) then begin

          if p4.XML=nil then begin

            Log('ResultCode=0 but xml is empty!');

            //ParseXMLSmartFInderResult(LastXMLResult);

            //iInternalState:= isSmartFinderReady;

          end else if lowercase(p4.xml)='finished' then

          begin

            Log('Finished');

            //iInternalState:= isSmartFinderReady;

          end else begin

            Log('Append result: '+p4.XML);

            //WriteLn(fResultTextFile,p4.xml);

            //ParseXMLSmartFInderResult(p4.xml);

          end;

        end else if p4.ResultCode=-3000 then begin

          Log('-3000 Picture not found');

          //iInternalState:= isSmartFinderReady;

        end else if p4.ResultCode=-55 then begin

          Log('More Results available');

          //bSFMoreResults:= True;

          //ParseXMLSmartFInderResult(LastXMLResult);

          //iInternalState:= isSmartFinderReady;

        end else begin

          Log('APIState:= isSmartfinderReady');

          //iInternalState:= isSmartFinderReady;

        end;

      end;

    end;

    finally

    end;

  except

    on E:Exception do

      Log('Error in Callback: '+E.Message);

  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  i : Integer;
begin
  for i := Low(SessionIDs) to High(SessionIDs) do
  begin
    SessionIDs[i] := -1;
  end;

  mmo1.Clear;
end;

procedure callback(pParameters: pointer; pResult: pointer; pInput: pointer);
var

  p: PConnectCallbackData;

  p2: PNavigateTrackCallbackData;

  p4: PSearchResultXML;

begin

  try

  try

    p:= pParameters;

    Log('Callback API -> FuncID='+inttostr(p.ulFunctionID)+' Result:'+inttostr(pInteger(pResult)^));

    case p.ulFunctionID of

      1: if pInteger(pResult)^=0 then begin

        Log('APIState:= isConnected');

        //iInternalState:= isConnected;

      end else begin

        Log('APIState:= isConnectingError');

        //iInternalState:= isConnectingError;

        //inc(iConnectingTrials);

      end;

      5: begin

           //iInternalState:= isClosed;

        p4 := pResult;

        Log('APIState:= isConnectionClosed ' + IntToStr(p4.ResultCode));


      end;

      100: if pInteger(pResult) ^= 0 then begin
        p4 := pResult;
        Log('ShowRecorderInfo: ' + p4.XML);
      end;

      200: if pInteger(pResult)^=0 then begin

        Log('APIState:= isLive');

        //iInternalState:= isLive;

      end else begin

        Log('APIState:= isConnected');

        //iInternalState:= isConnected;

      end;

      300: if pInteger(pResult)^=0 then begin

        Log('APIState:= isPlay');

        //iInternalState:= isPlay;

      end else begin

        Log('APIState:= isConnected');

        //iInternalState:= isConnected;

      end;

      301: if pInteger(pResult)^=0 then begin

        Log('APIState:= isNavigated');

        //iInternalState:= isNavigated;

      end else begin

        Log('APIState:= isNavigatingFailed');

        //iInternalState:= isNavigatedFailed;

        //inc(iNavigatingTrials);

      end;

      600: begin

        //Smartfinder-Result

        Log('Smartfinder-Result');

        p4:= pResult;

        if (p4.ResultCode=0) then begin

          if p4.XML=nil then begin

            Log('ResultCode=0 but xml is empty!');

            //ParseXMLSmartFInderResult(LastXMLResult);

            //iInternalState:= isSmartFinderReady;

          end else if lowercase(p4.xml)='finished' then

          begin

            Log('Finished');

            //iInternalState:= isSmartFinderReady;

          end else begin

            Log('Append result: '+p4.XML);

            //WriteLn(fResultTextFile,p4.xml);

            //ParseXMLSmartFInderResult(p4.xml);

          end;

        end else if p4.ResultCode=-3000 then begin

          Log('-3000 Picture not found');

          //iInternalState:= isSmartFinderReady;

        end else if p4.ResultCode=-55 then begin

          Log('More Results available');

          //bSFMoreResults:= True;

          //ParseXMLSmartFInderResult(LastXMLResult);

          //iInternalState:= isSmartFinderReady;

        end else begin

          Log('APIState:= isSmartfinderReady');

          //iInternalState:= isSmartFinderReady;

        end;

      end;

    end;

    finally

    end;

  except

    on E:Exception do

      Log('Error in Callback: '+E.Message);

  end;
  end;

end.
