package hadoopRPC;

public class NameNodeImpl implements NameNode {

	@Override
	public String receiveClientMessage(String message) {
	       System.out.println("���յ��ͻ��˵���Ϣ"+message);
		return "��ã��ͻ���";
	}

}
