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
 */
public class SortByMerge {

	
		public static void main(String[] args) {
			
		//	int mid = 0 + ((7) >> 1);
		//System.out.println(mid);
			int[] top = new int[] {5,20,8,3,17,24,38,7};
			
			mergeSort(top);
		}
		
		
		public static void mergeSort(int[] arr) {
		    sort(arr, 0, arr.length - 1);
		  //  System.out.println(Arrays.toString(arr));
		}

		public static void sort(int[] arr, int L, int R) {
		    if(L == R) {
		        return;
		    }
		    int mid = L + ((R - L) >> 1);
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
		        temp[i++] = arr[p1] < arr[p2] ? arr[p1++] : arr[p2++];
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
}
