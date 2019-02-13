module display::demo::basic::Primes

import display::SocketConnection;
import Prelude;
import util::Math;

Widget segment(Widget p, int n) {
   num phi = 2*PI()/n;
   num r = 0.9;
   str pat1  = "M <r> 0, L 0 0, L<r*sin(phi)> <r*cos(phi)>, A <r> <r> 0 0 <r> 0";
   Widget w1 = path(defs()).attr("d", pat1).attr("fill","yellow")
      .attr("stroke","black").attr("stroke-width","0.001px");
   return frame(use(w1)
   , viewBox="0, 0, 1, 1").style("width:50%;height:50%");
   }

public void main() {
   Widget z=createPanel();
   // addStylesheet("path{stroke-width:1};");
   Widget dv = div(z).class("part");
   segment(dv, 6);
   eventLoop(dv, []);
}