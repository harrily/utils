package hadoopRPC;

import java.io.Serializable;
/**
 * �ͻ��˷���˴�����Ϣ������
 * */
public class Data implements Serializable{
	   private String method;    //�ͻ��˵��÷���˵Ľӿ�����
	    private String param;  //���󷽷��Ĳ���
	     private String result;  //���÷������صĽ��
	     
		public String getMethod() {
			return method;
		}
		public void setMethod(String method) {
			this.method = method;
		}
		public String getParam() {
			return param;
		}
		public void setParam(String param) {
			this.param = param;
		}
		public String getResult() {
			return result;
		}
		public void setResult(String result) {
			this.result = result;
		}
}
