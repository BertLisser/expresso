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
@contributor{Tijs van der Storm - storm@cwi.nl - CWI}


alias Model = map(str, tuple[real shift, real amplitude, real frequency]); 
                   
Model m =  <<1, 1, 1>, <1, 1, 1>>;

data Msg
  = shift(str idx, str s)
  | amplitude(str idx, str a)
  | frequency(str idx, str f)
  ;
  
Msg(str) shift(str idx) = Msg(str s) { return shift(idx, s); };
Msg(str) amplitude(str idx) = Msg(str s) { return amplitude(idx, s); }; 
Msg(str) frequency(str idx) = Msg(str s) { return frequency(idx, s); }; 

real toReal_(str s) {
  try {
    return toReal(s);
  }
  catch IllegalArgument():
    return 0.0;
}

void updateView(Msg msg) {
    // println(m);
    switch (msg) {
       case shift(str idx, _): {attribute(idx, "d", "<round(m.shift)>");}
       case amplitude(str idx, _): {attribute(idx, "d", "<round(m.amplitude)>");}
       case frequency(str idx, _): {attribute(idx, "d", "<round(m.frequency)>");}
       }
    }

Model updateModel(Model m , Msg msg) {
  switch (msg) {
    case shift(str new): {m = toReal_(new);}
    case amplitude(str new): {m = toC(toReal_(new));}
    case frequency(str new): {m = toC(toReal_(new));}
  }
  return m;
}

void(Widget) update() {
      return void(Widget w) {
         Msg msg;
         if (w.id == cc.id) {msg = c(property(w, "value"));}
         if (w.id == ff.id) {msg = f(property(w, "value"));}
         // println("updateChange: <w.id> <cc.id> <msg>");
         model=updateModel(model, msg);
         updateView(model, msg, cc ,ff); 
         };
      }

void gonio() {
    
    Widget p = createPanel();
    addStylesheet(
    "path{stroke-width:1}
    '.sin{stroke:blue}
    '.cos{stroke:red}
    "
    );
    num n = 64;
    num delta = 1.0/n;
    Graph d1 = <"sin","", [<x, sin(x)>|num x<-[0, 2*PI()/n..2*PI()+delta]]>;
    Graph d2 = <"cos","", [<x, cos(x)>|num x<-[0, 2*PI()/n..2*PI()+delta]]>;
    Overlay z = graph(p ,"0", ["\u03C0/2","\u03C0","3\u03C0/2", "2\u03C0"],
                                 ["-2","-1","0","1","2"], d1, d2, viewBox=<0, -2, 2*PI(), 4>);
    {
    Widget pp  = p(p.div()); span(pp).innerHTML("shift"); 
    input(pp).attr("value", "<round(model.sin.shift)>")
        .attr("type", "range").attr("min","0").attr("max","10");
    pp.eventf(change, shift(pp.id), update); 
    }
    {
    Widget pp  = p(p.div()); span(pp).innerHTML("amplitude"); 
    input(pp).attr("value", "<round(model.sin.amplitude)>")
        .attr("type", "range").attr("min","0").attr("max","10");
    pp.eventf(change, amplitude(pp.id), update); 
    }
    {
    Widget pp  = p(p.div()); span(pp).innerHTML("frequency"); 
    input(pp).attr("value", "<round(model.sin.frequency)>")
        .attr("type", "range").attr("min","0").attr("max","10");
    pp.eventf(change, frequency(pp.id), update); 
    }                           
    int f = 70;
    z.overlay.style("width:<f>%;height:<floor(4.0/(2*PI())*f)>%");                               
    }
