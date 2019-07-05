package hadoopRPC;

import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.net.Socket;

/**
  * �ͻ��˷�����Ϣ�Ĺ���
  * 
  * */
public class RequestHandler {
	 public static Data request(Data data,String host,int port){
		 try {
		Socket socket = new Socket(host,port);
		ObjectOutputStream oos = new ObjectOutputStream(socket.getOutputStream());	 
		//�ͻ��˰�  data������д��ͨ����  data����������������� ��  ��������Ϣ---(" //////���÷���˵Ľӿ�")
		oos.writeObject(data);
		oos.flush();
		
		ObjectInputStream ois = new ObjectInputStream(socket.getInputStream());
		data =  (Data) ois.readObject();
		System.out.println("------�ӵ�����˵ķ�����Ϣ��"+data.getResult());
		oos.close();
		ois.close();
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println(e);
		}
		 return data;
	 }
}
  