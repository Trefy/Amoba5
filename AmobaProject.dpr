program AmobaProject;

uses
  Forms,
  Amoba in 'Amoba.pas' {MainForm},
  AmobaBackground in 'AmobaBackground.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
