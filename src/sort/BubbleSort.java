package sort;

import java.util.Arrays;

public class BubbleSort {
	
	/*
	 * 
	 *	原理：比较两个相邻的元素，将值大的元素交换至右端。
		思路：依次比较相邻的两个数，将小数放在前面，大数放在后面。即在第一趟：首先比较第1个和第2个数，将小数放前，大数放后。然后比较第2个数和第3个数，
	将小数放前，大数放后，如此继续，直至比较最后两个数，将小数放前，大数放后。重复第一趟步骤，直至全部排序完成。
	N个数字要排序完成，总共进行N-1趟排序，每i趟的排序次数为(N-i)次，所以可以用双重循环语句，外层控制循环多少趟，内层控制每一趟的循环次数。
	冒泡排序的优点：每进行一趟排序，就会少比较一次，因为每进行一趟排序都会找出一个较大值。如上例：第一趟比较之后，排在最后的一个数一定是最大的一个数，
	第二趟排序的时候，只需要比较除了最后一个数以外的其他的数，同样也能找出一个最大的数排在参与第二趟比较的数后面，第三趟比较的时候，只需要比较除了最后两个数以外的其他的数，
	以此类推……也就是说，没进行一趟比较，每一趟少比较一次，一定程度上减少了算法的量。
	 */
	
		public static void main(String[] args) {
			
			int[] num12 = new int [] {14,2,5,19,25};
			int[] num1= new int[] { 6 ,1 ,2, 7, 9, 3, 4, 5, 10 ,8};
			for(int i = 0 ; i< num1.length -1 ; i ++) {
				for(int j = 0 ; j< num1.length -i -1    ; j ++) {
					 if( num1[j] > num1 [j+1]) {
						 int tmp = num1[j];
						 num1[j] = num1[j+1];
						 num1[j+1] = tmp;
					 }
				}
				 System.out.println("inner:"+Arrays.toString(num1));
			}
			
//			for(int i = 0 ; i< num1.length ; i ++) {
//				System.out.println(num1[i]);
//			}
			 System.out.println(Arrays.toString(num1));
		}
			 
	}		
		
		