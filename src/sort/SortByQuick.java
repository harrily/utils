package sort;

import java.util.Arrays;
/**
 快速排序（Quicksort）是对冒泡排序的一种改进。
		通过一趟排序将要排序的数据分割成的独立两部分，其中一部分的所有数据都比另外一部分的所有数据都要小，然后再按此方法对这两部分数据分别进行快速排序，整个排序过程可以递归进行，以此达到整个数据变成有序序列。
 	归并排序（MERGE-SORT）是建立在归并操作上的一种有效的排序算法,该算法是采用分治法（Divide and Conquer）的一个非常典型的应用。将已有序的子序列合并，得到完全有序的序列；即先使每个子序列有序，再使子序列段间有序。
快速排序与归并排序的区别：
  	快速排序的时间复杂度是O?(nlogn)，但是快速排序是一种不稳定的排序方法，也就是说当有多个相同的值的时候在排序结束的时候它们的相对位置会发生改变。
 归并排序的时间复杂度是O?(nlogn)，但是归并排序是一种稳定的排序方法，即相等的元素顺序不会改变，但是相比于快速排序来说归并要申请的空间更大，消耗空间更多。
 * 
 * @author Administrator
 */
public class SortByQuick {
     public static void main(String[] args) {
    	 int[] top = new int[] {5,20,8,3,17,24,38,7};
    	 int[] top2 = new int[] { 6 ,1 ,2, 7, 9, 3, 4, 5, 10 ,8};
//    	 quickTest2(top2, 0, top2.length-1);
//    	 quickTest3(top2, 0, top2.length-1);
    	 quickTest(top2, 0, top2.length-1);
    	 System.out.println(Arrays.toString(top2));
    	 
	}
     
     public static void quickSort(int[] arr,int low,int high){
         int i,j,temp,t;
         if(low > high){
             return;
         }
         i=low;
         j=high;
         //temp就是基准位
         temp = arr[low];
         while (i<j) {
             //先看右边，依次往左递减 【找比枢轴  小的数】
        	 //  若先设置 low为基准，则 j先走（可以保证，i=j时，所指向的数一定小于等于枢轴的值。满足现有逻辑由小到大。） 
        	 //   =======================
        	 //（：如果i先走的话，i等于j的时候所指向的数会大于枢轴的值[当前逻辑上i=j的值应小于枢轴的值，]，这时候再将这个值与枢轴交换，就会出现问题。）
        	 //  因为设置low为基准（  temp = arr[low];），且i是找比枢轴大的数（temp>=arr[i]&&i<j），则i=j时，所指向的数一定是大于等于枢轴的数，此时交换，则违背本来的逻辑由小到大。
             while (temp<=arr[j]&&i<j) {
                 j--;
             }
             //再看左边，依次往右递增  【找比枢轴  大的数】
             while (temp>=arr[i]&&i<j) {
                 i++;
             }
             //如果满足条件则交换
             if (i<j) {
                 t = arr[j];
                 arr[j] = arr[i];
                 arr[i] = t;
             }
             System.out.println(Arrays.toString(arr));
         }
         //最后将基准为与i和j相等位置的数字交换 (保证基准左侧都是小于基准的数，右侧都是大于基准的数)
          arr[low] = arr[i];
          arr[i] = temp;
         //递归调用左半数组
         quickSort(arr, low, j-1);
         //递归调用右半数组
         quickSort(arr, j+1, high);
     }
     
     
     
     
     //自测 
     public static void quickTest(int[] array,int low ,int high) {
    	 
    	 if(low > high){
             return;
         }
    	 int tmp = array[low];
    	 int i = low;
    	 int j = high;
    	 int t ;
    	 
    	 while(i < j) {
    		 // 从小到大
    		 while(tmp<=array[j] && i<j) {
    			 j--;
    		 }
    		 while(tmp>=array[i] && i<j) {
    			 i++;
    		 }
    		 if(i<j) {
    			t = array[j];
    			array[j] = array[i];
    			array[i] = t;
    		 }
//    		  System.out.println(Arrays.toString(array));
    	 }
    	 
    	 array[low] = array[j];
    	 array[j] = tmp;
    	 
    	 quickTest(array, low, i-1);
    	 quickTest(array, i+1, high);
     }
     
     
     // 自测2 2022-10-10
     public static void quickTest2(int[] array,int low ,int high) {
    	 int i ,j , tmp ,t;
    	 if(low > high ) {
    		 return ;
    	 }
    	 tmp = array[low];
    	 i = low ;
    	 j = high;
    	 while(i < j ) {
    		 // 从大到小
    		 while(array[j] <= tmp & i <j) {
    			 j--;
    		 }
    		 while(array[i] >= tmp & i <j) {
    			 i++;
    		 }
    		 if(i<j) {
    			 t = array[i];
    			 array[i] = array[j];
    			 array[j] = t;
    		 }
    		 System.out.println("i:"+i +" ,j:" + j);
    		 System.out.println(Arrays.toString(array));
    	 }
    	 
    	 
    	 if(i == j){
    		 array[low] = array[i];
    		 array[i] = tmp;
    	 }
    	
    	 quickTest2( array, low , i-1) ;
    	 quickTest2( array, i+1 , high);
     }
     
