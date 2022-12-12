package LeetCode;

import java.util.Stack;

public class ReverseLink {
	  public static class ListNode {
	      int val;
	      ListNode next;
	      ListNode() {}
	      ListNode(int val) { this.val = val; }
	     ListNode(int val, ListNode next) { this.val = val; this.next = next; }
	  }
	  
		static ListNode head;
		static ListNode insert(int[] num) {
			
			if(head == null) {
				head  = new ListNode(num[0]);
			}
			ListNode node = head;
			for(int i=1;i<num.length;i++) {
				if(node.next == null) {
					node.next  = new ListNode(num[i]);
				}
				node = node.next;
			}
			return head;
		}
		
	    public static ListNode reverseBetween(ListNode head, int left, int right) {
	            ListNode node = head;
	            ListNode node1 = null;
	            ListNode node2 = null ;
	            int index = 1;
	            if(node.next == null){
	                return head;
	            }
	            while(node.next != null){
	                index ++ ;
	                if(index == left){
	                   node1 = node;
	                }
	                if(index == right){
	                   node2 = node;
	                }
	               node = node.next;
	               
	            }
	           
	            if(node1 == null && node2 == null){
	                return head;
	            }
	            
	            if(node1 == node2){
	                return head;
	            }
	            if( node1 != null){
	                ListNode leftNode = node1.next ;
	                ListNode rightNode = node2.next ;
	                leftNode.next = rightNode.next;  // 2 -> 5   2-null
	                rightNode.next  = node2; // 4 ->3        3-2
	                node1.next = rightNode;   // 1->4       1-3
	                if(node2 != leftNode){
	                     node2.next = leftNode;    //  3->2     2.next =2 
	                }
	               
	            }else{
	                ListNode leftNode = head ;
	                ListNode rightNode = node2.next ;
	                leftNode.next = rightNode.next;  //     1->null
	                rightNode.next  = node2; // 4 ->3        3-2
	                head = rightNode;   // 1->4       1-3
	                if(node2 != leftNode){
	                     node2.next = leftNode;    //  3->2     2.next =2 
	                }
	            }
	            return head;
	    }	
	    
	    
	    public static ListNode reverseBetween2( int left, int right) {
	    	    ListNode node = head;
//	    	    head.next = new ListNode(20);
	            ListNode node1 = null;
	            ListNode node2 = null ;
	            int index = 1;
	            if(node.next == null){
	                return head;
	            }
	            if(left == right) {
	            	return head;
	            }
	            
	            while(node.next != null){
	                index ++ ;
	                if(index == left){
	                   node1 = node;
	                }
	                if(index == right){
	                   node2 = node;
	                }
	               node = node.next;
	            }
	            
                ListNode rightNode = node2.next ;
                ListNode tmp = node1 ;
                if(node1 == null) {
            		tmp = head;
	            }
                Stack<Integer> stack = new Stack<Integer>();
	            while(tmp.next != null) {
	            	if(node1 == null) {
	            		stack.add(tmp.val);
		            }else {
		            	stack.add(tmp.next.val);
		            }
	            	if(tmp == rightNode ) {
	            		break;
	            	}
	            	tmp = tmp.next;
	            }
	            ListNode tmp2 = node1 ;
	            while(!stack.isEmpty()) {
	            	if(tmp2 != null) {
	            		tmp2.next = new ListNode(stack.pop()) ;
		            	tmp2 = tmp2.next;
	            	}else {
	            		node1 = new ListNode(stack.pop()) ;
	            		tmp2 = node1 ;
//		            	tmp2 = tmp2.next;
	            	}
	            	if(stack.isEmpty()) {
	            		tmp2.next = rightNode.next;
	            	}
	            
	            }
	        head = node1;
			return head;
	    }
	    
	    public static void main(String[] args) {
	    	int[] arr1 = {1,2,3,4};
	    	ListNode insert = insert(arr1);
	    	ListNode reverseBetween2 = reverseBetween2( 2, 3);
	    	while(reverseBetween2!=null) {
	    		System.out.println(reverseBetween2.val);
	    		reverseBetween2 = reverseBetween2.next;
	    	}
		}
}
