package tree;

/**
 * 二叉排序树（搜索树）
 * 从任意节点开始，节点左侧节点值总比节点右侧值要小。
 */
public class TreeTest {
	Node root;//根
	
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
	
	public boolean insert (int x) {
		
		
		return false;
	}
	
	
		
}
