package LeetCode;

import javax.swing.tree.TreeNode;

import tree.Node;

public class RevertTree {
	  public Node mirrorTree1(Node root) {
	        if(root == null ){return null;}
	           Node tmp  = root.left  ;
	           root.left = root.right  ;
	           root.right = tmp  ;
	           mirrorTree1(root.right);
	           mirrorTree1(root.left);
	           return root;
	    }


	    public Node mirrorTree2(Node root) {
	        if(root == null) return null;
	        Node tmp = root.left;
	        root.left = mirrorTree2(root.right);
	        root.right = mirrorTree2(tmp);
	        return root;
	    }

}
