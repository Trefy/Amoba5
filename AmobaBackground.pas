unit AmobaBackground;

interface
const
    sizeX = 11;
    sizeY = 11;

    procedure InitPlayGround();
    function VerticalTest(lastI: Byte; lastJ: Byte; Player: Byte) : boolean;
    function HorizontalTest(lastI: Byte; lastJ: Byte; Player: Byte) : boolean;
    function VerticalDownTest(lastI: Byte; lastJ: Byte; Player: Byte) : boolean;
    function VerticalUpTest(lastI: Byte; lastJ: Byte; Player: Byte) : boolean;
    function CheckGameEnd(lastI: Byte; lastJ: Byte; Player: Byte) : boolean;
var
    PlayGround: array [0..sizeX, 0..sizeY] of Byte;

implementation

procedure InitPlayGround();
var i, j: Byte;
begin
  for i := 0 to sizeX do
    for j := 0 to sizeY do
      PlayGround[i,j] := 0;
end;

function CheckGameEnd(lastI: Byte; lastJ: Byte; Player: Byte) : boolean;
begin
  PlayGround[lastI, lastJ] := Player;
  Result := false;
  if VerticalTest(lastI, lastJ, Player) then Result := true
  else
    if HorizontalTest(lastI, lastJ, Player) then Result := true
      else
        if VerticalDownTest(lastI, lastJ, Player) then Result := true
          else
            if VerticalUpTest(lastI, lastJ, Player) then Result:= true;
end;

function HorizontalTest(lastI: Byte; lastJ: Byte; Player: Byte) : boolean;
var
  y, m, j, k: Byte;
  temp: Integer;
begin
  Result := false;
  temp := lastJ - 4;
  if temp < 0 then temp := 0;
  y := temp;
  temp := lastJ + 4;
  if temp > sizeY then temp := sizeY;
  m := temp;
  k := 0;
  for j := y to m do
  begin
    if PlayGround[lastI, j] = Player then k := k + 1
    else k := 0;
    if k >= 5 then
    begin
      Result := true;
      break;
    end;
  end;
end;

function VerticalTest(lastI: Byte; lastJ: Byte; Player: Byte) : boolean;
var
  x, n, i, k: Byte;
  temp: Integer;
begin
  Result := false;
  temp := lastI - 4;
  if temp < 0 then temp := 0;
  x := temp;
  temp := lastI + 4;
  if temp > sizeX then temp := sizeX;
  n := temp;
  k := 0;
  for i := x to n do
  begin
    if PlayGround[i, lastJ] = Player then k := k + 1
    else k := 0;
    if k >= 5 then
    begin
      Result := true;
      break;
    end;
  end;
end;

// "\"
function VerticalDownTest(lastI: Byte; lastJ: Byte; Player: Byte) : boolean;
var
  x, n, i, j, k: Byte;
  temp, dx, dy: Integer;
begin
  Result := false;
  dx := 0; dy := 0;

  temp := lastI - 4;
  if temp < 0 then begin dx := temp * -1; temp := 0; end;
  x := temp;

  temp := lastJ - 4;
  if temp < 0 then begin dy := temp * -1; temp := 0; end;
  j := temp;

  if dx <> dy then
  begin
    if dx < dy then x := x + (dy - dx);
    if dx > dy then j := j + (dx - dy);
  end;

  temp := lastI + 4;
  if temp > sizeX then temp := sizeX;
  n := temp;

  k := 0;
  for i := x to n do
  begin
    if PlayGround[i, j] = Player then k := k + 1
    else k := 0;
    if k >= 5 then
    begin
      Result := true;
      break;
    end
    else
       if (j >= sizeY) then break;
    j := j + 1;
  end;
end;

function VerticalUpTest(lastI: Byte; lastJ: Byte; Player: Byte) : boolean;
var
  x, n, i, j, k: Byte;
  temp, dx, dy: Integer;
begin
  Result := false;
  dx := 0; dy := 0;

  temp := lastI - 4;
  if temp < 0 then begin dx := temp * -1; temp := 0; end;
  x := temp;

  temp := lastI + 4;
  if temp > sizeX then temp := sizeX;
  n := temp;

  temp := lastJ + 4;
  if temp > sizeY then begin dy := temp - sizeY; temp := sizeY; end;
  j := temp;

  if dx <> dy then
  begin
    if dx < dy then begin x := x + (dy - dx); end;
    if dx > dy then j := j - (dx - dy);
  end;

  k := 0;
  for i := x to n do
  begin
    if PlayGround[i, j] = Player then k := k + 1
    else k := 0;
    if k >= 5 then
    begin
      Result := true;
      break;
    end
    else
       if (j <= 0) then break;
    j := j - 1;
  end;
end;

end.
