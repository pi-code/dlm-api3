unit DavidDISAPI;

interface
uses
  Windows;//, uGlobalLog;

var
  DLLLoaded: Boolean = False;
  sessionHandle : Integer;


Type
  Tdlm_initSDK= function:integer; stdcall;
  Tdlm_shutdownSDK= function: integer; stdcall;
  Tdlm_connect= function(ulWindowHandle: cardinal;
                        strIP: PAnsiChar;
                        strUser1: PAnsiChar;
                        strPwd1: PAnsiChar;
                        strUser2: PAnsiChar;
                        strPWD2: PAnsiChar;
                        pParameters: pointer;
                        pInput: Pointer): integer stdcall;

  TDlm_CreateSession = function : Integer; stdcall;

  TDlm_ConnectSession = function(SessionID: Integer;
                        ulWindowHandle: cardinal;
                        strIP: PAnsiChar;
                        strUser1: PAnsiChar;
                        strPwd1: PAnsiChar;
                        strUser2: PAnsiChar;
                        strPWD2: PAnsiChar;
                        pParameters: pointer;
                        pInput: Pointer): integer stdcall;

  Tdlm_connectSocket= function(ulSocketHandle: LongInt;
                              ulWindowHandle: LongInt;
                              const strIP: PChar;
                              const strUser1: PChar;
                              const strPwd1: PChar;
                              const strUser2: PChar;
                              const strPWD2: PChar;
                              pParameters: pointer;
                              pInput: pointer
                              )
