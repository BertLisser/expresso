module display::demo::basic::Primes

import display::SocketConnection;
import Prelude;
import util::Math;

alias Model = list[int];

data Msg
  = press(str idx)
  | refresh(str v)
  ;
  
int n = 15;

Model m =  [];

Widget forRemove = defaultWidget;
  
 void updateView(Msg msg) { 
    switch (msg) {
      case press(_): {
         for (int i<-[0..n]) 
         if (m[i]==1) cells[i][1].attr("fill", "red");
         else if (m[i]==2) cells[i][1].attr("fill", "brown");
         else cells[i][1].attr("fill", "lightgrey"); 
         }
      case refresh(str  s): {
        n = toInt(s);
        m =  [0|int _<-[0..n]];
        cells = segments(n);
        str2int = (cells[k][1].id:k|k<-[0..n]);
        Widget newFrame = frame([cells[k][0]|int k<-[0..n]], viewBox="0 0 3 3")
        .style("width:50%;height:50%");
        replace(forRemove, newFrame);
        forRemove = newFrame;
        }
    }
    }

 void updateModel(Msg msg) {
    // println("updateModel <msg>");
    m =[0|_<-[0..n]];
    switch (msg) {
     case press(str id): {
         int k = str2int[id];
         int p = k;
         for (int i<-[0..n]) {
             m[p%n]=(p%n==k)?2:1;
             p*=k; 
             }  
         }      
    }
   //  println(m); 
   }
   
void update(Msg msg) {
      updateModel(msg);
      updateView(msg); 
      }

num rnd(num x) = round(x, 0.00001);

map[str, int] str2int = ();
list[tuple[Widget, Widget]] cells = [];

tuple[Widget, Widget] segment(int n, int k) {
   num teta = k*2*PI()/n+PI();
   num phi = 2*PI()/n;
   num r1 = 0.7;
   str pat1  = 
   "M <rnd(r1*cos(teta))> <rnd(r1*sin(teta))>, L 0 0, 
   'L <rnd(r1*cos(teta)*cos(phi)-r1*sin(teta)*sin(phi))>  
   ' <rnd(r1*sin(teta)*cos(phi)+r1*cos(teta)*sin(phi))>
   ' , A <r1> <r1> 0 0 0 <rnd(r1*cos(teta))> <rnd(r1*sin(teta))>";
   Widget w1 = path().attr("d", pat1).attr("fill","antiquewhite")
      .attr("stroke","black").attr("stroke-width","0.001px");
   num r2 = 0.9;
   str pat2 = 
   " M <rnd(r2*cos(teta))> <rnd(r2*sin(teta))>
   ',L <rnd(r1*cos(teta))> <rnd(r1*sin(teta))> 
   ',A <r1> <r1> 0 0 1 
   '   <rnd(r1*cos(teta)*cos(phi)-r1*sin(teta)*sin(phi))>  
   '   <rnd(r1*sin(teta)*cos(phi)+r1*cos(teta)*sin(phi))>
   ' L <rnd(r2*cos(teta)*cos(phi)-r2*sin(teta)*sin(phi))>
   '   <rnd(r2*sin(teta)*cos(phi)+r2*cos(teta)*sin(phi))>
   ',A <r2> <r2> 0 0 0 <rnd(r2*cos(teta))> <rnd(r2*sin(teta))>
   "
  ;
   Widget w2 = path().attr("d", pat2).attr("fill","lightgrey")
      .attr("stroke","black").attr("stroke-width","0.001px");
   tuple[num x, num y] c = <((r1+r2)/2)*cos(teta+phi/2), ((r1+r2)/2)*sin(teta+phi/2)>;
     Widget dot = text("<k>").x(rnd(c.x)).y(rnd(c.y)).attr("font-size","0.5%")
      .style("text-anchor:middle;dominant-baseline:middle")
      ;
   Widget r = frame(w1, w2  , dot
   , viewBox="-1 -1 2 2").width(3).height(3).x(0).y(0);
   w2.eventm(click, press(w2.id), update); 
   return <r, w2>;
   }
   
list[tuple[Widget, Widget]] segments(int n) = [
     segment(n, k) | k<-[0..n]
];

public void main() {
   int val = 15, min = 3, max = 32;
   Widget z=createPanel(); 
   addStylesheet("line{stroke-width:0.01; stroke:black}"
   );
   forRemove = div();
   updateView(refresh("<val>"));
   Widget tb  = z.table().style("width:90%");
   Widget qq = input(tb.tr().td()).attr("value", "<val>")
       .attr("type", "range").attr("min","<min>").attr("max","<max>")
       .attr("step","1").class("range").style("width:100%")
       ;
      frame(tb.tr().td(),  [
      //line(<k, 0>, <k, 1>)|int k<-[min..max+1]
      text("<k>").x(k*0.97+0.5).y(0.6).attr("font-size","5%")
       .style("text-anchor:middle")
       |int k<-[min..max+1]
      ] 
      ,viewBox="<min> 0 <max-min> 1").
      style("height:<400/(max-min)>%;width:100%")
      ;
      qq.eventf(change, refresh, updateView);  
      eventLoop(z, []);
}