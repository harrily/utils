package tree;

import java.util.ArrayDeque;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Queue;
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
	    public List<Integer> inorderTraversal2(TreeNode root,List<Integer> list) {
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
	     * 	  -  二叉树层序遍历 
	     */
	   public List<Integer> levelOrderTraversal(TreeNode root,List<Integer> list) {
		   Queue<TreeNode> quene = new ArrayDeque<TreeNode> ();
		   if(root == null) {
			   return null;
		   }else {
			   quene.add(root);
		   }
		   while(!quene.isEmpty()) {
			   TreeNode poll = quene.poll();
			   if(poll.left != null) {
				   quene.add(poll.left);
			   }
			   if(poll.right != null) {
				   quene.add(poll.right);
			   }
			  list.add(poll.val);
			  System.out.println(poll.val);
		   }
		   return list;
	   }
	   
	   /**
	     * 	  -  二叉树层序遍历  分树杈打印
	     * [[2], [1, 0], [3, 4]] 
	     */
	   public List<List<Integer>> levelOrderTraversal2(TreeNode root,List<Integer> list) {
		   Queue<TreeNode> quene = new ArrayDeque<TreeNode> ();
		   List<List<Integer>> list1 = new ArrayList<List<Integer>>();
		   
		   if(root == null) {
			   return null;
		   }else {
			   quene.add(root);
		   }
		   while(!quene.isEmpty()) {
			   ArrayList<Integer> list2 = new ArrayList<Integer>();
			   int size = quene.size();
			   // 左右支，循环遍历，  根据队列当前大小，  遍历
			   for(int i = 0; i < size; ++i) {
				   TreeNode poll = quene.poll();
				   if(poll.left != null) {
					   quene.add(poll.left);
				   }
				   if(poll.right != null) {
					   quene.add(poll.right);
				   }
				  list2.add(poll.val);
				  System.out.println(poll.val);
			   }
			   list1.add(list2);
		   }
		   return list1;
	   }
	    
	    /**
	     * 
 	2 
  1   0 
3  4 
	     * @param args
	     */
	 public static void main(String[] args) {
	  	 	inorderTraversal i1 = new inorderTraversal();
	  	 	TreeNode treeNode1 = i1.new TreeNode(3,null,null);
	  		TreeNode treeNode2 = i1.new TreeNode(4,null,null);
	    	TreeNode root = i1.new TreeNode(1,treeNode1,treeNode2);
	    	TreeNode root2 = i1.new TreeNode(2,root,null);
	    	ArrayList<Integer> list = new ArrayList<Integer>();
//	    	System.out.println(i1.inorderTraversal2(root2,list));
	    	System.out.println(i1.levelOrderTraversal2(root2, list));
	}
   
   
}