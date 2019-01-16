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
    createPanel(); 
    addStylesheet("rect{stroke:yellow;stroke-width:2}");
    overlay([frame(rect().style("fill:red"), shrink = 0.5, align = leftTop)
            ,frame(rect().style("fill:green"), shrink=0.5,   align = rightBottom)    
            ,frame(rect().style("fill:orange"), shrink=0.3, align = leftBottom)
            ]
           );                      
    }
 
    
 public void main() {
    int cx = 25, cy  =25, r = 10;
    createPanel(); 
    Widget w = box(4
                  ,rect().width(100).height(100).style("fill:red;stroke:yellow").attr("stroke-width","8")
                  ,circle().cx(cx+2).cy(cy+2).r(r).style("fill:black")
                  shrink=0.5, viewBox= "0 0 100 100")
         .add1(box(8 
                 ,rect().width(100).height(100). style("fill:yellow;stroke:brown").attr("stroke-width","16")
                 ,circle().cx(cx+4).cy(cy+4).r(r).style("fill:black") 
                 hshrink = 0.5, vshrink = 0.5, viewBox= "0 0 100 100"), rightBottom)
         .add1(box(16
                 ,rect().width(100).height(100).style("fill:yellow;stroke:green").attr("stroke-width","32")
                 ,circle().cx(cx+8).cy(cy+8).r(r).style("fill:black")
                 ,shrink = 0.5, viewBox= "0 0 100 100"), rightBottom)
         .add1(box(32   
                 ,rect().width(100).height(100).style("fill:yellow;stroke:blue").attr("stroke-width","64")
                 ,circle().cx(cx+16).cy(cy+16).r(r).style("fill:black")
                 ,shrink = 0.5, viewBox= "0 0 100 100"), rightBottom)
        ;
    }
    
 //list[str] colors = ["antiquewhite", "beige", "brown", "cadetblue", "darksalmon", "deeppink", 
 //                   "floralwhite", "forestgreen", "indianred", "lavender", "lightseagreen"];
 list[str] colors = ["darkmagenta", "darkolivegreen",  "darkkhaki", "darkorange",   
            "darkorchid", "darkred", "darksalmon", "darkseagreen"];              
 public Widget palettec() {
      // Widget _ = createPanel();
      num lw = 400;
      num shrink = 1.0;
      Widget result = box(lw, circle().cx(5000).cy(5000).r(5000-lw/2).style(
          "fill:none;stroke-width:inhirit;stroke:<head(colors)>") 
                    , shrink = 0.5 , viewBox="0 0 10000 10000"
                             ).
                    attr("width","300").attr("height","300")
                    ;
     Widget w = result;
     for (str color <- tail(colors)) {
          lw = (10000 / (10000-2*lw)) *lw;
          Widget inner = box(lw, circle().cx(5000).cy(5000).r(5000-lw/2).style(
          "stroke-width:<lw>;stroke:<color>; fill:none"), 
                     shrink = shrink , viewBox="0 0 10000 10000"
                     )
          ;
          w = w.add1(inner,center);
          // break;
          } 
      return result;
      }
      
 public Widget paletter() {
      num lw = 400;
      num hshrink = 0.9;
      num vshrink = 0.9;
      Widget result = box(lw, rect()
        .x(lw/2).y(lw/2).style(
          "fill:white;stroke-width:<lw>;stroke:<head(colors)>;width:<10000-lw>;height:<10000-lw>") 
                    , viewBox="0 0 10000 10000", shrink = 0.8)
                    // .attr("width","500").attr("height","500")
                    ;
     Widget w = result;
     for (str color <- tail(colors)) {
          lw = (10000 / (10000-2*lw)) *lw;
          lw = lw/0.9;
          Widget inner = box(lw, rect()
          .x(lw/2).y(lw/2).style(
              "stroke-width:<lw>;stroke:<color>; fill:white; width:<10000-lw>;height:<10000-lw>"), 
                     vshrink = vshrink, hshrink = hshrink, viewBox="0 0 10000 10000")
                     ;
          w = w.add1(inner, rightBottom);   
          // break;
          } 
      return frame(result.class("app"), viewBox="0 0 10000 10000")
         .attr("width","500").attr("height","500")
      ;
      }
      
 void nesting() {
      createPanel();
      addStylesheet("td{border: 4px ridge grey} .aap{transform:rotate(30deg)}");
      Grid g = vcat([paletter()
                    ,palettec()
           ]);
      // g.td[0][0].height(700).width(700);
      }
                    
 

