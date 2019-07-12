module websocket::RascalWebSocketServe
import Prelude;
@reflect{To get access to the data types}
@javaClass{websocket.RascalWebSocketServe}
public java void serve(int port, value callback);

@javaClass{websocket.RascalWebSocketServe}
public java void shutdown();

public void main() {
    serve(9094, void(str x) {
        println(x);});
    }