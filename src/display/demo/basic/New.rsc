module display::demo::basic::New
import display::SocketConnection;
import Prelude;

Widget box(Widget w, str fillColor) {
    Widget r = w.svg().attr("fill", "<fillColor>");
    r.width(200).height(50);
    int width = toInt(replaceFirst(style(r, "width"), "px",""));
    int height = toInt(replaceFirst(style(r, "height"), "px", ""));
    r.rect().width(width). height(height);
    return r;
    }

public void main() {
    Widget _ = createPanel();
    addStylesheet(_, "table{border-spacing:0;padding:0px; background-color:blue;border-width:0} td{padding:0};");
    Table t = table(_, [[box(_, "red")],
                        [box(_, "white")],
                        [box(_, "blue")]                 
                       ]);
    t.table.style("border-color:black;border-width:2px;border-style:solid"); 
    }