package LeetCode;

import java.util.Arrays;
import java.util.Stack;

public class RandomRoute {
	public static void main(String[] args) {
		//山东华安昆仑网络科技有限公司   winaId=1741
//		int sceneId = 244;
//		String sre = "A8016D" + String.format("%06x", 13 * sceneId + 1).toUpperCase();
//		System.out.println(sre);
		//System.out.println(isValid2("()[]()[]()[]()[]()[]()[]()[]()[]()[]()[]()[]()[]()[]()[]()[]()[]()[]()[]()[]()[]()[]()[]()[]()[]()[]()[]()[]()[]"));
		System.out.println(replaceSpace(null));
		System.out.println(Arrays.toString(printNumbers(3)));
	}
	
	
	   public static int[] printNumbers(int n) {
	        String num = "1";
	        for(int i=0;i<n;i++){
	            num = num+"0";
	        }
	        int[] res = new int [Integer.parseInt(num)-1] ;
	        for(int i=0;i<Integer.parseInt(num)-1;i++) {
	        	res[i] = i+1;
	        }
			return res;
	    }
	
	 public static String replaceSpace(String s) {
		 if(s == null) {
			 return "";
		 }
		 String replace = s.replace(" ", "%20");
		 return replace;
	 }
	
	
	
	//使用非map来实现。（栈原理。）
	 public static boolean isValid2(String s) {
		char[] cha =  s.toCharArray();
	    if(cha.length%2!=0) {
	 	     return false;
	    }
	    Stack<Character> stack = new Stack<Character>();
	    for(char a : cha) {
	    	if(a == '[') {
	    		stack.push(']');
	    	}else if(a == '{') {
	    		stack.push('}');
	    	}else if(a == '(') {
	    		stack.push(')');
	    	}else if(stack.empty() || a !=stack.pop() ) {
	    			return false;
	    	}
	    }
	    if(stack.empty() ) {
	    	return true;
	    }
		return false;
	 }
	
	
	 public static boolean isValid(String s) {
	        if(s == null){
	            return false;
	        }
	        if("".equals(s)){
	            return true;
	            
	        }
	        
	        if(s.toCharArray().length%2!=0) {
	        	return false;
	        }
	        char[] cha =  s.toCharArray();
	        int flag = 0;
	        for(int i=0;i<cha.length;i++){
	        	if(cha.length%2==0) {
	        		if(i>(cha.length/2-1)){
		                break;
		            }
        	}
//	        		else {
//	        		if(i>((cha.length+1)/2-1)){
//		                break;
//		            }
//	        	}
	        	if(cha.length>1) {
	        		if( (cha[0] == '(' && cha[cha.length-0-1] == ')' )
	  		              || (cha[0] == '[' && cha[cha.length-0-1] == ']')
			              || (cha[0] == '{' && cha[cha.length-0-1] == '}')) {
	        			  if(  (cha[i] == '(' && cha[cha.length-i-1] == ')' )
	        		              || (cha[i] == '[' && cha[cha.length-i-1] == ']')
	        		              || (cha[i] == '{' && cha[cha.length-i-1] == '}')  ){          
	        		                flag = 0;
	        		                continue;
	        		     }else {
	        		    	  flag +=1;
	  		                break;
	        		     }
	        		}
	        		
	        		else if((cha[0] == '(' && cha[1] == ')' )
	  		              || (cha[0] == '[' && cha[1] == ']')
			              || (cha[0] == '{' && cha[1] == '}')) {
	        			
	        			if(  (cha[i] == '(' && cha[i+1] == ')' )
	      		              || (cha[i] == '[' && cha[i+1] == ']')
	    		              || (cha[i] == '{' && cha[i+1] == '}') ) {
	        				flag = 0;
	        				 continue;
	        			}else {
	        				System.out.println(i%2);
			            	if(i%2!=0) {
			            		continue;
			            	}
			                flag +=1;
			                break;
	        			}
	        			
	        		}
	        		else {
	        			 flag +=1;
			                break;
	        		}
//		            if(  (cha[i] == '(' && cha[cha.length-i-1] == ')' )
//		              || (cha[i] == '[' && cha[cha.length-i-1] == ']')
//		              || (cha[i] == '{' && cha[cha.length-i-1] == '}')  ){          
//		                flag = 0;
//		                continue;
//		            }else if(  (cha[i] == '(' && cha[i+1] == ')' )
//		              || (cha[i] == '[' && cha[i+1] == ']')
//		              || (cha[i] == '{' && cha[i+1] == '}')  ){
//		            	flag = 0;	
//		            	continue;
//		            }else{
//		            	System.out.println(i%2);
//		            	if(i%2!=0) {
//		            		continue;
//		            	}
//		                flag +=1;
//		                break;
//		            } 
	         	}else {
	         		 flag +=1;
		                break;
	         	}
	        }
	        if (flag==0){
	            return true;
	        }else{
	            return false;
	        }

	    }
}
