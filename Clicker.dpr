program Clicker;

uses
  Forms,
  MainForm in 'MainForm.pas' {FormMain},
  ThreadCkickbl in 'ThreadCkickbl.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormMain, FormMain);
  Application.Run;
end.