     /*
      *   以 array[low] 为基准，为什么 j 要先走， i后走？ 
         以此为例子  ：  6 1 2 7 9 3 4 5 10 8
         	若 i 先走 （ i 找的是比基准值大的数） ， i= 0 ， j = 9    
         	第一次  ：  i找到7  ，  j 找到 5    i 和j互换 ， 此时    6 1 2 5 9 3 4 7 10 8   ;  i= 3  j = 7 
         	第二次：    i找到 9 ,j 找到4    i 和j互换 ， 此时    6 1 2 5 4 3 9 7 10 8   ;  i= 4   j = 6
         	第三次：    i找到9 ,j 找到9        i 和j互换 ， 此时  6 1 2 5 4 3 9 7 10 8   ;  i= 6   j = 6      

     最后和基准更换位置 ；
     		  此时 基准值6和9互换位置 , 发现此时array[i] = array[6] = 9, 比基准值大，此时更换会导致错误，更换后数组变为
     		  		[9, 1, 2, 5, 4, 3, 6, 7, 10, 8]    至此第一次while(i < j ) 执行完毕。 
     		  		
     		  总结： 如果基准值定为 array[low]  , j必须先走（不管是从大到小，还是从小到大排序）
     		  
参考资料：https://blog.csdn.net/pei327586354/article/details/109490564

从基准数位置的另一侧先开始查找，可以保证在两侧“探兵”相遇时，新基准值不会大于旧基准值(默认规则是升序排列)
问题在于当我们先从在边开始时，那么 i 所停留的那个位置肯定是大于基数6的
而在上述例子中，为了满足 i<j 于是 j也停留在7的位置，但最后交换回去的时候，7就到了左边

		1、需要满足 i<j ,才能交换
		2、如果正序排列(满足tmp>=array[i] && i<j ， 找到i大于基准的值交换)，且i先走，要满足i<j，   若此时i=j，则j不走了， 此时 i所在的值肯定大于基准值。 此时再array[i]和基准值交换，就违背正序排列（以为array[i] > 基准值）
      *   如果倒序排列(tmp<=array[i] && i<j， 找到i小于基准的值交换)，且i先走，要满足i<j，   若此时i=j，则j不走了， 此时 i所在的值肯定小于基准值。 此时再array[i]和基准值交换，就违背倒序排列（以为array[i] < 基准值）
      */  

     
     // 自测2 2022-10-10  基准值定为high  ， 则i先走
     public static void quickTest3(int[] array,int low ,int high) {
    	 int i ,j , tmp ,t;
    	 if(low > high ) {
    		 return ;
    	 }
    	 tmp = array[high];
    	 i = low ;
    	 j = high;
    	 while(i < j ) {
    		 // 从大到小
    		 while(array[i] >= tmp & i <j) {
    			 i++;
    		 }
    		 while(array[j] <= tmp & i <j) {
    			 j--;
    		 }
    		 
//    		 // 从小到大
//    		 while(array[i] <= tmp & i <j) {
//    			 i++;
//    		 }
//    		 while(array[j] >= tmp & i <j) {
//    			 j--;
//    		 }
    		 
    		 if(i<j) {
    			 t = array[i];
    			 array[i] = array[j];
    			 array[j] = t;
    		 }
    		 System.out.println("i:"+i +" ,j:" + j);
    		 System.out.println(Arrays.toString(array));
    	 }
    	 
    	 
    	 if(i == j){
    		 array[high] = array[i];
    		 array[i] = tmp;
    	 }
    	
    	 quickTest3( array, low , i-1) ;
    	 quickTest3( array, i+1 , high);
     }

}



 