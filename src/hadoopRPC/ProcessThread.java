package hadoopRPC;

import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.net.Socket;

/**
 * ����˽�����Ϣ�߳�
 * */
public class ProcessThread extends Thread{
	  private NameNode nameNode;
	  private Socket socket;
	public ProcessThread(NameNode nameNode, Socket socket) {
		this.nameNode = nameNode;
		this.socket = socket;
	}
      public void run(){
    	 try {
			ObjectInputStream ois = new ObjectInputStream(socket.getInputStream());
			//��ȡ���ͻ��˷�����data��Ϣ  
			Data data = (Data) ois.readObject();
			
			
			//���÷��䴥���ӿڷ���
		    Data data1= NameNodeHandler.doMethod(nameNode, data);
		    
		    ObjectOutputStream oos = new ObjectOutputStream(socket.getOutputStream());
			oos.writeObject(data1);
			oos.flush();
			ois.close();
			oos.close();
		} catch (IOException | ClassNotFoundException e) {
			System.out.println("��Ϣ����ʧ��");
			e.printStackTrace();
		}finally{
			try {
				socket.close();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		}
    	  
     }
	  
}
