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
	// 节点递归获取高度
	public int getHeight(Node t) {
        if(t==null) {return -1;}//
        int l = getHeight(t.left);
        int r  =  getHeight(t.right);
        return 1 + Math.max(l, r);
//        return 1+Math.max(getHeight(t.left), getHeight(t.right));
    }
	// insert的时候，记录新插入节点的高度，,balance不需要每次都递归获取高度。
	public int getHeight2(Node t) {
        if(t==null) {return -1;}//
        return t.height;
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
		/**
		  * 				      15
		  * 				/            \
		  * 			  8                23
		  * 			/   \           /      \				-->      5 
		  * 		  4      11		  19          71			       /   \
		  * 		    \             /         /    \				  4      6
		  *              5          17        50	  75
		  *               \      
		  * 			   6(new)
		  */
//		System.out.println(">>>>>>>>>>>>>>>>>>>>>>"+ oldNode.value);  // 最后插入6,此时4节点不平衡 
		Node newNode = oldNode.right;     // newNode的节点高度更新为oldNode.right
		oldNode.right = oldNode.right.left;  //替换节点， 更新old。right的高度 （从 1 --> -1）
		newNode.left =  oldNode; // oldNode 的高度 替换给newNodeleft， 此时是value = 4 ，height = 2
		// old 和 new 树的高度需要重新计算
		oldNode.height = Math.max(getHeight2(oldNode.left),getHeight2(oldNode.right))+1; //更新oldNode的高度(即更newNode.left高度，对象引用)，  height=0
		newNode.height = Math.max(getHeight2(newNode.left),getHeight2(newNode.right))+1; // 
//		System.out.println("======="+newNode.height);
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
		oldNode.height = Math.max(getHeight2(oldNode.left),getHeight2(oldNode.right))+1;
		newNode.height = Math.max(getHeight2(newNode.left),getHeight2(newNode.right))+1;
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
		oldNode.left = getRRbalance(oldNode.left);// 左节点平衡后，覆盖
		oldNode.height = Math.max(getHeight2(oldNode.left), getHeight2(oldNode.right))+1;
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
		oldNode.height = Math.max(getHeight2(oldNode.left), getHeight2(oldNode.right))+1;
		Node lLbalance = getRRbalance(oldNode);
		return lLbalance;
	}
	
	
	
	/**
	 *   AVL插入操作  非递归  ---> 待完善
	 *   	1、非递归形式插入， 每次循环，从上往下，  balance无效 ，需要从下而上
	 * @param x
	 * @return
	 */
	public Node insert (int x) {
		Node current = node;
		if(node == null) { 
			node = new Node(x);
			node.height=Math.max(getHeight2(node.left),getHeight2(node.right))+1;//不要写成递归， 递归效率低
			System.out.println("node.height000:"+node.height + " value : "+node.value);
			return node;
			}
		while(current != null) {
			if(x < current.value) {
				if(current.left == null) {
					current.left =  new Node(x);
					current.height=Math.max(getHeight2(current.left),getHeight2(current.right))+1;//不要写成递归， 递归效率低
					System.out.println("current.height111:"+current.height + " value : "+current.value);
					return  current.left;
				}else {
					current.height=Math.max(getHeight2(current.left),getHeight2(current.right))+1;//不要写成递归， 递归效率低
					System.out.println("current.height222:"+current.height+ " value : "+current.value);
					current = current.left;
				}
			}
			if(x > current.value) {
				if(current.right == null) {
					current.right =  new Node(x);
					current.height=Math.max(getHeight2(current.left),getHeight2(current.right))+1;//不要写成递归， 递归效率低
					System.out.println("current.height333:"+current.height+ " value : "+current.value);
//					 current = Balance(current);   // 5节点插入6 ， 此时8节点不平衡，但那时此时balance的确实当前节点5，  所以不生效，故需要递归的方式实现。，
					return current.right;
				}else {
					current.height=Math.max(getHeight2(current.left),getHeight2(current.right))+1;//不要写成递归， 递归效率低
					System.out.println("current.height444:"+current.height+ " value : "+current.value);
					current = current.right;
				}
			}
		}
//		return current;
		
		return Balance(current);
	}
	/**
	 * val 递归插入 
	 * @param value
	 * @return
	 */
	//  递归插入
	public Node insert1(int value) {
		return node = insert(value, node);
    }
	//递归实现  ,  递归从底到高， 每层遍历是否需要balance。
	public Node insert(int x,Node t)//插入   t是node = root的引用
    {
		
        if(t==null)    
        {
        	Node a1=new Node(x);
        	return a1;
        }
        //插入操作。递归实现
        else if(t!=null)
        {
            if(x<t.value)
            {
            	// 右边是左节点循环， 左边是把新值赋值给当前节点的左节点。（如果右左节点，还是复制给左节点）
            	t.left=insert(x,t.left);
            }
            else
            { 
            	t.right= insert(x,t.right);
            }
        }
        /*
         * 更新当前节点的高度，因为整个插入只有被插入的一方有影响，
         * 所以递归会更新好最底层的，上层可直接调用
         */
      //    记录当前节点的高度 (后续balance的时候，只需要更新newRoot和oldRoot的高度)
        t.height=Math.max(getHeight2(t.left),getHeight2(t.right))+1;
        System.out.println("t高度:"+t.height+ " t is value : "+t.value);
        return Balance(t);
//        return t;
    }
	public Node findMin(Node root){
		if(root == null) { return null;}
		while(root.left != null) {
			root = root.left;
		}
		return root;
	}
	/**
	 * 1、 递归 删除节点   ,  使用右节点最小值，替换
	 * 2、balance 树
	 * @param x
	 * @param t
	 * @return
	 */
	
		public Node remove(int x, Node t)
		{
			if (t == null) {
				return null;
			}
			if (x < t.value) {
				t.left = remove(x, t.left);
			} else if (x > t.value) {
				t.right = remove(x, t.right);
			} else if (t.left != null && t.right != null)// 左右节点均不空
			{
				t.value = findMin(t.right).value;// 找到右侧最小值替代  待删除节点的值。 
				t.right = remove(t.value, t.right);  // 更新当前节点右节点，改为删除 替换的值。继续remove判断。后续blance
			} else // 左右单空或者左右都空
			{
				if (t.left == null && t.right == null) {
					t = null;
				} else if (t.right != null) {
					t = t.right;
				} else if (t.left != null) {
					t = t.left;
				}
//				return t;
			}
			return Balance(t);
//			return t;
		}
	
	
	/**
	 *  平衡 avl树 
	 * @param node
	 * @return
	 */
	public Node Balance(Node node) {
		if(node == null) {
			return node;
		}
		// 不要平衡
		if(Math.abs(getHeight2(node.left) - getHeight2(node.right))  <= 1 ) {
//			System.out.println("balance:left:"+getHeight2(node.left));
//			System.out.println("balance:right:"+getHeight2(node.right));
//			System.out.println("balance: value:"+node.value);
			return node;
		}else if(getHeight2(node.left) > getHeight2(node.right)  ) {  // 左树高度 > 右树高度 
//			System.out.println("1:"+ node.value);
			if(getHeight2(node.left.left) > getHeight2(node.left.right) ) { // 且 左数左节点 > 左数右节点  即  左左类型  -->  右旋转
//				System.out.println("2: "+ node.value);
				return getLLbalance(node);      
			}else {
//				System.out.println("3:"+ node.value);
				return getLRbalance(node);       // 左右类型，   先左再右旋。
			}
		
		}else {
//			System.out.println("a:"+ node.value);
			if(getHeight2(node.right.right) > getHeight2(node.right.left)) {
//				System.out.println("b:"+ node.value +" "+ getHeight2(node.right.right) + " "+getHeight2(node.right.left));
				return getRRbalance(node);
			}else {
//				System.out.println("c:"+ node.value);
				return getRLbalance(node);
			}
		}
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
//		// 非递归插入
//		 Node insert1 = avlTree.insert(15);
//		 avlTree.insert(8);
//		 avlTree.insert(23);
//		 avlTree.insert(4);
//		 avlTree.insert(11);
////		 avlTree.insert(5);  //此时插入，需要balance
//		 avlTree.insert(19);
//		 avlTree.insert(71);
//		 	avlTree.insert(17);
//		 	avlTree.insert(5);
////		 treeTest.insert(21);
////		 avlTree.insert(71);  //此时插入，需要balance
//		 	avlTree.insert(50);
//			 avlTree.insert(75);
//		 // 新插入不平衡节点 6
//		 avlTree.insert(6);
		
		 /**
		  * 				      15
		  * 				/            \
		  * 			  8                23					   23	 	             23					        	23
		  * 			/   \           /      \		删除 71 		  \		              	\				 			  \		
		  * 		  4      11		  19          71      --> 		  75	 balance     	51					      	   50 												
		  * 		    \             /         /    \				/	      -->		   /   \			我以为是：		 /     \
		  *              5          17        50	  75          50                  	 50  	75			     	   49      75 
		  *               \      		     /   \			    /	 \				    /	    			     		      /								
		  * 			   6(new)			49   51            49     51              49        			    		    51
		  */	 
		// 递归插入
		 Node insert1 = avlTree.insert1(15);
		 avlTree.insert1(8);
		 avlTree.insert1(23);
		 avlTree.insert1(4);
		 avlTree.insert1(11);
//		 avlTree.insert1(5);  //此时插入，需要balance
		 avlTree.insert1(19);
		 avlTree.insert1(71);  
		 avlTree.insert1(17);
		 avlTree.insert1(5);
//		 treeTest.insert(21);
//		 avlTree.insert1(71);  //此时插入，需要balance
		 avlTree.insert1(50);
		 avlTree.insert1(75);
		 avlTree.insert1(6);   //此时插入，需要balance （测试插入balance）
		 
		 avlTree.insert1(49);
		 avlTree.insert1(51); // [15, 8, 5, 4, 6, 11, 23, 19, 17, 71, 50, 49, 51, 75]
		 avlTree.remove(71, insert1);  //删除 71 ，75替换，不平衡了， 测试 （ 先把 75.left = 50 节点，左旋， 然后 75节点，右旋。） 【因为替换后75的左子树的左支不大于右支，故先左再右】
		 avlTree.insert1(76); 
		 
		 /**
		  * 				      15
		  * 				/            \
		  * 			  8                23					   23	 	             
		  * 			/   \           /      \		删除 71 		  \		              	
		  * 		  5      11		  19          51      --> 		  75	 balance     										
		  * 		/   \             /         /    \				/	\      -->		 
		  *        4     6          17        50	  75          50     76             
		  *                       		     /   		\	     /	 				   							
		  * 			       			    49          76     49                   
		  */	 
		 avlTree.remove(51, insert1);  // 此时删除51,则找51节点右支最小值75替换（此时75的右节点是76）。相当于删除75，继续删除判断，  之后balance
		 List<Integer> list = new ArrayList<Integer>();
		 List<Integer> list2 = new ArrayList<Integer>();
		 System.out.println(avlTree.MiddleSearch(insert1, list, 1));
//		 System.out.println(avlTree.MiddleSearch(balance, list2, 1));
		 System.out.println(avlTree.getHeight(avlTree.node));
	}
}
