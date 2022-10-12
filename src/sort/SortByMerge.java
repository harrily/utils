package sort;import java.util.Arrays;

/**
 *时间复杂度 = O(nlogn)
 *空间复杂度= O(n)
 * 
 * 归并排序实现的主要实现的原理是由上至下递归的二分原数组，并由下至上递归的合并二分后的子数组，由于每次数组的分裂都需要建立两个新的数组，
 * 所以其实归并排序的空间复杂度是较高的，可达O(n)。
 * 	在这里，可能有些小伙伴会在空间复杂度到底是O(n)还是O(nlogn)之间存在疑惑，因为由代码可以得出归并算法的整个过程会复制logn个大小为n的数组，
 * 那为什么空间复杂度不是O(nlogn)呢？
 * 	原因是程序的执行是在线程栈中，一次方法的调用和返回代表着一个栈帧的入栈和出栈，栈帧出栈后，该栈帧中的临时变量所占用的空间都会得到释放。
 * （归并排序每次递归需要用到一个辅助表，长度与待排序的表相等，虽然递归次数是O(log2n)，但每次递归都会释放掉所占的辅助空间，所以下次递归的栈空间和辅助空间与这部分释放的空间就不相关了，因而空间复杂度还是O（n）。）
 * 
 * @author Administrator
 *
 *
	 例如 int i = 10;  int j = i << 1; 
	i = 10 : 十进制 是10，二进制是 1010
	i << 1: 左移1位，二进制变为 10100，转换位十进制 则是 20
	结论，j = 20,也就是 左移1位，相当于 乘以2，以此类推，<< 2 相当于乘以 4
	
	例如 int i = 20;  int j = i >> 1; 
	i = 20 : 十进制 是20，二进制是 10100
	i >> 1: 右移1位，二进制变为01010，转换位十进制 则是 10
	结论，j = 10,也就是 右移1位，相当于 除以2，以此类推，>> 2 相当于除以 4



对比冒泡优点：
 	针对 {5,20,8,3,17,24,38,7}; 
冒泡  ， 每一次循环，  只把最大最小的孵出来，  第一次循环，（假设数组个数8个） 所有相邻数对比交换， 后续依次减少对比的相邻数据交换位置（7~1）），直至结束。
 归并：
 	1、平分数组，直至不能切分
 	2、对比左右数组数大小，  重新排序,新数组写入原数组 
 	 	对比方式： 拿着左数组最小/最大值与 右数组最小/最大值 对比， 交换位置，切换左右下标对比。
 	 	比如到： [5, 20, 3, 8]  这一步
 	 				先比较 5 与 3 ，   3小，放进tmp，   右数组(p2)下标 ++
 	 				在比较 5 和 8 ， 5小，放进tmp,  左数组(p1)下标 ++
 	 				再比较 20和8 ，    8小， 放进tmp, 右数组(p2)下标++   ，此时 p2 溢出，  把p1剩下的元素放进tmp。
 	 			
 	第一次  
		["5", "20", 8, 3, 17, 24, 38, 7]
	第二次：
		[5, 20, "3", "8", 17, 24, 38, 7]     p2++  p1++  p2++ 
	第三次：
		["3", "5", "8", "20", 17, 24, 38, 7]
	...
 */
public class SortByMerge {

	
		public static void main(String[] args) {
			
			int mid = 0 + ((11) >> 1);
			System.out.println(mid);
			int[] top = new int[] {5,5,8,3,17,24,38,7};
//			mergeSort(top);
//			mergeSort2(top);
			mergeSort3(top);
		}
		
		
		public static void mergeSort(int[] arr) {
		    sort(arr, 0, arr.length - 1);
		  //  System.out.println(Arrays.toString(arr));
		}

		public static void sort(int[] arr, int L, int R) {
		    if(L == R) {
		        return;
		    }
		    // 比如遍历下标到  L = 4  R = 7   
//		    int mid = L + ((R - L) >> 1);
		    int mid =  ((R + L) >> 1);
		    sort(arr, L, mid);
		    sort(arr, mid + 1, R);
		    merge(arr, L, mid, R);
		}

