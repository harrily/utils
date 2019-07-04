package sort;

import java.util.Arrays;
/**
 * 快速排序（Quicksort）是对冒泡排序的一种改进。
		通过一趟排序将要排序的数据分割成独立的两部分，其中一部分的所有数据都比另外一部分的所有数据都要小，然后再按此方法对这两部分数据分别进行快速排序，整个排序过程可以递归进行，以此达到整个数据变成有序序列。
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
    	 quickSort(top, 0, top.length-1);
    	 System.out.println(Arrays.toString(top));
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

}
