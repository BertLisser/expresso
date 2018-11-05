module display::Shapes

private int counter = 0;

void click(str e, str n, str v) {
   counter+=(n=="incr"?1:-1);
   textProperty("text", text = "<counter>");
   }

Figure f =
      vcat([
          inputButton("Incr", id="incr", event = on("click", click))
         ,inputButton("Decr", id="decr", event = on("click", click))
         ,text(id="text", text="<counter>")
      ]);