package hadoopRPC;

import java.io.IOException;
import java.net.UnknownHostException;

public class TestRpcService {
      public static void main(String[] args) throws UnknownHostException, IOException {
		  //new NameNodeImpl()--- 相当于读取代理的东西放在这里面
    	  RPC.getServer(new NameNodeImpl(), 8888,200 , "127.0.0.1");
	}
}
