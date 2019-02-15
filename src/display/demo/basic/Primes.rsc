module display::demo::basic::Primes

import display::SocketConnection;
import Prelude;
import util::Math;

num rnd(num x) = round(x, 0.001);

Widget segment(int n, teta) {
   num phi = 2*PI()/n;
   num r = 0.9;
   str pat1  = 
   "M <rnd(r*cos(teta))> <rnd(r*sin(teta))>, L 0 0, 
   'L <rnd(r*cos(teta)*cos(phi)-r*sin(teta)*sin(phi))>  
   ' <rnd(r*sin(teta)*cos(phi)+r*cos(teta)*sin(phi))>
   ' , A <r> <r> 0 0 0 <rnd(r*cos(teta))> <rnd(r*sin(teta))>";
   Widget w1 = path(defs()).attr("d", pat1).attr("fill","blue")
      .attr("stroke","black").attr("stroke-width","0.001px")
      .style("fill-opacity:<abs(rnd(teta/(2*PI())))>");
   return frame(w1
   , viewBox="-1 -1 2 2").width(3).height(3).x(0).y(0);
   }
   
list[Widget] segments(int n) = [
     segment(n, k*2*PI()/n) | k<-[0..n]
];

public void main() {
   Widget z=createPanel();
   //addStylesheet("path{stroke-width:1};");
   Widget dv = div(z).class("part");
   frame(segments(40), viewBox="0 0 3 3")
   .style("width:50%;height:50%");
   // eventLoop(dv, []);
}