module display::SocketConnection
import Prelude;
import util::Math;
import lang::json::IO;


// Events
public str click  = "click";
public str change = "change";
public str tick = "tick";

data Msg = init();

int width0 = 800;
int height0 = 800;
alias Margin = tuple[num fx, num fy];

alias Align = str;

public Align leftBottom = "leftBottom";
public Align centerBottom = "centerBottom";
public Align rightBottom = "rightBottom";
public Align leftCenter = "leftCenter";
public Align center = "center";
public Align rightCenter = "rightCenter";
public Align leftTop = "leftTop";
public Align centerTop = "centerTop";
public Align rightTop = "rightTop";


alias Bounds = tuple[num x, num y, num width, num height];
alias BoundsC = tuple[num cx, num cy, num width, num height];

BoundsC center(Bounds b, Margin a) = <b.x+b.width*a.fx, b.y+b.height*a.fy,b.width, b.height>;
Bounds  bounds(BoundsC c, Margin a) = <c.cx-c.width*a.fx, c.cy-c.height*a.fy, c.width, c.height>;

map[int, lrel[set[tuple[str id , str eventName]], void()]] events = ();

/*
alias Widget = tuple[int process, str id, str eventName, str val
    ,value(str) class, value(str) style
    ,value(str, str) attr, value(int) width,  value(int) height
    ,value(int) x, value(int) y
    ,value(int) cx, value(int) cy
    ,value(int) r
    ,value(str) innerHTML
    ,value(str ,  void(value)) event
    ,value(str , Msg , void(value, Msg)) eventm
    ,value(str , Msg(str) , void(value, Msg)) eventf
    ];
 */
 data Widget
     = widget(int process = -1, str id = "", str eventName="main", str val = "none"
      , Align align = "center", bool isSvg = false
     ,Widget(Widget, Align)  add = widgetWidgetAlign
     ,Widget() div = widgetVoid
     ,Widget() span = widgetVoid
     ,Widget() h1 = widgetVoid
     ,Widget() h2 = widgetVoid
     ,Widget() h3 = widgetVoid
     ,Widget() h4 = widgetVoid
     ,Widget() table = widgetVoid
     ,Widget() tr = widgetVoid
     ,Widget() td = widgetVoid
     ,Widget() button = widgetVoid
     ,Widget() input = widgetVoid
     ,Widget() svg = widgetVoid
     ,Widget() rect = widgetVoid
     ,Widget() circle = widgetVoid
     ,Widget() line = widgetVoid
     ,Widget() path = widgetVoid
     ,Widget() foreignObject = widgetVoid
     ,Widget(str) class = widgetStr
     ,Widget(str) style = widgetStr
     ,Widget(str, str) attr = widgetStrStr
     ,Widget(num) width  = widgetNum
     ,Widget(num) height  = widgetNum
     ,Widget(num) x = widgetNum
     ,Widget(num) y = widgetNum
     ,Widget(num) cx = widgetNum
     ,Widget(num) cy = widgetNum
     ,Widget(num) r = widgetNum
     ,Widget(str) innerHTML =widgetStr
     ,Widget(str ,  void(value)) event  = widgetStrFun
     ,Widget(str , Msg , void(Msg)) eventm = widgetEvent1
     ,Widget(str , Msg(str) , void(Msg)) eventf = widgetEvent2
     );
     
 alias Grid = tuple[Widget table, list[Widget] tr, list[list[Widget]] td];
 
 alias Overlay = tuple[Widget overlay, list[Widget] array];
      
 private Widget newWidget(Widget p,  str id) {
    return newWidget(p, id, p.eventName);
    }
    
