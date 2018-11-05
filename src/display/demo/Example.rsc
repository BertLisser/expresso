module experiments::crypto::Example
import experiments::crypto::SocketConnection;
import Prelude;
public Widget getRect() {
   Widget z=createPanel();
   Widget p = svg(z).width(800).height(800).class("b");
   Widget q=rect(p).class("a").width(100).height(100).x(140).y(80)
    .style("stroke:red;stroke-width:10;fill:blue");
   q.attr("onclick", "app.sendClick(\'<q.id>\')");
   while (true) {
       Widget s = waitForUser(q);
       if (s.event=="exit") return s;
       println("id:<s.id>");
       map[str, str] v = style(s);
       if (v["fill"]=="blue") attribute( s, "style", "fill:red");
       else
                              attribute( s, "style", "fill:blue");
       }
   return q;
}

public Widget getTable() {
   Widget p=createPanel();
   Widget q = div(p).class("rTable");
   int k = 1;
   for (int i<-[0..3]) {
      Widget r = div(q).class("rTableRow");
      for (int j<-[0..3]) {
         Widget c = div(r).class("rTableCell");
         Widget b = button(c);
         innerHTML(b, "q<k>").attr("value", "<k>");
         k+=1;
      }
   }
   while (true) {
       Widget s = waitForUser(z);
       if (s.event=="exit") return s;
       println("id:<s.id>  <s.attribute("value")>");
       }
   return q;
}

public void beziers() {
     Widget z=createPanel();
     Widget p = svg(z).width(800).height(800).class("main");
     Widget lineAB = path(p).attr("d", "M 100 350 l 150 -300").attr("stroke", "red").attr("stroke-width", "3");
     Widget lineBC = path(p).attr("d", "M 250 50 l 150 300").attr("stroke", "red").attr("stroke-width", "3");
     Widget lineH = path(p).attr("d", "M 175 200 l 150 0").attr("stroke", "green").attr("stroke-width", "3");
     Widget bezier = path(p).attr("d", "M 100 350 q 150 -300 300 0").attr("stroke", "blue")
     .attr("stroke-width", "5").attr("fill","none");
     Widget group1  = g(p).attr("stroke", "black").attr("fill", "black");
     Widget c1 =circle(group1).cx(100).cy(350).r(3);
     Widget c2 =circle(group1).cx(250).cy(50).r(3);
     Widget c3 =circle(group1).cx(400).cy(350).r(3);
     Widget group2  = g(p).attr("font-size", "30").attr("font-family", "sans-serif")
     .attr("text-anchor", "middle")
     .attr("fill", "black").attr("stroke","none");
     text(group2).x(100).y(350).attr("dx", "-30").innerHTML("A");
     text(group2).x(250).y(50).attr("dy", "-10").innerHTML("B");
     text(group2).x(400).y(350).attr("dx", "30").innerHTML("C");
    }
    
    
 public void clock() {
     int r = 150;
     int r1 = 6;
     int d = 50;
     int mr = 4;
     Widget z=createPanel();
     Widget p = svg(z).width(800).height(800).attr("viewBox", "-400 -400 800 800").class("main");
     Widget k = defs(p);
     Widget m = marker(k).attr("markerWidth", "<mr>").attr("markerHeight", "<mr>"). 
          attr("refX","<mr/2>").attr("refY", "<mr/2>");
     Widget pointer = g(k);
     Widget pat = path(pointer).attr("d", 
            "M <-r1> 0 L <-r1> <-0.5*r> 
            'A <50> <r> 0 0 1 <0> <-0.95*r> 
            'A <50> <r> 0 0 1 <r1> <-0.5*r>
            'L <r1> 0
            ")
     .attr("fill", "lightgrey");
     circle(m).cx(mr/2).cy(mr/2).r(mr/2).style("fill:green");
     Widget frame = path(p, markerStart = m, markerMid=m).attr("d", 
     "M <0> <-r> 
     'A <r> <r> 0 0 1 <r>  <0> 
     'A <r> <r> 0 0 1 <0>  <r> 
     'A <r> <r> 0 0 1 <-r> <0> 
     'A <r> <r> 0 0 1 <0>  <-r>"
     ).attr("stroke", "red")
     .attr("stroke-width", "3").attr("fill","none");
     use(p, pointer); 
     circle(p).r(r1).attr("fill","lightgrey");
     Widget group  = g(p).attr("font-size", "30").attr("font-family", "sans-serif")
     .attr("text-anchor", "middle")
     .attr("fill", "black").attr("stroke","none");
     text(group).x(0).y(-r).attr("dy", "-10").innerHTML("12");
     text(group).x(r).y(0).attr("dx", "18").attr("dy","12").innerHTML("3");
     text(group).x(0).y(r).attr("dy", "30").innerHTML("6");
     text(group).x(-r).y(0).attr("dx", "-18").attr("dy", "12").innerHTML("9");
     Widget w = input(z).attr("type","range").attr("min", "0").attr("max", "360").attr("step", "6").
     attr("value", "6");
     while (true) {
       Widget s = waitForUser(w);
       if (s[0]<0) continue;
       if (s.event=="exit") {println("exit"); return;}
       pointer.attr("transform", "rotate(<s.val>)");
       }
     println("finished");
    }
    
 
    
     
     /*
    while (true) {
        Widget s = waitForUser(z);
        if (s[0]<0) continue;
        if (s.event=="exit") {println("exit"); return;}
        if (s.id==up.id)
           counter+= 1;
        if (s.id ==down.id)
           counter-= 1;  
        r.innerHTML("<counter>");
        } 
     */