: integer stdcall;

  Tdlm_disconnect= function(SessionHandle: Integer;
                           pParameters: pointer;
                           pInput: Pointer): integer stdcall;

  Tdlm_mute= function(SessionHandle: Integer;
                     bSoundOff: byte): integer stdcall;

  Tdlm_showRecorderinfo= function(SessionHandle: Integer;
                                 bUpdateNow: byte;
                                 pParameters: pointer;
                                 pInput: Pointer): integer stdcall;

  Tdlm_showLive= function(SessionHandle: Integer;
                         ulCamera: LongInt;
                         pParameters: pointer;
                         pInput: Pointer): integer stdcall;

  Tdlm_redraw= function(SessionHandle: Integer): integer stdcall;

  Tdlm_sendTransparent= function(SessionHandle: Integer;
                                ulPort: LongInt;
                                const pchDataChunk: PChar;
                                ulLength: LongInt;
                                pParameters: pointer;
                                pInput: Pointer): integer stdcall;

  Tdlm_showTrack= function(SessionHandle: Integer;
                          ulTrackID: LongInt;
                          pParameters: pointer;
                          pInput: Pointer): integer stdcall;

  Tdlm_showFileTrack= function(SessionHandle: Integer;
                              const pchFilename: PChar;
                              pParameters: pointer;
                              pInput: Pointer): integer stdcall;

  Tdlm_navigateTrack= function(SessionHandle: Integer;
                              ulCommand: LongInt;
                              liAddData: int64;
                              ulCameraFilter: LongInt;
                              bUseDB: byte;
                              pParameters: pointer;
                              pInput: Pointer): integer stdcall;
  Tdlm_backup= function(SessionHandle: Integer;
                       ulCameraFilter: LongInt;
                       liStartTimestamp: int64;
                       liStopTimestamp: int64;
                       const pchFilename: PChar;
                       const pchFormat: PChar;
                       pParameters: pointer;
                       pInput: Pointer
                       ): integer stdcall;

  Tdlm_export= function(SessionHandle: Integer;
                       const pchFilename: PChar;
                       const pchFormat: PChar): integer stdcall;

  Tdlm_search= function(SessionHandle: Integer;
                       ulCameraFilter: longint;
                       liStartTimestamp: int64;
                       liStopTimestamp: int64;
                       pchCriteria: pointer;
                       pParameters: pointer;
                       pInput: Pointer): integer stdcall;

  Tdlm_cancel= function(SessionHandle: Integer;
                       pParameters: pointer;
                       pInput: Pointer): integer stdcall;


  Tdlm_getConnectedCameras= function(SessionHandle: Integer;
                                    pParameters: pointer;
                                    pInput: Pointer): integer stdcall;
  Tdlm_getTrackList= function(SessionHandle: Integer;
                             pParameters: pointer;
                             pInput: Pointer): integer stdcall;

  Tdlm_getTrackSettings= function(SessionHandle: Integer;
                                 TrackID: LongInt;
                                 pParameters: pointer;
                                 pInput: Pointer): integer stdcall;


  Tdlm_getConnectionState= function(SessionHandle: Integer): integer stdcall;

  Tdlm_getDisplayMode= function(SesisonHandle: Integer): integer stdcall;

  Tdlm_getNavigationMode= function(SesisonHandle: Integer): integer stdcall;

  Tdlm_getCameraName= function(SessionHandle: Integer;
                              pchCamName: PChar;
                              ulSize: LongInt): integer stdcall;

  Tdlm_mirrorSession= function(SessionHandle: Integer;
                              bStart: byte;
                              const pchFileName: PChar;
                              pParameters: pointer;
                              pInput: Pointer): integer stdcall;

  Tdlm_getImageInfo= function(SessionHandle: Integer;
                             pchImageInfo: PChar;
                             ulSize: LongInt): integer stdcall;

  Tdlm_isWaitingForCallback= function(SessionHandle: Integer): byte stdcall;

  Tdlm_changeRectOld= function(SessionHandle: Integer;
                              iRectID: Integer;
                              irtx: Integer;
                              irty: Integer;
                              ilbx: Integer;
                              ilby: Integer): integer stdcall;

  Tdlm_config= function(SessionHandle: Integer;
                       const pchStrConfig: PAnsiChar): integer stdcall;

  Tdlm_configProp= function(SessionHandle: Integer;
                           const pchStrConfigProp: PChar;
                           ulLength: LongInt): integer stdcall;

  Tdlm_configPropDevice= function(SessionHandle: Integer;
                                 const pchStrConfigProp: PChar;
                                 pParameters: pointer;
                                 pInput: Pointer): integer stdcall;

  Tdlm_setEncDataCallback= function(SessionHandle: Integer;
                                   pCallback: pointer): int64 stdcall;

  Tdlm_setYUVDataCallback= function(SessionHandle: Integer;
                                   pCallback: pointer): int64 stdcall;

  Tdlm_getLastError= function: integer stdcall;

  Tdlm_getCurrentSec= function(SessionHandle: Integer): integer stdcall;

  Tdlm_getCurrentMilliSec= function(SessionHandle: Integer): integer stdcall;

  Tdlm_setAddInfoCallback= function(SessionHandle: Integer;
                                   pCallback: pointer): integer stdcall;

  Tdlm_getVersion= function(SessionHandle: Integer;
                           pchVersion: PChar;
                           ulSize: LongInt): integer stdcall;