private Widget newWidget(Widget p,  str id, str eventName) {
    Widget _r =  widget(process=p.process, id=id, eventName=eventName, isSvg = p.isSvg
     , align = p.align
    );
    
     _r.div = Widget() {return xml(_r, "div");};
    _r.span = Widget() {return xml(_r, "span");};
    _r.h1 = Widget() {return xml(_r, "h1");};
    _r.h2 = Widget() {return xml(_r, "h2");};
    _r.h3 = Widget() {return xml(-r, "h3");};
    _r.h4 = Widget() {return xml(_r, "h4");};
    _r.table = Widget() {return xml(_r, "table");};
    _r.tr = Widget() {return xml(_r, "tr");};
    _r.td = Widget() {return xml(_r, "td");};
    _r.button = Widget() {return xml(_r, "button");};
    _r.input = Widget() {return xml(_r, "input");};
    _r.svg = Widget() {_r.isSvg=true; Widget w = svg(_r, 1, 1, 0);return w;};
    _r.rect = Widget() {return xml(_r, "rect");};
    _r.circle = Widget() {return xml(_r, "circle");};
    _r.line = Widget() {return xml(_r, "line");};
    _r.path = Widget() {return xml(_r, "path");};
    _r.foreignObject = Widget() {return foreignObject(_r);};
    _r.class = class(_r);
    _r.style = style(_r);
    _r.attr = attr(_r);
    _r.width = width(_r);
    _r.height = height(_r);
    _r.x = x(_r);
    _r.y = y(_r);
    _r.cx = cx(_r);
    _r.cy = cy(_r);
    _r.r = r(_r);
    _r.innerHTML = innerHTML(_r);
    _r.event = event(_r);
    _r.eventm = eventm(_r);
    _r.eventf = eventf(_r);
    _r.add = add(_r);
    return _r;
    }
    
private Widget(Widget, Align) add(Widget p) {
   return Widget(Widget w, Align align) {
        return add(p, w, align);
        };
    }

private Widget(str, str) attr(Widget p) {
   return Widget(str key, str val) {
        return attribute(p, key, val); 
        };
    }
    
public Widget(str) style(Widget p) {
   return Widget(str val) {
        return attribute(p, "style", val); 
        };
    }
    
private Widget(str, void(Widget)) event(Widget p) {
    return Widget(str eventName, void(Widget) val) {
         void() q = () {val(p);};
         if (!(events[p.process]?)) events[p.process] = [];
         events[p.process]+=<{<p.id, eventName>} , q>;
         Widget r = newWidget(p, p.id);
         return r;
         };
    }
    
private Widget(str, Msg, void(Msg)) eventm(Widget p) {
    return Widget(str eventName, Msg m, void(Msg) val) {
         void() q = () {val(m);};
         if (!(events[p.process]?)) events[p.process] = [];
         events[p.process]+=<{<p.id, eventName>} , q>;
         Widget r = newWidget(p, p.id);
         return r;
         };
    }
    
private Widget(str, Msg(str), void(Msg)) eventf(Widget p) {
    return Widget(str eventName, Msg(str) m, void(Msg) val) {
         void() q = () {str s = property(p, "value");val(m(s));};
         if (!(events[p.process]?)) events[p.process] = [];
         events[p.process]+=<{<p.id, eventName>} , q>;
         Widget r = newWidget(p, p.id);
         return r;
         };
    }
/*   
private Widget() divf(Widget p) {
   return Widget() {
        return div(p); 
        };
    }
*/
   
private Widget(str) class(Widget p) {
   return Widget(str c) {
        return attribute(p, "class",c); 
        };
    }

    
private Widget(num) width(Widget p) {
   return Widget(num w) {
        return attribute(p, "width","<w>"); 
        };
    }
    
private Widget(num) height(Widget p) {
   return Widget(num h) {
        return attribute(p, "height","<h>"); 
        };
    }
    
private Widget(num) x(Widget p) {
   return Widget(num d) {
        return attribute(p, "x","<d>"); 
        };
    }
    
private Widget(num) y(Widget p) {
   return Widget(num d) {
        return attribute(p, "y","<d>"); 
        };
    }
    
private Widget(num) cx(Widget p) {
   return Widget(num d) {
        return attribute(p, "cx","<d>"); 
        };
    }
    
private Widget(num) cy(Widget p) {
   return Widget(num d) {
        return attribute(p, "cy","<d>"); 
        };
    }
    
private Widget(num) r(Widget p) {
   return Widget(num d) {
        return attribute(p, "r","<d>"); 
        };
    }
    
private Widget(str) innerHTML(Widget p) =
   Widget(str s) {
        return innerHTML(p, s); 
        };



public Widget defaultWidget = widget();

Widget createRootWidget(int p, str result, str rootName) {
   return newWidget(widget(process=p, id=""), result, rootName);
}

