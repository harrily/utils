package hadoopRPC;

import java.lang.reflect.Method;
/**
 * 根据客户端发送过来的消息 ，利用反射触发方法
 * */
public class NameNodeHandler {
       public static Data doMethod(NameNode nameNode,Data data){
           try {
			  String method  = data.getMethod();
              String parm = data.getParam();
              //通过接口的实现类的对象  ，  来获取反射的类对象
              Class clazz = nameNode.getClass();
             //通过反射 ，实现灵活性，  因为根据方法的名字 和参数就可以获取方法的主体，客户端只需要写他想执行的方法即可
              //执行实现类里面对应的方法（把里面的内容  --打印在server端  ）
              Method m = clazz.getMethod(method, String.class);
             // result ----指的是   方法return的内容(此invoke是反射的与代理的不同)
              System.out.println("..............");
              
              String result =(String) m.invoke(nameNode, parm);
              
              System.out.println("-----上面这一行代码  ...打印的是  实现类里面的东西----");
              
              data.setResult(result);
	 	   } catch (Exception e) {
			// TODO: handle exception
	 		   System.out.println(e);
		   } 
    	   return data;
       }
       
       
}
