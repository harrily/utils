package tree;

import java.util.ArrayList;
import java.util.List;

public class AvlTree {

    class Node
    {
        int value;
        Node left;
        Node right;
        int height; // 计算高度(平衡因子)
        public Node() {

        }
        public Node(int value)
        {
            this.value=value;
            this.height=0;
        }
        public Node(int value,Node left,Node right)
        {
            this.value=value;
            this.left=left;
            this.right=right;
            this.height=0;
        }
    }

	Node node ;
	public int getHeight(Node t) {
        if(t==null) {return -1;}//
        int l = getHeight(t.left);
        int r  =  getHeight(t.right);
        return 1 + Math.max(l, r);
//        return 1+Math.max(getHeight(t.left), getHeight(t.right));
    }
	
	/**
	 * : 左 旋   (在结点oldNode 的 右结点（newNode） 的 右子树（H3） 上做了插入元素(n1,n2)的操作，我们称这种情况为 右右型 ，我们应该进行左旋转。 )	
	 * 
	 * 				oldNode							newNode
	 * 			  /			\					  /          \
	 * 			H1         newNode		-->	    oldNode		  H3	 
	 * 					  /       \			   /      \      /  \
	 * 					H2		   H3		  H1      H2	n1   n2
	 * 							 /    \
	 * 							n1     n2	
 	 * 	 
	 * @return
	 */
	public Node getRRbalance(Node oldNode) {
		Node newNode = oldNode.right;
		oldNode.right = oldNode.right.left;
		newNode.left =  oldNode; 
		// old 和 new 树的高度需要重新计算
		oldNode.height = Math.max(getHeight(oldNode.left),getHeight(oldNode.right))+1;
		newNode.height = Math.max(getHeight(newNode.left),getHeight(newNode.right))+1;
		return newNode;
	}
	
	/**
	 * 
	 *  右 旋 (在结点oldNode 的 左 结点（newNode） 的 左子树（H1） 上做了插入元素(n1,n2)的操作，我们称这种情况为 左左 型 ，我们应该进行右旋转。 )	
	 *  
	 * 					oldNode							newNode
	 * 				  /			\					  /         \
	 * 			 newNode         H3		-->	    	H1 	 		oldNode	 
	 * 	  	 	/       \			  			  /	   \		/      \
	 * 	 	  H1		  H2		  			n1	   n2	  H2		H3
	 * 		/    \
	 *     n1     n2
	 * :		 
	 * @return
	 */
	public Node getLLbalance(Node oldNode) {
		Node newNode = oldNode.left;
		oldNode.left = oldNode.left.right;
		newNode.right =  oldNode; 
		// old 和 new 树的高度需要重新计算
		oldNode.height = Math.max(getHeight(oldNode.left),getHeight(oldNode.right))+1;
		newNode.height = Math.max(getHeight(newNode.left),getHeight(newNode.right))+1;
		return newNode;
	}
	
	
	/**
	 *  在结点oldNode1的 左结点（oldNode2） 的 右子树（newNode） 上做了插入元素(n1,n2)的操作，我们称这种情况为 左右型 ，我们应该进行左右旋。(先左再右)
	 * 					oldNode1							oldNode1						newNode
	 * 				  /			\		         先-左旋 			  /         \		再 - 右旋			/	   \ 
	 * 			 oldNode2         H3		-->	      newNode 	 	  H3	 -->		oldNode2   oldNode1 
	 * 	  	 	/       \			  				  /	   \							/	  \		/     \
	 * 	 	  H1		newNode		  			  oldNode2	n2	  					  H1	  n1   n2     H3
	 * 					/    \					 /		\
	 *    			   n1     n2				H1		n1
	 * 
	 * 
	 * @param oldNode
	 * @return
	 */
	public Node getLRbalance(Node oldNode) {
		oldNode.left = getRRbalance(oldNode.left);
		oldNode.height = Math.max(getHeight(oldNode.left), getHeight(oldNode.right))+1;
		Node lLbalance = getLLbalance(oldNode);
		return lLbalance;
	}
	
	
	/**
	 *  在结点oldNode1的 右结点（oldNode2） 的 左子树（newNode） 上做了插入元素(n1,n2)的操作，我们称这种情况为 右左型 ，我们应该进行右左旋。(先右再左)
	 * 					oldNode1							oldNode1						newNode
	 * 				  /			\		         先-右旋 			  /         \		  再 - 左旋			/	   \ 
	 * 				H1		 oldNode2     	-->	      	H1 	 	  newNode	  -->		oldNode1   oldNode2 
	 * 	  	 				/       \			  				  /	   \				/	  \		/     \
	 * 	 	 			newNode		H3		  			  		n1	oldNode2		   H1	  n1   n2     H3
	 * 					/    \									    /     \
	 *    			   n1     n2								   n2	   H3
	 * 
	 * 
	 * @param oldNode
	 * @return
	 */
	public Node getRLbalance(Node oldNode) {
		oldNode.right = getLLbalance(oldNode.right);
		oldNode.height = Math.max(getHeight(oldNode.left), getHeight(oldNode.right))+1;
		Node lLbalance = getRRbalance(oldNode);
		return lLbalance;
	}
	
	
	
	/**
	 *   AVL插入操作
	 * @param x
	 * @return
	 */
	public Node insert (int x) {
		Node current = node;
		if(node == null) { node = new Node(x); return node;}
		while(current != null) {
			if(x < current.value) {
				if(current.left == null) {
					return  current.left =  new Node(x);
				}else {
					current = current.left;
				}
			}
			if(x > current.value) {
				if(current.right == null) {
					return  current.right =  new Node(x);
				}else {
					current = current.right;
				}
			}
		}
		
		return current;
	}
	
	
	
	
	public static void main(String[] args) {
		
	}
}
