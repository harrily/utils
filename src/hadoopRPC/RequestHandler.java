package hadoopRPC;

import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.net.Socket;

/**
  * 客户端发送消息的过程
  * 
  * */
public class RequestHandler {
	 public static Data request(Data data,String host,int port){
		 try {
		Socket socket = new Socket(host,port);
		ObjectOutputStream oos = new ObjectOutputStream(socket.getOutputStream());	 
		//客户端把  data的内容写进通道，  data里面包括方法的名字 和  参数的信息---(" //////调用服务端的接口")
		oos.writeObject(data);
		oos.flush();
		
		ObjectInputStream ois = new ObjectInputStream(socket.getInputStream());
		data =  (Data) ois.readObject();
		System.out.println("------接到服务端的返回消息："+data.getResult());
		oos.close();
		ois.close();
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println(e);
		}
		 return data;
	 }
}
  