unit Matrice;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;
   function isResolvable(Memo1:TMemo):boolean;
   function absoluteError(k:integer):boolean;
   function relativeError(k:integer):boolean;

type
  TForm2 = class(TForm)
    Ma: TLabel;
    Label1: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    Edit9: TEdit;
    Memo1: TMemo;
    Button1: TButton;
    Edit10: TEdit;
    Edit11: TEdit;
    Edit12: TEdit;
    Button2: TButton;
    Label2: TLabel;
    Edit13: TEdit;
    Memo2: TMemo;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure init();

  private
    { Private declarations }
  public
    { Public declarations }
  end;
const
n=3;
var
  Form2: TForm2;
  A,D:array[1..n,1..n] of double;
  B:array[1..n] of double;
  X:array[1..2,1..3] of double;
  s:array[1..n] of double;
  R:array[1..2,1..n] of double;
  ep:double;
implementation
procedure TForm2.Button2Click(Sender: TObject);
begin
Memo1.Clear;
Memo2.Clear;
end;
//---------------------------------------------------Relative Error-------------------------------------------------------------


function relativeError(k:integer):boolean;
var
i,j,cpt:integer;

begin
for i:=1 to n do
  begin
    //-------------------------------------------------------------------------
    if abs((X[k+1][i]-X[k][i])/X[k+1][i])<ep then
       begin
            cpt:=cpt+1;
           //-------------------------------------------------------------------------
            if cpt=n then
            begin
                result:=true;
                exit;
            end;
          //-------------------------------------------------------------------------
      end;
     //-------------------------------------------------------------------------
     if (i=n) and (cpt<>n) then
       //-------------------------------------------------------------------------
       begin
           result:=false;
          exit;
       end
    //-------------------------------------------------------------------------------
  end;

end;

//----------------------------------------------------  [And]  -------------------------------------------------------------

  //---------------------------------ABSOLUTE ERROR---------------
function absoluteError(k:integer):boolean;
var
 i,j,cpt:integer;
begin
cpt:=0;
//-------------------------------------------------------------------------
for i:=1 to n do
  begin
    //-------------------------------------------------------------------------
    if abs(X[k+1][i]-X[k][i])<ep then
       begin
            cpt:=cpt+1;
           //-------------------------------------------------------------------------
            if cpt=n then
            begin
                result:=true;
                exit;
            end;
          //-------------------------------------------------------------------------
      end;
     //-------------------------------------------------------------------------
     if (i=n) and (cpt<>n)then
       //-------------------------------------------------------------------------
       begin
           result:=false;
          exit;
       end
    //-------------------------------------------------------------------------------
  end;
//----------------------------------------------------------------------------------
end;

   //-----------------------END----------------------------------------
procedure TForm2.init();
var k,j,i:integer;
somme1:double;
begin

   X[1,1]:=0.5;
   X[1,2]:=0.5;
   X[1,3]:=0.5;

     A[1][1]:=StrToFloat(Edit1.Text);
     A[1][2]:=StrToFloat(Edit2.Text);
     A[1][3]:=StrToFloat(Edit3.Text);
     A[2][1]:=StrToFloat(Edit4.Text);
     A[2][2]:=StrToFloat(Edit5.Text);
     A[2][3]:=StrToFloat(Edit6.Text);
     A[3][1]:=StrToFloat(Edit7.Text);
     A[3][2]:=StrToFloat(Edit8.Text);
     A[3][3]:=StrToFloat(Edit9.Text);

     B[1]:=StrToFloat(Edit10.Text);
     B[2]:=StrToFloat(Edit11.Text);
     B[3]:=StrToFloat(Edit12.Text);
     ep:=StrToFloat(Edit13.Text);

     //---------------Determination de R0-------------------
     for i := 1 to n do begin
      somme1:=0;
      for j := 1 to n do begin
      somme1:=somme1+X[1,i]*A[i][j];
      end;
      R[1,i]:=b[i]-somme1;
      ShowMessage('-->'+FloatToStr(R[1,i]));
     end;
     ///--------------------------------

end;

//------------------------------------------------
function isResolvable(Memo1:TMemo):boolean;
var
i,cpt,j,m,l,k:integer;
somme,pre:double;
begin
 cpt:=0;
 l:=0;
 pre:=0;
  for i := 1 to n do begin
      somme:=0;
      for j := 1 to n do begin
        if j<>i then begin
            somme:=somme+abs(A[i][j]);
        end;
      end;
      //--------------------
      if (abs(A[i][i])>=somme) then begin
        cpt:=cpt+1;
        if cpt=n then begin
             result:=true;
         exit;
        end;
      end
      //-------------------------
      else if (abs(A[i][i])<somme)then begin

             for m := i+1 to n do begin
                somme:=0;
                for j := 1 to n do begin
                  if j<>i then  begin
                     somme:=somme+abs(A[m][j]);
                  end;
                end;

                if abs(A[m][i])>=somme then begin
                  //------Permutatio- A ----------
                  for l := 1 to n do begin
                    pre:=A[i][l];
                    A[i][l]:=A[m][l];
                    A[m][l]:=pre;
                  end;
                //------------------Affichage--------
                  Memo1.Lines.Add('Apres permutation');
                  for k := 1 to n do begin
                    for l := 1 to n do begin
                     Memo1.Lines.Add('A['+IntToStr(k)+']['+IntToStr(l)+'] = '+FloatToStr(A[k][l]));
                    end;
                  end;

                Memo1.Lines.Add('-------------------');
                //------Permuter B----
                  pre:=B[i];
                  B[i]:= B[m];
                  B[m]:=pre;
                  //------------------------
                  cpt:=cpt+1;
               end;
            end;
        end;
        //-----------------------------
      if cpt=n then begin
           result:=true;
           exit;
      end;
      if (i=n) and (cpt<>n) then begin
          result:=false;
          exit;
      end;



  end;

