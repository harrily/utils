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
	
		时间复杂度：  
			O(N) * O(N-1) = N2次方
		空间复杂度：
			间复杂度是对一个算法在运行过程中临时占用存储空间大小的量度 。空间复杂度不是程序占用了多少bytes的空间，因为这个也没太大意义，
			所以空间复杂度算的是变量的个数。空间复杂度计算规则基本跟实践复杂度类似，也使用大O渐进表示法。
			
		参考资料： https://blog.csdn.net/qq_49613557/article/details/115301174
	 */
	
		public static void main(String[] args) {
			
			int[] num12 = new int [] {14,2,5,19,25};
			int[] num1= new int[] { 6 ,12 ,23, 7, 9, 3, 4, 5, 10 ,8,100,22};
//			int[] num1= new int[] { 3,1 ,2, 4};
			sortBubble(num1);
//			sortByMaopao(num1);
//			sortBySelect(num1);
//			sortByInsert(num1);
		}
		
		/**
		 *    冒泡排序1 
			1-、左右元素对比，交换
			2-、将最大/小数，慢慢移动至最左侧/最右侧。
			3-、外层循环控制循环次数,内层循环控制左右数对比
		    4-、内层for循环，循环次数每次-i（因为外层没循环一次，就有最大/最小的数被找到，内层循环因此每次循环次数 要 -i）
		 * @param num1
		 */
		// 理念 ： 每次是内存数组，左右两个数循环对比，找出最大/最小的数， 放在最后一位。  
		public static void sortBubble(int[] num1) {
			for(int i = 0 ; i< num1.length -1; i ++) {
				int flag = 0 ;
				for(int j = 0 ; j< num1.length -i -1 ; j ++) {
					 if( num1[j] > num1 [j+1]) {
						 int tmp = num1[j];
						 num1[j] = num1[j+1];
						 num1[j+1] = tmp;
						 //标识位置
						 flag = 1 ;
					 }
//					 System.out.println(j + "==:"+num1[j] +" ::" +num1[j+1]);
				}
				if(flag == 0) {
					break;
				}
				 System.out.println("inner:"+Arrays.toString(num1));
			}
			
//			for(int i = 0 ; i< num1.length ; i ++) {
//				System.out.println(num1[i]);
//			}
//			 System.out.println(Arrays.toString(num1));
		}
		
		/**
		 *  冒泡排序 2 
		 *  	理念 ： 第一个数和后续的数对比，每次找出最大最小的数，放在首位，    后续内存循环依次少依次循环j = i+1
		 * @param array
		 */
		public static void sortByMaopao(int[] array){  
			for(int i = 0 ;i< array.length -1 ; i++ ) {
			
				/**
				 * 循环比较array[i]的位置的值与其他的值，保证每次当前循环array[i]是最大值。
				 * 每次从第一个记录开始，一、二两个记录比较，大的往后放，二三两个记录比较...依次类推, 每一趟冒泡排序后，无序序列中值最大的记录冒到序列末尾，所以称之为冒泡排序。
				 */
				int tmp = array[i];
				//  每次保证tmp  是最小的值
//				for(int j = i+1 ;j< array.length  ; j++ ) {
//					if(tmp > array[j]) {
//						tmp = array[j];  
//	                    array[j] = array[i];  
//	                    array[i] = tmp;  
//						}
//				}
				//第二种  注意与上个for的区别，下标和判断   ,每次保证array[i]  是最小的值
				for(int j = i+1 ;j< array.length  ; j++ ) {
					if(array[i] > array[j]) {
						tmp = array[i];  
	                    array[i] = array[j];  
	                    array[j] = tmp;  
					}
				}
				
				/*
				第3 种       此种写法， 思路混乱了，      末尾减少， 和首位增加 两个理念搞混了。
				  因为 j = i +1 , 此时每次最大最小值，应该是放在首位， 但是 如果用j -1 与 j  对比， 则是两两对比， 此时最大最小的数，是放在末尾， 那么此时 
				  内层数组不能从首位开始加，而应该从末尾开始-。  其实也就是  sortBubble的思路。 
				{ 6 ,12 ,2, 7, 9, 3, 4, 5, 10 ,8,100,22}; 
				 * */
//				for(int j = i+1 ;j< array.length  ; j++ ) {  // 首位增加，则应该那第一位的数，和其他后面的数对比。 
//					if(array[j-1] > array[j]) {  //  末尾减少  ， 末尾出最大最小， name首位不变 （换言之，这样相邻数对比， 只会把最大/最小的数，移动到最后一位。 ） 
//						tmp = array[j-1];  
//	                    array[j-1] = array[j];  
//	                    array[j] = tmp;  
//					}
//				}
//				
				 System.out.println("inner:"+Arrays.toString(array));
			}
	    }
		
		/**
		 * 选择排序（冒泡升级版）
		 * 		  每次二层循环，选出最大或最小的下标，交换一次即可。
		 * 
		 * @param array
		 */
		public static void sortBySelect(int[] array) {
			
			for(int i=0;i<array.length-1;i++) {
				int tmp = array[i];
				int flag = i;
				for(int j=i+1;j<array.length;j++) {
					// 选出最大最小的数的下标。  交换依次即可
					if( array[flag] > array[j]) {
						flag = j;
					}
				}
				// 相同的下标，无须交换
				if(flag != i) {
					tmp = array[flag];
					array[flag] = array[i];
					array[i] = tmp;
				}
				System.out.println("inner:"+Arrays.toString(array));
			}
		}
		
		
		
		/**
		 * 
		 * 插入排序    循环，取其中下标（从1开始）的数为tmp，与之前的数对比，大或者小，换位置，
		 * @param array
		 * 
		 * 插入排序  
			 
			{  6 ,12 ,2, 7, 9, 3, 4, 5, 10 ,8,100,22};
			
			[ 6 ,12 ,2, 7, 9, 3, 4, 5, 10 ,8,100,22 ]
			
				j= 1 i=2 tmp =2   
				[ 6 ,2 ,12, 7, 9, 3, 4, 5, 10 ,8,100,22 ]
				  arrar[j=1] = 2  j = 0  tmp =2  array [j=0] = 2  
				 
				[ 2 ,6  ,12, 7, 9, 3, 4, 5, 10 ,8,100,22 ]
			
			[ 2 ,6  ,12, 7, 9, 3, 4, 5, 10 ,8,100,22 ]
				j = 2 i = 3 tmp =7  
				[ 2 ,6  ,7, 12, 9, 3, 4, 5, 10 ,8,100,22 ]
					j = 1 i =3  tmp =7 
		 */		
		public static void sortByInsert(int[] array) {
			//System.out.println("===="+Arrays.toString(array));
			for(int i=1;i<array.length; i++) {
				int tmp = array[i];
				for(int j=i-1;j>=0;j--) {
//					System.out.println("innnn:  i:"+i+"  j:"+j + " tmp:"+tmp + " array[j+1]:" + array[j+1] + " array[j]:" + array[j]);
					if(tmp < array[j]) {
						array[j+1] = array[j]; 
						array[j] = tmp;
					}
					//System.out.println(Arrays.toString(array));
				}
				System.out.println(Arrays.toString(array));
			}
			
			/** --     写法2：  比较指定插入下标，之前的数，  两两对比。   
			 * 				与写法1 区别：
			 * 						1、如果每次都交换 ， 写法1与写法2一致， 因为每次交换后， tmp的值实际上就是上次array[j]的值，因为j-- ,Y也就是下次 array[j+1]的值
			 * 			innnn:  i:1  j:0 tmp:4 array[j+1]:4 array[j]:5
						---
						[4, 5, 3, 1]
						innnn:  i:2  j:1 tmp:3 array[j+1]:3 array[j]:5
						---
						innnn:  i:2  j:0 tmp:3 array[j+1]:3 array[j]:4
						---
						[3, 4, 5, 1]
						innnn:  i:3  j:2 tmp:1 array[j+1]:1 array[j]:5
						---
						innnn:  i:3  j:1 tmp:1 array[j+1]:1 array[j]:4
						---
						innnn:  i:3  j:0 tmp:1 array[j+1]:1 array[j]:3
						---
						[1, 3, 4, 5]

			 * 						2、如果不用交换，  则 tmp 和下次 array[j+1] 的值不一样， 也就是 内存for循环， 比较的左对象不一样， 但是结果是一至的都是不会交换，
			 * 							因为，此时i下标的 tmp的值如果与左侧的数不交换， 那么在往左侧循环也是不会交换的， 因为 i下标之前的数，已经排好序了，肯定是满足的，其实不需要比较了。
			 for(int i=1;i<array.length; i++) {
				for(int j=i-1;j>=0;j--) {
					//System.out.println("i:"+i+"  j:"+j);
					if(array[j+1] < array[j]) {
						int tmp = array[j+1];
						array[j+1] = array[j]; 
						array[j] = tmp;
					}
					//System.out.println(Arrays.toString(array));
				}
				System.out.println(Arrays.toString(array));
			} 
			 * 
			 */
			
			/**
			 * 
			 * 优化3 ， 内层少循环
			 * 
			 for(int i=1;i<array.length; i++) {
				int tmp = array[i];
				int flag = 0;
				for(int j=i-1;j>=0;j--) {
					System.out.println("innnn:  i:"+i+"  j:"+j + " tmp:"+tmp + " array[j+1]:" + array[j+1] + " array[j]:" + array[j]);
					if(tmp < array[j]) {
						array[j+1] = array[j]; 
						array[j] = tmp;
						flag = 1;
					}
					//System.out.println(Arrays.toString(array));
					//  因为左侧是有序数列， 如果第一次比较不通过， 后续无须比较。
					if(flag == 0) {
						break;
					}
				}
			 */
		}
		
