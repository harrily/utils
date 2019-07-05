package proxy;

import java.lang.reflect.InvocationHandler;
import java.lang.reflect.Method;
import java.lang.reflect.Proxy;

public class DynamicProxy implements InvocationHandler {
	
	private Object object;
	
	public Object createProxyInstance(Object object) {
		this.object = object;
		return Proxy.newProxyInstance(object.getClass().getClassLoader(),object.getClass().getInterfaces(), this);
	}
	@Override
	public Object invoke(Object proxy, Method method, Object[] args) throws Throwable {
			System.out.println("====执行方法之前===");
			Object obj = method.invoke(this.object, args);
			System.out.println("----执行方法之后----");
			return obj;
	}
	
}
