unit unitlazbounce;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls;

type

  { TFormUtama }

  TFormUtama = class(TForm)
    GameOverLabel: TLabel;
    Retry: TLabel;
    ScoreLabel: TLabel;
    Papan: TShape;
    Bola: TShape;
    Timer: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure GameOverLabelClick(Sender: TObject);
    procedure MouseEnterRetry(Sender: TObject);
    procedure MouseLeaveRetry(Sender: TObject);
    procedure OnTime(Sender: TObject);
    procedure PapanController(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure PapanMouseOver(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure RetryBtn(Sender: TObject);
    procedure ScoreLabelClick(Sender: TObject);
  private
    //Function
    procedure InitGame;
    procedure UpdateScore;
    procedure GameOver;
    procedure IncreaseSpeed;
  public

  end;

var
  FormUtama: TFormUtama;
  Score : integer;
  SpeedX,SpeedY:integer;

implementation

{$R *.lfm}

{ TFormUtama }

procedure TFormUtama.PapanController(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  Papan.Left:= X-(Papan.Width div 2);
  Papan.Top:= ClientHeight-Papan.Height-2;
end;

procedure TFormUtama.FormCreate(Sender: TObject);
begin
  DoubleBuffered:=true;
  InitGame;
end;

procedure TFormUtama.GameOverLabelClick(Sender: TObject);
begin

end;

procedure TFormUtama.MouseEnterRetry(Sender: TObject);
begin
  Retry.Font.Style:=[fsBold];
end;


procedure TFormUtama.MouseLeaveRetry(Sender: TObject);
begin
   Retry.Font.Style:=[];
end;



procedure TFormUtama.OnTime(Sender: TObject);
begin
  Bola.Left:=Bola.Left+SpeedX;
  Bola.Top:= Bola.Top+SpeedY;

  //Atas
  if Bola.Top <0  then SpeedY:=-SpeedY;

  //Kiri Kanan
  if (Bola.Left <0) or (Bola.Left + Bola.Width>= ClientWidth) then SpeedX:=-SpeedX;

  // Jika Nyentuh Paling Bawah
  if Bola.Top + Bola.Height >= ClientHeight then GameOver;

  //OnCollison Papan dengan bola
  if (Bola.Left + Bola.Width >= Papan.Left) and ( Bola.Left <= Papan.Left + Papan.Width)
  and (Bola.Top + Bola.Height >= Papan.Top) then
  begin
    SpeedY:=-SpeedY;
    IncreaseSpeed;
    Inc(Score,1);  //Tambah Score
    UpdateScore;
  end;
end;

procedure TFormUtama.PapanMouseOver(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  PapanController(Sender,Shift,X+Papan.Left,Y+Papan.Top);
end;

procedure TFormUtama.RetryBtn(Sender: TObject);
begin
  InitGame;
end;

procedure TFormUtama.ScoreLabelClick(Sender: TObject);
begin

end;
//Function
procedure TFormUtama.InitGame;
begin
  Score :=0;
  SpeedX:=-4;
  SpeedY:=-4;

  Bola.Top:=10;
  Bola.Left:=10;
  Timer.Enabled:=true;

  GameOverLabel.Visible:=false;
  Retry.Visible:=false;
  Retry.Font.Style:=[];

  UpdateScore;
end;

procedure TFormUtama.UpdateScore;
begin
  ScoreLabel.Caption:= 'Score : '+ IntToStr(Score);
end;

procedure TFormUtama.GameOver;
begin
   Timer.Enabled:=false;

   GameOverLabel.Visible:=true;
   Retry.Visible:=true;
end;

procedure TFormUtama.IncreaseSpeed;
begin
  if SpeedX >0 then Inc(SpeedX) else Dec(SpeedX);
  if SpeedY >0 then Inc(SpeedY) else Dec(SpeedY);
end;

end.

