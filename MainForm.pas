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
    btn2: TButton;
    pnl2: TPanel;
    btn3: TButton;
    btn4: TButton;
    btn5: TButton;
    btn6: TButton;
    procedure btn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure btn4Click(Sender: TObject);
    procedure btn3Click(Sender: TObject);
    procedure btn5Click(Sender: TObject);
    procedure btn6Click(Sender: TObject);
  private
    SessionID : Integer;
    SessionID2 : Integer;
  public
    procedure DlmCallback(pParameters: pointer; pResult: pointer; pInput: pointer); stdcall;
  end;

  procedure callback(pParameters: pointer; pResult: pointer; pInput: pointer);stdcall;

var
  Form1: TForm1;

implementation

{$R *.dfm}


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
begin
  ret := dlm_config(-1, '<DlmSDK><DlmConfig><Information AppName="Triple-M" /></DlmConfig></DlmSDK>');
  Log('SetAppName: ' + IntToStr(ret));
  ret := dlm_config(-1, '<DlmSDK><DlmConfig><Display UseDirect3D="1" /></DlmConfig></DlmSDK>');
  Log('UseDirect3D: ' + IntToStr(ret));

  SessionId := dlm_connect(pnl1.Handle, '192.168.1.59', '', '3', '', '', @callback, nil);

  ret := dlm_config(sessionID, '<DlmSDK><DlmConfig><Video EnableGPUDecoder="1" /></DlmConfig></DlmSDK>');
  Log('EnableGPUDecoder: ' + IntToStr(ret));
end;

procedure TForm1.btn2Click(Sender: TObject);
var
  ret : Integer;
begin
  ret := dlm_showLive(SessionID, 1, @callback, nil);

  Log('dlm_showLive: ' + IntToStr(ret));
end;

procedure TForm1.btn3Click(Sender: TObject);
var
  ret : Integer;
begin
  ret := dlm_showLive(SessionID2, 1, @callback, nil);

  Log('dlm_showLive: ' + IntToStr(ret));

end;

procedure TForm1.btn4Click(Sender: TObject);
var
  ret : Integer;
begin
  ret := dlm_config(-1, '<DlmSDK><DlmConfig><Information AppName="Triple-M" /></DlmConfig></DlmSDK>');
  Log('SetAppName: ' + IntToStr(ret));
  ret := dlm_config(-1, '<DlmSDK><DlmConfig><Display UseDirect3D="1" /></DlmConfig></DlmSDK>');
  Log('UseDirect3D: ' + IntToStr(ret));

  SessionId2 := dlm_connect(pnl2.Handle, '192.168.1.59', '', '3', '', '', @callback, nil);

  ret := dlm_config(sessionID2, '<DlmSDK><DlmConfig><Video EnableGPUDecoder="1" /></DlmConfig></DlmSDK>');
  Log('EnableGPUDecoder: ' + IntToStr(ret));
end;

procedure TForm1.btn5Click(Sender: TObject);
begin
  dlm_disconnect(SessionID, nil, nil);
  pnl1.Refresh;
end;

procedure TForm1.btn6Click(Sender: TObject);
begin
  dlm_disconnect(SessionID2, nil, nil);
  pnl2.Refresh;
end;

procedure TForm1.DlmCallback(pParameters, pResult, pInput: pointer);
begin

end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  SessionID := -1;
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
