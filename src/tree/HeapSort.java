package tree;

import java.util.List;

/**
 * 
 * 堆排序
 * 参考资料：https://blog.csdn.net/weixin_51609435/article/details/122982075
 * @author wang.ying.nan
 *
 */
public class HeapSort {

	class Node{
		Node left ;
		Node right;
		Node parent;
		int key;
		public Node(int key,Node left ,Node right) {
			// TODO Auto-generated constructor stub
			this.left = left;
			this.right = right;
			this.key = key;
		}
	}
	/**
	 * 完全二叉树
			  	           0
			     1                2  
			 3       4         5      6
		   7   8  9   10    11  12  13  14	  
		   
		  1、最后一个非叶子节点元素(索引)下标  =  size / 2  -1 
		  		比如 size = 2  , 则0下标是
		  		   size = 4   , 则1 
		  		   size = 8    ,则3  
		  		   size = 5   , 数组 [0,1,2,3,4]   ，则  5/2 -1 =  1 ,(即2下标为最后一个非叶子节点，) [下取整]
		  		    size = 6  , 数组 [0,1,2,3,4,5]   ，则  6/2 -1 =  2 ,(即2下标为最后一个非叶子节点，)
		  		    
		  		资料： 于一个完全二叉树，在填满的情况下（非叶子节点都有两个子节点），每一层的元素个数是上一层的二倍，根节点数量是1，所以最后一层的节点数量，一定是之前所有层节点总数+1，
		  			所以，我们能找到最后一层的第一个节点的索引，即节点总数/2（根节点索引为0），这也就是第一个叶子节点，所以第一个非叶子节点的索引就是第一个叶子结点的索引-1。
		  			那么对于填不满的二叉树呢？这个计算方式仍然适用，当我们从上往下，从左往右填充二叉树的过程中，第一个叶子节点，一定是序列长度/2，所以第最后一个非叶子节点的索引就是 arr.len / 2 -1，
		  			
				  	end=最后一行size
					all=end之前所有size
					size = 整个size
						end + all + 1 = size 
						end = all +1 
						size / 2 =  all + 1   
							siez/ 2  - 1 = all  得出最后一个非叶子节点索引。
						size / 2 =  end  得出第一个叶子节点索引		

	 * @param arr
	 * @return
	 */
	public int[] sort(int[] arr){
		// 找到所有的非叶节点。[先找到最后一个非叶节点，然后上溯至root， ]
		int temp;
		int length = arr.length;
		int i = arr.length/2 -1 ;
		while(i >= 0 ) {
			for(int j = i ; j >=0; j--) {
	//			System.out.println(j);
				int j1 = j * 2 + 1; 
				int index = 0 ;
				//数组长度减1后，判断右叶子是否存在，存在对比，反之使用父节点对比
				if(j1+1 <= length-1) {
					if( arr[j1] < arr[j1+1]) {
						index = j1+1;
					}else {
						index = j1;
					}
				}else {
					index = j1;
				}
				// 置当前堆顶为最大值。
				if(arr[index] > arr[j] ) {
					temp = arr[index];
					arr[index] = arr[j];
					arr[j] = temp;
				}
			}
			// 堆顶与末尾元素互换
			temp = arr[0];
			arr[0] = arr[length -1 ];
			arr[length -1 ] = temp;
			//数组长度 -1
			length--;
			// 更新i值
			i = length/2 -1 ;
//			System.out.println(length + "==" + i);
		}
		return arr;
	}
		
	public static void main(String[] args) {
//		int [] arr = new int[] {4,6,3,5,9,7,123,45,124,2322,35,23,2,-1};
//		int[] sort = new HeapSort().sort(arr);
//		for(int i : sort) {
//			System.out.println(i);
//		}
		
		
		 int [] test = new int[1000];
		 for(int j = 0 ;j<100; j++) {
			 test[j] = (int)(Math.random()*100-1);;
		 }
		 int[] sort2 = new HeapSort().sort(test);
		 for(int i1 : sort2) {
				System.out.println(i1);
			}
		/**
		 int i = 1000;
		 int [] test = new int[1000];
		 for(int j = 0 ;j<1000; j++) {
			 test[j] = i;
			 i-- ;
		 }
		 int[] sort2 = new HeapSort().sort(test);
		 for(int i1 : sort2) {
				System.out.println(i);
			}
		**/
		
	}
}
