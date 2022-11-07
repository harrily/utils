package tree;

public class RedBlackTree {
	/**
	 * 
	 * 		插入情况汇总
	 * 	1、插入节点的parent是black，直接插入即可
	 *  2、插入节点的uncle = not Red (black or null)：
	 *  	1-、RR & LL
	 *  		1-、RR情况 :  parent = grandpa.right , newNode = parent.right
	 *  		2-、LL情况:  parent = grandpa.left , newNode = parent.left
	 *  		步骤：
	 *  			1、parent 染为black ， grandPa染为 Red
	 *  			2、grand 进行单旋操作
	 *  				 RR: 左旋 
	 *  		 		 LL: 右旋
	 *  	2-、LR & RL 
	 *  		1-、LR情况:   parent = grandpa.left , newNode = parent.right
	 *		 	2-、RL情况:  parent = grandpa.right , newNode = parent.left
	 *  	  	步骤：
	 *  			1、 插入节点（newNode） 染为 Black , grandPa染为 Red
	 *  			2、双旋转操作:
	 *  				 LR:parent 左旋转， grandpa 右旋转
	 *  				 RL:parent 右旋转， grandpa 左旋转
	 *  3、插入节点的uncle =  Red : 
	 *   LL,RR,LR,RL: 
	 *  	parent、uncle 染成黑色
     *		grand 向上合并
	 *			将向上合并的grand染成红色，相对上一层，就当做是新添加的节点，再次来一遍插入情况的判断，进行处理。
			grand 向上合并时，可能继续发生上溢。这种情况就继续递归调用修复方法就可以了。若上溢持续到根节点，只需将根节点染成黑色即可
			（这个意思就是说断向上上溢，一直上溢到了B树的根节点位置了，只需要将向上合并的节点变成黑色作为红黑树的根节点即可。因为从B树根节点选择出来上溢的节点，肯定就是作为整个红黑树的根节点了）。
			
			备注： 每次向上的节点granpd ， 应该要判断，是否uncle为Red
					1、如果uncle为Red ，则  变色即可
					2、如果uncle为Black or null ,则应该参考  LL/RR进行处理。
	 *  		
	 *  
	 * 
	 */
	
	RBTreeNode root ;
	final boolean RED = false;
	final boolean BLACK = true;
	/**
	 *   红黑树插入操作
	 * @param key
	 * @return
	 */
	public RBTreeNode insert(int key) {
		RBTreeNode node = root;
		if(root == null) {
			root = new RBTreeNode(key);
			root.color= BLACK;
			return root;
		}
		while(node != null) {
			if(key > node.key ) {
				if(node.right == null) {
					RBTreeNode rbTreeNode = new RBTreeNode(key);
					rbTreeNode.parent = node;
					return rbTreeNode;
				}else {
					node = node.right;
				}
			}
			if(key < node.key) {
				if(node.left == null) {
					RBTreeNode rbTreeNode = new RBTreeNode(key);
					rbTreeNode.parent = node;
					return rbTreeNode;
				}else {
					node = node.left;
				}
			}
		}
		return node;
	}
	
	/**
	 * 
	 	oldNode 
	2  		 newNode 
		     4     5
		             inNode
	 *  左旋
	 * @param node
	 * @return
	 */
	public RBTreeNode getRRbalance(RBTreeNode oldNode) {
	    RBTreeNode newNode = oldNode.right;
	    RBTreeNode parent = oldNode.parent;
	    oldNode.right = newNode.left;
	    // newNode的左节点，父节点赋值（父节点的左右节点赋值已操作，其实就是oldNode的左右节点重赋值）
	    if(newNode.left != null) {
	    	newNode.left.parent = oldNode;
	    }
	    newNode.left = oldNode;
	    // 更新newNode的父节点
	    newNode.parent = parent;
	    // oldNode 的父节点，  左or右节点重新赋值
	    if(parent != null) {
	    	if(parent.left != null && parent.left  == oldNode) {
	    		parent.left = newNode;
	    	}else {
	    		parent.right = newNode;
	    	}
	    }
	    // 更新oldNode的父节点
	    oldNode.parent = newNode;
		return newNode;
		
//		    RedBlackTreeNode right = node.getRight();
//	        RedBlackTreeNode parent = node.getParent();
//	 
//	        node.setRight(right.getLeft());
//	        if(right.getLeft() != null){
//	            right.getLeft().setParent(node);
//	        }
//	        node.setParent(right);
//	 
//	        right.setLeft(node);
//	        if(parent == null){
//	            root = right;
//	            right.setParent(null);
//	        }else{
//	            right.setParent(parent);
//	            if(parent.getLeft() != null && parent.getLeft() == node){
//	                parent.setLeft(right);
//	            }else{
//	                parent.setRight(right);
//	            }
//	        }

		
	}
	/**
	 * 右旋
	 * 
				 	oldNode 
				newNode  	6	  
			    4     5
		   innode		             
	 * 
	 * @param node
	 * @return
	 */
	public RBTreeNode getLLbalance(RBTreeNode oldNode) {
		RBTreeNode newNode = oldNode.left;
	    RBTreeNode parent = oldNode.parent;
	    oldNode.left = newNode.right;
	    if(newNode.right != null) {
	    	newNode.right.parent = oldNode;
	    }
	    newNode.right = oldNode;
	    newNode.parent = parent;
	    if(parent != null) {
	    	if(parent.left != null && parent.left  == oldNode) {
	    		parent.left = newNode;
	    	}else {
	    		parent.right = newNode;
	    	}
	    }
	    oldNode.parent = newNode;
		return newNode;
	}
	

	class RBTreeNode{
		final boolean RED = false;
		final boolean BLACK = true;
		int key ;
		boolean color ;
		RBTreeNode left ;
		RBTreeNode right ;
		RBTreeNode parent;
		
		public RBTreeNode(int key){
			this.key = key;
			this.color = RED;
		}
		public RBTreeNode(int key,RBTreeNode left,RBTreeNode right ,RBTreeNode parent){
			this.key = key;
			this.color = RED;
			this.left = left;
			this.right = right;
			this.parent = parent;
		}
		
//		public int getKey() {
//			return key;
//		}
//		public void setKey(int key) {
//			this.key = key;
//		}
//		public boolean isColor() {
//			return color;
//		}
//		public void setColor(boolean color) {
//			this.color = color;
//		}
//		public RBTreeNode getLeft() {
//			return left;
//		}
//		public void setLeft(RBTreeNode left) {
//			this.left = left;
//		}
//		public RBTreeNode getRight() {
//			return right;
//		}
//		public void setRight(RBTreeNode right) {
//			this.right = right;
//		}
//		public RBTreeNode getParent() {
//			return parent;
//		}
//		public void setParent(RBTreeNode parent) {
//			this.parent = parent;
//		}
	} 
	
	
	
}