Widget widgetVoid() {return defaultWidget;}

Widget widgetStr(str x) {return defaultWidget;}

Widget widgetInt(int x) {return defaultWidget;}

Widget widgetNum(num x) {return defaultWidget;}

Widget widgetWidgetAlign(Widget x, Align align) {return defaultWidget;}

Widget widgetStrStr(str x, str y) {return defaultWidget;}

Widget widgetStrFun(str x, void(value) y) {return defaultWidget;}

Widget widgetStrValVal(str x, value y, value z) {return defaultWidget;}

Widget widgetEvent1(str x, Msg y, void(Msg) z) {return defaultWidget;}

Widget widgetEvent2(str x, Msg(str) y, void(Msg) z) {return defaultWidget;}

Widget scratch = defaultWidget;

public Widget createPanel(str initPage="MainPanel.html", int portNumber= 8002
                         ,int width = 800, int height = 800) {
    int p = openSocketConnection("espresso.MainPanel", initPage = initPage, portNumber = portNumber
    ,width = width, height = height); 
    setPrecision(3);
    str result = exchange(p, "root", [],sep);
    Widget r =  createRootWidget(p, result, result);
    scratch  = r;
    // r._ =  r.div()
       // .style("visibility:hidden")
    ;
    width0 = width; height0 = height;
    return r;
    }
    
public Widget createSvgPanel(num hshrink, num vshrink, int lineWidth) {
    Widget w = createPanel();
    Widget s =   svg(w, hshrink, vshrink, lineWidth);
    return w;
    }
    
public Widget select(Widget p, str id) {
    }
    
str sep = ";:";
    
private Widget xml(Widget p, str tg) = newWidget(p, exchange(p.process, tg, [p.id], sep));

public Widget foreignObject(Widget p) {
     str id = exchange(p.process, "foreignObject", [p.id], sep);
     return newWidget(p, id);
     }
    
public Widget h1(Widget p) = newWidget(p, exchange(p.process, "h1", [p.id], sep));

public Widget h2(Widget p) = newWidget(p, exchange(p.process, "h2", [p.id], sep));

public Widget h3(Widget p) = newWidget(p, exchange(p.process, "h3", [p.id], sep));

public Widget h4(Widget p) = newWidget(p, exchange(p.process, "h4", [p.id], sep));
  
public Widget div(Widget p) = newWidget(p, exchange(p.process, "div", [p.id], sep));

public Widget p(Widget p) = newWidget(p, exchange(p.process, "p", [p.id], sep));

public Widget ul(Widget p) = newWidget(p, exchange(p.process, "ul", [p.id], sep));

public Widget ol(Widget p) = newWidget(p, exchange(p.process, "ol", [p.id], sep));

public Widget li(Widget p) = newWidget(p, exchange(p.process, "li", [p.id], sep));

public Widget span(Widget p) = newWidget(p, exchange(p.process, "span", [p.id], sep));
    
public Widget svg(Widget p, num hshrink, num vshrink, num lineWidth) {
    int hprocent  = round(hshrink*100);int vprocent  = round(vshrink*100);
    str result = exchange(p.process, "svg", [p.id], sep);
    Widget r = newWidget(p, result);
    r.isSvg = true;
    r.attr("width", "<hprocent>%").attr("height","<vprocent>%").attr("preserveAspectRatio", "none")
    .attr("viewBox", "0 0 100 100").attr("stroke-width","<round(lineWidth)>");
    return r;
    }
    
public Widget button(Widget p) {
    str result = exchange(p.process, "button", [p.id], sep);
    Widget r = newWidget(p, result);
    return r;
    }
    
public Widget addStylesheet(Widget p, str content) = newWidget(p, exchange(p.process, "addStylesheet", [p.id, content], sep)); 
    
public Widget setInterval(Widget p, int interval) = newWidget(p, exchange(p.process, "setInterval", [p.id, "<interval>"], sep)); 

public Widget clearInterval(Widget p) = newWidget(p, exchange(p.process, "clearInterval", [p.id], sep)); 
    
public Widget input(Widget p) = newWidget(p, exchange(p.process, "input", [p.id], sep)); 
    
