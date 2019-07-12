package websocket;

import java.io.IOException;
import java.util.concurrent.ArrayBlockingQueue;
import java.util.concurrent.BlockingQueue;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.ExecutionException;
import java.util.function.Function;
import java.util.logging.Logger;
import org.nanohttpd.protocols.http.IHTTPSession;
import org.nanohttpd.protocols.websockets.CloseCode;
import org.nanohttpd.protocols.websockets.NanoWSD;
import org.nanohttpd.protocols.websockets.WebSocket;
import org.nanohttpd.protocols.websockets.WebSocketFrame;
import org.rascalmpl.ast.AbstractAST;
import org.rascalmpl.interpreter.IEvaluator;
import org.rascalmpl.interpreter.IEvaluatorContext;
import org.rascalmpl.interpreter.control_exceptions.Throw;
import org.rascalmpl.interpreter.result.ICallableValue;
import org.rascalmpl.interpreter.result.Result;
import org.rascalmpl.interpreter.types.RascalTypeFactory;

import io.usethesource.vallang.IBool;
import io.usethesource.vallang.IValue;
import io.usethesource.vallang.IValueFactory;
import io.usethesource.vallang.type.Type;
import io.usethesource.vallang.type.TypeFactory;

/**
 * @author Paul S. Hawke (paul.hawke@gmail.com) On: 4/23/14 at 10:31 PM
 */
public class RWebSocketServer extends NanoWSD {

    /**
     * logger to log to.
     */
    private static final Logger LOG = Logger.getLogger(RWebSocketServer.class.getName());

    private final boolean debug;
    
    final IValueFactory vf;
    static IEvaluatorContext ctx;
    final TypeFactory tf = TypeFactory.getInstance();
    
    private Function<IValue, CompletableFuture<IValue>> executor;
    
    private Function<IValue, CompletableFuture<IValue>> buildRegularExecutor(ICallableValue target) {
        return (request) -> {
            CompletableFuture<IValue> result = new CompletableFuture<>();
            executeCallback(target, result, request, true);
            return result;
        };
    }

    private Function<IValue, CompletableFuture<IValue>> asyncExecutor(ICallableValue callback, BlockingQueue<Runnable> mainThreadExecutor) {
        return (request) -> {
            CompletableFuture<IValue> result = new CompletableFuture<>();
            try {
                mainThreadExecutor.put(() -> executeCallback(callback, result, request, false));
            }
            catch (InterruptedException e) {
                result.cancel(true);
            }
            return result;
        };
    }
    
    private void executeCallback(ICallableValue callback, CompletableFuture<IValue> target, IValue request, boolean asDaemon) {
        IEvaluator<Result<IValue>> eval = callback.getEval();
        synchronized (eval) {
            boolean oldInterupt = eval.isInterrupted();
            try {
                if (asDaemon) {
                    eval.__setInterrupt(false);
                }
                else if (oldInterupt) {
                    target.cancel(true); // cancel signals interupted evaluator
                    return;
                }
                Result<IValue> result = callback.call(new Type[] {tf.stringType()}, new IValue[] { request }, null);
                if (result != null && result.getValue() != null) {
                    target.complete(result.getValue());
                }
                else {
                    throw new Throw(vf.string("void result of function"),  (AbstractAST)null, eval.getStackTrace());
                }
            }
            catch (Throwable t) {
                target.completeExceptionally(t);
            }
            finally {
                if (asDaemon) {
                    eval.__setInterrupt(oldInterupt);
                }
            }
        }
    }


    public RWebSocketServer(int port, boolean debug, final IValue callback, IValueFactory vf, IEvaluatorContext ctx, boolean asDeamon) 
    {
        super(port);
        this.debug = debug;
        this.vf = vf;
        RWebSocketServer.ctx = ctx;
        if (debug) ctx.getStdErr().println("Opened2");
        BlockingQueue<Runnable> mainThreadExecutor;
        if (asDeamon) {
            mainThreadExecutor = null;
            executor = buildRegularExecutor((ICallableValue) callback);
        }
        else {
            mainThreadExecutor = new ArrayBlockingQueue<>(1024, true);
            executor = asyncExecutor((ICallableValue) callback, mainThreadExecutor);
        }
    }

    @Override
    protected WebSocket openWebSocket(IHTTPSession handshake) {
        return new DebugWebSocket(this, handshake);
    }

    private class DebugWebSocket extends WebSocket {

        private final RWebSocketServer server;

        public DebugWebSocket(RWebSocketServer server, IHTTPSession handshakeRequest) {
            super(handshakeRequest);
            this.server = server;
        }

        @Override
        protected void onOpen() {
        	  if (server.debug) ctx.getStdErr().println("Open");
        	  // ctx.getStdErr().flush();
        	  // CompletableFuture<IValue> rascalResponse = 
        			  executor.apply(vf.string("open/"));
//        	  try {
//        		  ctx.getStdErr().println(rascalResponse.get());
//        		  ctx.getStdErr().flush();
//			} catch (InterruptedException e) {
//				// TODO Auto-generated catch block
//				e.printStackTrace( ctx.getStdErr());
//			} catch (ExecutionException e) {
//				// TODO Auto-generated catch block
//				e.printStackTrace( ctx.getStdErr());
//			}
        }

        @Override
        protected void onClose(CloseCode code, String reason, boolean initiatedByRemote) {
            if (server.debug) {
            	ctx.getStdErr().println("C [" + (initiatedByRemote ? "Remote" : "Self") + "] " + (code != null ? code : "UnknownCloseCode[" + code + "]")
                        + (reason != null && !reason.isEmpty() ? ": " + reason : ""));
            	ctx.getStdErr().flush();
            executor.apply(vf.string("close/"));
            }
        }

        @Override
        protected void onMessage(WebSocketFrame message) {
            try {
                message.setUnmasked();
                executor.apply(vf.string("message/"+message.getTextPayload()));
                sendFrame(message);
            } catch (IOException e) {
                throw new RuntimeException(e);
            }
        }
        
        

        @Override
        protected void onPong(WebSocketFrame pong) {
            if (server.debug) {
            	ctx.getStdErr().println("P " + pong);
            }
        }
/*
        @Override
        protected void onException(IOException exception) {
            RascalWebSocketServer.LOG.log(Level.SEVERE, "exception occured", exception);
        }
*/

        @Override
        protected void debugFrameReceived(WebSocketFrame frame) {
            if (server.debug) {
            	ctx.getStdErr().println("R " + frame);
            }
        }

        @Override
        protected void debugFrameSent(WebSocketFrame frame) {
            if (server.debug) {
            	ctx.getStdErr().println("S " + frame);
            }
        }

		@Override
		protected void onException(IOException arg0) {
			 if (server.debug) {
				 ctx.getStdErr().println("E " + arg0.getMessage());
	            }
			
		}
    }
}