package hadoopRPC;

import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.net.Socket;

/**
 * 服务端接收消息线程
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
			//读取到客户端发来的data信息  
			Data data = (Data) ois.readObject();
			
			
			//利用反射触发接口方法
		    Data data1= NameNodeHandler.doMethod(nameNode, data);
		    
		    ObjectOutputStream oos = new ObjectOutputStream(socket.getOutputStream());
			oos.writeObject(data1);
			oos.flush();
			ois.close();
			oos.close();
		} catch (IOException | ClassNotFoundException e) {
			System.out.println("消息发送失败");
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
