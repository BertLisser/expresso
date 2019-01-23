module display::demo::basic::Calc
import display::SocketConnection;
import Prelude;
import util::Math;


data Msg
  = v0()
  | v1()
  | v2()
  | v3()
  | v4()
  | v5()
  | v6()
  | v7()
  | v8()
  | v9()
  | enter()
  | plus()
  | min()
  | times()
  | divide()
  | init()
  ;
  
alias Model = tuple[int v, list[int] stack];

Model model = <0, []>;

int pop() {
    tuple[int, list[int]] r = pop(model.stack);
    model.stack = r[1];
    return r[0];
    }
  
 void updateModel(Msg msg) {
  switch (msg) {
    case v0(): model.v =(10*model.v);
    case v1(): model.v =(10*model.v+1);
    case v2(): model.v =(10*model.v+2);
    case v3(): model.v =(10*model.v+3);
    case v4(): model.v =(10*model.v+4);
    case v5(): model.v =(10*model.v+5);
    case v6(): model.v =(10*model.v+6);
    case v7(): model.v =(10*model.v+7);
    case v8(): model.v =(10*model.v+8);
    case v9(): model.v =(10*model.v+9);
    case plus():  model.v += pop();    
    case min():  model.v -= pop();   
    case plus():  model.v += pop();    
    case times():  model.v *= pop(); 
    case divide():  model.v /= pop();                      
    case enter(): {model.stack+=[model.v]; model.v = 0;}
  }
}
  


Widget display = defaultWidget;
  
Widget view(Msg msg) {
  if (msg==init()) {
    Widget mainWindow = createPanel();
    addStylesheet(".calc td{border: 0px solid orange;width:60px
                  ';background-image:radial-gradient(lightgrey, grey)}
                  '.display{border:4px ridge grey;
                     text-align:center;background-color:black;color:white;width:192px;margin-bottom:10px}
                  '.part{width:200px;border-collapse:collapse}
                  'div{margin:auto}
                  '.object{width:250px;height: 300px; background-image:radial-gradient(darkorange, orange);
                    border: 4px ridge grey;rx:3px;ry:3px}
                    body{text-align:center}
                  ");
    Widget d = mainWindow.div().class("object");
     ;d.h2().innerHTML("Pocket Calculator")
     ;display = d.div().class("display");
     ;Grid g = grid(d.div().class("part"), [3, 3, 3, 3, 3])
     ;g.table.class("calc")
     ;g.td[0][0].innerHTML("1").eventm(click, v1(), update)
     ;g.td[0][1].innerHTML("2").eventm(click, v2(), update)
     ;g.td[0][2].innerHTML("3").eventm(click, v3(), update)
     ;g.td[1][0].innerHTML("4").eventm(click, v4(), update)
     ;g.td[1][1].innerHTML("5").eventm(click, v5(), update)
     ;g.td[1][2].innerHTML("6").eventm(click, v6(), update)
     ;g.td[2][0].innerHTML("7").eventm(click, v7(), update)
     ;g.td[2][1].innerHTML("8").eventm(click, v8(), update)
     ;g.td[2][2].innerHTML("9").eventm(click, v9(), update)
     ;g.td[3][0].innerHTML("0").eventm(click, v0(), update)
     ;g.td[3][1].innerHTML("enter").eventm(click, enter(), update)
     ;g.td[3][2].innerHTML("+").eventm(click, plus(), update)
     ;g.td[4][0].innerHTML("-").eventm(click, min(), update)
     ;g.td[4][1].innerHTML("*").eventm(click, times(), update)
     ;g.td[4][2].innerHTML("/").eventm(click, divide(), update)
     ;
    } 
  display.innerHTML("<model.v>");
  return display;
  }
  
void update(Msg msg) {
   updateModel(msg);
   view(msg);
}

public void main() {
    eventLoop(
      view(init()) 
    , [])
    ; 
    }