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

 public void over() {
    Widget _ = createPanel(); 
    Overlay v = overlay(_, [box(0, rect().style("fill:red;stroke:yellow"), lineWidth=16, shrink = 0.5, align = leftTop )
                           ,box(0, rect().style("fill:green;stroke:yellow"), shrink=0.5, lineWidth=16,
                           align = rightBottom)    
                           ,box(0, rect().style("fill:orange;stroke:yellow"), shrink=0.3, lineWidth = 2, align = leftBottom)
                          ]);                      
    }
 
    
 public void main() {
    int cx = 25, cy  =25, r = 10;
    createPanel(); 
    Widget w = box(4
                  ,rect().width(100).height(100).style("fill:red;stroke:yellow").attr("stroke-width","8")
                  ,circle().cx(cx+2).cy(cy+2).r(r).style("fill:black")
                  shrink=0.5)
         .add(box(8 
                 ,rect().width(100).height(100). style("fill:yellow;stroke:brown").attr("stroke-width","16")
                 ,circle().cx(cx+4).cy(cy+4).r(r).style("fill:black") 
                 hshrink = 0.5, vshrink = 0.5), rightBottom)
         .add(box(16
                 ,rect().width(100).height(100).style("fill:yellow;stroke:green").attr("stroke-width","32")
                 ,circle().cx(cx+8).cy(cy+8).r(r).style("fill:black")
                 ,shrink = 0.5), rightBottom)
         .add(box(32   
                 ,rect().width(100).height(100).style("fill:yellow;stroke:blue").attr("stroke-width","64")
                 ,circle().cx(cx+16).cy(cy+16).r(r).style("fill:black")
                 ,shrink = 0.5), rightBottom)
        ;
    }
    
 //list[str] colors = ["antiquewhite", "beige", "brown", "cadetblue", "darksalmon", "deeppink", 
 //                   "floralwhite", "forestgreen", "indianred", "lavender", "lightseagreen"];
 list[str] colors = ["darkmagenta", "darkolivegreen",  "darkkhaki", "darkorange",   
            "darkorchid", "darkred", "darksalmon", "darkseagreen"];              
 public Widget palettec() {
      // Widget _ = createPanel();
      num lw = 4;
      num shrink = 1.0;
      Widget result = box(lw, circle().cx(50).cy(50).r(round(50-lw/2, 0.001)).style(
          "fill:none;stroke-width:inhirit;stroke:<head(colors)>") 
                    , shrink = 0.5).
                    attr("width","300").attr("height","300")
                    ;
     Widget w = result;
     for (str color <- tail(colors)) {
          lw=round(lw/(shrink*((100-lw)/100)), 0.01);
          w = w.add(
          box(lw, circle().cx(50).cy(50).r(round(50-lw/2, 0.001)).style(
          "stroke-width:<lw>;stroke:<color>; fill:none") 
                     shrink = shrink), center);
          // break;
          } 
      return result;
      }
      
 public Widget paletter() {
      num lw = 2;
      num shrink = 0.95;
      Widget result = box(lw, rect()
        .x(lw/2).y(lw/2).style(
          "fill:white;stroke-width:inhirit;stroke:<head(colors)>;width:<100-lw>%;height:<100-lw>%") 
                    shrink = 0.5, align = rightCenter).attr("width","300").attr("height","300");
     Widget w = result;
     for (str color <- tail(colors)) {
          lw=round(lw/(shrink*((100-lw)/100)), 0.01);
          w = w.add(
          box(lw, rect()
          .x(lw/2).y(lw/2).style(
          "stroke-width:<lw>;stroke:<color>; fill:white; width:<100-lw>%;height:<100-lw>%") 
                     shrink = shrink), center);
          // break;
          } 
      return result;
      }
      
 void nesting() {
      Widget _ = createPanel();
      addStylesheet(_, "td{border: 4px ridge grey}");
      vcat(_, [paletter(), palettec()]);
      }
                    
 

public void flag() {
    Widget _ = createPanel();
    Grid t = grid(_, [[box(0, rect().style("fill:red"))],
                        [box(0,rect().style("fill:white"))],
                        [box(0, rect().style("fill:blue"))]                 
                       ]);
    t.table.style("border-color:black;border-width:2px;border-style:solid"); 
    }

 
 public void mondriaan() {
     Widget _ = createPanel(width=400, height=700);
     addStylesheet(_,"rect{stroke:black;stroke-width:2;fill:none} 
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
        str w = "20px", h = "250px";
        g.td[0][0].style("width:<w>;height:<h>;padding:0;border-width:0"); 
        g.td[1][0].style("width:<w>;height:<h>;padding:0;border-width:0");
        g.td[0][1].style("width:<w>;height:<h>;padding:0;border-width:0"); 
        g.td[1][1].style("width:<w>;height:<h>; padding:0;border-width:0"); 
        // g.table.attr("width","50%").attr("height","50%");    
        // g.table.style("width:50%; height:50%");        
     }
     
list[Widget] lines() {
     int n = 10;
     return 
            [line(<0, (100/n)*i>, <100, (100/n)*i>).class("grey")|int i<-[1..n]]
     +      [line(<(100/n)*i,0>, <(100/n)*i, 100>).class("grey")|int i<-[1..n]]
     +      [line(<0, (100/n)*i>, <(100/n)*i, 100>).class("blue")|int i<-[1..n]]
     +      [line(<(100/n)*i, 0>, <100, (100/n)*i>).class("blue")|int i<-[1..n]]
     ;
     }
     
 void linedBox() {
     createPanel();
     addStylesheet("line.grey{stroke-width:0.5;stroke:grey}line.blue{stroke-width:0.5;stroke:blue}");
     num lw=1;
     Widget result = box(lw
               ,rect().style("width:<(100-lw)>%;height:<(100-lw)>%;fill:white;stroke-width:inhirit;stroke:<head(colors)>")
                 .x(lw/2).y(lw/2)
               ,shrink = 0.5)
           .add(box(0, lines()),center)
           ;
     }
     
 public void sets() {
    Widget _ = createPanel();
    num rx  = 40, ry = 20; 
    Overlay v = overlay(_, [box(0,  ellipse().cx(50).cy(50).attr("rx", "<rx>").attr("ry", "<ry>").style("fill:red;fill-opacity:0.5")
                                 ,align = leftCenter, shrink = 0.7)
                           ,box(0,  ellipse().cx(50).cy(50).attr("rx", "<rx>").attr("ry", "<ry>").style("fill:blue;fill-opacity:0.5")
                                 ,align = rightCenter, shrink = 0.7)
                           ,box(0,  ellipse().cx(50).cy(50).attr("rx", "<rx>").attr("ry", "<ry>").style("fill:yellow;fill-opacity:0.5")
                                 ,align = centerBottom, shrink = 0.7)
                          ]);
    }
     
     