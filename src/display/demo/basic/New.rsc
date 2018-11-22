module display::demo::basic::New
import display::SocketConnection;
import Prelude;
import util::Math;
    
    

 /*
 public void main() {
    Widget _ = createPanel();
    addStylesheet(_, "table{border-spacing:0;padding:0px; background-color:none;border-width:0} td{padding:0};");
    
    box1(_, style="fill:green;stroke:yellow", shrink=0.3, lineWidth=2
                           , inner=box1(_,style="fill:gray;stroke:blue", lineWidth=4, hshrink=0.9, vshrink=0.5)
                           , align = rightBottom);
   
    }
 */

  
 public void main() {
    Widget _ = createPanel();
    addStylesheet(_, "table{border-spacing:0;padding:0px; background-color:none;border-width:0} td{padding:0px};");
    Overlay v = overlay(_, [box(_, style="fill:red;stroke:yellow", lineWidth=16, shrink = 0.5 )
                           ,box(_, style="fill:green;stroke:yellow", shrink=0.5, lineWidth=16
                           , inner=box(_,style="fill:gray;stroke:blue", lineWidth=16, vshrink=0.5, hshrink=0.8
                               , inner = box(_, style="fill:antiquewhite;stroke:brown", shrink=0.5, lineWidth=16)
                           , align = leftBottom)
                           , align = rightBottom) 
                           ,box(_, style="fill:orange;stroke:yellow", shrink=0.3, lineWidth = 2)
                          ]);
    v.overlay.style("border-color:black;border-width:2px;border-style:solid;width:400px;height:400px");
    setAlign(v.array[0],leftTop);
    setAlign(v.array[1], rightBottom);
    setAlign(v.array[2], leftBottom);   
    }
 
 /* 
public void main() {
    Widget _ = createPanel();
    addStylesheet(_, "table{border-spacing:0;padding:0px; background-color:antiquewhite;border-width:0} td{padding:0};");
    Grid t = grid(_, [[box(_, "red")],
                        [box(_, "white")],
                        [box(_, "blue")]                 
                       ]);
    t.table.style("border-color:black;border-width:2px;border-style:solid"); 
    t.table.width(400).height(300);
    for (list[Widget] q <- t.td) {
        setAlign(q[0], rightBottom);
        }
    }
 */