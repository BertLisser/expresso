module display::demo::basic::Polynom
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


alias Model = str;

data Msg
  = from(str c)
  ; 


void updateView(Model m, Msg msg, Widget ff) {
   // println("updateView");
    switch (msg) {
       case from(_): {ff.innerHTML(math(m));}
       }
    }

Model update(Model m , Msg msg) {
  switch (msg) {
    case from(str new): {m = new;}
  }
  return m;
}

alias Term = tuple[str f, str n, str p];

list[Term] makePol(str p) {
    list[str] terms = split("+", p);
    return [<factor, name, exp> | str term<-terms,  /<factor:[0-9]+><name:\w+>\^<exp:\w+>/:=term];
    }
    
str mathML(list[Term] ts) {
   str r= "\<math\>\<mrow\>";
   r+="<for(t<-ts){>\<mi\><t.f>\</mi\>\<mo\>&InvisibleTimes;\</mo\>
       '\<msup\>\<mi\><t.n>\</mi\>\<mi\><t.p>\</mi\>\</msup\><}>
       ";
   r+="\</mrow\>\</math\>";
   return r;
   }
   
 str math(str s) = mathML(makePol(s));
   
public str tt(list[int] pol) {
   str r = "\<math\>\<mrow\>";
   r+="\<mstyle displaystyle=\"true\" mathcolor=\"teal\"\>";
   bool first = false;
   if (size(pol)>0) {
        int d = head(pol);
        r+="\<mn\><d>\</mn\>";
        pol = tail(pol);
        first = true;
        }
   if (size(pol)>0) {
     int d = head(pol);
     if (d!=0) {  
           if (first) {
             str p = d<0?"-":"+";
             if (d<0) d = -d;
             str g1="";
             if (d!=1) g1 = "\<mn\><d>\</mn\>\<mo\>&InvisibleTimes;\</mo\>";
                 r+="\<mo\><p>\</mo\><g1>\<mi\>x\</mi\>";
              }
           else {
              str g1="";
              if (d!=1 && d!=-1) g1 = "\<mn\><d>\</mn\>\<mo\>&InvisibleTimes;\</mo\>";  
              str h1="";
              if (d==-1) h1="-";
              r+="<g1>\<mi\><h1>x\</mi\>";
              first  = true;
              }
           }
     int i  = 2;
     pol = tail(pol);
     for (int d<-pol) {
        if (d!=0) {
          if (first) {
             str p = d<0?"-":"+";
             if (d<0) d = -d;  
              str g1="";
              if (d!=1) g1 = "\<mn\><d>\</mn\>\<mo\>&InvisibleTimes;\</mo\>";  
              r+="\<mo\><p>\</mo\><g1>\<msup\>\<mi\>x\</mi\>\<mn\><i>\</mn\>\</msup\>";
             }
          else {
              str g1="";
              if (d!=1 && d!=-1) g1 = "\<mn\><d>\</mn\>\<mo\>&InvisibleTimes;\</mo\>";  
              str h1="";
              if (d==-1) h1="-";
              r+="<g1>\<msup\>\<mi\><h>x\</mi\>\<mn\><i>\</mn\>\</msup\>";
              first = true;
             }
          }
        i+=1;
     }
   }
   r += "\<mstyle\>";
   r += "\<mrow\>\</math\>";
   return r;
}

int sum1(list[int] p) = isEmpty(p)?0:sum(p);

list[int] mult(list[int] a, list[int] b) {
      int n = size(a)+size(b);
      list[int] r = [sum1([((j<size(a))?a[j]:0)*(((k-j)<size(b))?b[k-j]:0)|int j<-[0..k+1]])|int k<-[0..n]];
      return r;
      }

Widget z=defaultWidget;

public void t(list[int] pol) {
   window(z, tt(pol));  
}

public void main() {
   Model model = "??";
   z=createPanel();
   /*
   Widget d = div(z);
   h2(d).innerHTML("Polynomial displayer");
   Widget pp  = p(d); span(pp).innerHTML("Input:"); 
   Widget cc = input(pp).attr("value", model).attr("type", "text");
   // Widget ff = div(z).innerHTML(attribute(cc, "value"));
   Widget ff = div(z);
   void(Widget) updateChange() {
      return void(Widget w) {
         Msg msg;
         msg = from(property(w, "value"));
         model=update(model, msg);
         updateView(model, msg, ff); 
         };
      }
    
    cc.event(change, updateChange());
    
    //  ff.event(change, updateChange());
    eventLoop(z, []); 
    */
   }