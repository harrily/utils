package tree;

import java.util.ArrayList;
import java.util.List;

/**
 * 二叉排序树（搜索树）
 * 从任意节点开始，节点左侧节点值总比节点右侧值要小。
 * 
 * 参考资料： https://blog.csdn.net/qq_40693171/article/details/99699862
 *  avl树： https://blog.csdn.net/qq_40693171/article/details/100051631
 *  数的高度，深度 ： https://blog.csdn.net/weixin_41969587/article/details/88420110
 *  	https://www.cnblogs.com/jianglinliu/p/11197715.html
 */
public class BinarySortTree {
	public static void main(String[] args) {
		 BinarySortTree treeTest = new BinarySortTree();
		 // 插入测试
		 Node node = treeTest.insert(15);
		 treeTest.insert(6);
		 treeTest.insert(23);
		 treeTest.insert(4);
		 treeTest.insert(7);
		 treeTest.insert(5);
		 treeTest.insert(19);
		 treeTest.insert(17);
//		 treeTest.insert(21);
		 treeTest.insert(71);
		 treeTest.insert(50);
		 treeTest.insert(75);
		 System.out.println(treeTest.findMax(node).value);
		 List<Integer> list = new ArrayList<Integer>();
		 // 前  [15, 6, 4, 5, 7, 23, 19, 17, 71, 50, 75]
		 // 后 [5, 4, 7, 6, 17, 19, 50, 75, 71, 23, 15]
//		 System.out.println(treeTest.MiddleSearch(node,list,2));
		 // 删除while测试    [15, 6, 4, 5, 7, 19, 17, 71, 50, 75]  左大
//		 System.out.println(treeTest.Delete(23));  
		 // // 删除递归 测试  左大 
		 System.out.println(treeTest.removeByLeftMax(5, node));  
		 // 官网 demo[15, 6, 4, 5, 7, 50, 19, 17, 71, 75] 右小
//		 System.out.println(treeTest.remove(71, node));  
		 System.out.println(treeTest.MiddleSearch(node,list,1));
		 
		 
	}
	
	Node root;//根
	
	/**
	一、 如果依次插入 4,5,6,7  退化为链表
	   	 4
	n          5
  n    n      n     6
 n n  n n    n n   n  7
 
            二、 依次插入  6 , 4 ,5 ,7
          6 
        4    7
      n  5  n  n
            
       前序：  中左右      [6, 4, 5, 7] 
       后序 ：  左右中    [5, 4, 7, 6]
       中序：   左中右     [4, 5, 6, 7]
  		
  		
	 * 前中后序遍历
	 * @param node
	 * @param list
	 * @return
	 */
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
	
	public Node findMin(Node root){
		if(root == null) { return null;}
		while(root.left != null) {
			root = root.left;
		}
		return root;
	}
	
	public Node findMax(Node root){
		if(root == null) { return null;}
		while(root.right != null) {
			root = root.right;
		}
		return root;
	}
	
	public boolean isContains(int x){
		Node current = root;
		if(root == null) { return false;}
		while(current.value != x && current != null) {
			if(x < current.value) {current = current.left;}
			if(x > current.value) {current = current.right;}
			if(current == null){return false;}
		}
		if(current.value == x) {return true;}
		return false;
	}
	
	public Node insert (int x) {
		Node current = root;
		if(root == null) { root = new Node(x); return root;}
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
	
	
	public boolean Delete(int x) {
		
		Node current = root ;
		if(root == null) {
			return false;
		}
		Node parent = null ;  // 父节点
		int flag = 0 ;  // 替换节点是父节点的  1 左节点  2 右节点
		while(current != null && current.value != x) {
			if( x < current.value ) {
				if ( current.left != null && current.left.value == x   ) {
					parent = current;
					flag = 1;
				}
				if(current.right != null  && current.right.value == x    ) {
					parent = current;
					flag = 2;
				}
				
				current = current.left;
			} 
			if( x > current.value ) {
				if( current.left != null  && current.left.value == x  ) {
					parent = current;
					flag = 1;
				}
				if(   current.right != null  && current.right.value == x  ) {
					parent = current;
					flag = 2;
				}
				current = current.right;
			} 
		}
		if(current != null && current.value == x) {
			//1、待删除节点， 左右支都为null.  
			// 找到  待删除节点的父节点， 然后删除父节点对应的左/右值，即删除当前节点。
			if(current.left == null && current.right == null) {
				if(flag == 1 ) {
					parent.left = null;
				}
				if(flag == 2 ) {
					parent.right = null;
				}
				return true;
//				current = null;
//				return true;
			// 2、待删除节点，左右支都有值。 【可以找到左支的最大值，或右支最小值 替换】
			}else if(current.left != null && current.right != null) {
				Node findMax = findMax(current.left);  
				Node right = current.right;  
				current.value = findMax.value;  // 当前节点值，替换为 找到的左支最大值
				current.left = findMax.left; // 左节点已经变味 找到左支最大的值的左节点
				current.right = right;// 右节点还是当前节点的右节点
				return true;
			}else{
				//  3、待删除节点只有一个节点， 左支/右支，  拿左支或右支替换即可。
				Node tmp ;
				if(current.left != null) {
					tmp = current.left;
					current.value = tmp.value;
					current.left = tmp.left;
					current.right = tmp.right;
				}else if(current.right != null) {
					tmp  = current.right;
					current.value = tmp.value;
					current.left = tmp.left;
					current.right = tmp.right;
				}
				return true;
			}
		}
		
		return false;
		
	}
	
	// 递归 删除节点   ,  使用右节点最小值，替换
	public Node remove(int x, Node t)
	{
		if (t == null) {
			return null;
		}
		if (x < t.value) {
			System.out.println("左---------");
			t.left = remove(x, t.left);
			System.out.println("左+++++++++");
		} else if (x > t.value) {
			System.out.println("右   --------");
			t.right = remove(x, t.right);
			System.out.println("右  +++++++++");
		} else if (t.left != null && t.right != null)// 左右节点均不空
		{
			t.value = findMin(t.right).value;// 找到右侧最小值替代
			t.right = remove(t.value, t.right);  // 更新当前节点右节点，删除 需要替换的值。（即右侧最小值节点）
		} else // 左右单空或者左右都空
		{
			if (t.left == null && t.right == null) {
				t = null;
			} else if (t.right != null) {
				t = t.right;
			} else if (t.left != null) {
				t = t.left;
			}
			return t;
		}
		return t;
	}
	
	// 递归 删除节点   ,  使用左节点最大值，替换
	public Node removeByLeftMax(int x ,Node t) {
		if(t == null) {
			return null;
		}
		if(x < t.value) {
			// 必须赋值  ,要不然后续替换后的值，返回不到上一层。
			t.left = removeByLeftMax(x,t.left);
		}else if(x > t.value) {
			// 必须赋值
			t.right = removeByLeftMax(x,t.right);
		}else {
			if( t.left != null && t.right != null) {
				// 必须赋值
				t.value = findMax(t.left).value;
				// 必须赋值
				t.left = removeByLeftMax(t.value, t.left);
			}else {
				if (t.left == null && t.right == null) {
					 t = null;
				}else if (t.right != null) {
					 t = t.right;
				}else if (t.left != null) {
					 t = t.left;
				}
//				// 为什么要返回t????  可以不用return
//				return t;
			}
		}
		return t;
	}
		
}