public Widget rect(Widget p) = newWidget(p, exchange(p.process, "rect", [p.id], sep));

public Widget rect() = newWidget(scratch, exchange(scratch.process, "rect", [scratch.id], sep));

public Widget line(Widget p) = newWidget(p, exchange(p.process, "line", [p.id], sep));

public Widget line(tuple[num x , num y] p1, tuple[num x, num y] p2) = 
        newWidget(scratch, exchange(scratch.process, "line", [scratch.id], sep))
        .attr("x1", "<round(p1.x, 0.01)>").attr("y1", "<round(p1.y, 0.01)>")
        .attr("x2", "<round(p2.x, 0.01)>").attr("y2", "<round(p2.y, 0.01)>");

public Widget ellipse(Widget p) = newWidget(p, exchange(p.process, "ellipse", [p.id], sep));

public Widget ellipse() = newWidget(scratch, exchange(p.process, "ellipse", [scratch.id], sep));

public Widget circle(Widget p) = newWidget(p, exchange(p.process, "circle", [p.id], sep));

public Widget circle() = newWidget(scratch, exchange(scratch.process, "circle", [scratch.id], sep));

public Widget polygon(Widget p) = newWidget(p, exchange(p.process, "polygon", [p.id], sep));

public Widget polygon() = newWidget(scratch, exchange(scratch.process, "polygon", [scratch.id], sep));

public Widget use(Widget p, Widget g) = newWidget(p, exchange(p.process, "use", [p.id,g.id], sep));

public Widget use(Widget g) = newWidget(scratch, exchange(scratch.process, "use", [scratch.id,g.id], sep));

public Widget path(Widget p, Widget markerStart = defaultWidget, Widget markerMid = defaultWidget
     , Widget markerEnd = defaultWidget ) {
     Widget w = newWidget(p, exchange(p.process, "path", [p.id], sep));
     str style = "";
     if (markerStart != defaultWidget) {
          style += "marker-start: url(#<markerStart.id>);";
          }
     if (markerMid != defaultWidget) {
          style += "marker-mid: url(#<markerMid.id>);";
          }
     if (markerEnd != defaultWidget) {
          style += "marker-end: url(#<markerEnd.id>);";
          }
     if (!isEmpty(style)) w.style(style);
     return w;
     }
     
 public Widget path(Widget markerStart = defaultWidget, Widget markerMid = defaultWidget
     , Widget markerEnd = defaultWidget ) {
     return path(scratch, markerStart = markerStart, markerMid = markerMid, markerEnd = markerEnd);
     }

public Widget text(Widget p) = newWidget(p, exchange(p.process, "text", [p.id], sep));

public Widget g(Widget p) = newWidget(p, exchange(p.process, "g", [p.id], sep));

public Widget defs(Widget p) = newWidget(p, exchange(p.process, "defs", [p.id], sep));

public Widget marker(Widget p) = newWidget(p, exchange(p.process, "marker", [p.id], sep));

public Widget removechilds(Widget p) = newWidget(p, exchange(p.process, "removechilds", [p.id], sep));

public Widget createRoot(Widget p) = newWidget(p, exchange(p.process, "createRoot", [], sep));
    
public Widget attribute(Widget p, str key, str val) { 
    exchange(p.process, "attribute", [p.id, key, val], sep);
    //  WHY ????
    // println("A: <p.isSvg>");
    Widget r = newWidget(p, p.id);
    // println("B: <r.isSvg>");
    return r;
    // return p;
    }
    
public str attribute(Widget p, str attr) {
    // println("attribute:<p.id> <attr>");
    return exchange(p.process, "attribute", [p.id, attr], sep);
    }
    
 public Widget attributeChild(Widget p, str key, str val, int i) { 
    exchange(p.process, "attributeChild", [p.id, key, val, "<i>"], sep);
    //  WHY ????
    Widget r = newWidget(p, p.id);
    return r;
    // return p;
    }
    
 public str attributeChild(Widget p, str attr, int i) {
    // println("attribute:<p.id> <attr>");
    return exchange(p.process, "attributeChild", [p.id, attr, "<i>"], sep);
    }
    
 public Widget attributeParent(Widget p, str key, str val) { 
    exchange(p.process, "attributeParent", [p.id, key, val], sep);
    Widget r = newWidget(p, p.id);
    return r;
    }
    
 public str attributeParent(Widget p, str attr) {
    // println("attribute:<p.id> <attr>");
    return exchange(p.process, "attributeParent", [p.id, attr], sep);
    }
    
