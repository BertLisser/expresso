package websocket;

import java.io.IOException;

import org.nanohttpd.protocols.websockets.NanoWSD;

public class EchoSocketSample1 {
	 public static void main(String[] args) throws IOException  {
	        // final boolean debugMode = args.length >= 2 && "-d".equals(args[1].toLowerCase());
		    final boolean debugMode = true;
	        //NanoWSD ws = new RWebSocketServer(args.length > 0 ? Integer.parseInt(args[0]) : 9090, debugMode);
	        // ws.start(50000000);
	        System.out.println("Server started, hit Enter to stop.\n");
	        try {
	            System.in.read();
	        } catch (IOException ignored) {
	        }
	        // ws.stop();
	        System.out.println("Server stopped.\n");
	    }

}
