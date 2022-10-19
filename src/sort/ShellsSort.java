package sort;

/**
 *  插入排序升级版   o(n 的 3/2次方)
 * 算法稳定与不稳定是怎么判断的？
 * 	由于多次插入排序，我们知道一次插入排序是稳定的，不会改变相同元素的相对顺序，但在不同的插入排序过程中，相同的元素可能在各自的插入排序中移动，最后其稳定性就会被打乱，所以shell排序是不稳定的。
 * 
 * 希尔排序目的为了加快速度改进了插入排序，交换不相邻的元素对数组的局部进行排序，并最终用插入排序将局部有序的数组排序。
在此我们选择增量 gap=length/2，缩小增量以 gap = gap/2 的方式，用序列 {n/2,(n/2)/2...1} 来表示。
 * @author wang.ying.nan
 *
 */
public class ShellsSort {
	
	public static void main(String[] args) {
		int[] num1= new int[] { 6 ,12 ,23, 7, 9, 3, 4, 5, 10 ,8,100,22};
		shellSort(num1, 0, num1.length  );
	}
	
	public static void shellSort(int[] arr,int low,int high) {
		int mid = (high + low ) >> 1 ;
	}
	
	
}	
