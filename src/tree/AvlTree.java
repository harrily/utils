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
		if(node == null) { 
			node = new Node(x);
			node.height=Math.max(getHeight(node.left),getHeight(node.right))+1;//不要写成递归， 递归效率低
			System.out.println("node.height000:"+node.height + " value : "+node.value);
			return node;
			}
		while(current != null) {
			if(x < current.value) {
				if(current.left == null) {
					current.left =  new Node(x);
					current.height=Math.max(getHeight(current.left),getHeight(current.right))+1;//不要写成递归， 递归效率低
					System.out.println("current.height111:"+current.height + " value : "+current.value);
					return  current.left;
				}else {
					current.height=Math.max(getHeight(current.left),getHeight(current.right))+1;//不要写成递归， 递归效率低
					System.out.println("current.height222:"+current.height+ " value : "+current.value);
					current = current.left;
				}
			}
			if(x > current.value) {
				if(current.right == null) {
					current.right =  new Node(x);
					current.height=Math.max(getHeight(current.left),getHeight(current.right))+1;//不要写成递归， 递归效率低
					System.out.println("current.height333:"+current.height+ " value : "+current.value);
					return  current.right;
				}else {
					current.height=Math.max(getHeight(current.left),getHeight(current.right))+1;//不要写成递归， 递归效率低
					System.out.println("current.height444:"+current.height+ " value : "+current.value);
					current = current.right;
				}
			}
		}
		
		return current;
	}
	//  递归插入
	public Node insert1(int value) {
		return node = insert(value, node);
    }
	//实现
	public Node insert(int x,Node t)//插入   t是root的引用
    {
		Node a1=new Node(x);
        //if(root==null) {root=a1;return root;}		
        if(t==null)    {return a1;}
        //插入操作。递归实现
        else if(t!=null)
        {
            if(x<t.value)
            { t.left=insert(x,t.left);}
            else
            { t.right= insert(x,t.right);}
        }
        /*
         * 更新当前节点的高度，因为整个插入只有被插入的一方有影响，
         * 所以递归会更新好最底层的，上层可直接调用
         */
        t.height=Math.max(getHeight(t.left),getHeight(t.right))+1;//不要写成递归， 递归效率低
        System.out.println("t高度:"+t.height+ " t is value : "+t.value);
        return t;//因为java对象传参机制，需要克隆，不可直接t=xx 否则变换	  
    }
	
	public List<Integer> MiddleSearch(Node node,List<Integer> list,int flag){
		if(node == null){
            return list;
        }
		if(flag == 1 ) {
			list.add(node.value);  // 前序
			MiddleSearch(node.left, list,flag);
			MiddleSearch(node.right, list,flag);
		}
		if(flag == 2 ) {
			
			MiddleSearch(node.left, list,flag);
			list.add(node.value);  // 中序
			MiddleSearch(node.right, list,flag);
		}
		if(flag == 3 ) {
			MiddleSearch(node.left, list,flag);
			MiddleSearch(node.right, list,flag);
			list.add(node.value);  // 后序
		}
		
		
		return list;
	}
	
	
	public static void main(String[] args) {
		AvlTree avlTree = new AvlTree();
//		 Node node = avlTree.insert(15);
//		 avlTree.insert(6);
//		 avlTree.insert(23);
//		 avlTree.insert(4);
//		 avlTree.insert(7);
//		 avlTree.insert(5);
//		 avlTree.insert(19);
//		 avlTree.insert(17);
////		 treeTest.insert(21);
//		 avlTree.insert(71);
//		 avlTree.insert(50);
//		 avlTree.insert(75);
		
		 /**
		  * 				     15
		  * 			6                 23
		  * 		4      7		 19        71
		  *            5          17          50	  75      
		  * 
		  */
		
		Node insert1 = avlTree.insert1(15);
		 avlTree.insert1(6);
		 avlTree.insert1(23);
		 avlTree.insert1(4);
		 avlTree.insert1(7);
		 avlTree.insert1(5);
		 avlTree.insert1(19);
		 avlTree.insert1(17);
//		 treeTest.insert(21);
		 avlTree.insert1(71);
		 avlTree.insert1(50);
		 avlTree.insert1(75);
		
		 List<Integer> list = new ArrayList<Integer>();
		 System.out.println(avlTree.MiddleSearch(insert1, list, 1));
	}
}
