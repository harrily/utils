package sort;

import java.util.Arrays;

public class SortByDichotomy {
	
	/**
	 * 数据量特别大
	 * 采用二分法查找时，数据需是有序不重复的。 基本思想：假设数据是按升序排序的，对于给定值 x，
	 * 从序列的中间位置开始比较，如果当前位置值等于 x，则查找成功；若 x 小于当前位置值，则在数列的前半段中查找；
	 * 若 x 大于当前位置值则在数列的后半段中继续查找，直到找到为止。
	 * 
	  * 时间复杂度为:O(log2n)。
	 * @param a
	 * @param goal
	 * @return
	 */
	//非递归	
	public static int binarySearch(int[] a,int goal){
			int high = a.length - 1;
			int low = 0;
			int mid  = 0;
			while(low <= high){
				mid = (high - low)/2+low;//(high+low)/2容易溢出
				System.out.println("===:"+mid);
				if(a[mid] == goal){
					return mid;
				}
				else if(a[mid] < goal){
					low = mid +1;
				}
				else
					high = mid - 1;
			}

			return -1;
		}
		
		//递归
		public static int binarySearch(int[] a,int low,int high,int goal){
			while(low <= high){   // 不用while就可以，判断退出递归条件即可
				int mid = (high - low)/2 + low;
				if(a[mid] == goal){
					return mid;
				}
				else if(a[mid] < goal){
					return binarySearch(a,mid+1,high,goal);
				}
				else
					return binarySearch(a,low,mid-1,goal);
			}
			return -1;
		}
		// Test  20221012   test  二分查找递归
		public static int binarySearchTest20221012(int[] a,int low,int high,int goal){
				// 找不到退出递归
				if(low > high) {
					return -1;
				}
				int mid = (low + high ) >>1 ;
				if(a[mid] == goal ) {
					return mid;
				}else if(a[mid] > goal) {
					return binarySearchTest20221012(a,low ,mid -1,goal);
				}else {
					return binarySearchTest20221012(a,mid+1,high,goal);
				}
				
		}
		
			// Test 非递归  TEST
 				public static int binarySearchTest20221012_fe(int[] a,int low,int high,int goal){
 					while(low <= high) {
 						int mid = (low + high ) >>1 ;
	 					if(a[mid] == goal ) {
	 						return mid;
	 					}else if(a[mid] > goal) {
	 						high = mid -1;
	 					}else {
	 						low = mid +1 ;
	 					}
 					}
 					return -1;
				}
		
 				//  Test
		public static int twoSerarch(int array[],int goal) {
			int low = 0;
			int high = array.length-1;
			int mid = 0;
			while(low <= high) {
				mid = low + ((high-low ) >> 1);
				if(array[mid] == goal) {
					return mid;
				}else if (array[mid] < goal) {
					low = mid +1  ;
				}else {
					high = mid -1 ;
				}
			}
			
			return -1;
			
		}
		// test 
		public static int twoSerarchByRecusion(int array[],int goal,int low,int high) {
	 		int mid = 0;
			while(low <= high) {
				mid = low + ((high-low ) >> 1);
				if(array[mid] == goal) {
					return mid;
				}else if (array[mid] < goal) {
					low = mid + 1  ;
					twoSerarchByRecusion(array, goal, low, high);
				}else {
					high = mid -1 ;
					twoSerarchByRecusion(array, goal, low, high);
				}
			}
			return -1;
			
		}
		
		
		/**
		 *   归并自测
		 * @param array
		 * @param low
		 * @param high
		 */
		public static void  recusion(int [] array,int low,int high) {
			int mid = low + ((high - low ) >>1 );
			if(low == high) {
				return;
			}
			recusion(array, low, mid);
		    recusion(array,mid+1,high);
		    merge(array, low, mid, high);
		}
		public static void merge(int[] array,int low ,int mid ,int high){
			int[] tmp = new int [high-low +1];
			int p1 = low;
			int p2 = mid +1;
			int i = 0;
			while(p1 <= mid  && p2 <= high) {
				tmp[i++] = array[p1] < array[p2] ? array[p1++] : array[p2++]; 
			}
			while(p1 <= mid) {
				tmp[i++] = array[p1++];
			}
			while(p2 <= high) {
				 tmp[i++] = array[p2++];
			}
			
			for(int j=0;j<tmp.length;j++){
				array[low+j] = tmp[j];
			}
		}
		
		public static void main(String[] args) {
			// 二分法自测
			int[] a = {1,2,3,4,5,6,7,8,9};
//			System.out.println(binarySearch(a,0,a.length - 1,3));
//			System.out.println(twoSerarch(a,3));
//			System.out.println(twoSerarchByRecusion(a, 3, 0, a.length-1));
			System.out.println(binarySearchTest20221012(a,0,a.length - 1,5));
//			System.out.println(binarySearchTest20221012_fe(a,0,a.length - 1,5));
			// 归并自测
			int[] gui = {1,11,32,41,7,6,17,8,62};
//			recusion(gui,0,gui.length-1);
//			System.out.println(Arrays.toString(gui));
		}

}
