module display::Kijk

// int a = 7;

int f(int y) =y*y;

@javaClass{display.Aap}
java int g(int z);

data Aap = aap(str id ="", Aap(int) init =  defaultAap);

// Widget defaultWidget(int x) = widget();
Widget defaultWidget(str x) = widget();

data Widget
     = widget(int process = -1, str id = "", str eventName="main", str val = "none"
     /*
     ,Widget(str) class = widget0
     */
     ,Widget(str) style =  defaultWidget   // Widget(str x) {return widget();}
     /*
     ,Widget(str, str) attr = widget0
     ,Widget(int) width  = widget0
     ,Widget(int) height  = widget0
     ,Widget(int) x = widget0
     ,Widget(int) y = widget0
     ,Widget(int) cx = widget0
     ,Widget(int) cy = widget0
     ,Widget(int) r = widget0
     ,Widget(str) innerHTML = widget0
     ,Widget(str ,  void(value)) event  = widget0
     ,Widget(str , Msg , void(value, Msg)) eventm = widget0
     ,Widget(str , Msg(str) , void(value, Msg)) eventf = widget0
     */
     );

Widget main() {
 Widget a = widget(process=-1, id="root", eventName="none");
 a.style =  Widget(str x) {return widget();};
 return a.style("");
 }

    
 