		public static void merge(int[] arr, int L, int mid, int R) {
		    int[] temp = new int[R - L + 1];
		    int i = 0;
		    int p1 = L;
		    int p2 = mid + 1;
		    // 比较左右两部分的元素，哪个小，把那个元素填入temp中
		    while(p1 <= mid && p2 <= R) {
		        temp[i++] = arr[p1] <= arr[p2] ? arr[p1++] : arr[p2++];
		    }
		    // 上面的循环退出后，把剩余的元素依次填入到temp中
		    // 以下两个while只有一个会执行
		    while(p1 <= mid) {
		        temp[i++] = arr[p1++];
		    }
		    while(p2 <= R) {
		        temp[i++] = arr[p2++];
		    }
		    // 把最终的排序的结果复制给原数组
		    for(i = 0; i < temp.length; i++) {
		        arr[L + i] = temp[i];
		    }
		    System.out.println(Arrays.toString(arr));
		}
		
		
		/**
		 * 
		 * 自测
		 * @param arr
		 */
		
		public static void mergeSort3(int arr[]) {
			sort3(arr, 0, arr.length - 1);
		}
		
		public static void sort3(int[] arr,int L ,int R) {
			if(L == R){
				return;
			}
			int mid = (L + R) >> 1;
		    sort3(arr, L, mid);
		    sort3(arr, mid+1, R);
		    merge3(arr, L, R);
		}
		
		public static void merge3(int[] arr,int L ,int R) {
			// 数组 大小 = R - L + 1  
			int[] tmp = new int[R - L + 1   ];
			int p1 = L ;
			int i = 0;
			int mid = ((L + R ) >> 1 );
			// 有数组第一位下标 =  mid + 1 
			int p2 = mid  + 1 ;
		    while (p1<= mid & p2<=R) {
		    	// 为什么 不用 <= ? 无影响。  只是p1和p2谁先放tmp而已。
		    	tmp[i++] = arr[p1] < arr[p2] ? arr[p1++]: arr[p2++]; 
		    }
		    System.out.println(Arrays.toString(tmp));
		    //    改造版1 ： 会导致违法控制循环次数， 
		    /*
		    while ( p1 > mid) {
		    	p1--;
		    	tmp[i++] = arr[p2];
		    	
		    }
		    while ( p2 > R) {
		    	p2--;
		    	tmp[i++] = arr[p1];
		    }
		    */
		    /**
		     * 改造版2
		     * 改造版赋剩余的值
		     */
		    int t = tmp.length - i;
		    for(int z = 0 ;z < t   ; z++) {
		    	if(p1 > mid) {
		    		tmp[i++] = arr[p2++];
		    		
		    	}else if( p2 > R) {
				    tmp[i++] = arr[p1++];
		    	} 
		    }
		    
		    /**
		     * 原版
		     * */
//		    while(p1 <= mid) {
//		    	tmp[i++] = arr[p1++];
//		    }
//		    while(p2 <= R) {
//		    	tmp[i++] = arr[p2++];
//		    }
		    
		    //  为什么长度 是 tmp.length - 1  ?  解析： 遍历数组正常操作
		    for(int j = 0 ; j < tmp.length  ; j++) {
		    	arr[L+j] = tmp[j];
		    }
		    System.out.println(Arrays.toString(arr));
		}
		
		
		/**
		 *测试 递归
		 *     先执行到sort1（遍历到最底部，假设3层） ，跳出循环执行 sort2（遍历到最底部，假设1层）  跳出循环，  
		 * @param arr
		 
		public static void mergeSort2(int[] arr) {
		    sort2(arr, 0, arr.length - 1);
		  //  System.out.println(Arrays.toString(arr));
		}
		public static void sort2(int[] arr, int L, int R) {
		    if(L == R) {
		        return;
		    }
		    System.out.println(" L:" +L+" R:"+R);
		    int mid = L + ((R - L) >> 1);
		    sort2(arr, L, mid);
		    sort2(arr, mid + 1, R);
		    merge2(arr, L, mid, R);
		}
		public static void merge2(int[] arr, int L, int mid, int R) {
				System.out.println("merge2:"+Arrays.toString(arr)+" L:" +L+" R:"+R);
		}

		*/
}
