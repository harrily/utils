package my_test;

import java.util.HashMap;
import java.util.Map.Entry;
import java.util.Set;


public class EqualTest {
	 
	   /**
	    *  equal方法分析
	    */
	       private static class Person{
	           int idCard;
	           String name;

	           public Person(int idCard, String name) {
	               this.idCard = idCard;
	               this.name = name;
	           }
	          //重写equals方法（默认是根据对象地址比较是否相同）
	           @Override
	           public boolean equals(Object o) {
	        	   //比较对象地址是否相同
	               if (this == o) {
	                   return true;
	               }
	               if (o == null || getClass() != o.getClass()){
	                   return false;
	               }
	               Person person = (Person) o;
	               //两个对象是否等值，通过idCard来确定
	               return this.idCard == person.idCard;
	           }  
	         
	           //重写hashcode方法    ( 默认返回的实际上是该对象在jvm的堆上的内存地址，)
	           @Override
	           public int hashCode() {
	               int result = 17;
	               //result = 31 * result + (name == null ? 0 : name.hashCode());
	               result = 31 * result + idCard;
	               return result;
	           }

	       }
	       public static void main(String []args){
	           HashMap<Person,String> map = new HashMap<Person, String>();
	           Person person = new Person(1234,"乔峰");
	           //put到hashmap中去
	           map.put(person,"天龙八部");
	           /**
	            * 本例中重写了equals和hashcode，只要idCard值相同，则此对象的hashcode值核equals判断都相同。
	            * 这样，在hashmap中判断时，只要两个对象，idCard一致，则认为是相同的对象。
	            * 
	            * 	如果hashcode不重写，则虽然idCard相同，但是hashMap不任务这两个对象是相同的（因为hashMap中会比较两个对象的hashcode是否一致）
	            * */
	           Person person2 =  new Person(1234,"王英楠");
	           //get取出，从逻辑上讲应该能输出“天龙八部”  //结果:天龙八部
	           System.out.println("结果:"+map.get(person2));
	           
	       }
}
