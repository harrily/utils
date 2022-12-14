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
		
//	    public static ListNode reverseBetween(ListNode head, int left, int right) {
//	            ListNode node = head;
//	            ListNode node1 = null;
//	            ListNode node2 = null ;
//	            int index = 1;
//	            if(node.next == null){
//	                return head;
//	            }
//	            while(node.next != null){
//	                index ++ ;
//	                if(index == left){
//	                   node1 = node;
//	                }
//	                if(index == right){
//	                   node2 = node;
//	                }
//	               node = node.next;
//	               
//	            }
//	           
//	            if(node1 == null && node2 == null){
//	                return head;
//	            }
//	            
//	            if(node1 == node2){
//	                return head;
//	            }
//	            if( node1 != null){
//	                ListNode leftNode = node1.next ;
//	                ListNode rightNode = node2.next ;
//	                leftNode.next = rightNode.next;  // 2 -> 5   2-null
//	                rightNode.next  = node2; // 4 ->3        3-2
//	                node1.next = rightNode;   // 1->4       1-3
//	                if(node2 != leftNode){
//	                     node2.next = leftNode;    //  3->2     2.next =2 
//	                }
//	               
//	            }else{
//	                ListNode leftNode = head ;
//	                ListNode rightNode = node2.next ;
//	                leftNode.next = rightNode.next;  //     1->null
//	                rightNode.next  = node2; // 4 ->3        3-2
//	                head = rightNode;   // 1->4       1-3
//	                if(node2 != leftNode){
//	                     node2.next = leftNode;    //  3->2     2.next =2 
//	                }
//	            }
//	            return head;
//	    }	
//	    
	    /**
	     *   1、找到left，right  遍历一次
	     *   2、旋转链表遍历一次【使用栈，空间复杂度o(n)】
	     * @param left
	     * @param right
	     * @return
	     */
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
	            while(tmp != null) {
	            	if(node1 == null) {
	            		stack.add(tmp.val);
	            		if(tmp == rightNode ) {
		            		break;
		            	}
		            }else {
		            	stack.add(tmp.next.val);
		            	if(tmp.next == rightNode ) {
		            		break;
		            	}
		            }
	            	
	            	tmp = tmp.next;
	            }
	            ListNode tmp2 = node1 ;
	            int flag = 0;
	            while(!stack.isEmpty()) {
	            	if(tmp2 != null) {
	            		tmp2.next = new ListNode(stack.pop()) ;
		            	tmp2 = tmp2.next;
	            	}else {
	            		// node1 为null，说明left是第一位。  此时生成node1， 和head脱节。
	            		node1 = new ListNode(stack.pop()) ;
	            		tmp2 = node1 ;
	            		flag = 2 ; // 标记重新覆盖head
//		            	tmp2 = tmp2.next;
	            	}
	            	if(stack.isEmpty()) {
	            		tmp2.next = rightNode.next;
	            	}
	            }
	            // 因为node1位null， 此时重新生成数组，需要覆盖原head
	            if(flag == 2) {  
	            	head = node1;
	            }
//	            while(node1!=null) {
//		    		System.out.print(node1.val);
//		    		node1 = node1.next;
//		    	}
//	            System.out.println();
			return head;
	    }
	    
	    /**
	     *    --   只遍历一次完成翻转
	     *    		头插法
	     *    
	     *    curr：指向待反转区域的第一个节点 left；
				next：永远指向 curr 的下一个节点，循环过程中，curr 变化以后 next 会变化；
				pre：永远指向待反转区域的第一个节点 left 的前一个节点，在循环过程中不变
				
		  * @param args
	     */
	    public static ListNode reverseBysingle( int left, int right) {
	    	ListNode listNode = new ListNode(-1, head);
	    	ListNode pre = listNode;
	    	for(int i=0 ;i<left-1   ; i++) {
	    		pre = pre.next;
	    	}
	    	// 修改cur.next， 同时也会更新pre的next。
	    	ListNode cur = pre.next;  // [2,3,4,5,6]  --> [2,4,5,6] --> [2,5,6]  -->[5,6]
	    	ListNode next;
	    	for(int i=0 ;i<right -left ; i++) {
	    	 	 next = cur.next;   	//[3,4,5,6] 	   --> [4,5,6]       --> [5,6]
	    	  	 cur.next = next.next ; // [2,4,5,6]      -->  [2,5,6]      -->  [2,6]
	    		 next.next = pre.next;  //[3,2,4,5,6]      --> [4,3,2,5,6]    -->[5,4,3,2,6]
	             pre.next = next;   	// [1,3,2,4,5,6]   -->  [1,4,3,2,5,6]  -->   [1,5,4,3,2,6]  
	    	}
			return listNode.next;
	    }
	    
	    
	    
	    public static void main(String[] args) {
	    	int[] arr1 = {1,2,3,4,5,6};
	    	ListNode insert = insert(arr1);
//	    	ListNode reverseBetween2 = reverseBetween2(1,4);
//	    	while(reverseBetween2!=null) {
//	    		System.out.println(reverseBetween2.val);
//	    		reverseBetween2 = reverseBetween2.next;
//	    	}
//	    	
			ListNode reverseBysingle = reverseBysingle(2, 5);
			while(reverseBysingle!=null) {
	    		System.out.println(reverseBysingle.val);
	    		reverseBysingle = reverseBysingle.next;
	    	}
	    	
	    	
	    	
		}
}
