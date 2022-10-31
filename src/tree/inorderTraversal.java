package tree;

import java.util.ArrayList;
import java.util.List;
/**
 *  前 中 后序遍历二叉树
 * @author wang.ying.nan
 *
 */
public class inorderTraversal {
	class TreeNode {
	    int val;
	    TreeNode left;
	    TreeNode right;
	    TreeNode() {}
	    TreeNode(int val) { this.val = val; }
	    TreeNode(int val, TreeNode left, TreeNode right) {
	       this.val = val;
	        this.left = left;
	        this.right = right;
	    }
	}
	// 前中后序  demo
	    public static List<Integer> inorderTraversal2(TreeNode root,List<Integer> list) {
	            if(root == null){
	                return list;
	            }
	            list.add(root.val);
	            inorderTraversal2(root.left, list);
//	            list.add(root.val);
	            inorderTraversal2(root.right, list);
//	            list.add(root.val);
	            return list;
	    }
	    /**
	     * 
 	2 
  1   0 
0  0 
	     * @param args
	     */
	 public static void main(String[] args) {
	  	 inorderTraversal i1 = new inorderTraversal();
	    	TreeNode root = i1.new TreeNode(1,i1.new TreeNode(),i1.new TreeNode());
	    	TreeNode root2 = i1.new TreeNode(2,root,i1.new TreeNode());
	    	ArrayList<Integer> list = new ArrayList<Integer>();
	    	System.out.println(inorderTraversal2(root2,list));
	}
   
   
}