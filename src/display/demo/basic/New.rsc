module display::demo::basic::New
import display::SocketConnection;
import Prelude;

Widget box(Widget w, str fillColor) {
    Widget r = w.svg().width(200).height(50);
    int width1 = toInt(replaceFirst(getStyle(r, "width"), "px",""));
    int height1 = toInt(replaceFirst(getStyle(r, "height"), "px", ""));
    r.rect().width(width1). height(height1).attr("fill", "<fillColor>");
    return r;
    }

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
        q[0].style("vertical-align:bottom");
        styleChild(q[0], "margin-left:auto;margin-right:0", 0);
        }
    }