/**
 * 
 *     冒泡的两种思路
 *     	两者区别 
			 
{  6 ,12 ,2, 7, 9, 3, 4, 5, 10 ,8,100,22};

sortBubble  -- 冒泡， 每次相邻的数对比，移动然后， 每次找到数组最大/最小的数， 
inner:[6, 2, 7, 9, 3, 4, 5, 10, 8, 12, 22, 100]
inner:[2, 6, 7, 3, 4, 5, 9, 8, 10, 12, 22, 100]
inner:[2, 6, 3, 4, 5, 7, 8, 9, 10, 12, 22, 100]
inner:[2, 3, 4, 5, 6, 7, 8, 9, 10, 12, 22, 100]
inner:[2, 3, 4, 5, 6, 7, 8, 9, 10, 12, 22, 100]
inner:[2, 3, 4, 5, 6, 7, 8, 9, 10, 12, 22, 100]
inner:[2, 3, 4, 5, 6, 7, 8, 9, 10, 12, 22, 100]
inner:[2, 3, 4, 5, 6, 7, 8, 9, 10, 12, 22, 100]
inner:[2, 3, 4, 5, 6, 7, 8, 9, 10, 12, 22, 100]
inner:[2, 3, 4, 5, 6, 7, 8, 9, 10, 12, 22, 100]
inner:[2, 3, 4, 5, 6, 7, 8, 9, 10, 12, 22, 100]

//  sortByMaopao   -- 找的【整个数组】最大最小， 以最左侧的下标为每次循环的交换位（内层循环，满足条件，就会会更新最左侧的值。），  。。
inner:[2, 12, 6, 7, 9, 3, 4, 5, 10, 8, 100, 22] 
inner:[2, 3, 12, 7, 9, 6, 4, 5, 10, 8, 100, 22]
inner:[2, 3, 4, 12, 9, 7, 6, 5, 10, 8, 100, 22]
inner:[2, 3, 4, 5, 12, 9, 7, 6, 10, 8, 100, 22]
inner:[2, 3, 4, 5, 6, 12, 9, 7, 10, 8, 100, 22]
inner:[2, 3, 4, 5, 6, 7, 12, 9, 10, 8, 100, 22]
inner:[2, 3, 4, 5, 6, 7, 8, 12, 10, 9, 100, 22]
inner:[2, 3, 4, 5, 6, 7, 8, 9, 12, 10, 100, 22]
inner:[2, 3, 4, 5, 6, 7, 8, 9, 10, 12, 100, 22]
inner:[2, 3, 4, 5, 6, 7, 8, 9, 10, 12, 100, 22]
inner:[2, 3, 4, 5, 6, 7, 8, 9, 10, 12, 22, 100]

// 选择排序   --  找【整个数组】最大最小， 以最左侧的下标为每次循环的交换位 ，（内层循环，满足条件，记录下标， 找到最小/最大的数的下标，才会和arr[i]交换值。），  。。
inner:[2, 12, 6, 7, 9, 3, 4, 5, 10, 8, 100, 22]
inner:[2, 3, 6, 7, 9, 12, 4, 5, 10, 8, 100, 22]
inner:[2, 3, 4, 7, 9, 12, 6, 5, 10, 8, 100, 22]
inner:[2, 3, 4, 5, 9, 12, 6, 7, 10, 8, 100, 22]
inner:[2, 3, 4, 5, 6, 12, 9, 7, 10, 8, 100, 22]
inner:[2, 3, 4, 5, 6, 7, 9, 12, 10, 8, 100, 22]
inner:[2, 3, 4, 5, 6, 7, 8, 12, 10, 9, 100, 22]
inner:[2, 3, 4, 5, 6, 7, 8, 9, 10, 12, 100, 22]
inner:[2, 3, 4, 5, 6, 7, 8, 9, 10, 12, 100, 22]
inner:[2, 3, 4, 5, 6, 7, 8, 9, 10, 12, 100, 22]
inner:[2, 3, 4, 5, 6, 7, 8, 9, 10, 12, 22, 100]

//插入排序   从下表为1 ，保证左侧数组【有序，从小到大】开始 ，    保证下表前的数据是有序的，  直至遍历结束
 * 
[6, 12, 2, 7, 9, 3, 4, 5, 10, 8, 100, 22]
[2, 6, 12, 7, 9, 3, 4, 5, 10, 8, 100, 22]
[2, 6, 7, 12, 9, 3, 4, 5, 10, 8, 100, 22]
[2, 6, 7, 9, 12, 3, 4, 5, 10, 8, 100, 22]
[2, 3, 6, 7, 9, 12, 4, 5, 10, 8, 100, 22]
[2, 3, 4, 6, 7, 9, 12, 5, 10, 8, 100, 22]
[2, 3, 4, 5, 6, 7, 9, 12, 10, 8, 100, 22]
[2, 3, 4, 5, 6, 7, 9, 10, 12, 8, 100, 22]
[2, 3, 4, 5, 6, 7, 8, 9, 10, 12, 100, 22]
[2, 3, 4, 5, 6, 7, 8, 9, 10, 12, 100, 22]
[2, 3, 4, 5, 6, 7, 8, 9, 10, 12, 22, 100]

			 */
	}		
		
		