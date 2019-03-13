module rascalscape::Graph
import display::SocketConnection;
import rascalscape::RascalScape;
import Prelude;
import util::Math;
import util::HtmlDisplay;


 public void main() {
    int m=7;
    lrel[int, int] aap = [<i%m, (i+2)%m>|int i<-[0..m]];
    list[Ele] edges = [e("<a[0]>_<a[1]>", "<a[0]>", "<a[1]>")
        |a<-aap];
    list[Ele]  nodes = [n("<i>") | int i<-[0..m]];
    str output = genScript("cy", cytoscape(
        elements= nodes+edges
        ,styles = [<"", style(
              edgeShape=straight(arrowShape=[ArrowShape::triangle()])
             )>]
        ));
    println(output);
    writeFile(|project://expresso/src/rascalscape/Output.js|, output);
    loc html = |project://expresso/src/rascalscape/Graph.html|;
    htmlDisplay(html); 
    }
