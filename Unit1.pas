unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls ,jpeg;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    img1: TImage;
    bt1: TButton;
    bt2: TButton;
    Image1: TImage;
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Memo1: TMemo;
    Memo2: TMemo;
    Panel2: TPanel;
    Image2: TImage;
    Image3: TImage;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Button1: TButton;
    Button2: TButton;
    Memo3: TMemo;
    Label7: TLabel;
    Label8: TLabel;
    Timer1: TTimer;
    Timer2: TTimer;
    Panel3: TPanel;
    Label9: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Panel4: TPanel;
    Label14: TLabel;
    Label10: TLabel;
    Panel5: TPanel;
    Label11: TLabel;
    Label15: TLabel;
    Timer3: TTimer;
    Timer4: TTimer;
    img4: TImage;
    Timer5: TTimer;
    Timer6: TTimer;
    img5: TImage;
    Timer7: TTimer;
    Button3: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure bt1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure bt2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Timer3Timer(Sender: TObject);
    procedure Timer4Timer(Sender: TObject);
    procedure Timer5Timer(Sender: TObject);
    procedure Timer6Timer(Sender: TObject);
    procedure Timer7Timer(Sender: TObject);
    procedure FormMouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    procedure FormClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  mbm,bm :TBitmap;
  bx, by, br, bclr, bdx, bdy , obx , oby , bgclr , i:integer;
  ax, ay, ar, aclr, adx, ady , oax , oay :integer;
  bbx, bby, bbr, bbclr, bbdx, bbdy , oobx , ooby , bbgclr :integer ;
  aax, aay, aar, aaclr, aadx, aady , ooax , ooay , aagclr :integer ;
  score1,score2: integer;
  anum,bnum:integer;
implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin

   MessageBox(Handle,'請閱讀顯示的遊戲說明，再開始遊戲！','進入遊戲說明',MB_OK);
   panel1.Visible:=true;
   panel2.Visible:=false;

   randomize;
   bx:=20;
   Repeat                //bx,by球的中心點
    by:=random(Form1.Height)+panel3.Top+57;
   Until (by<>Img4.Top) and (by<>Img4.Top+Img4.Height);
   br:=6; bclr:=$b08477;
   bdx:=5;
   bgclr:=Form1.Color; //背景顏色

   ax:=Form1.Width-20;
   Repeat
    ay:=random(Form1.Height)+panel3.Top+57;
   Until (ay<>Img5.Top) and (ay<>Img5.Top+Img5.Height);
   ar:=6; aclr:=$6f35de;
   adx:=5;
   bm:=img1.Picture.Bitmap;
   mbm:=TBitmap.Create();
   bbx:=img4.Left+img4.Width;   ////左飛機
   bby:=0;
   bbr:=10; bbclr:=$c8ad7f;
   bbdx:=10;
   bbgclr:=Form1.Color; //背景顏色
   bnum:=1;

   //mbm:=TBitmap.Create();
   aax:=img5.Left;   ////右飛機
   aay:=0;
   aar:=10; aaclr:=$3540af;
   aadx:=-10;
   aagclr:=Form1.Color; //背景顏色
   anum:=1;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var r:Trect;
begin
    Form1.Canvas.Pen.Color:=bclr;
    Form1.Canvas.Pen.Width:=1;
    Form1.Canvas.Ellipse(bx-br, by-br, bx+br, by+br );
    //包住球的矩形
    //Ellipse抓的是左上跟右下兩個點(左上右下)

    //擦除舊球
    Form1.Canvas.Brush.Color:=bgclr;  //Brush畫方框
    Form1.Canvas.Pen.Color:=bgclr;
    r.Left:=obx-br; r.Top:=oby-br;
    r.Right:=obx+br; r.Bottom:=oby+br;
    Form1.Canvas.FillRect( r );      //填充矩形

    Form1.Canvas.Pen.Color:=bclr;
    Form1.Canvas.Pen.Width:=1;
    Form1.Canvas.Brush.Color:=bclr;
    Form1.Canvas.Ellipse(bx-br, by-br, bx+br, by+br );
    obx:=bx; oby:=by;     //記憶舊球
    bx:=bx+bdx; if (bx>= (Form1.Width - br-2)) then bdx:=bdx*-1;  //下一顆球

    //計分-系統球扣分
    if (bx>=img5.Left) and (by>=img5.top) and (by<=img5.Top+img5.height) then
    begin
      bx:=0;
      bdx:=bdx*-1;
      score2:=score2-1;
    end;

    //計分-系統球加分
    if (bx<=img4.Left+img4.Width) and (by>=img4.top) and (by<=img4.Top+img4.height) then
    begin
      bx:=0;
      score1:=score1+1;
    end;

    //反彈
    if bx=Form1.Width then
    begin
      bdx:=bdx*-1;
    end;

    //重新發射
    if bx<=0 then
    begin
     Repeat
        by:=random(Form1.Height-panel3.Top-57)+(panel3.Top+57);
      Until (by<>Img4.Top) and (by<>Img4.Top+Img4.Height);
      bdx:=bdx*-1;
    end
