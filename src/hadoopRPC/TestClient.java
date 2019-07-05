package hadoopRPC;

public class TestClient {
    public static void main(String[] args) {
    	//传递一个.class(在代理类里面，通过反射获取interfaces)
		 NameNode nameNode = RPC.getProxy(NameNode.class, "127.0.0.1", 8888);
		 //执行invoke方法
		 String returns= nameNode.receiveClientMessage(" //////调用服务端的接口");
		 System.out.println(returns);
	}
}
   