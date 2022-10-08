package LeetCode;

import java.util.Stack;

public class PlusNoIf {
	public static void main(String[] args) {
		System.out.println(sumNums(2));
	}
	
	    public static int sumNums(int n) {
	    	
	    	boolean flag = n>0 && ( n=n+sumNums(n-1)) >0 ;
			return n;
	    }
}
