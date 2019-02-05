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

Widget p = defaultWidget;

data Msg
  = shift(str idx, str func, str sh)
  | amplitude(str idx, str func, str am)
  | frequency(str idx, str func, str fr)
  ;
  
Msg(str) shift(str idx, str func) { return Msg(str s) { 
         return shift(idx, func, s); };
         }
Msg(str) amplitude(str idx, str func) = Msg(str s) { return amplitude(idx, func, s); }; 
Msg(str) frequency(str idx, str func) = Msg(str s) { return frequency(idx, func, s); }; 

num toReal_(str s) {
  try {
    return round(toReal(s), 0.001);
  }
  catch IllegalArgument():
    return 0.0;
}

void updateView(Msg msg) {
    switch (msg) {
       case shift(str idx, str func, _): 
         attribute(p, idx, "d", getString(f(func), <0, -2, 2*PI(), 4>));
       case amplitude(str idx, str func,_): 
         attribute(p, idx, "d",  getString(f(func), <0, -2, 2*PI(), 4>));
       case frequency(str idx,str func, _): 
         attribute(p, idx, "d",  getString(f(func), <0, -2, 2*PI(), 4>));
       }
    }


void updateModel(Msg msg) {
  switch (msg) {
    case shift(str id, str func, str sh): {m[func].shift = toReal_(sh);}
    case amplitude(str id, str func, str am): {m[func].amplitude = toReal_(am);}
    case frequency(str id, str func,str fr): {m[func].frequency = toReal_(fr);}
  }
}

void update(Msg msg) {
      updateModel(msg);
      updateView(msg); 
      }

void buttons(Widget p, str func) {     
   {
    Widget pp  = p.div(); 
    span(pp).innerHTML("<func>:shift"); 
    Widget qq = input(pp).attr("value", "<round(m[func].shift)>")
       .attr("type", "range").attr("min","0").attr("max","4").attr("step", "0.01");
    qq.eventf(change, shift(func, func), update); 
    }
    {
    Widget pp  = p.div(); span(pp).innerHTML("<func>:amplitude"); 
    Widget qq =input(pp).attr("value", "<round(m[func].amplitude)>")
        .attr("type", "range").attr("min","0").attr("max","4").attr("step", "0.01");
    qq.eventf(change, amplitude(func, func), update); 
    }
    {
    Widget pp  = p.div(); span(pp).innerHTML("<func>:frequency"); 
    Widget qq = input(pp).attr("value", "<round(m[func].frequency)>")
        .attr("type", "range").attr("min","0").attr("max","4").attr("step", "0.01");
    qq.eventf(change, frequency(func, func), update); 
    }
   } 
 
Graph f(str fname) {
    num n = 64;
    num delta = 1.0/n;
    tuple[num shift, num amplitude, num frequency] t = m[fname];
    switch(fname) {
        case "sin": return <"sin","", [<x, t.amplitude*sin(t.frequency*(x+t.shift))>|num x<-[0, 2*PI()/n..2*PI()+delta]]>;
        case "cos": return <"cos","", [<x, t.amplitude*cos(t.frequency*(x+t.shift))>|num x<-[0, 2*PI()/n..2*PI()+delta]]>;
        }
    }               

void gonio() {
    m =  ("sin":<0,1,1>,"cos":<0,1,1>);
    p = createPanel();
    addStylesheet(
    "path{stroke-width:1}
    '.sin{stroke:blue}
    '.cos{stroke:red}
    '.input{type:range;max:0.25;min:0.25;step:0.01}
    "
    );
    buttons(p, "sin");
    buttons(p, "cos"); 
    Graph d1 = f("sin");
    Graph d2 = f("cos");
    Overlay z = graph(p ,"-2/0", ["\u03C0/2","\u03C0","3\u03C0/2", "2\u03C0"],
                                ["-1","0","1","2"], d1, d2, viewBox=<0, -2, 2*PI(), 4>);
            
    int f = 70;
    z.overlay.style("width:<f>%;height:<floor(4.0/(2*PI())*f)>%");  
    eventLoop(p, []);                              
    }
