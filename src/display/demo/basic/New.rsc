module display::demo::basic::New
import display::SocketConnection;
import Prelude;
import util::Math;

Widget box(Widget w, str fillColor) {
    Widget r = w.svg().width(200).height(50);
    int width1 = toInt(replaceFirst(getStyle(r, "width"), "px",""));
    int height1 = toInt(replaceFirst(getStyle(r, "height"), "px", ""));
    r.rect().width(width1). height(height1).attr("fill", "<fillColor>");
    return r;
    }
    
    
Widget box1(Widget w, str style="", num shrink=1, num vshrink=1, num hshrink=1, int lineWidth=0,
    Widget inner = defaultWidget, Align align = center) {
    if (vshrink==1 && hshrink==1) {vshrink = shrink; hshrink = shrink;}
    int vprocent  = round(vshrink*100);
    int hprocent  = round(hshrink*100);
    Widget r = w.svg().attr("width", "<hprocent>%").attr("height","<vprocent>%").attr("preserveAspectRatio", "none")
    .attr("viewBox", "0 0 100 100")
    ;
    r.lineWidth = lineWidth;
    r.hshrink = hshrink; r.vshrink = vshrink;
    r.rect().attr("vector-effect","non-scaling-stroke").attr("width", "100"). 
    attr("height", "100").style(style).attr("stroke-width","<lineWidth>")
    ;
    if (inner!=defaultWidget) {
         int vprocent1  = round(inner.vshrink*100);
         int hprocent1  = round(inner.hshrink*100);
         println("QQQ:<r.lineWidth>");
         Widget html = r.foreignObject().attr("width", "100").attr("height","100")
           .table()
           .width(400).height(400)
           .attr("width", "100%")
           .attr("height","100%")
           .tr().td().style("padding:<10>px");
         add(html, inner); 
         inner.attr("width","<hprocent1>%");inner.attr("height","<vprocent1>%");
         inner.width(hprocent1); inner.height(vprocent1); 
         inner.lineWidth = r.lineWidth + inner.lineWidth;     
         setAlign(html,align);  
         }
    return r;
    }
 
 public void main() {
    Widget _ = createPanel();
    addStylesheet(_, "table{border-spacing:0;padding:0px; background-color:none;border-width:0} td{padding:0};");
    
    box1(_, style="fill:green;stroke:yellow", shrink=0.5, lineWidth=2
                           , inner=box1(_,style="fill:gray;stroke:blue", lineWidth=4, hshrink=0.9, vshrink=0.5)
                           , align = rightBottom);
   
    }

 /*  
 public void main() {
    Widget _ = createPanel();
    addStylesheet(_, "table{border-spacing:0;padding:0px; background-color:none;border-width:0} td{padding:0};");
    Overlay v = overlay(_, [box1(_, style="fill:red;stroke:yellow", lineWidth=2 )
                           ,box1(_, style="fill:green;stroke:yellow", shrink=0.6, lineWidth=2
                           , inner=box1(_,style="fill:gray;stroke:blue", lineWidth=4, shrink=0.2)
                           , align = rightBottom
                           ) 
                          // ,box1(_, style="fill:orange;stroke:yellow", shrink=0.3, lineWidth = 2)
                          ]);
    v.overlay.style("border-color:black;border-width:2px;border-style:solid;width:400px;height:400px");
    setAlign(v.array[1],leftTop);
    //setAlign(v.array[2], rightBottom);  
    }
 */
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