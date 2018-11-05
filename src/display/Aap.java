package display;
import io.usethesource.vallang.IValueFactory;
import io.usethesource.vallang.IInteger;

public class Aap {
	private final IValueFactory vf;
	public Aap(IValueFactory vf) {
        this.vf = vf;
    }
	
	public static void main(String[] args) {
		System.out.println("Hello world");
	}
	
	public IInteger g(IInteger x) {
		int z = x.intValue();
		return vf.integer(z*z);
	}
}
