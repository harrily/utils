package proxy;

public class RemoteServiceImpl implements RemoteService {

	private String name ;
	public RemoteServiceImpl(String name ) {
		this.name = name;
	}
	
	@Override
	public void doMethod1() {
		System.out.println(name + " 1 hello word");
		
	}

	@Override
	public void doMethod2() {
		System.out.println(name + "  2  弄啥呢");
		
	}

}