end;

procedure TForm1.Timer2Timer(Sender: TObject);
var r:Trect;
begin
    Form1.Canvas.Pen.Color:=aclr;
    Form1.Canvas.Pen.Width:=1;
    Form1.Canvas.Ellipse(ax-ar, ay-ar, ax+ar, ay+ar );

    Form1.Canvas.Brush.Color:=bgclr;
    Form1.Canvas.Pen.Color:=bgclr;
    r.Left:=oax-ar; r.Top:=oay-ar;
    r.Right:=oax+ar; r.Bottom:=oay+ar;
    Form1.Canvas.FillRect( r );

    Form1.Canvas.Pen.Color:=aclr;
    Form1.Canvas.Pen.Width:=1;
    Form1.Canvas.Brush.Color:=aclr;
    Form1.Canvas.Ellipse(ax-ar, ay-ar, ax+ar, ay+ar );
    oax:=ax; oay:=ay;
    ax:=ax-adx;  if (ax<= 0) then adx:=adx*-1;

    //系統球扣分
    if (ax<=img4.Left+img4.Width) and (ay>=img4.top) and (ay<=img4.Top+img4.height) then
    begin
      form1.Caption:='到了!!';
      ax:=form1.Width;
      adx:=adx*-1;
      score1:=score1-1;
    end;

    //系統球加分
    if (ax>=img5.Left) and (ay>=img5.top) and (ay<=img5.Top+img5.height) then
    begin
      form1.Caption:='到了!!';
      ax:=form1.Width;
      score2:=score2+1;
    end;

    if ax=0 then
    begin
      adx:=adx*-1;
    end;

    if ax>=form1.Width then
    begin
      Repeat
        ay:=random(Form1.Height-panel3.Top-57)+(panel3.Top+57);
      Until (ay<>Img5.Top) and (ay<>Img5.Top+Img5.Height);
      adx:=adx*-1;
    end

end;

procedure TForm1.bt1Click(Sender: TObject);
begin
  score1:=0;
  score2:=0;
  Timer1.Enabled:=true;
  Timer2.Enabled:=true;
  panel1.Visible:=false;
  panel2.Visible:=false;
  panel3.Visible:=true;
  label14.Caption:=edit1.Text+'的';
  label11.Caption:=edit2.Text+'的';
  label5.Caption:=edit1.Text;
  label6.Caption:=edit2.Text;
  img4.Visible:=true;
  img5.Visible:=true;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TForm1.bt2Click(Sender: TObject);
begin
  Application.Terminate; //關閉程式
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  score1:=0;
  score2:=0;
  panel1.Visible:=true;
  panel2.Visible:=false;
  panel3.Visible:=false;
end;

procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  //藍色飛機
    if key=87 then
  begin
    img4.Top:=img4.Top-10;
    if img4.Top<= panel3.Top+57 then
    begin
       img4.Top:= panel3.Top+57;
    end
  end
  else if key=83 then
  begin
    img4.Top:=img4.Top+10;
    if (img4.Top>=Form1.ClientHeight-img4.Height) then
    begin
      img4.Top:= Form1.ClientHeight-img4.Height;
      end
  end;

  if key=68 then
  begin
    if Timer3.Enabled=false then
    begin
      timer3.Enabled:=true;
      timer4.Enabled:=true;
    end;
  //紅色飛機
  end;
  {
    if key=38 then
  begin
    img5.Top:=img5.Top-10;
    if img5.Top<=0 then
    begin
       img5.Top:=0;
    end
  end
  else if key=40 then
  begin
    img5.Top:=img5.Top+10;
    if (img5.Top>=Form1.ClientHeight-img5.Height) then
    begin
      img5.Top:= Form1.ClientHeight-img5.Height;
      end
  end;

  if key=37 then
  begin
    if Timer5.Enabled=false then
    begin
      timer5.Enabled:=true;
      timer6.Enabled:=true;
    end;

  end  }
end;

procedure TForm1.Timer3Timer(Sender: TObject);
var r:Trect;
begin
    //左邊飛機發射球

    Timer4.Enabled:=false;
    Form1.Canvas.Pen.Color:=bbclr;
    Form1.Canvas.Brush.Color:=$894e2c;
    Form1.Canvas.Pen.Width:=1;
    Form1.Canvas.Ellipse(bbx-bbr, bby-bbr, bbx+bbr, bby+bbr );
    //包住球的矩形
    //Ellipse抓的是左上跟右下兩個點(左上右下)
    //擦除舊球
    Form1.Canvas.Brush.Color:=bgclr;  //Brush畫方框
    Form1.Canvas.Pen.Color:=bgclr;
    r.Left:=oobx-bbr; r.Top:=ooby-bbr;
    r.Right:=oobx+bbr; r.Bottom:=ooby+bbr;
    Form1.Canvas.FillRect( r );      //填充矩形

    Form1.Canvas.Pen.Color:=bbclr;
    Form1.Canvas.Pen.Width:=1;
    Form1.Canvas.Brush.Color:=$894e2c;
    Form1.Canvas.Ellipse(bbx-bbr, bby-bbr, bbx+bbr, bby+bbr );
    oobx:=bbx; ooby:=bby;     //記憶舊球
    bbx:=bbx+bbdx;   //下一顆球

    //計分
    if (bbx>=img5.Left) and (bby>=img5.top) and (bby<=img5.Top+img5.height) then
    begin
      bbx:=Form1.Width;
      score1:=score1+3;

      //碰到後把球擦掉
      Form1.Canvas.Brush.Color:=bgclr;
      Form1.Canvas.Pen.Color:=bgclr;
      r.Left:=oobx-bbr; r.Top:=ooby-bbr;
      r.Right:=oobx+bbr; r.Bottom:=ooby+bbr;
      Form1.Canvas.FillRect( r );
    end;

    if bbx>=Form1.Width then
    begin
      Timer3.Enabled:=false;
      bbx:=img4.Left+img4.Width;   //bx,by球的中心點
      bby:=0;
    end
