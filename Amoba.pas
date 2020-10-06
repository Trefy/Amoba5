unit Amoba;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, AmobaBackground;
type
    TMainForm = class(TForm)
    Exit: TButton;
    procedure FormCreate(Sender: TObject);
    procedure ExitClick(Sender: TObject);
  private
    Player: Byte;
    TableButton: array [0..sizeX, 0..sizeY] of TButton;
    procedure TableButtonClick(Sender: TObject);
    procedure RefreshPlayGround();
    procedure Winner(Player: Byte);
    procedure CheckGameEnd(lastI: Byte; lastJ: Byte; Player: Byte);
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.DFM}

procedure TMainForm.FormCreate(Sender: TObject);
var
  i, j: Byte;
begin
  Player := 1;
  for i := 0 to sizeX do
    for j := 0 to sizeY do
      begin
        TableButton[i, j] := TButton.Create(Self);
        TableButton[i, j].Name := Format('B_%d_%d', [i,j]);
        TableButton[i, j].Tag := j;
        TableButton[i, j].Caption := '';
        TableButton[i, j].Parent := Self;
        TableButton[i, j].Height := 40;
        TableButton[i, j].Width := 50;
        TableButton[i, j].Left := 10 + j * 51;
        TableButton[i, j].Top := 10 + i * 41;
        TableButton[i, j].OnClick := TableButtonClick;
      end;
  InitPlayGround();
end;

procedure TMainForm.ExitClick(Sender: TObject);
begin
  Application.Terminate();
end;

procedure TMainForm.TableButtonClick(Sender: TObject);
var
  i, j: Byte;
  strA: String;
  strArray: TStrings;
begin
  if TButton(Sender).Caption = '' then
    begin
      strArray := TStringList.Create;
      try
        strA := TButton(Sender).Name;
        ExtractStrings(['_'], [], PChar(strA), strArray);
        i := StrToInt(strArray[1]);
        j := StrToInt(strArray[2]);
        PlayGround[i, j] := Player;
      finally
        strArray.Free;
      end;
      if (Player = 1) then
         begin
           TButton(Sender).Caption := 'X';
           Player := 2;
         end
         else begin
           TButton(Sender).Caption := 'O';
           Player := 1;
         end;
         CheckGameEnd(i, j, PlayGround[i, j]);
    end;
end;

procedure TMainForm.RefreshPlayGround();
var i, j: Byte;
begin
  for i := 0 to sizeX do
    for j := 0 to sizeY do
      begin
        case PlayGround[i, j] of
          0 : TableButton[i, j].Caption := '';
          1 : TableButton[i, j].Caption := 'X';
          2 : TableButton[i, j].Caption := 'O';
        end;
        TableButton[i, j].Font.Style := [];
      end;
end;

procedure TMainForm.Winner(Player: Byte);
var i: Byte;
begin
  for i := 0 to 4 do
    TableButton[WinnerI[i], WinnerJ[i]].Font.Style := [fsBold];
    //TableButton[WinnerI[i], WinnerJ[i]].Caption := '$';

  Application.MessageBox('We have a winner!', 'Message', 0);
  InitPlayGround();
  RefreshPlayGround();
end;

procedure TMainForm.CheckGameEnd(lastI: Byte; lastJ: Byte; Player: Byte);
begin
  if AmobaBackground.CheckGameEnd(lastI, lastJ, Player) then
    Winner(Player);
end;

end.