var
  dlm_getVersion: Tdlm_getVersion;
  dlm_initSDK: Tdlm_initSDK;
  dlm_navigateTrack: Tdlm_navigateTrack;
  dlm_showRecorderinfo: Tdlm_showRecorderinfo;
  dlm_shutdownSDK: Tdlm_shutdownSDK;
  dlm_connect: Tdlm_connect;
  dlm_createSession : TDlm_CreateSession;
  dlm_connectSession : TDlm_ConnectSession;
  dlm_connectSocket: Tdlm_connectSocket;
  dlm_disconnect: Tdlm_disconnect;
  dlm_mute: Tdlm_mute;
  dlm_showLive: Tdlm_showLive;
  dlm_redraw: Tdlm_redraw;
  dlm_sendTransparent: Tdlm_sendTransparent;
  dlm_showTrack: Tdlm_showTrack;
  dlm_showFileTrack: Tdlm_showFileTrack;
  dlm_backup: Tdlm_backup;
  dlm_export: Tdlm_export;
  dlm_search: Tdlm_search;
  dlm_cancel: Tdlm_cancel;
  dlm_getConnectedCameras: Tdlm_getConnectedCameras;
  dlm_getTrackList: Tdlm_getTrackList;
  dlm_getTrackSettings: Tdlm_getTrackSettings;
  dlm_getConnectionState: Tdlm_getConnectionState;
  dlm_getDisplayMode: Tdlm_getDisplayMode;
  dlm_getNavigationMode: Tdlm_getNavigationMode;
  dlm_getCameraName: Tdlm_getCameraName;
  dlm_mirrorSession: Tdlm_mirrorSession;
  dlm_getImageInfo: Tdlm_getImageInfo;
  dlm_changeRectOld: Tdlm_changeRectOld;
  dlm_config: Tdlm_config;
  dlm_configProp: Tdlm_configProp;
  dlm_configPropDevice: Tdlm_configPropDevice;
  dlm_setEncDataCallback: Tdlm_setEncDataCallback;
  dlm_getLastError: Tdlm_getLastError;
  dlm_getCurrentMilliSec: Tdlm_getCurrentMilliSec;
  dlm_setAddInfoCallback: Tdlm_setAddInfoCallback;
  dlm_getCurrentSec: Tdlm_getCurrentSec;
  dlm_setYUVDataCallback: Tdlm_setYUVDataCallback;
  dlm_isWaitingForCallback: Tdlm_isWaitingForCallback;


