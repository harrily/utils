package hadoopRPC;

import java.io.IOException;
import java.net.UnknownHostException;

public class TestRpcService {
      public static void main(String[] args) throws UnknownHostException, IOException {
		  //new NameNodeImpl()--- �൱�ڶ�ȡ����Ķ�������������
    	  RPC.getServer(new NameNodeImpl(), 8888,200 , "127.0.0.1");
	}
}