public Widget style(Widget p, str attr) {
    // println("attribute:<p.id> <attr>");
    // return exchange(p.process, "style", [p.id, attr], sep);
    return attribute(p, "style", attr);
    }
    
public str getStyle(Widget p, str attr) {
    // println("attribute:<p.id> <attr>");
    return exchange(p.process, "style", [p.id, attr], sep);
    }
    
public Widget styleChild(Widget p, str attr, int i) {
    // println("attribute:<p.id> <attr>");
    // return exchange(p.process, "style", [p.id, attr], sep);
    return attributeChild(p, "style", attr, i);
    }
    
 public Widget property(Widget p, str key, str val) { 
    exchange(p.process, "property", [p.id, key, val], sep);
    //  WHY ????
    Widget r = newWidget(p, p.id);
    return r;
    // return p;
    }
    
public str property(Widget p, str attr) {
    // println("attribute:<p.id> <attr>");
    return exchange(p.process, "property", [p.id, attr], sep);
    }
    
 public Bounds getBBox(Widget p) {
   // println("attribute:<p.id> <attr>");
    str r = exchange(p.process, "getBBox", [p.id], sep);
    // return round(toReal(r));
    map[str, num] z = parseJSON(#map[str, num], r);
    return <z["x"], z["y"], z["width"], z["height"]>;
    }
    
 public Bounds getBoundingClientRect(Widget p) {
   // println("attribute:<p.id> <attr>");
    str r = exchange(p.process, "getBoundingClientRect", [p.id], sep);
    // return round(toReal(r));
    map[str, num] z = parseJSON(#map[str, num], r);
    return <z["left"], z["top"], z["width"], z["height"]>;
    }
    
public Widget innerHTML(Widget p, str text) {
    exchange(p.process, "innerHTML", [p.id, text], sep);
    Widget r = newWidget(p, p.id);
    return r;
    }
    
 public str attribute(int p, str key, str attr, str val) {
    return exchange(p, "attribute", [key, attr, val], sep);
    }
    
public Widget waitForUser(Widget p) {
    str s = exchange(p.process, p.eventName, [p.id], sep);
    if (isEmpty(s)) return newWidget(p, "", "exit", p.svg);
    list[str] r = split(":", s);
    if (size(r)<2) return defaultWidget;
    Widget z = newWidget(p, r[0], r[1], p.svg);
    if (size(r)==3) z.val = r[2];       
    return z;
    }
    
public map[str, str] getStyle(Widget p) {
   str s = attribute(p, "style");
   list[str] styles = split(";", s);
   map[str, str] r = (styl[0]: styl[1]|str x<-styles, list[str] styl:=split(":", x));
   return r;
   }
    
@reflect{For getting IO streams}
@javaClass{display.SocketConnection}
public java int openSocketConnection(str javaClass, loc workingDir=|cwd:///|, list[str] args = [], map[str,str] envVars = ()
, int portNumber=8000, str initPage="mainPage", int width = 800, int height = 800);

@reflect{For getting IO streams}
@javaClass{display.SocketConnection}
public java str exchange(int processId, str toServer);


public str exchange(int processId, str key, list[str] toServer, str sep) {
   list[str] args  = [key]+toServer;
   // println(size(intercalate(sep, args)));
   return exchange(processId, replaceAll(intercalate(sep, args),"\n", " "));
   }

@reflect{For getting IO streams}
@javaClass{display.SocketConnection}
public java str getResource(str javaClass);


@javaClass{display.SocketConnection}
public java void closeSocketConnection(int processId, bool force);

//eventLoop(z, ({<up.id, click>}:()  {counter+=1;}
     //            ,{<down.id, click>}:() {counter-=1;}
     //             ,{<up.id, click>, <down.id, click>}:() {r.innerHTML("<counter>");}
     //         ); 
  
 public void eventLoop(lrel[set[tuple[Widget w , str eventName]], void()] eventName) { 
      if (isEmpty(eventName) || isEmpty(eventName[0][0])) return;
      lrel[set[tuple[str id , str eventName]], void()] r = 
         [<{<y[0].id, y[1]>|tuple[Widget w , str eventName] y<-x[0]}, x[1]>|tuple[set[tuple[Widget w , str eventName]], void()] x<-eventName];
      eventLoop(getOneFrom(eventName[0][0])[0], r);
      }
      
 bool procIn(tuple[str id, str eventName] t, set[tuple[Widget() w, str eventName]] key) {
      for (tuple[Widget() w, str eventName] x<-key) {
          if (t.id == x.w().id && t.eventName == x.eventName) return true;
          }
      return false;
      }
      
 public void eventLoop(lrel[set[tuple[Widget() w , str eventName]], void()] events) { 
      if (isEmpty(events) || isEmpty(events[0][0])) return;
      Widget z = getOneFrom(events[0][0])[0]();
      while (true) {
        Widget s = waitForUser(z);
        // println("eventLoop: <s.id> <s.eventName>");
        if (s.process<0) continue;
        if (s.eventName=="exit") {println("exit"); return;}
        tuple[str, str] t = <s.id, s.eventName>;
        for (tuple[set[tuple[Widget() w, str eventName]] key, void() f] ev <-  events) {
             if (procIn(t, ev.key)) ev.f();
             }
        } 
     }  
 
 public void eventLoop(Widget z, lrel[set[tuple[str id , str eventName]], void()] events1) {
      while (true) {
        Widget s = waitForUser(z);
        // println("eventLoop: <s.id> <s.eventName>");
        if (s.process<0) continue;
        if (s.eventName=="exit") {println("exit"); return;}
        tuple[str, str] t = <s.id, s.eventName>;
        for (tuple[set[tuple[str id, str eventName]] key, void() f] ev <-  events[z.process]) {
             if (t in ev.key) ev.f();
             }
        for (tuple[set[tuple[str id, str eventName]] key, void() f] ev <-  events1) {
             if (t in ev.key) ev.f();
             }
        } 
     }
  
 public Widget grow(Widget src, Widget tgt, num f, Margin align) {   
    Bounds b = getBBox(src);
    BoundsC c = center(b, align);
    c.width *= f; c.height *= f;
    Bounds b1 = bounds(c, align);
    return tgt.x(b1.x).y(b1.y).width(b1.width).height(b1.height);
   }
   
public void window(Widget z, str html) {
      z.div().class("window").div().class("line").innerHTML(html);  
      }
 
    
 public Widget add(Widget p, Widget inner, Align align) { 
    if (inner!=defaultWidget && p.isSvg && inner.isSvg) {
         Widget fo = p.foreignObject();
         Widget html = fo.table().attr("width","100%").attr("height","100%").
         class("inner").tr().td().class("inner");
         exchange(html.process, "add", [html.id, inner.id],sep); 
         exchange(html.process, "adjust", [p.id, inner.id],sep); 
         setAlign(html,align);
        //  html.attr("height","100%"); // Problem. Must be 100%
         return newWidget(inner, inner.id);       
         } 
    exchange(p.process, "add", [p.id, inner.id],sep); 
    if (!p.isSvg) setAlign(p,align);
    return p;
    }
      
public Grid hcat(Widget p, list[Widget] ws, num shrink=1, num vshrink=1, num hshrink=1, Align align = center) {
      Widget r = p.table();
      r.align = align;
      int vprocent  = round(vshrink*100);
      int hprocent  = round(hshrink*100);    
      r.style("width:<hprocent>%;height:<vprocent>%");
      Widget tr = r.tr();
      list[Widget] tds = [];
      for (Widget w<-ws) {
         Widget td = tr.td();
         add(td,w, w.align); 
         tds+=td;
         }
      return <r, [tr], [tds]>;
      }
      
public Grid hcat(Widget p, int n) {
      Widget r = p.table();
      // r.style("width:100%;height:100%");
      Widget tr = r.tr();
      list[Widget] tds = [];
      for (int i<-[0..n]) {
         Widget td = tr.td(); 
         tds+=td;
         }
      return <r, [tr], [tds]>;
      }
      
public Grid vcat(Widget p, list[Widget] ws, num hshrink=1, num vshrink=1, num shrink = 1, Align align = center) {
if (vshrink==1 && hshrink==1) {vshrink = shrink; hshrink = shrink;}
      Widget r = p.table();
      r.align = align;
      int vprocent  = round(vshrink*100);
      int hprocent  = round(hshrink*100);    
      r.style("width:<hprocent>%;height:<vprocent>%");
      list[Widget] trs = [];
      list[list[Widget]] tds = [];
      for (Widget w<-ws) {
         Widget tr = r.tr();
         Widget td = tr.td();
         add(td, w, w.align);  
         trs+=tr;
         tds+=[[td]];
         }
      return <r, trs, tds>;
      }
      
public Grid vcat(Widget p, int n) {
      Widget r = p.table();
      // r.style("width:100%;height:100%");
      list[Widget] trs = [];
      list[list[Widget]] tds = [];
      for (int i<-[0..n]) {
         Widget tr = r.tr();
         Widget td = tr.td();
         trs+=tr;
         tds+=[[td]];
         }
      return <r, trs, tds>;
      }
      
 public Overlay overlay(Widget p, list[Widget] ws, Align align = center) {
      Widget r = p.div().style("position:absolute;width:400px;height:400px");
      r.align = align;
      list[Widget] array = [];
      for (Widget w<-ws) {
         //int vprocent  = round(w.vshrink*100);
         //int hprocent  = round(w.hshrink*100);
         Widget div = r.table().class("overlay").tr().td().class("inner");
         add(div, w, w.align);
         array+=div;
         }
      return <r, array>;
      }
      
 Widget box(Widget w, num border, Widget ws..., str style="", num shrink=1, num vshrink=1, num hshrink=1, 
    Align align = center) {
    if (vshrink==1 && hshrink==1) {vshrink = shrink; hshrink = shrink;}
    Widget r = svg(w, hshrink, vshrink, border);
    r.align = align;
    for (Widget q<-ws) {add(r, q, q.align);}
    return newWidget(r, r.id);
    }
 
 Widget box(num border, Widget ws..., str style="", num shrink=1, num vshrink=1, num hshrink=1,
    Align align = center) {  
        return box(scratch, border, ws,   style=style,  shrink=shrink, vshrink=vshrink, hshrink = hshrink, align = align);
    }
 
      
  public Grid grid(Widget p, list[list[Widget]] ts
      , num shrink=1, num vshrink=1, num hshrink=1, str align = center) {
      Widget r = p.table();
      r.align  = align;
      int vprocent  = round(vshrink*100);
      int hprocent  = round(hshrink*100);    
      r.style("width:<hprocent>%;height:<vprocent>%");
      list[Widget] trs = [];
      list[list[Widget]] rows = [];
      for (list[Widget] ws<-ts) {
         list[Widget] tds = [];
         Widget tr = r.tr();
         for (Widget w <- ws) {
            Widget td = tr.td();
            add(td, w, w.align);
            // w.style("width:100%;height:100%");
            // setAlign(td,w.align);   
            tds+=td;
            }
         trs+=tr;
         rows+=[tds];
         }
      return <r, trs, rows>;
      }

public Widget setAlign(Widget p, Align align) {
    tuple[str, str] r = <"", "">; 
    switch(align) {
      case leftBottom: r = <"margin-right:auto;margin-left:0", "vertical-align:bottom">;
      case centerBottom: r = <"margin:auto", "vertical-align:bottom">;
      case rightBottom: r = <"margin-left:auto;margin-right:0", "vertical-align:bottom">;
      case leftCenter: r = <"margin-right:auto;margin-left:0", "vertical-align:center">;
      case center: r = <"margin:auto", "vertical-align:center">;
      case rightCenter: r = <"margin-left:auto;margin-right:0", "vertical-align:center">;
      case leftTop: r = <"margin-right:auto;margin-left:0", "vertical-align:top">;
      case centerTop: r = <"margin:auto", "vertical-align:top">;
      case rightTop: r = <"margin-left:auto;margin-right:0", "vertical-align:top">;
    }
    p.style(r[1]);
    styleChild(p, r[0], 0);
    return p;
    }
