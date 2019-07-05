package hadoopRPC;

import java.lang.reflect.Method;
/**
 * ���ݿͻ��˷��͹�������Ϣ �����÷��䴥������
 * */
public class NameNodeHandler {
       public static Data doMethod(NameNode nameNode,Data data){
           try {
			  String method  = data.getMethod();
              String parm = data.getParam();
              //ͨ���ӿڵ�ʵ����Ķ���  ��  ����ȡ����������
              Class clazz = nameNode.getClass();
             //ͨ������ ��ʵ������ԣ�  ��Ϊ���ݷ��������� �Ͳ����Ϳ��Ի�ȡ���������壬�ͻ���ֻ��Ҫд����ִ�еķ�������
              //ִ��ʵ���������Ӧ�ķ����������������  --��ӡ��server��  ��
              Method m = clazz.getMethod(method, String.class);
             // result ----ָ����   ����return������(��invoke�Ƿ���������Ĳ�ͬ)
              System.out.println("..............");
              
              String result =(String) m.invoke(nameNode, parm);
              
              System.out.println("-----������һ�д���  ...��ӡ����  ʵ��������Ķ���----");
              
              data.setResult(result);
	 	   } catch (Exception e) {
			// TODO: handle exception
	 		   System.out.println(e);
		   } 
    	   return data;
       }
       
       
}
