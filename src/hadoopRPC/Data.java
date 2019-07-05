package hadoopRPC;

import java.io.Serializable;
/**
 * 客户端服务端传递信息的载体
 * */
public class Data implements Serializable{
	   private String method;    //客户端调用服务端的接口名称
	    private String param;  //请求方法的参数
	     private String result;  //调用方法返回的结果
	     
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
