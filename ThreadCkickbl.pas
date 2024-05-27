unit ThreadCkickbl;

interface

uses
  Classes, Forms, IdHTTP, IdCookieManager, RegExpr, SysUtils, Dialogs;

type
  Clickbl = class(TThread)
  private
    { Private declarations }
  protected
    procedure Execute; override;
  end;

var
  IdHTTP: TIdHTTP;
  IdCM: TIdCookieManager;
  Link: String;
  IdUserAgent, IdCountry, IdUseClickGo: Integer;
  MassUserAgent: array [0 .. 8] of String;
  MassCountry: array [0 .. 6] of String;
  ErrorKey: boolean;

implementation

uses MainForm;

{ Clickbl }

procedure Initialize;
begin
  FormMain.Memo2.Lines.Add('—тартовала процедура Initialize;');
  ErrorKey := false;
  IdUserAgent := Random(Length(MassUserAgent));
  IdCountry := Random(Length(MassCountry));
  MassUserAgent[0] :=
    'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/534.1 (KHTML, like Gecko) Chrome/6.0.437.3 Safari/534.1';
  MassUserAgent[1] :=
    'Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.1; Trident/4.0)';
  MassUserAgent[2] :=
    'Mozilla/4.0 (compatible; MSIE 6.0; Windows CE; IEMobile m.n)';
  MassUserAgent[3] :=
    'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.3) Gecko/20100401 Firefox/3.6.3';
  MassUserAgent[4] :=
    'Opera/9.80 (Windows NT 5.1; U; ru) Presto/2.5.24 Version/10.53';
  MassUserAgent[5] :=
    'Opera/9.80 (S60; SymbOS; Opera Mobi/499; U; ru) Presto/2.4.18 Version/10.00';
  MassUserAgent[6] :=
    'Opera/8.01 (J2ME/MIDP; Opera Mini/2.0.4509/1316; fi; U; ssr)';
  MassUserAgent[7] :=
    'Opera/9.60 (J2ME/MIDP; Opera Mini/4.2.14912/812; U; ru) Presto/2.4.15';
  MassUserAgent[8] :=
    'Mozilla/5.0 (Windows; U; Windows NT 6.1; ru-RU) AppleWebKit/533.17.8 (KHTML, like Gecko) Version/5.0.1 Safari/533.17.8';
  MassCountry[0] := 'United States';
  MassCountry[1] := 'Ukraine';
  MassCountry[2] := 'Italy';
  MassCountry[3] := 'Greece';
  MassCountry[4] := 'Germany';
  MassCountry[5] := 'Canada';
  MassCountry[6] := '';
  FormMain.Memo2.Lines.Add('«авершена процедура Initialize;');
  FormMain.Memo2.Lines.Add('-------------------------------');
end;

procedure Clickbl.Execute;
var
  FirstPost, AdvertisingLink, AdvertisingLink2: TStringList;
  HTML, Link: String;
  CopyStart, CopyEnd: Integer;
  RegExp: TRegExpr;
