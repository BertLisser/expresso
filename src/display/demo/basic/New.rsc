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
    Overlay v = overlay(_, [box(_, style="fill:red;stroke:yellow", lineWidth=16, shrink = 0.5, align = leftTop )
                           ,box(_, style="fill:green;stroke:yellow", shrink=0.5, lineWidth=16
                           , inner=box(_,style="fill:gray;stroke:blue", lineWidth=16,  vshrink=0.5, hshrink=0.7
                               , inner = box(_, style="fill:antiquewhite;stroke:brown", shrink=0.5, lineWidth=16, align = rightBottom)
                               , align = leftBottom
                               ), 
                           align = rightBottom)    
                           ,box(_, style="fill:orange;stroke:yellow", shrink=0.3, lineWidth = 2, align = leftBottom)
                          ]);
                          
    v.overlay.style("border-color:black;border-width:2px;border-style:solid;width:400px;height:400px");
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
 
 public void mondriaan() {
     Widget _ = createPanel();
     addStylesheet(_,"rect{stroke:black;stroke-width:2;fill:none} 
                     'table{border-spacing:0;padding:0; resize:both; border-collapse:collapse;
                     overflow:auto; border-width:0; width:100%;height:100%} 
                     'td{padding:0; border-width:4px; border-style:solid}");
        Grid leftUpper = vcat(_, 2);
        Grid rightUpper = vcat(_, 1);
        rightUpper.td[0][0].style("background-color:red;border-left-width:0"); 
        Grid leftUnder = vcat(_, 1);
        leftUnder.td[0][0].style("background-color:blue;border-top-width:0"); 
        Grid rightLeftUnder = vcat(_, 1);
        for (Widget w<-concat(rightLeftUnder.td)) {
             w.style("padding:0;border-left-width:0;border-right-width:0;border-top-width:0"); }
        Grid rightRightUnder = vcat(_, 2);
        rightRightUnder.td[0][0].style("background-color:yellow;border-top-width:0");
        Grid rightUnder = hcat(_, [rightLeftUnder.table, rightRightUnder.table]);
        for (Widget w<-concat(rightUnder.td)) {w.style("width:50%;border-width:0"); }
        Grid g = grid(_, [[leftUpper.table,  rightUpper.table], [leftUnder.table, rightUnder.table]]);
        g.td[0][0].style("width:30%;padding:0;border-width:0"); 
        g.td[1][0].style("width:30%;padding:0;border-width:0");
        g.td[0][1].style("width:70%;padding:0;border-width:0"); 
        g.td[1][1].style("width:70%;padding:0;border-width:0");   
        g.table.style("width:300px; height:400px");        
     }