public void flag() {
    createPanel();
    Grid t = grid([[frame(rect().style("fill:red"))],
                   [frame(rect().style("fill:white"))],
                   [frame(rect().style("fill:blue"))]                 
                   ]);
    t.table.style("border-color:black;border-width:2px;border-style:solid"); 
    }

 
 public void mondriaan() {
     createPanel(width=400, height=700);
     str w = "20px", h = "250px";
     addStylesheet("rect{stroke:black;stroke-width:2;fill:none} 
                     'td{padding:0; border-width:4px; border-style:solid}
                     '.mainGrid{width:<w>;height:<h>;padding:0;border-width:0}
                     ");
        Grid leftUpper = vcat(2);
        Grid rightUpper = vcat(1);
        rightUpper.td[0][0].style("background-color:red;border-left-width:0"); 
        Grid leftUnder = vcat(1);
        leftUnder.td[0][0].style("background-color:blue;border-top-width:0"); 
        Grid rightLeftUnder = vcat(1);
        for (Widget w<-concat(rightLeftUnder.td)) {
             w.style("padding:0;border-left-width:0;border-right-width:0;border-top-width:0"); }
        Grid rightRightUnder = vcat(2);
        rightRightUnder.td[0][0].style("background-color:yellow;border-top-width:0");
        Grid rightUnder = hcat([rightLeftUnder.table, rightRightUnder.table]);
        for (Widget w<-concat(rightUnder.td)) {w.style("width:50%;border-width:0"); }
        Grid g = grid([[leftUpper.table,  rightUpper.table], [leftUnder.table, rightUnder.table]]);
        for (Widget w<-concat(g.td)) w.class("mainGrid");        
     }
     
list[Widget] lines() {
     int n = 20, m = 10;
     addStylesheet("line.grey{stroke-width:0.5;stroke:grey}line.blue{stroke-width:0.5;stroke:blue}");
     return 
            [line(<0, (100/m)*i>, <100, (100/m)*i>).class("grey")|int i<-[1..m]]
     +      [line(<(100/m)*i,0>, <(100/m)*i, 100>).class("grey")|int i<-[1..m]]
     +      [line(<0, (100/n)*i>, <(100/n)*i, 100>).class("blue")|int i<-[1..n]]
     +      [line(<(100/n)*i, 0>, <100, (100/n)*i>).class("blue")|int i<-[1..n]]
     ;
     }
     
 list[Widget] hText() = [text("<i>").x(8*i-1).y(7)|i<-[1..10]];
 
 list[Widget] vText() = [text("<i>").y(3+8*i).x(4)|i<-[1..10]];
 
 void linedBox() {
     createPanel();
     num lw=1;
     addStylesheet("rect{fill:antiquewhite;}text{font-size:8px}");
     Widget middle = box(lw
               ,rect().style("width:<(100-lw)>%;height:<(100-lw)>%;fill:white;stroke-width:inhirit;stroke:<head(colors)>")
                 .x(lw/2).y(lw/2)
               ,shrink = 1.0)
             .add(frame(lines()),center);
           ;
     Widget left = frame([rect()]+vText(), vshrink = 0.8, hshrink = 0.1, align = leftCenter
        //, viewBox="0 0 100 100"
         );
     Widget bottom = frame([rect()]+hText(), hshrink = 0.8, vshrink = 0.1, align = centerBottom
        //, viewBox="0 0 100 100"   
         );
     Widget extra = frame(frame(
      circle().style("fill:yellow;stroke-width:4;stroke:red").r(46).cx(50).cy(50), 
      shrink=0.5
         , align = rightBottom
         , viewBox="0 0 100 100"
         )
           .add(text("Hallo").x(50).y(50).style("text-anchor:middle;dominant-baseline:middle;font-size:20"), center)
         , shrink=0.5
         , viewBox = "0 0 100 100"
         , align=leftTop)
         
         ;
     //Widget extra1 = frame([circle().style("fill:yellow;stroke-width:4;stroke:red").r(21).cx(27).cy(27)], shrink=0.5
     //    , align = center, viewBox="-25 -25 100 100").add(text("Hallo").x(15).y(27), center);
     overlay([left, bottom, frame(middle, shrink=0.8, align = center, viewBox = "0 0 100 100"), extra]);
     }
   
     
 public void sets() {
    createPanel();
    num rx  = 40, ry = 20; 
    overlay([frame(ellipse().cx(50).cy(50).attr("rx", "<rx>").attr("ry", "<ry>").style("fill:red;fill-opacity:0.5")
                                 ,align = leftCenter, shrink = 0.7, viewBox = "0 0 100 100")
                           ,frame(ellipse().cx(50).cy(50).attr("rx", "<rx>").attr("ry", "<ry>").style("fill:blue;fill-opacity:0.5")
                                 ,align = rightCenter, shrink = 0.7, viewBox = "0 0 100 100")
                           ,frame(ellipse().cx(50).cy(50).attr("rx", "<rx>").attr("ry", "<ry>").style("fill:yellow;fill-opacity:0.5")
                                 ,align = centerBottom, shrink = 0.7, viewBox = "0 0 100 100")
                          ]);
    }
    
 public void tables() {
     int n  = 10, m = 10;
     Widget w = createPanel();
     addStylesheet("td{border: 4px ridge grey;text-align:center}");
     Grid g =  grid([m|int i<-[0..n]]);
     for (int i<-[0..n])
        for (int j<-[0..m])
           g.td[i][j].innerHTML("<i*j>");
     }
     
 public void pascal() {
     int n  =  12;
     Widget w = createPanel();
     addStylesheet(
     "
     'td{text-align:center}
     'table{width:300px;height:300px}
     '.pascal{width:400px;height:400px;margin:auto}
     ");
     list[int] a = [((i == (n-1)/2)? 1:0)|int i<-[0..n]];
     list[list[int]] r = [a];
     for (int i<-[0..n]) {
        list[int] b = [(j>=1?a[j-1]:0)+(j>=n-1?0:a[j+1])|j<-[0..n]];
        r+=[b];
        a = b;
        }
     Grid g =  grid(w.div().class("pascal"), [n|int i<-[0..n/2]]);
     for (int i<-[0..n/2])
        for (int j<-[0..n])
           if (r[i][j]!=0) g.td[i][j].innerHTML("<r[i][j]>");
     }
     
     