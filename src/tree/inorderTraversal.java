package tree;

import java.util.ArrayList;
import java.util.List;

public class inorderTraversal {
	  
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
	    	TreeNode root = new TreeNode(1,new TreeNode(),new TreeNode());
	    	TreeNode root2 = new TreeNode(2,root,new TreeNode());
	    	ArrayList<Integer> list = new ArrayList<Integer>();
	    	System.out.println(inorderTraversal2(root2,list));
	}
   
   
}