{///exporting of the decoder's functions }


const
  MSEC_BETWEEN_1601_AND_1970 = 11644473600000;
type
  TConnectCallback = procedure (pParameters: pointer; pResult: pointer; pInput: pointer) of object; stdcall;

  pInteger = ^Integer;

  TConnectCallbackData = packed record
    ulFunctionID: cardinal; //see table 1
    ulSocketHandle: cardinal; //handle to socket of the established connection
    ulWindowHandle: cardinal;
    SessionHandle: integer; //session handle of the session created
    strIP,
    strUser1,
    strPwd1,
    strUser2,
    strPWD2: pchar;
  end;
  PConnectCallbackData = ^TConnectCallbackData;

TNavigateTrackCallbackData = packed record
  ulFunctionID: cardinal; //see table 1
  SessionHandle: integer;
  ulCommand: cardinal;
  liAddData: int64;
  ulCameraFilter: cardinal;
  bUseDB: boolean;
end;
PNavigateTrackCallbackData = ^TNavigateTrackCallbackData;

TSearchResultCallback = packed Record
  ulFunctionID: cardinal; //see table 1
  SessionHandle: integer;
  ulCameraFilter: cardinal;
  liSTartTimeStamp: int64;
  liStopTimeStamp: int64;
  pchCriteria: pchar;
end;
PSearchResultCallback = ^TSearchResultCallback;

TSearchResultXML = packed record
  ResultCode: Integer;
  XML: pAnsiChar;
end;
PSearchResultXML = ^TSearchResultXML;




implementation





var
  SaveExit: pointer;
  DLLHandle: THandle;
{$IFNDEF MSDOS}
  ErrorMode: Integer;
{$ENDIF}

  procedure UnloadDLL; 
  begin
    if DLLHandle>=32 then begin
//      ExitProc := SaveExit;
      FreeLibrary(DLLHandle)
    end;
    DLLLoaded:= False;
    dlm_initSDK := nil; //DLLHandle,'_dlm_initSDK@0');
    dlm_shutdownSDK := nil; //DLLHandle,'_dlm_shutdownSDK@0');
    dlm_createSession := nil;
    dlm_connectSession := nil;
    dlm_connect := nil; //DLLHandle,'_dlm_connect@32');
    dlm_connectSocket := nil; //DLLHandle,'_dlm_connectSocket@36');
    dlm_disconnect := nil; //DLLHandle,'_dlm_disconnect@12');
    dlm_mute := nil; //DLLHandle,'_dlm_mute@8');
    dlm_showRecorderinfo := nil; //DLLHandle,'_dlm_showRecorderinfo@16');
    dlm_showLive := nil; //DLLHandle,'_dlm_showLive@16');
    dlm_redraw := nil; //DLLHandle,'_dlm_redraw@4');
    dlm_sendTransparent := nil; //DLLHandle,'_dlm_sendTransparent@24');
    dlm_showTrack := nil; //DLLHandle,'_dlm_showTrack@16');
    dlm_showFileTrack := nil; //DLLHandle,'_dlm_showFileTrack@16');
    dlm_navigateTrack := nil; //DLLHandle,'_dlm_navigateTrack@32');
    dlm_backup := nil; //DLLHandle,'_dlm_backup@40');
    dlm_export := nil; //DLLHandle,'_dlm_export@12');
    dlm_search := nil; //DLLHandle,'_dlm_search@36');
    dlm_cancel := nil; //DLLHandle,'_dlm_cancel@12');
    dlm_getConnectedCameras := nil; //DLLHandle,'_dlm_getConnectedCameras@12');
    dlm_getTrackList := nil; //DLLHandle,'_dlm_getTrackList@12');
    dlm_getTrackSettings := nil; //DLLHandle,'_dlm_getTrackSettings@16');
    dlm_getConnectionState := nil; //DLLHandle,'_dlm_getConnectionState@4');
    dlm_getDisplayMode := nil; //DLLHandle,'_dlm_getDisplayMode@4');
    dlm_getNavigationMode := nil; //DLLHandle,'_dlm_getNavigationMode@4');
    dlm_getCameraName := nil; //DLLHandle,'_dlm_getCameraName@12');
    dlm_mirrorSession := nil; //DLLHandle,'_dlm_mirrorSession@20');
    dlm_getImageInfo := nil; //DLLHandle,'_dlm_getImageInfo@12');
    dlm_isWaitingForCallback := nil; //DLLHandle,'_dlm_isWaitingForCallback@4');
    dlm_changeRectOld := nil; //DLLHandle,'_dlm_changeRectOld@24');
    dlm_config := nil; //DLLHandle,'_dlm_config@8');
    dlm_configProp := nil; //DLLHandle,'_dlm_configProp@12');
    dlm_configPropDevice := nil; //DLLHandle,'_dlm_configPropDevice@16');
    dlm_setEncDataCallback := nil; //DLLHandle,'_dlm_setEncDataCallback@8');
    dlm_setYUVDataCallback := nil; //DLLHandle,'_dlm_setYUVDataCallback@8');
    dlm_getLastError := nil; //DLLHandle,'_dlm_getLastError@0');
    dlm_getCurrentSec := nil; //DLLHandle,'_dlm_getCurrentSec@4');
    dlm_getCurrentMilliSec := nil; //DLLHandle,'_dlm_getCurrentMilliSec@4');
    dlm_setAddInfoCallback := nil; //DLLHandle,'_dlm_setAddInfoCallback@8');
    dlm_getVersion := nil; //DLLHandle,'_dlm_getVersion@12');
  end {NewExit};

procedure LoadDLL(dllname: string); far;
begin
  //GlobalLog.Log('Load DLL: '+DllName);
  if DLLLoaded then begin
    //GlobalLog.Log('DLL already loaded. Cancel loading');
    Exit;
  end;
  DLLHandle:=0;
//  ErrorMode := SetErrorMode($8000{SEM_NoOpenFileErrorBox});
  DLLHandle := LoadLibrary('david_common.dll');
  if DLLHandle >= 32 then
  begin
    //GLobalLog.Log('DLL loaded->Getting proc-pointers->');
    DLLLoaded := True;
//    SaveExit := ExitProc;
//    ExitProc := @UnloadDLL;
    dlm_initSDK := GetProcAddress(DLLHandle,'_dlm_initSDK@0');
    if not assigned(dlm_initsdk) then
    begin
      DLLLoaded := False;
      Exit;
    end;

    dlm_shutdownSDK := GetProcAddress(DLLHandle,'_dlm_shutdownSDK@0');
    dlm_createSession := GetProcAddress(DLLHandle,'_dlm_createSession@0');;
    dlm_connectSession := GetProcAddress(DLLHandle,'_dlm_connectSession@36');;
    dlm_connect := GetProcAddress(DLLHandle,'_dlm_connect@32');
    dlm_connectSocket := GetProcAddress(DLLHandle,'_dlm_connectSocket@36');
    dlm_disconnect := GetProcAddress(DLLHandle,'_dlm_disconnect@12');
    dlm_mute := GetProcAddress(DLLHandle,'_dlm_mute@8');
    dlm_showRecorderinfo := GetProcAddress(DLLHandle,'_dlm_showRecorderinfo@16');
    dlm_showLive := GetProcAddress(DLLHandle,'_dlm_showLive@16');
    dlm_redraw := GetProcAddress(DLLHandle,'_dlm_redraw@4');
    dlm_sendTransparent := GetProcAddress(DLLHandle,'_dlm_sendTransparent@24');
    dlm_showTrack := GetProcAddress(DLLHandle,'_dlm_showTrack@16');
    dlm_showFileTrack := GetProcAddress(DLLHandle,'_dlm_showFileTrack@16');
    dlm_navigateTrack := GetProcAddress(DLLHandle,'_dlm_navigateTrack@32');
    dlm_backup := GetProcAddress(DLLHandle,'_dlm_backup@40');
    dlm_export := GetProcAddress(DLLHandle,'_dlm_export@12');
    dlm_search := GetProcAddress(DLLHandle,'_dlm_search@36');
    dlm_cancel := GetProcAddress(DLLHandle,'_dlm_cancel@12');
    dlm_getConnectedCameras := GetProcAddress(DLLHandle,'_dlm_getConnectedCameras@12');
    dlm_getTrackList := GetProcAddress(DLLHandle,'_dlm_getTrackList@12');
    dlm_getTrackSettings := GetProcAddress(DLLHandle,'_dlm_getTrackSettings@16');
    dlm_getConnectionState := GetProcAddress(DLLHandle,'_dlm_getConnectionState@4');
    dlm_getDisplayMode := GetProcAddress(DLLHandle,'_dlm_getDisplayMode@4');
    dlm_getNavigationMode := GetProcAddress(DLLHandle,'_dlm_getNavigationMode@4');
    dlm_getCameraName := GetProcAddress(DLLHandle,'_dlm_getCameraName@12');
    dlm_mirrorSession := GetProcAddress(DLLHandle,'_dlm_mirrorSession@20');
    dlm_getImageInfo := GetProcAddress(DLLHandle,'_dlm_getImageInfo@12');
    dlm_isWaitingForCallback := GetProcAddress(DLLHandle,'_dlm_isWaitingForCallback@4');
    dlm_changeRectOld := GetProcAddress(DLLHandle,'_dlm_changeRectOld@24');
    dlm_config := GetProcAddress(DLLHandle,'_dlm_config@8');
    dlm_configProp := GetProcAddress(DLLHandle,'_dlm_configProp@12');
    dlm_configPropDevice := GetProcAddress(DLLHandle,'_dlm_configPropDevice@16');
    dlm_setEncDataCallback := GetProcAddress(DLLHandle,'_dlm_setEncDataCallback@8');
    dlm_setYUVDataCallback := GetProcAddress(DLLHandle,'_dlm_setYUVDataCallback@8');
    dlm_getLastError := GetProcAddress(DLLHandle,'_dlm_getLastError@0');
    dlm_getCurrentSec := GetProcAddress(DLLHandle,'_dlm_getCurrentSec@4');
    dlm_getCurrentMilliSec := GetProcAddress(DLLHandle,'_dlm_getCurrentMilliSec@4');
    dlm_setAddInfoCallback := GetProcAddress(DLLHandle,'_dlm_setAddInfoCallback@8');
    dlm_getVersion := GetProcAddress(DLLHandle,'_dlm_getVersion@12');
  end
  else
  begin
    //GLobalLog.Log('Loading of DLL failed');
    DLLLoaded := False;
  end;
//  SetErrorMode(ErrorMode)
end {LoadDLL};

initialization
  LoadDLL('david_common.dll');
  dlm_initSDK;

finalization
  dlm_shutdownSDK;
  UnloadDLL;

end.
