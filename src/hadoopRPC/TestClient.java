package hadoopRPC;

public class TestClient {
    public static void main(String[] args) {
    	//����һ��.class(�ڴ��������棬ͨ�������ȡinterfaces)
		 NameNode nameNode = RPC.getProxy(NameNode.class, "127.0.0.1", 8888);
		 //ִ��invoke����
		 String returns= nameNode.receiveClientMessage(" //////���÷���˵Ľӿ�");
		 System.out.println(returns);
	}
}
   