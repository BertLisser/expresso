module display::demo::basic::gonio::Gonio
import display::SocketConnection;
import Prelude;
import util::Math;

@license{
  Copyright (c) Tijs van der Storm <Centrum Wiskunde & Informatica>.
  All rights reserved.
  This file is licensed under the BSD 2-Clause License, which accompanies this project
  and is available under https://opensource.org/licenses/BSD-2-Clause.
}
@contributor{Bert Lisser - bertl@cwi.nl - CWI}


alias Model = map[str, tuple[num shift, num amplitude, num frequency]]; 

void gonio() {
    Model m =  ("sin":<0,1,1>,"cos":<0,1,1>);
    Widget root = createPanel();
    addStylesheet(
    "path{stroke-width:0.02}
    '.sin{stroke:blue}
    '.cos{stroke:red}
    '.sincos{stroke:brown}
    '.overlay_frame{width:400px;height:400px}
    '.range{width:70%}
    'td{border: 4px groove #999999;border-collapse:collapse;text-align:center}
    "
    );
    
    Graph d1 = <"sin","", []>;
    Graph d2 = <"cos","", []>; 
    Graph d3 = <"sincos","", []>;
    Overlay plot = graph(root ,"-2/0", ["\u03C0/2","\u03C0","3\u03C0/2", "2\u03C0"],
                                ["-1","0","1","2"], d1, d2, d3
                                , view=<0, -2, 2*PI(), 4>);
                                 
   list[Widget] button(str title, str id,  num val, num min, num max, num step) {
      Widget range = input().attr("value", "<round(val,0.0001)>")
       .attr("type", "range").attr("min","<round(min,0.0001)>").attr("max","<round(max,0.0001)>")
       .attr("step","<round(step,0.0001)>").class("range");
      range.eventScript(change, |project://expresso/src/display/demo/basic/gonio/update.js?id=<range.id>;name=<id>_<title>;func=<id>|);
      return  [div("<title>"),div("<round(min)>"),range,div("<round(max)>")];
    }

   void buttons(Widget p, str func) { 
      Grid pp = grid(p,     
      [button("shift", func,  m[func].shift, 0, 4, 0.01),
       button("frequency", func,  m[func].frequency, 0, 10, 1),
       button("amplitude", func, m[func].amplitude, 0, 4, 0.01)
      ]
     );
    for (list[Widget] row <- pp.td) row[0].style("width:25%");
    pp.table.style("width:70%");
   } 
    h2(root, "sin");                            
    buttons(root, "sin");
    h2(root, "cos");
    buttons(root, "cos");                                   
    int c = 70;
    plot.overlay.style("width:<c>%;height:<floor(4.0/(2*PI())*c)>%");
         runScriptHead(
    |project://expresso/src/display/demo/basic/gonio/path.js|
       ,"sin_id=<plot.ref["sin"].id>"
       ,"cos_id=<plot.ref["cos"].id>"
       ,"sincos_id=<plot.ref["sincos"].id>"
       ,"sin_shift=<round(m["sin"].shift, 0.0001)>"
       ,"cos_shift=<round(m["cos"].shift, 0.0001)>"
       ,"sin_frequency=<round(m["sin"].frequency, 0.0001)>"
       ,"cos_frequency=<round(m["cos"].frequency, 0.0001)>"
       ,"sin_amplitude=<round(m["sin"].amplitude, 0.0001)>"
       ,"cos_amplitude=<round(m["cos"].amplitude, 0.0001)>"
      );                            
    }
