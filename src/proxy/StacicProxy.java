package proxy;

public class StacicProxy {

	public RemoteService remote;
	
	public StacicProxy(RemoteService remote) {
		this.remote = remote;
	}
	
	public void doMethod() {
		remote.doMethod1();
		remote.doMethod2();
	}
}
