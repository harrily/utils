package hadoopRPC;

import java.io.IOException;
import java.lang.reflect.InvocationHandler;
import java.lang.reflect.Method;
import java.lang.reflect.Proxy;
import java.net.InetAddress;
import java.net.ServerSocket;
import java.net.Socket;
import java.net.UnknownHostException;

/**
 * ��������˽ӿڵĴ��� 
 * */
public class RPC {
	   public static void getServer(NameNode nameNode,int port,int backlog,String host) throws UnknownHostException, IOException{
		    ServerSocket ss = new ServerSocket(port,backlog,InetAddress.getByName(host));
		    while(true){
		    	   Socket socket = ss.accept();
		    	   new ProcessThread(nameNode, socket).start();
		    }
	   }
	   //Thread.currentThread().getContextClassLoader()  ���ص���TestClient������߳�
	   public static NameNode getProxy(Class clazz,String host,int port){
		    Class[] interfaces = new Class[1];
		    interfaces[0] = clazz;
		   return (NameNode) Proxy.newProxyInstance(Thread.currentThread().getContextClassLoader(), interfaces, new InvocationHandler() {
			public Object invoke(Object proxy, Method method, Object[] args) throws Throwable {
				Data data = new Data();
				//��ȡ�ӿ���receiveClientMessage�ķ�������
				data.setMethod(method.getName());
				//��ȡ�ӿ��е�receiveClientMessage��������
				data.setParam((String) args[0]);
				return RequestHandler.request(data,"127.0.0.1",8888).getResult();
			}
		});
	   }
}
