package tree;

import java.util.Arrays;
import java.util.List;

/**
 * 
 * 堆排序
 * 堆排序是不稳定的排序，空间复杂度为O(1),平均的时间复杂度为O(nlogn),最坏情况下也稳定在O(nlogn)
 *  	第一次堆排序：
			logn*n/2  = (logn) * n
					K=n/2 次
					2的K次方= n  -->  K = logn
		剩余元素堆排序：	
		logn* (n-1) =  (logn) * n
				K=n-1次
				2的K次方= n  -->  K = logn
		想加：
		logn*n+ logn*n   =  (2logn) * n  = (logn) * n
		
1、 将待排序序列构造成一个大顶堆
2、此时，整个序列的最大值就是堆顶的根节点。
3、将其与末尾元素进行交换，此时末尾就为最大值。
4、然后将剩余n-1个元素重新构造成一个堆，这样会得到n个元素的次小值。如此反复执行，便能得到一个有序序列了。

备注： 每次必须要构建最大堆， 即每个有孩子的节点保证都是最大值，
 	  1、初识构建最大堆的时候， 起始点是从 size /2 -1 (开始)上溯比较，  【即从第一个非叶子节点开始】
	  2、n-1次的数据构建最大堆的时候，
	   		1-、此时每次都是从root（节点索引是i=0）开始（因为root后面的堆已经是最大堆了） ， 往下Node进行。
	   		2-、往下Node索引是根据root（此时是最小值）交换的下标开始。   及 i *2 +1 
	   				比如：  root和孩子交换。  则下次循环的k = i *2 +1 ,或者 k++
	   			2.1、往下循环，需要判断当前索引的孩子节点是否超过length长度。
	  3、 数组中都和tmp比较,连续交换位置,方式
	  		int tmp = arr[i];
	  		 for (int k=i*2+1;k<length;k=k*2+1){
	            if (arr[k]>temp){
	                //交换位置  -- 中间大于tmp的数，依次上移。找到新位置
	                arr[i]=arr[k];
	                i=k;  // 更新下次的位置信息
	            }else{
	                break;
	            }
	        }
	        // 最终最小的数的位置。（中间循环完毕，找到最小值的位置，交换）
	         arr[i]=temp;
	         return times;
	  			 
	  		示例：      3             8       8       8       8
	  		   8    6        8       5       5       5
	  		 5   2		   5	   5       4       4
	   	   4   11	     4       4       4       3
	   	   
	   	     	 -、此时除了11元素外，其他元素再构造最大堆。   从i=0 开始,tmp =3 
	   	     	 -、比较3的孩子和3比较，先把 arr[0] =  arr[1]  。        
	  	         -、找原来8的孩子与tmp比较，此时arr[1] = arr[3].
	  	         -、找原来5的孩子与tmp比较，此时arr[3] = arr[5].
	  	         -、最后把tmp赋值给arr[5]
	  	         
 * 参考资料：https://blog.csdn.net/weixin_51609435/article/details/122982075
 * https://blog.csdn.net/cativen/article/details/124810686
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
	            int n_times = 0;
	            n_times = adjustHeap(arr,0,j,n_times);
	            System.out.println("--------:"+n_times + "////:"+j);
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
	                //交换位置  -- 中间大于tmp的数，依次上移。找到新位置
	                arr[i]=arr[k];
	                i=k;
	            }else{
	                break;
	            }
	            times++;
	        }
	        // 最终最小的数的位置。
	         arr[i]=temp;
	         return times;
	    }
	    
	    
	public static void main(String[] args) {
//		int [] arr = new int[] {4,6,8,5,9};
//	    heapSort(arr); 
//	    System.out.println(Arrays.toString(arr)); 
//	    System.out.println( Arrays.toString(new HeapSort().sort(arr)));
		/**
		 * */
		 int [] arr = new int[10];
		 int i = 10;
		 for(int j = 0 ;j<10; j++) {
			 arr[j] = i;
			 i-- ;
		 } 
// 		demo   10000数据，循环  tttimes:106697
	    heapSort(arr); 
	    System.out.println(Arrays.toString(arr));   
		
		// 自实现 10000数据，循环   times +==25000000
//	    System.out.println( Arrays.toString(new HeapSort().sort(arr)));
		
		
		
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
