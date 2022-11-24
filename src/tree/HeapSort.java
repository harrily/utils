package tree;

import java.util.Arrays;
import java.util.List;

/**
 * 
 * 堆排序
 * 
1、 将待排序序列构造成一个大顶堆
2、此时，整个序列的最大值就是堆顶的根节点。
3、将其与末尾元素进行交换，此时末尾就为最大值。
4、然后将剩余n-1个元素重新构造成一个堆，这样会得到n个元素的次小值。如此反复执行，便能得到一个有序序列了。
 * 参考资料：https://blog.csdn.net/weixin_51609435/article/details/122982075
 * @author wang.ying.nan
 *
 */
public class HeapSort {

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
		int times  = 0;
		// 上溯至root构造最大堆
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
				times++;
			}
			// 堆顶与末尾元素互换
			temp = arr[0];
			arr[0] = arr[length -1 ];
			arr[length -1 ] = temp;
			//数组长度 -1
			length--;
			// 更新i值
			i = length/2 -1 ;
			System.out.println(Arrays.toString(arr));
		}
		System.out.println( "times +==" + times);
		return arr;
	}
	
	
	/**
	 * 
	 *   demo
	 *   	每次构建最大堆， 除了root是最大， 其他有孩子的node也要是最大的值、；
	 * @param arr
	 */
	 public static void heapSort(int[] arr){
		  int times = 0;
	        //给你一个数组 {4,6,8,5,9} , 要求使用堆排序法，将数组升序排序
	        /*
	         将待排序序列构造成一个大顶堆
	        此时，整个序列的最大值就是堆顶的根节点。*/
	        /*adjustHeap( arr,1,arr.length);
	        adjustHeap( arr,0,arr.length);*/
	        for (int i = arr.length/2-1; i >=0; i--) {
	            times = adjustHeap( arr,i,arr.length,times);
	        }
	        int temp=0;
	        /*
	         将其与末尾元素进行交换，此时末尾就为最大值。
	         然后将剩余n-1个元素重新构造成一个堆，这样会得到n个元素的次小值。如此反复执行，便能得到一个有序序列了。*/
	        for (int j=arr.length-1;j>0;j--){
	            temp=arr[j];
	            arr[j]=arr[0];
	            arr[0]=temp;
	            times = adjustHeap(arr,0,j,times);
	        }
	        System.out.println("tttimes:"+times);
	    }
	    public static int adjustHeap(int[] arr,int i,int length,int times){
	        //第一步把数组 {4,6,8,5,9}调整排序为{4,9,8,5,6}
	        //k=i*2+1 是循环对应的左子树元素
	        //记录当前要调整的元素
	        int temp=arr[i];
	        for (int k=i*2+1;k<length;k=k*2+1){
	            //把当前左子树和右子树的数据作比较，更换较大的数据
	            if (k+1<length&&arr[k]<arr[k+1]){
	                k++;
	            }
	            if (arr[k]>temp){
	                //交换位置
	                arr[i]=arr[k];
	                i=k;
	            }else{
	                break;
	            }
	            times++;
	        }
	         arr[i]=temp;
	         return times;
	    }
	    
	    
	public static void main(String[] args) {
		int [] arr = new int[] {4,6,8,5,9,11};
//	    heapSort(arr); 
//	    System.out.println(Arrays.toString(arr)); 
	    System.out.println( Arrays.toString(new HeapSort().sort(arr)));
		/**
		 * 
		 int [] arr = new int[10000];
		 int i = 10000;
		 for(int j = 0 ;j<10000; j++) {
			 arr[j] = i;
			 i-- ;
		 }
// 		demo   10000数据，循环  tttimes:106697
//	    heapSort(arr); 
//	    System.out.println(Arrays.toString(arr));   
		
		// 自实现 10000数据，循环   times +==25000000
//	    System.out.println( Arrays.toString(new HeapSort().sort(arr)));
		 */
		
		
//		int [] arr = new int[] {4,6,3,5,9,7,123,45,124,2322,35,23,2,-1};
//		int[] sort = new HeapSort().sort(arr);
//		for(int i : sort) {
//			System.out.println(i);
//		}
		
		 /**
		  * 
		  * 随机数测试
		  */
//		 int [] test = new int[1000];
//		 for(int j = 0 ;j<100; j++) {
//			 test[j] = (int)(Math.random()*100-1);;
//		 }
//		 int[] sort2 = new HeapSort().sort(test);
//		 for(int i1 : sort2) {
//				System.out.println(i1);
//			}
		 
		/**
		 int i = 1000;
		 int [] test = new int[1000];
		 for(int j = 0 ;j<1000; j++) {
			 test[j] = j;
			 j-- ;
		 }
		 int[] sort2 = new HeapSort().sort(test);
		 for(int i1 : sort2) {
				System.out.println(i);
			}
		**/
		
	}
	
	
	    
}
