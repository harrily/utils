package sort;
/**
 * 
 * 双向链表
 *  双向链表的每一个结点都有一条指向其后继结点的next链和一条指向其前结点的pre链。
 *  双向链表既可以从第一项开始遍历也可以从最后一项开始往前遍历，双向链表可以用下图表示：
 *  参考资料：https://blog.csdn.net/timewilltell12/article/details/123704947
 * @author wangyingnan
 *
 */
public class DoubleLinkList {

	class Node{
		Node next ;
		Node pre;
		int val;
		public Node(int val) {
			this.val = val;
		}
		public Node(int val,Node next ,Node pre) {
			this.val = val;
			this.next = next ;
			this.pre = pre;
		}
	}
	Node head;
	public Node insert(int val) {
		if(head == null) {
			head = new Node(val);
			head.next = head;
			head.pre = head;
			return head;
		}
		Node begin = head;
		while(begin.next != head) {
			begin = begin.next;
		}
		Node node = new Node(val,head,begin);
		head.pre = node;
		begin.next = node;
		return node;
	}
	
	public static void main(String[] args) {
		DoubleLinkList doubleLinkList = new DoubleLinkList();
		Node insert = doubleLinkList.insert(1);
		doubleLinkList.insert(2);
		doubleLinkList.insert(3);
		doubleLinkList.insert(4);
		doubleLinkList.insert(5);
		Node head2 = doubleLinkList.head;
		
		while(head2.next != doubleLinkList.head) {
			System.out.println(head2.val);
			head2 = head2.next;
			if(head2.next == doubleLinkList.head) {
				System.out.println(head2.val);
			}
		}
//		System.out.println(doubleLinkList.head.pre.val);
		
	}
}
