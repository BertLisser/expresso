module display::demo::basic::Circle
import display::SocketConnection;
import Prelude;
import util::Math;

public void main() {
 Widget z=createPanel(portNumber=8020).div();
 Widget p = z.svg().width(200).height(200).class("b").attr("viewBox","0 0 200 200");
   //p.rect().width(100).height(100).style("fill:yellow");
   //num r = shrink*(100-10)/2;
   //num cx = 100/2;
   //num cy = 100/2;
   num r = 50;
   num cx = 100;
   num cy = 100;
   Widget q=p.circle().attr("r", "<r>").attr("cx", "<cx>").attr("cy","<cy>").
   style("stroke:red;stroke-width:8;fill:blue;visibility:visible");
   for (num f<-[1.2, 1.3..2])
   grow(q,  p.rect().style("fill:yellow;fill-opacity:0.1;stroke:red;stroke-width:4"), f, <0.5, 0.5>);
   eventLoop(z, []);
   }