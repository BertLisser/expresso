module display::graph::Graph
import display::SocketConnection;
import Prelude;
import util::Math;
import util::HtmlDisplay;


public str produceGraph(lrel[value, value] z, str \layout) {
   str r = "cy.add([";
   list[value] c = sort(toList(toSet(carrier(z))));
   
   list[str] zs = ["{ group: \'nodes\', data: { id: \'<s>\'}}"|value s<-c];
   zs+= ["{group: \'edges\', data: {id: \'<p[0]>_<p[1]>\', source:\'<p[0]>\',target:\'<p[1]>\'}}"|p<-z];
   str v = intercalate(",", zs);
   r+=v;
   r+="]);\n";
   r+="var layout=cy.layout({name:\'<\layout>\'});\n";
   r+="layout.run();\n";
   return r;
   }

/*
cy.add([ // list of graph elements to start with
    { // node a
	  group: 'nodes',
      data: { id: 'a' }
    },
    { // node b
      group: 'nodes',
      data: { id: 2 }
    },
    { // edge ab
      group: 'edges',
      data: { id: 'ab', source: 'a', target: 2 }
    }
    { // edge ab
      group: 'edges',
      data: { id: 'ab', source: 'a', target: 2 }
    }
*/


 public void main() {
    int n=7;
    lrel[int, int] aap = [<i%n, (i+2)%n>|int i<-[0..n]];
    str output = produceGraph(aap, "circle");
    writeFile(|project://expresso/src/display/graph/Output.js|, output);
    loc html = |project://expresso/src/display/graph/Graph.html|;
    htmlDisplay(html);
    //Widget root = createPanel();
    //addStylesheet(root, "#root {width: 300px;height: 300px;display: block;}");
    //println("done");
    //runScriptBody(
    //      |project://expresso/src/display/graph/Graph.js|,"A=B"    
    //  );       
    }
