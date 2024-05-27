unit MainForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP,
  StdCtrls, IdCookieManager, RegExpr, ThreadCkickbl, ComCtrls;

type
  TFormMain = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    Button2: TButton;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Memo1: TMemo;
    Memo2: TMemo;
    Button3: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
    Thread_1: Clickbl;
  public
    { Public declarations }
  end;

var
  FormMain: TFormMain;

implementation

{$R *.dfm}

procedure TFormMain.Button1Click(Sender: TObject);
{ var
  idHTTP: TIdHTTP;
  IdCM: TIdCookieManager;
  FirstPost: TStringList;
  HTML, Link: String;
  CopyStart, CopyEnd: Integer;
  RegExp: TRegExpr; }
begin
  Thread_1 := Clickbl.Create(true);
  Thread_1.Resume;
  Thread_1.Priority := tpIdle;
end;

procedure TFormMain.Button2Click(Sender: TObject);
var
  RegExp: TRegExpr;
  input: string;
begin
  input := Memo1.Text;
  RegExp := TRegExpr.Create;
  RegExp.Expression := '<a href="http://(.+?)biz(.+?)">(.+?)</a>';
  if RegExp.Exec(input) then
    repeat
      Edit1.text := RegExp.Match[0];
      Edit2.text := RegExp.Match[1];
      Edit3.text := RegExp.Match[2];
      Edit4.text := 'http://' + RegExp.Match[1] + 'biz' + RegExp.Match[2];
    until not RegExp.ExecNext;
RegExp.Free;
end;



procedure TFormMain.Button3Click(Sender: TObject);
var
  input: string;
  CopyStart, CopyEnd: Integer;
begin
input := Memo1.Text;
CopyStart := Pos('<frame src="http://', input) + Length('<frame src="http://');
CopyEnd := Pos('" name="site">', input);
Link := 'http://' + Copy(input, CopyStart, CopyEnd - CopyStart);
Edit1.text := ' Link = ' + Link;
end;

end.
