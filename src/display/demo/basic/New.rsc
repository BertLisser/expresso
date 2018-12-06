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

 /*
 public void main() {
    Widget _ = createPanel();
    addStylesheet(_, "table{border-spacing:0;padding:0px; background-color:none;border-width:0} td{padding:0px};");
    Overlay v = overlay(_, [box(_, style="fill:red;stroke:yellow", lineWidth=16, shrink = 0.5, align = leftTop )
                           ,box(_, style="fill:green;stroke:yellow", shrink=0.5, lineWidth=16
                           , inner=box(_,style="fill:gray;stroke:blue", lineWidth=16,  vshrink=0.5, hshrink=0.7
                               , inner = box(_, style="fill:antiquewhite;stroke:brown", shrink=0.7, 
                                              lineWidth=16, align = leftTop)
                               , align = leftBottom
                               ), 
                           align = rightBottom)    
                           ,box(_, style="fill:orange;stroke:yellow", shrink=0.3, lineWidth = 2, align = leftBottom)
                          ]);
                          
    v.overlay.style("border-color:black;border-width:2px;border-style:solid;width:400px;height:400px");
    }
  */
    
 public void main() {
    int cx = 25, cy  =25, r = 10;
    Widget _ = createPanel();
    addStylesheet(_, "table{border-spacing:0;padding:0px; background-color:none;border-width:0} td{padding:0px};");
    Widget w = box(_ 
                  ,_ .rect().width(100).height(100).style("fill:red;stroke:yellow").attr("stroke-width","8")
                  , _.circle().cx(cx+2).cy(cy+2).r(r).style("fill:black")
                  ,lineWidth=4, shrink=0.5)
         .add(box(_ 
                 ,_.rect().width(100).height(100). style("fill:yellow;stroke:brown").attr("stroke-width","16")
                 ,_.circle().cx(cx+4).cy(cy+4).r(r).style("fill:black") 
                 ,lineWidth=8, hshrink = 0.5, vshrink = 0.5, align=rightBottom))
         .add(box(_
                 ,_.rect().width(100).height(100).style("fill:yellow;stroke:green").attr("stroke-width","32")
                 ,_.circle().cx(cx+8).cy(cy+8).r(r).style("fill:black")
                 ,lineWidth=16, shrink = 0.5, align=rightBottom))
         .add(box(_   
                 ,_.rect().width(100).height(100).style("fill:yellow;stroke:blue").attr("stroke-width","64")
                 ,_.circle().cx(cx+16).cy(cy+16).r(r).style("fill:black")
                 ,lineWidth=32, shrink = 0.5, align=rightBottom))
        ;
    }
    
 //list[str] colors = ["antiquewhite", "beige", "brown", "cadetblue", "darksalmon", "deeppink", 
 //                   "floralwhite", "forestgreen", "indianred", "lavender", "lightseagreen"];
 list[str] colors = ["darkmagenta", "darkolivegreen",  "darkkhaki", "darkorange",   
            "darkorchid", "darkred", "darksalmon", "darkseagreen"];              
 public Widget palettec(Widget p) {
      // Widget _ = createPanel();
      Widget _ = p;
      num lw = 4;
      num shrink = 1.0;
      Widget result = box(_, _.circle().cx(50).cy(50).r(round(50-lw/2, 0.001)).style(
          "fill:none;stroke-width:inhirit;stroke:<head(colors)>") 
                    ,lineWidth = round(lw, 0.001), shrink = 0.5).
                    attr("width","200").attr("height","200")
                    ;
     Widget w = result;
     for (str color <- tail(colors)) {
          lw=lw/(shrink*((100-lw)/100));
          w = w.add(
          box(_, _.circle().cx(50).cy(50).r(round(50-lw/2, 0.001)).style(
          "stroke-width:<round(lw)>;stroke:<color>; fill:none") 
                    lineWidth = round(lw, 0.001), shrink = shrink));
          // break;
          } 
      return result;
      }
      
 public Widget paletter(Widget p) {
      Widget _ = p;
      num lw = 4;
      num shrink = 1;
      Widget result = box(_, _.rect().width(100-lw).height(100-lw).x(lw/2).y(lw/2).style(
          "fill:white;stroke-width:inhirit;stroke:<head(colors)>") 
                    lineWidth = lw, shrink = 0.5).attr("width","200").attr("height","200");
     Widget w = result;
     for (str color <- tail(colors)) {
          lw=lw/(shrink*((100-lw)/100));
          w = w.add(
          box(_, _.rect().width(100-lw).height(100-lw).x(lw/2).y(lw/2).style(
          "stroke-width:<lw>;stroke:<color>; fill:white") 
                    lineWidth = lw, shrink = shrink));
          // break;
          } 
      return result;
      }
      
 void nesting() {
      Widget _ = createPanel();
      addStylesheet(_, "td{border: 4px ridge grey}");
      vcat(_, [paletter(_), palettec(_)]);
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