end;

procedure TForm1.Timer4Timer(Sender: TObject);
begin
   bby:=img4.Top+(img4.Height div 2);
end;

procedure TForm1.Timer5Timer(Sender: TObject);
var r:Trect;
begin
    //右邊飛機發射球

    Timer6.Enabled:=false;
    Form1.Canvas.Pen.Color:=aaclr;
    Form1.Canvas.Brush.Color:=aaclr;
    Form1.Canvas.Pen.Width:=1;
    Form1.Canvas.Ellipse(aax-aar, aay-aar, aax+aar, aay+aar );
    //包住球的矩形
    //Ellipse抓的是左上跟右下兩個點(左上右下)
    //擦除舊球
    Form1.Canvas.Brush.Color:=aagclr;  //Brush畫方框
    Form1.Canvas.Pen.Color:=aagclr;
    r.Left:=ooax-aar; r.Top:=ooay-aar;
    r.Right:=ooax+aar; r.Bottom:=ooay+aar;
    Form1.Canvas.FillRect( r );      //填充矩形

    Form1.Canvas.Pen.Color:=aaclr;
    Form1.Canvas.Pen.Width:=1;
    Form1.Canvas.Brush.Color:=aaclr;
    Form1.Canvas.Ellipse(aax-aar, aay-aar, aax+aar, aay+aar );
    ooax:=aax; ooay:=aay;     //記憶舊球
    aax:=aax+aadx;   //下一顆球


    //計分
    if (aax<=img4.Left+img4.Width) and (aay>=img4.top) and (aay<=img4.Top+img4.height) then
    begin
      aax:=-2*br-3;
      score2:=score2+3;

      Form1.Canvas.Brush.Color:=aagclr;  //Brush畫方框
      Form1.Canvas.Pen.Color:=aagclr;
      r.Left:=ooax-aar; r.Top:=ooay-aar;
      r.Right:=ooax+aar; r.Bottom:=ooay+aar;
      Form1.Canvas.FillRect( r );      //填充矩形

    end;

    if aax <= -2*br-3 then
    begin
      Timer5.Enabled:=false;
      aax:=img5.Left;   //bx,by球的中心點
      aay:=0;
    end
end;
procedure TForm1.Timer6Timer(Sender: TObject);
begin
  aay:=img5.Top+(img5.Height div 2);
end;

{

}


procedure TForm1.Timer7Timer(Sender: TObject);
begin
    label10.Caption:= inttostr(score1);
    label15.Caption:= inttostr(score2);
    label7.Caption:= inttostr(score1);
    label8.Caption:= inttostr(score2);
    if (score1>=30)or (score2>=30)then
    begin
      img4.visible:=false;
      img5.visible:=false;
      panel2.Visible:=true;
      panel3.Visible:=false;//記分板關掉
    end;
end;

procedure TForm1.FormMouseWheel(Sender: TObject; Shift: TShiftState;
  WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
begin
  if WheelDelta = WHEEL_DELTA then
  begin
    img5.Top:=img5.Top-10;
    if img5.Top<=panel3.Top+57 then
    begin
       img5.Top:=panel3.Top+57;
    end
  end
  else if WheelDelta = -WHEEL_DELTA then
  begin
    img5.Top:=img5.Top+10;
    if (img5.Top>=Form1.ClientHeight-img5.Height) then
    begin
      img5.Top:= Form1.ClientHeight-img5.Height;
      end
  end
end;

procedure TForm1.FormClick(Sender: TObject);
begin
  if Timer5.Enabled=false then                                      
    begin
      timer5.Enabled:=true;
      timer6.Enabled:=true;
    end;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
    if (score1 >=30) then
    begin
      memo3.lines.add('恭喜 '+ edit1.text + ' 獲勝！');
      memo3.lines.add('獎勵可樂糖一罐！');
    end
    else
    begin
      if (score1>=30) and (score2 >=30) then
      begin
        memo3.lines.add('恭喜平手！');
        memo3.lines.add('友誼增加100分！');
      end
      else
      begin
        memo3.lines.add('恭喜 '+ edit2.text + ' 獲勝！');
        memo3.lines.add('獎勵機智豆一包！');
      end;
    end;
end;

end.