begin
  { Place thread code here }
  FormMain.Memo2.Lines.Add('================================');
  FormMain.Memo2.Lines.Add('—тартовала процедура Clickbl;');
  Initialize;
  IdHTTP := TIdHTTP.Create();
  IdCM := TIdCookieManager.Create();
  FirstPost := TStringList.Create;
  AdvertisingLink := TStringList.Create;
  RegExp := TRegExpr.Create;
  IdHTTP.AllowCookies := true;
  IdHTTP.HandleRedirects := true;
  IdHTTP.CookieManager := IdCM;
  IdHTTP.Request.UserAgent := MassUserAgent[IdUserAgent];
  FirstPost.Add('site=http://twwk-on.ru/');
  FirstPost.Add('country=United States');
  //FirstPost.Add('country=' + MassCountry[IdCountry]);
  try
    FormMain.Memo2.Lines.Add('Clickbl: отсылаем первый запрос, чтобы узнать ссылку на прокси-сайт;');
    HTML := IdHTTP.Post('http://anonymizer.nntime.com/script/anonymizer.php', FirstPost);
    FormMain.Memo1.Text := HTML;
    CopyStart := Pos('<frame src="http://', HTML) + Length('<frame src="http://');
    CopyEnd := Pos('" name="site">', HTML);
    Link := 'http://' + Copy(HTML, CopyStart, CopyEnd - CopyStart);
    FormMain.Memo2.Lines.Add('Clickbl: ссылка на прокси-сайт = ' + link + ' ;');

    if (Length(Link) > 100) then
    begin
      ErrorKey := true;
      FormMain.Memo2.Lines.Add('Clickbl: ссылка на прокси-сайт Ќ≈ нормальна€;');
    end
    else
    begin
      FormMain.Memo2.Lines.Add('Clickbl: ссылка на прокси-сайт нормальна€;');
    end;

    if (ErrorKey <> true) then
    begin
      FormMain.Memo2.Lines.Add('Clickbl: переходим по ссылке на прокси-сайт;');
      HTML := IdHTTP.Get(Link);
      FormMain.Memo2.Lines.Add('Clickbl: переход по ссылке на прокси-сайт завершен;');
      FormMain.Memo1.Text := HTML;
      if (Pos('<h1>Access Denied</h1>', HTML)<2) then
        ErrorKey := true;
      RegExp.Expression := '<a href="http://(.+?)biz(.+?)">(.+?)</a>';
      if ((RegExp.Exec(HTML)) AND (ErrorKey <> true)) then
      begin
        repeat
          FormMain.Memo2.Lines.Add('Clickbl: нужные нам рекламные ссылки существуют;');
          FormMain.Memo2.Lines.Add('Clickbl: RegExp.Match[2] = ' + RegExp.Match[2] + ' ;');
          if ((RegExp.Match[3] <> '/=3fuid=3d15840') AND (Pos('lick.php', String(RegExp.Match[3])) > 0)) then
            AdvertisingLink.Add('http://' + RegExp.Match[1] + 'biz' + RegExp.Match[2]);
        until not RegExp.ExecNext;
      end;
    end;
  finally
    RegExp.Free;
    //Application.ProcessMessages;
  end;

  if ((AdvertisingLink.Count > 0) AND (ErrorKey <> true))  then
  begin
    FormMain.Memo2.Lines.Add('Clickbl: генерирую рандомное число, чтобы вз€ть из нашего StringList_а какой-нить элемент;');
    IdUseClickGo := Random(AdvertisingLink.Count - 1);
    try
      FormMain.Memo2.Lines.Add('Clickbl: переходим на прокси-сайт по рекламной ссылке = ' + AdvertisingLink.Strings[IdUseClickGo] + ';');
      HTML := IdHTTP.Get(AdvertisingLink.Strings[IdUseClickGo]);
    finally
      Application.ProcessMessages;
      AdvertisingLink.Free;
    end;
  end;

  if (ErrorKey <> true) then
  begin
    AdvertisingLink2 := TStringList.Create;
    try
      FormMain.Memo2.Lines.Add('Clickbl: т.к. не работает редирект, то мы парсим страницу и выдираем рекламный пр€мой линк;');
      RegExp.Expression:='<a href=(.+?)>&#x0418;&#x0434;&#x0435;&#x0442; &#x0437;&#x0430;&#x0433;&#x0440;&#x0443;&#x0437;&#x043A;&#x0430;...</a>';
      if (RegExp.Exec(HTML) AND (ErrorKey <> true)) then
      begin
        repeat
          FormMain.Memo2.Lines.Add('Clickbl: линк мы нашли;');
          FormMain.Memo2.Lines.Add('Clickbl: RegExp.Match[1] = ' + RegExp.Match[1] + ';');
          AdvertisingLink2.Add(RegExp.Match[1]);
        until not RegExp.ExecNext;
      end;
    finally
      RegExp.Free;
      //Application.ProcessMessages;
    end;
  end;

  if ((AdvertisingLink2.Count > 0) AND (ErrorKey <> true)) then
  begin
    try
      //rmMain.Memo2.Lines.Add('Clickbl: линк мы нашли;');
      // HTML := IdHTTP.Get(AdvertisingLink2.Strings[0]);
      //FormMain.Edit4.Text := AdvertisingLink2.Strings[0];
    finally
      //Application.ProcessMessages;
      AdvertisingLink2.Free;
    end;
  end;

  FormMain.Memo2.Lines.Add('«авершена процедура Clickbl;');
  FormMain.Memo2.Lines.Add('-------------------------------');
end;

end.
