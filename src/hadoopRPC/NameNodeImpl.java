package hadoopRPC;

public class NameNodeImpl implements NameNode {

	@Override
	public String receiveClientMessage(String message) {
	       System.out.println("接收到客户端的消息"+message);
		return "你好，客户端";
	}

}
