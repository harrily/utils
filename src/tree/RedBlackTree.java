package tree;

import java.util.ArrayList;
import java.util.List;

import tree.AvlTree.Node;

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
					RBTreeNode newNode = new RBTreeNode(key);
					newNode.parent = node;
					newNode.color = RED;
					node.right = newNode;
//					return newNode;
					return getBalance(newNode);
				}else {
					node = node.right;
				}
			}
			if(key < node.key) {
				if(node.left == null) {
					RBTreeNode newNode = new RBTreeNode(key);
					newNode.parent = node;
					newNode.color = RED;
					node.left = newNode;
//					return newNode;
					return getBalance(newNode);
				}else {
					node = node.left;
				}
			}
		}
		return null;
	}
	
	public RBTreeNode getBalance(RBTreeNode newNode) {
		if(newNode.parent != null) {
			if( newNode.parent.color == BLACK) {
				return  newNode;
			}else {
				RBTreeNode parent = newNode.parent;
				RBTreeNode grandpa = parent.parent;
				if(grandpa != null) {
					// uncle 是 右 节点
					if(grandpa.left != null && grandpa.left == parent) {
						if(grandpa.right != null && grandpa.right.color == RED) {
							parent.color = BLACK;
							grandpa.right.color = BLACK;
							grandpa.color = RED;
							return getBalance(grandpa);
						}else {
							//右旋
							if(newNode == parent.left) {
								parent.color = BLACK;
								grandpa.color = RED;
								return getLLbalance(grandpa);
							}
							// 左右旋
							if( newNode == parent.right) {
								newNode.color = BLACK;
								grandpa.color = RED;
								parent = getRRbalance(parent);
								return getLLbalance(grandpa);
							}
						}
					}else {  // uncle 是左孩子
						if(grandpa.left != null && grandpa.left.color == RED) {
							parent.color = BLACK;
							grandpa.left.color = BLACK;
							grandpa.color = RED;
							return getBalance(grandpa);
						}else {
							//左旋
							if( newNode == parent.right) {
								parent.color = BLACK;
								grandpa.color = RED;
								return getRRbalance(grandpa);
							}
							// 右左旋
							if( newNode == parent.left) {
								newNode.color = BLACK;
								grandpa.color = RED;
								parent = getLLbalance(parent);
								return getRRbalance(grandpa);
							}
						}
					}
				}
				else {
					root.color = BLACK;
				}
		  }
		}else {
			newNode.color = BLACK;
			return newNode;
		}
		return null;
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
	/**
	 * 前后中序遍历  1,2，3
	 * @param node
	 * @param list
	 * @param flag
	 * @return
	 */
	public void MiddleSearch(RBTreeNode node,int flag){
		if(node == null){
			return;
        }
		if(flag == 1 ) {
//			list.add(node.key);  // 前序
			System.out.println(node.key + "color:"+ (node.color == true?"Black":"Red"));
			MiddleSearch(node.left,flag);
			MiddleSearch(node.right,flag);
		}
		if(flag == 2 ) {
			
			MiddleSearch(node.left,flag);
//			list.add(node.key);  // 中序
			System.out.println(node.key + "color:"+ (node.color == true?"Black":"Red"));
			MiddleSearch(node.right,flag);
		}
		if(flag == 3 ) {
			MiddleSearch(node.left,flag);
			MiddleSearch(node.right,flag);
//			list.add(node.key);  // 后序
			System.out.println(node.key + "color:"+ (node.color == true?"Black":"Red"));
		}
	}
	
	public static void main(String[] args) {
		 RedBlackTree tree = new RedBlackTree();
	        RBTreeNode insert = tree.insert(13);
	        tree.insert(8);
	        tree.insert(17);
	        tree.insert(1);
	        tree.insert(11);
	        tree.insert(15);
	        tree.insert(25);
	        tree.insert(6);
	        tree.insert(22);
	        tree.insert(27);
	        tree.insert(21);
	        List<Integer> list = new ArrayList<Integer>();
	        tree.MiddleSearch(insert, 2);
	
	}
	
}
