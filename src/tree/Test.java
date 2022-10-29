package tree;

import tree.AvlTree.Node;

public class Test {
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
	 
	 public static void main(String[] args) {
		Node node1 = new Test().new Node(4);
		node1.height = 1;
		node1.value = 100;
		Node node2 = new Test().new Node(4);
		node2.height = 2;
		node2.value = 200;
		System.out.println(node2.height);
		node1 = node2;
		System.out.println(node1.height);
		System.out.println(node1.value);
		node2.height = 3;
		node2.value = 300;
		System.out.println(node1.height); 
		System.out.println(node1.value);
		
		
		
		String a =  new String("A");
		String b = new String("B");
		System.out.println(a);
		a = b;
		b = new String("C");
		System.out.println(a);
	}
}
