module display::Viz
import vis::Figure;
import vis::Render;

public int counter  = 0;
Figure figure() {
   return vcat([button("inc", void() {counter+=1; render(computeFigure(figure));})
        ,button("dec", void() {counter-=1; render(computeFigure(figure));})
        ,text("<counter>")
        ]);
   }

public void main() {
   render(figure());
}