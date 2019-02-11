module display::demo::basic::Gonio
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
                   
Model m =  ("sin":<0,1,1>,"cos":<0,1,1>);

Overlay plot;

Widget root = defaultWidget;

data Msg
  = shift(str idx, str func, str sh)
  | amplitude(str idx, str func, str am)
  | frequency(str idx, str func, str fr)
  ;
  
Msg(str) shiftF(str idx, str func) { return Msg(str s) { 
         return shift(idx, func, s); };
         }
Msg(str) amplitudeF(str idx, str func) = Msg(str s) { return amplitude(idx, func, s); }; 
Msg(str) frequencyF(str idx, str func) = Msg(str s) { return frequency(idx, func, s); }; 

num toReal_(str s) {
  try {
    return round(toReal(s), 0.001);
  }
  catch IllegalArgument():
    return 0.0;
}

void updateView(Msg msg) {
    // println("updateView <msg>");
    switch (msg) {
       case shift(str idx, str func, _): 
        plot.ref[idx].attr("d", getString(f(func), <0, -2, 2*PI(), 4>));
       case amplitude(str idx, str func,_): 
         plot.ref[idx].attr("d",  getString(f(func), <0, -2, 2*PI(), 4>));
       case frequency(str idx,str func, _): 
          plot.ref[idx].attr("d",  getString(f(func), <0, -2, 2*PI(), 4>));
       }
    }


void updateModel(Msg msg) {
  switch (msg) {
    case shift(_, str func, str sh): {m[func].shift = toReal_(sh);}
    case amplitude(_, str func, str am): {m[func].amplitude = toReal_(am);}
    case frequency(_, str func,str fr): {m[func].frequency = toReal_(fr);}
  }
}

void update(Msg msg) {
      updateModel(msg);
      updateView(msg); 
      }
      
Widget button(str title, str id, Msg(str)(str, str) func,  num val, num min, num max, num step) {
     Widget qq = input().attr("value", "<round(val,0.0001)>")
       .attr("type", "range").attr("min","<round(min,0.0001)>").attr("max","<round(max,0.0001)>")
       .attr("step","<round(step,0.0001)>");
    qq.eventf(change, func(id, id), update); 
    Grid pp = hcat(div().class("buttons"),
     [div("<id>:<title>")
    ,div("<round(min)>")
    ,qq
    ,div("<round(max)>")
    ]);
    // list[Widget] ws = concat([wr|wr<-pp.td]);
    // for (Widget w<-ws) w.attr("width","50px");
    // Widget pp  = div(); 
    // span(pp).style("display:inline-block;width:100px").;
    return pp.table;
    }

void buttons(Widget p, str func) { 
    Grid pp = vcat(p,     
    [ button("shift", func, shiftF, m[func].shift, 0, 4, 0.01),
    button("frequency", func, frequencyF, m[func].frequency, 0, 4, 0.01),
    button("amplitude", func, amplitudeF, m[func].amplitude, 0, 4, 0.01)
    ]
    );
    pp.table.style("width:70%");
   } 
 
Graph f(str fname) {
    num n = 1024;
    num delta = 1.0/n;
    tuple[num shift, num amplitude, num frequency] t = m[fname];
    switch(fname) {
        case "sin": return <"sin","", [<x, t.amplitude*sin(t.frequency*(x+t.shift))>|num x<-[0, 2*PI()/n..2*PI()+delta]]>;
        case "cos": return <"cos","", [<x, t.amplitude*cos(t.frequency*(x+t.shift))>|num x<-[0, 2*PI()/n..2*PI()+delta]]>;
        }
    }               

void gonio() {
    m =  ("sin":<0,1,1>,"cos":<0,1,1>);
    root = createPanel();
    addStylesheet(
    "path{stroke-width:1}
    '.sin{stroke:blue}
    '.cos{stroke:red}
    '.input{type:range;max:0.25;min:0.25;step:0.01}
    '.overlay_frame{width:400px;height:400px}
    'td{border: 4px groove #999999;border-collapse:collapse;width:25%}
    "
    );
    
    Graph d1 = f("sin");
    Graph d2 = f("cos");
    plot = graph(root ,"-2/0", ["\u03C0/2","\u03C0","3\u03C0/2", "2\u03C0"],
                                ["-1","0","1","2"], d1, d2, viewBox=<0, -2, 2*PI(), 4>);
                                
    buttons(root, "sin");
    buttons(root, "cos");                                   
    int f = 70;
    plot.overlay.style("width:<f>%;height:<floor(4.0/(2*PI())*f)>%");  
    eventLoop(root, []);                              
    }
