package proxy;

public class test {

	
	public static void main(String[] args) {
		/**
		 * 
		 *  测试静态代理 
		 */
		RemoteService rs2 = new RemoteServiceImpl("王英楠");
		//传递对象  （必须是确定的，传递其他，需要修改代理类的逻辑） ， 执行代理方法(调用实例的方法)
		StacicProxy stacicProxy = new StacicProxy(rs2);
		stacicProxy.doMethod();
		
		
		System.out.println("");
		
		/**
		 * 
		 *  测试动态代理 
		 */
		DynamicProxy dynamicProxy = new DynamicProxy();
		RemoteService rs = new RemoteServiceImpl("王英楠");
		// 传递   指定的对象（可以是任意的）。 生成代理对象 ->执行方法（ 执行invoke） 
		RemoteService createProxyInstance = (RemoteService) dynamicProxy.createProxyInstance(rs);
		createProxyInstance.doMethod1();
		createProxyInstance.doMethod2();
	}
}
