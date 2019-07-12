package websocket;
import java.io.IOException;

import org.rascalmpl.interpreter.IEvaluatorContext;

import io.usethesource.vallang.IInteger;
import io.usethesource.vallang.IValue;
import io.usethesource.vallang.IValueFactory;

public class RascalWebSocketServe {
	private final IValueFactory vf;
	RWebSocketServer ws;
	IEvaluatorContext ctx;
	
	public RascalWebSocketServe(IValueFactory vf) {
	    this.vf = vf;
	  }
	
	public void serve(IInteger port, final IValue callback, final IEvaluatorContext ctx) {
		ctx.getStdErr().println("Server started1.\n");
	    this.ws  = new RWebSocketServer(port.intValue(), true, callback, vf, ctx, true); 
	    this.ctx = ctx;
	    // ctx.getStdErr().
	    
        try {
        	ws.start(50000000);
        } catch (IOException ignored) {
        	ignored.printStackTrace(ctx.getStdErr());
        }     
	}
	
	public void shutdown() {
		 ws.stop();
		 ctx.getStdErr().println("Server stopped.\n");
	};
	
	public static void main(String[] args) {
		System.out.println("OK1");
		};
	
}
