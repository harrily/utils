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
	 * author: wangyingnan
	 * date:2022-11-08
	 */
	
	RBTreeNode root ;
	final boolean RED = false;
	final boolean BLACK = true;
	final String LEFT = "LEFT";
	final String RIGHT = "RIGHT";
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
	
	// 插入balance
	public RBTreeNode getBalance(RBTreeNode newNode) {
		if(newNode.parent != null) {
			if( newNode.parent.color == BLACK) {
				return  newNode;
			}else {
				RBTreeNode parent = newNode.parent;
				RBTreeNode grandpa = parent.parent;
//				if(grandpa != null) {  // 当前节点的 parent不为null， 且parent为RED。  所以grandPa肯定不会为null，故不需要判断。
					// uncle 是 右孩子
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
//				}
//				else {
//					root.color = BLACK;
//				}
		  }
		}else {
			newNode.color = BLACK;//当前节点为根节点，重新赋颜色为 BLACK
			return newNode;
		}
		return null;
	}
	
	/**
	 * 
	 *  RB数删除操作：
	 *  		非递归，先找到节点，删除，然后balance 
	 *  			问题：
	 *  				1、递归修改的是当前节点的左右支， 后续回溯时，把它赋值给原来的左右节点。 
	 *  				2、但是红黑树， 平衡操作， 可能会修改待删除结点的grandpa节点的左右节点， 回溯到grandpa节点时， 此时递归会直接拿之前grandPa的左右支的key， 
	 *  		来找新的key， 替换old的key， 但是此时grandpa的左右之已经通过balance变了， 却还是使用之前的key值的balance后的节点来替换， 错乱了。 
	 *  			3、目前认为是，递归删除只适合修改待删除节点的父节点的左右节点更新，  上升到grandPa的更新，不适合
	 *  				可以参考avl树的remove验证。 
	 *  		本例子种， 如果使用递归找节点，上溯删除节点的话， 比如删除15-B节点。
	 *  
	 *  删除15 
 * 	            13-B
 *         /            \
 *       8-B             17-B                         25-B                           25-B
 *     /     \          /     \           -->         /    \          -->           /     \
 *   1-B     11-B     15-B    25-R 			        17-R    27-B                  21-R   27-B
 *      \				    /   \                   /   \                        /     \
 *     6-R                21-B   27-B             15-B   21-B                  17-B    22-B
 *                        /   \                          /    \                 /  \
 *                      20-R  22-R                     20-R  22-R             15-B  20-R
 *                      
 *               递归 2层， 先到17-B , 然后左支 15-B ， 然后balance的时候， 把17-B整个树，全换了， 13-B的右支变为25-B了。
 *               1、递归回溯时，   15-B删除，为null，回溯到17-B时， 赋值17-B的左支为null，满足
 *               2、但是回溯到 13-B时， 最开始递归的时候记录的节点值时17 ， 此时balance后的17-B ，  变为只有右支20-R,此时，回溯会把新的17-B赋值给13-B的右支， 虽然balance没问题，
 *               	此时就会发现，递归无法满足节点grandPa(13-B)的左支更新【虽然balance已经完成操作了】
 *        
	     *  参考：https://www.jianshu.com/p/84416644c080
	 * @param key
	 * @return
	 */
	
	public RBTreeNode search(int key,RBTreeNode t) {
		if(t == null) {
			return null;
		}
		while( t != null ) {
			if(key < t.key) {
				t = t.left;
			}else if(key > t.key) {
				t= t.right;
			}else {
			    return t;
			}
		}
		return null;
	}
	public RBTreeNode remove(int key,RBTreeNode t) {
		t = root;  // 从根节点出发
		return remove2(key, t);
	}
	
	public RBTreeNode remove2(int key,RBTreeNode t) {
		t = search(key, t);
		if(t == null) {
			return null;
		}
//		if(key < t.key) {
//			t.left = remove(key, t.left);
//		}else if(key > t.key) {
//			System.out.println("===:"+t.right.key);
//			t.right = remove(key, t.right);
////			System.out.println("===。"+t.right.key);
////			remove(key, t.right);
//		}else {
			// 1.无子节点时
			if(t.left == null && t.right == null) {
				//1.1 【 如果t=红色，且为叶子节点 】。直接删除即可，不会影响黑色节点的数量
				if(t.color == RED) {
					RBTreeNode parent = t.parent;
					if(parent.left != null && parent.left == t) {
						parent.left = null;
					}else {
						parent.right = null;
					}
					t.parent = null;
					t = null;
					return t;
				}else {
				//1.2 【 如果t=黑色，且是叶子节点】。则需要进行删除平衡的操作了
					// 删除平衡操作  
//					t = null ;
					if(t.parent == null) {
						// t为根节点 ，且没有子节点  ,直接删除不需要平衡
						root = null;
						return root ;
					}
					t = getRemoveBalance(t);
					// 删除15节点， 父节点的左支/右支15节点置为null
					if(t.parent.left != null && t.parent.left == t) {
						t.parent.left = null;
					}else {
						t.parent.right = null;
					}
					// 15节点置为null， 其实不修改也不影响？
					t.parent = null;
					t = null;
					return t;
				}
				// 3. 【t=黑色，2个节点】有两个子节点时，与二叉搜索树一样，使用后继节点作为替换的删除节点，情形转至为1或2处理。
			}else if(t.left != null && t.right != null) {
				t.key = findMin(t.right).key; // 右支最小值替换当前节点
				remove2(t.key,t.right);  // 找后继节点，删除后继节点。平衡。
			}else {
				// 2. 只有一个子节点时，【t=黑色，唯一的叶子节点为黑色】（删除节点t只能是黑色，其子节点为红色（且子节点无孩子），否则无法满足红黑树的性质了）。 此时用删除节点的子节点接到父节点，且将子节点颜色涂黑，保证黑色数量。
				RBTreeNode parent = t.parent;
				RBTreeNode newNode;
				if(t.left != null) {
					newNode = t.left;
				}else {
					newNode= t.right;
				}
				if(parent != null) {
					if(parent.left !=null && parent.left == t) {
						parent.left = newNode;
					}else {
						parent.right = newNode;
					}
				}else {
					// 删除节点是根节点，且只有一个节点
					newNode.parent = null;
					newNode.color = BLACK;
					root = newNode;
					return root;
				}
				newNode.parent = parent;
				newNode.color = BLACK;
//				t.parent = null;
				t = null; // 不置为null,好像不影响.
				return newNode; // t为null， 要那新的节点newNode替换了（用parent不行，因为递归进来，是t，后面用newNode替换了t，故返回newNode）
			}
//		}
		return t;
	}
			
	/**			 GP
	 * 		   /    \
	 * 		 P       U
	 * 		/  \
	 *    Nil-b   S
	 *    	   /  \
	 *        SL   SR
	 *        
	 *  红黑树  平衡操作  -- 删除黑色节点（且为叶子节点）之后的平衡操作
	 *    Nil-b即删除  D节点后，  补上去的待平衡节点 Nil。
	 *  	1、删除节点（D）为根节点， 不需要平衡
	 *  	2、S(兄弟)为黑色
	 *  		2.1、S子节点全黑
	 *  			2.1.1、P(父节点)为红色
	 *  					P与S颜色互换，平衡
	 * 				2.1.2 P为黑色
	 * 						此时将S涂红，父节点p作为新的平衡节点N，递归上去处理。
	 * 		    2.2  兄弟S子节点不全为黑		
	 *  
     *     --   参考资料： https://www.jianshu.com/p/84416644c080
	 *  			
	 * @param t
	 * @return
	 */
	public RBTreeNode getRemoveBalance(RBTreeNode t) {
		// 1、当前节点为根节点
		if(t.parent == null) {
			return t;
		}
		RBTreeNode parent = t.parent;
		RBTreeNode Slibing;  // 兄弟节点
//		RBTreeNode Slibing_Left;  // 兄弟的左孩子
//		RBTreeNode Slibing_right;  // 兄弟的右孩子
//		RBTreeNode grandPa = parent.parent;
		String slibling_flag ; // 兄弟节点 是左支 or 右支  。    left or right 
		if(parent.left != null && parent.left == t) {
			Slibing = parent.right; // 兄弟 = 右支
			slibling_flag = RIGHT;  
		}else{
			Slibing = parent.left; // 兄弟 = 左支
			slibling_flag = LEFT;
		}
		// 2 、兄弟节点=  黑色
		if(Slibing.color == BLACK) {
			// 2.1、兄弟节点的子节点全为黑色 (即S, SL,SR都为黑， 此时 SL,SR必为nil ,这样以P为节点的子树，才符合红黑树的特性。)
			/**
			 * 			P
			 *        /   \
	 		 *       D-b  S-b
			 *      /     /  \
			 *     nil   nil  nil
			 */
			if( Slibing.left == null && Slibing.right == null ) {
				   // 2.1.1、 父节点为黑色
				 if(parent.color == BLACK) {
					  //此时将S涂红，父节点作为新的平衡节点N，递归上去处理。
					 Slibing.color = RED;
					 parent = getRemoveBalance(parent);
				 }else { // 2.1.2  、父节点为红色
					 Slibing.color = RED;
					 parent.color = BLACK;
					 return t;
				 }
			}else {
				// 2.2 兄弟节点不全为黑
				/** 	    P				 P
				 *        /   \			   /  \
		 		 *       nil   S-b       nil   S-b
				 *            /   \            /  \
	     		 *          SL-R   nil      nil    SR-R             
				 */
				// 2.2.1  单旋 
				// 2.2.1.1    S=黑色 + 左支  ， SL = 红色   ， SR 可有可无（有则为红色）   【平衡思路 h(P->S->叶子)不变（因为SL涂黑补回来了），h(P->N->叶子)+1（因为多了个黑色P）。】 
				if(slibling_flag == LEFT && Slibing.left != null && Slibing.left.color == RED) { 
					boolean color = parent.color;  // S 和P颜色互换 [通常旋转后，新的P节点往往都会涂成原P的颜色：一是为了让GP-P不会颜色冲突；二是保持经过P的路径黑色数量不变。]
					parent.color = Slibing.color;
					Slibing.color = color;
					Slibing.left.color = BLACK;
					//以P为支点右旋；交换P和S颜色，SL涂黑；平衡结束。
					parent = getLLbalance(parent); // P右旋
					return t;
				}
				 // 2.2.1.2  S=黑色 + 右支支  ， SR = 红色 ，  SL可有可无 (有则为红色） 
				if(slibling_flag == RIGHT && Slibing.right != null && Slibing.right.color == RED) {
				    // 以P为支点左旋；交换P和S颜色（S涂为P原颜色，P涂黑），SR涂黑；平衡结束。
					boolean color = parent.color;  // S 和P颜色互换 [通常旋转后，新的P节点往往都会涂成原P的颜色：一是为了让GP-P不会颜色冲突；二是保持经过P的路径黑色数量不变。]
					parent.color = Slibing.color;
					Slibing.color = color;
					Slibing.right.color = BLACK;
					parent = getRRbalance(parent); // P左旋
					return t;
				}
				// 2.2.2  双旋转   S为左子，SL为黑 ， SR红；S为右子，SL红  ，SR=黑
				// 2.2.2.1  S为左子，SL为黑 ， SR红 （此时SL必为nil）
				if(slibling_flag == LEFT && Slibing.right != null && Slibing.right.color == RED  && Slibing.left == null) {
					//以S为支点左旋，交换S和SR颜色（SR涂黑，S涂红） ，此时转至情形2.2.1-(1) S左-SL红 进行处理。
					boolean color = Slibing.color;  
					Slibing.color = Slibing.right.color;
					Slibing.right.color = color;
					Slibing = getRRbalance(Slibing);  // 左旋 ，，先旋转还是先变色？？ 先变色？？？
					//以 P右旋，P和S颜色互换，SL涂黑色，
					color = Slibing.parent.color;
					Slibing.parent.color = Slibing.color;
					Slibing.color = color;
					Slibing.left.color = BLACK;
					Slibing.parent = getLLbalance(Slibing.parent);
					return t ; // P右旋
				}
				// 2.2.2.2  S为右子，SL红  ，SR=黑 （此时SR必为nil）
				if(slibling_flag == RIGHT && Slibing.left != null && Slibing.left.color == RED  && Slibing.right == null) {
					//以S为支点右旋，交换S和SL颜色（SL涂黑，S涂红），此时转至2.2.1-(2) S右-SR红进行处理
					boolean color = Slibing.color;  
					Slibing.color = Slibing.left.color;
					Slibing.left.color = color;
					Slibing = getLLbalance(Slibing);  // 右旋 ，，先旋转还是先变色？？ 先变色？？？
					//以 P左旋，P和S颜色互换，SR涂黑色，
					color = Slibing.parent.color;
					Slibing.parent.color = Slibing.color;
					Slibing.color = color;
					Slibing.right.color = BLACK;
					Slibing.parent = getRRbalance(Slibing.parent);
					return  t; // P左旋
				}
			}
		}else {
			// 3、兄弟节点为红色
			//3.1  交换P和S的颜色（或者直接S涂黑，P涂红） 
			Slibing.color = BLACK;
			parent.color = RED;
			if(slibling_flag == LEFT) {
				// S为左支，p右旋
				parent = getLLbalance(parent);
			}else {
				// S为右支，p左旋
				parent = getRRbalance(parent);
			}
			// 转为兄弟为黑色处理.//.
			  return getRemoveBalance(t);
		}
		return t;
	}
	
	// 查找最小值
	public RBTreeNode findMin(RBTreeNode root){
		if(root == null) { return null;}
		while(root.left != null) {
			root = root.left;
		}
		return root;
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
	    }else {
	    	// 更新根节点
	    	root = newNode;
	    	newNode.parent = null;
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
	    }else {
	    	// 更新根节点
	    	root = newNode;
	    	newNode.parent = null;
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
	        /**
	         * 	  -- 插入21前 
	         * 	            13-B
	         *         /            \
	         *       8-R             17-R
	         *     /     \          /     \       
	         *   1-B     11-B     15-B   25-B 
	         *      \				    /   \ 
	         *     6-R                22-R  27-R
	         * 
	         * 	   -- 插入21之后
	         * 	            13-B
	         *         /            \
	         *       8-B             17-B
	         *     /     \          /     \       
	         *   1-B     11-B     15-B    25-R 
	         *      \				    /   \ 
	         *     6-R                22-B  27-B
	         *                        /
	         *                      21-R
	         */
//	        tree.insert(21);   // ,递归  【parent = red, uncle = red】
	        tree.insert(20);   // ,递归  【parent = red, uncle = red】
	        /**
	         *   -->   插入19之前
	         *   
	         *   	        13-B
	         *         /            \
	         *       8-B             17-B
	         *     /     \          /     \       
	         *   1-B     11-B     15-B    25-R 
	         *      \				    /   \ 
	         *     6-R                22-B  27-B
	         *                        /
	         *                      21-R
	         *                      
	         *   -->   插入19之后
	         *   
	         *   	        13-B
	         *         /            \
	         *       8-B             17-B
	         *     /     \          /     \       
	         *   1-B     11-B     15-B    25-R          
	         *      \				    /   \ 
	         *     6-R                22-B  27-B
	         *                        /
	         *                      21-R
	         *                      /
	         *                    19-R 	                              
	         * 					
	         * 
				         * -- step1 :    ---> LL :   21-B,  22-R  ,右旋  【parent = red, uncle = black, LL型】
				         *   	        13-B
				         *         /            \
				         *       8-B             17-B
				         *     /     \          /     \       
				         *   1-B     11-B     15-B    25-R          
				         *      \				    /   \ 
				         *     6-R                21-B  27-B
				         *                        /  \
				         *                      19-R  22-R
				         	*          满足：
	         *               
	         *               
	         */
//	        tree.insert(19);   // 插入21后，此时插入19， 符合。右旋  【parent = red, uncle = black, LL型】
	        /**
	         * 
	         * 	   -- 插入21之前
	         * 	           13-B
	         *         /            \
	         *       8-B             17-B
	         *     /     \          /     \       
	         *   1-B     11-B     15-B    25-R 
	         *      \				    /   \ 
	         *     6-R                22-B  27-B
	         *                        /
	         *                      20-R
	         *                      
	         * 	   -- 插入21之后
	         * 	           13-B
	         *         /            \
	         *       8-B             17-B
	         *     /     \          /     \       
	         *   1-B     11-B     15-B    25-R 
	         *      \				    /   \ 
	         *     6-R                22-B  27-B
	         *                        /
	         *                      20-R
	         *                         	\
	         *                          21-R
				       
				         *   ---> step1:  LR: 1-、  插入节点（newNode） 染为 Black , grandPa染为 Red 
				         *   			      2-、  parent 左旋转，
				         * 	            13-B
				         *         /            \
				         *       8-B             17-B
				         *     /     \          /     \       
				         *   1-B     11-B     15-B    25-R 
				         *      \				    /   \ 
				         *     6-R                22-R  27-B
				         *                        /
				         *                      21-B
				         *                      /   
				         *                    20-R   
				         *                    
				         *   ---> step2:  LR: 1-、 grandpa 右旋转
				         *   			      
				         * 	            13-B
				         *         /            \
				         *       8-B             17-B
				         *     /     \          /     \       
				         *   1-B     11-B     15-B    25-R 
				         *      \				    /   \ 
				         *     6-R                21-B   27-B
				         *                        /   \
				         *                      20-R  22-R
				         *                      
				         *       *          满足：
	         *                          
	         */
	        tree.insert(21);  // 插入20后，此时插入21 ，符合， LR 【【parent = red, uncle = black, 】LR情况:   parent = grandpa.left , newNode = parent.right】
//	        tree.insert(14); // 【parent = Black】  新节点设为红色即可。
//	        tree.remove(22, insert); // 测试1.1   情况【   删除节点为红色 ，没有子节点】
//	        tree.remove(1, insert);  // 测试 2 情况  【删除节点为黑色， 一个子节点】    
	        /**
	         * 
		         * 删除15 
	 * 	            13-B
	 *         /            \
	 *       8-B             17-B                         25-B                           25-B
	 *     /     \          /     \           -->         /    \          -->           /     \
	 *   1-B     11-B     15-B    25-R 			        17-R    27-B                  21-R   27-B
	 *      \				    /   \                   /   \                        /     \
	 *     6-R                21-B   27-B             15-B   21-B                  17-B    22-B
	 *                        /   \                          /    \                 /  \
	 *                      20-R  22-R                     20-R  22-R             15-B  20-R
	         */
//	        tree.remove(15, insert);  //  测试1.2   [  删除节点为黑色 , 没有子节点]   -->， 3.2  兄红（25-R） ， 转 兄黑(21-B) , --> 2.2  兄弟节点不全黑。  【兄在右，  SR红（SL为黑且为nil或红）】 2.2.1  。
	        
	        /**
	         * 
			         * 删除17   									找后继，替换，删除后继
		 * 	            13-B						  13-B
		 *         /            \                            \
		 *       8-B             17-B(d)                    20-B(后继替换)                         
		 *     /     \          /     \           -->         /    \         
		 *   1-B     11-B     15-B    25-R 			        15-B    25-R                 
		 *      \				    /   \                 		  /   \                      
		 *     6-R                21-B   27-B           		 21-B  27-B                  
		 *                        /   \                              \              
		 *                      20-R  22-R                           22-R          
		 *                      
	      */
//	        tree.remove(17, insert);  // 测试删除两个子节点， 删除后继节点，  且后记节点属于1.1情况
	        
	        /**
	         * 
		 删除25  										后继节点替换25-R					 删除后继节点 27-B （兄左， SL为红（SR为红））  【P右旋，p和s交换颜色，SL涂黑。】
		 * 	            13-B						     13-B							13-B
		 *         /            \                            \							    \					
		 *       8-B             17-B                          17-B                          17-B
		 *     /     \          /     \           -->         /    \             -->         /    \
		 *   1-B     11-B     15-B    25-R(d)			     15-B  27-R                  15-B     21-R
		 *      \				    /   \                 		   /   \                           /   \ 
		 *     6-R                21-B   27-B           		 21-B  27-B                     20-B   27-B   
		 *                        /   \                          /   \                                 /   \
		 *                      20-R  22-R                     20-R  22-R                            22-R  27-B(d) 
			         */
//	        tree.remove(25, insert); // 测试删除两个子节点， 删除后继节点 ，后继节点是黑色无子节点，  数据2.2.1（兄黑，不全黑，兄右两个R） 2.2.1 【（兄左， SL为红（SR为红或者SR为黑且为nil？））】
	       
	        
	        /**
	         * 
				         *  删除 11  ，【2.2.2.1】[兄左，兄黑，SL为黑（且肯定为nil），SR必须为红（不存在SR为黑，如果为黑，此时应该属于2.1的情况，兄全黑）,]
												
															  S左旋[6-B]，S和SR互换颜色 ，转至2.2.1.1           P右旋（8-B），P和S颜色互换，SL涂黑色，
			  * 	        13-B						     	      13-B							      13-B		
			 *         /            \                                /						   		     /				
			 *       8-B             17-B                         8-B                                  6-B
			 *     /     \          /     \           -->         /    \             	-->           /   \
			 *   1-B     11-B(d)   15-B    25-R			        6-B  11-B(d)                       1-B    8-B
			 *      \				    /   \                 	 /  	                                     \
			 *     6-R                21-B   27-B              1-R 	                                         11-B(d)
			 *                        /   \                         
			 *                      20-R  22-R                   
	         * 
	         */
//	        tree.remove(11, insert);  // 测试 2.2.2.1 [兄左，兄黑，SL为黑（且肯定为nil），SR必须为红（不存在SR为黑，如果为黑，此时应该属于2.1的情况，兄全黑）]      --> 同理2.2.2.2  [兄右，兄黑，SR为黑（且肯定为nil），SL必为红（不存在SL为黑，如果为黑，此时应该属于2.1的情况，兄全黑）]
	        
	       /**
	        * 
				 删除节点1  ----，测试 2.2.2.2（前提 删除6，新增10，  构造2,2,2,2的情况）
														   S右旋[11-B] ,S和SL互换颜色 ，转至2.2.1.2       //以 P左旋，P和S颜色互换，SR涂黑色，
			
			  * 	        13-B						     	      13-B							      13-B		
			 *         /            \                                /						   		     /				
			 *       8-B             17-B                         8-B                                  10-B
			 *     /     \          /     \           -->         /    \             	  -->           /   \
			 *   1-B(d)  11-B    15-B    25-R			       1-B(d)   10-B                         8-B    11-B
			 *           / 		   		 /   \                 	  		    \	                      /        
			 *         10-R             21-B   27-B                         11-R 	                1-B(b)                     
			 *                        /   \                         
			 *                      20-R  22-R          
	        * 
	        */
	        	// 测试 2.2.2.2 
//		        tree.remove(6, insert);
//		        tree.insert(10);
//		        tree.remove(1, insert);
	        
	      
	        /**
	         * 		- 构造2.1.1  (兄全黑  ， 父 红 )	
	         *        tree.remove(20, insert);
	         *        tree.remove(22, insert);
	         *        tree.remove(21, insert);
																	S和P颜色互换	
			  * 	        13-B						     	      13-B							     
			 *         /            \                               	  \							   		 				
			 *       8-B             17-B                                 17-B                            
			 *     /     \          /     \           -->         		 /    \             	  
			 *   1-B     11-B    15-B    25-R			              15-B    25-B                     
			 *      \       		   /    \                 	  		      /    \	                    
			 *      6-R              21-B(d) 27-B                         21-B(d)  27-R                               
			 *                                                
			 */
//	        	tree.remove(20, insert);
//	        	tree.remove(22, insert);	
//	        	tree.remove(21, insert);	
	        
	        
	    /**
	    	测试 2.1.2 (兄全黑  ， 父黑)	
    	 *        tree.remove(6, insert);
    	 *        tree.remove(1, insert);
    										    //此时将S涂红，父节点作为新的平衡节点N，递归上去处理。     处理8-B的平衡 ，转为 2.2.1.2 【兄右，兄黑，SR红】
	    																										【以p左旋 ，p和s互换颜色，SR涂黑】
	     * 	            13-B						             13-B													   17-B 
	     *         /            \                             /          \										      /            \
	     *       8-B             17-B                        8-B          17-B                                      13-B          25-B
	     *     /     \          /     \           -->       /    \           ..    -->   						   /    \          /   \    
	     *   1-B(d)  11-B    15-B    25-R 			      1-B(d)  11-R                                          8-B     15-B     21-B   27-B 
	     *      				      /   \                 		                                           /   \            /   \ 
	     *                         21-B   27-B           		               						       1-B(d)  11-R       20-R  22-R
	     *                        /   \                                      
	     *                      20-R  22-R         
	     */
//	   	         tree.remove(6, insert);
//		         tree.remove(1, insert);
	        
	        /**
	         * 
			         * 删除15                         															删除后继节点，变色，旋转。
		 * 	            13-B(d)                              15-B(后继节点值替换)           15-B 
		 *         /            \                                \                               \
		 *       8-B             17-B                          25-B                           25-B
		 *     /     \          /     \           -->         /    \          -->           /     \
		 *   1-B     11-B     15-B    25-R 			        17-R    27-B                  21-R   27-B
		 *      \				    /   \                   /   \                        /     \
		 *     6-R                21-B   27-B           15-B(d) 21-B                   17-B    22-B
		 *                        /   \                          /    \                   \
		 *                      20-R  22-R                     20-R  22-R                 20-R
		 *                      
		 *       *          满足：
		 */ 
//	        tree.remove(13, insert);  //删除根节点。两个孩子。
		 
			 /**
			  * 
			  *    -- 测试 删除根节点 
			  *    		1、root没有孩子
			  *         2、root1个 ， 2 个 孩子的情况
	//		  */
	//		    RBTreeNode insert = tree.insert(13);
	//		    tree.insert(8);
	//		    tree.insert(14);
	//	        tree.remove(13, insert);
	        tree.MiddleSearch(tree.root, 1);
	        
	
	}
}