end;
//--------------------------------------------------

{$R *.dfm}

procedure TForm2.Button1Click(Sender: TObject);
var i,j,t,m,p,cpt,k,c,d,l,w,f:integer;
somme1,somme2,pre:double;

begin
init();
if isResolvable(Memo1) then begin

   k:=1;
     while k>0 do begin
         for i := 1 to n do begin
               //E*X
            somme1:=0;somme2:=0;
            for j := 1 to i-1 do begin
              somme1:=somme1+(A[i,j]*X[2,j]);
            end;
             //F*X
            for j := i+1 to n do begin
               somme2:=somme2+(A[i,j]*X[1,j]);
            end;

            X[2,i]:=(1/A[i][i])*(B[i]-somme1-somme2);
            //----------------cond arret-------------------

             //-----------Ri k------------------------------
             somme1:=0;
                 for w := 1 to n do begin
                    if w<>i then begin
                      somme1:=somme1+(A[i,w]/A[w,w])*R[1,i];
                    end;
                 end;
                 R[2,i]:=-somme1 ;
                 somme1:=0;
             //-----------Fin  ri k-----------------

      //--------------------------------------------
       end;
       //--------------------Les modulos----------------------------
             pre:=0;
             for l := 1 to n do begin
                 somme1:=somme1+R[2,l]*R[2,l];
                 Memo1.Lines.Add('--->['+FloatToStr(R[2][l])+']<---');
                 pre:=pre+B[l]*B[l];
             end;
               ShowMessage('-Ange--'+IntToStr(k)+'---'+FloatToStr(sqrt(somme1)));
             if (sqrt(somme1)/sqrt(pre))<ep then begin
                 Memo1.Lines.Add('----K = '+IntToStr(k)+'---Residus--');
                      for p:= 1 to n do begin
                        Memo1.Lines.Add(' ['+FloatToStr(X[2][p])+']');
                      end;
                       Memo1.Lines.Add('-----Fin------');
                exit;
             end;

       //------------------------------------------------------------
         if absoluteError(k) then begin
               Memo1.Lines.Add('----K = '+IntToStr(k)+'--Erreur absolue---');
                      for p:= 1 to n do begin
                        Memo1.Lines.Add(' ['+FloatToStr(X[2][p])+']');
                      end;
               Memo1.Lines.Add('-----Fin------');
         end
         else if relativeError(k) then begin
               Memo1.Lines.Add('----K = '+IntToStr(k)+'--Erreur relative---');
                      for p:= 1 to n do begin
                        Memo1.Lines.Add(' ['+FloatToStr(X[2][p])+']');
                      end;
               Memo1.Lines.Add('-----Fin------');
         end;



       //Memo2.Lines.Add('somme 1 = '+FloatToStr(somme1)+' somme2 = '+FloatToStr(somme1));
//------------------ COMPARAISON DES Xi-----------

//       cpt:=0;
//       for m := 1 to n do begin
//            if abs(X[2][m]-X[1][m])<ep then begin
//                  cpt:=cpt+1;
//                  if cpt=n then begin //si la différence de tout les coordonnées est infférieure à ep
//                       Memo1.Lines.Add('----K = '+IntToStr(k)+'-----');
//                      for p:= 1 to n do begin
//                        Memo1.Lines.Add('  '+FloatToStr(X[1][p]));
//                      end;
//                       Memo1.Lines.Add('-----Fin------');
//                       k:=0;
//                    exit;
//                end;
//            end;
//       end;
//---------------- Fin de la comparaison ------------
       //************* inversion **************
       for i := 1 to n do begin
            pre:=X[1][i];
            X[1][i]:=X[2][i];
            X[2][i]:=pre;
       end;
       //**************************************
      // **************Inversion de R*************
             for f := 1 to n do begin
             pre:=R[2,f];
             R[2,f]:=R[1,f];
             R[1,f]:=pre;
             end;
        //***************************************
    k:=k+1;
end;

   //----------------------------------------------

//--------------Affichage des x i-------------------
     for i := 1 to 2 do begin
     Memo1.Lines.Add('Solution X'+IntToStr(i));
       for j:= 1 to n do begin
         Memo1.Lines.Add('  '+FloatToStr(X[i][j]));
       end;
      Memo1.Lines.Add('-------------------');
     end;
 end
 else begin
   ShowMessage('Impossible de résoudre cette équation');
   exit;
 end;


end;


end.
