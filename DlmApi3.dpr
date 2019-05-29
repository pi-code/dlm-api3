program DlmApi3;

uses
  Vcl.Forms,
  MainForm in 'MainForm.pas' {Form1},
  DavidDISAPI in 'DavidDISAPI.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
