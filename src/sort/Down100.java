package sort;

import java.util.Arrays;
import java.util.Date;
import java.util.Random;

public class Down100 {
	
	public static void main(String[] args) {
		
		//find();  //求最小值，构建最大堆
		
		/**
		 * 
		  * 测试冒泡、选择、插入排序对的时间
		 */
		int number = 100;
		int maxnum = 1000000;
		int[] top = new int[] { 6 ,12 ,2, 7, 9, 3, 4, 5, 10 ,8,100,22};
//		int[] top = new int[number] ;
//		for (int i = 0; i < number; i++) {
//			top[i] = Math.abs(new Random().nextInt(maxnum));//设置为随机数
//		}
		Date startTime = new Date();
//		sortByInsert(top);  //    [1000  37ms]   [1w  42ms]    [10w  2899ms]      [100w   238790ms]
//		sortByMaopao(top);  //  [1000  114ms]  [1w  116ms]   [10w  12582ms]     [100w  1262235ms]
		System.out.println(Arrays.toString(top));
		sortByMaopao(top);
		System.out.println(Arrays.toString(top));
		//sortBySelect(top);   // [1000  45ms ]  [1w  48ms ]   [10w  3123ms]      [100w   263240ms]
		//System.out.println(Arrays.toString(top));
		Date endTime = new Date();
		System.out.println("用了"+(endTime.getTime() - startTime.getTime())+"毫秒");
	
	}
	public static void find( ) {//
		int number = 100000000;// 一亿个数
		int maxnum = 100000000;// 随机数最大值
		int i = 0;
		int topnum = 100;// 取最大的多少个
	 
		Date startTime = new Date();
		
		Random random = new Random();
		int[] top = new int[topnum];
	
		for (i = 0; i < topnum; i++) {
			top[i] = Math.abs(random.nextInt(maxnum));//设置为随机数
//			top[i] = getNum(i);
		}
		buildHeap(top, 0, top.length);// 构建最大堆， top[0]为最大元素
		for (i = topnum; i < number; i++) {
			int currentNumber2 = Math.abs(random.nextInt(maxnum));//设置为随机数
//			int currentNumber2 = getNum(i);
			// 大于 top[0]则交换currentNumber2  重构最大堆
			if (top[0] > currentNumber2) {
				top[0] = currentNumber2;
				shift(top, 0, top.length, 0); // 构建最大堆 top[0]为最大元素
			}
		}
		System.out.println(Arrays.toString(top));
		sortByMaopao(top);
		System.out.println(Arrays.toString(top));
		
		Date endTime = new Date();
		System.out.println("用了"+(endTime.getTime() - startTime.getTime())+"毫秒");
	}
	
	
	public static int getNum(int i){
		return i;
	}

 
	//构造排序数组
	public static void buildHeap(int[] array, int from, int len) {
		int pos = (len - 1) / 2;
		System.out.println(pos);
		for (int i = pos; i >= 0; i--) {
			shift(array, from, len, i);
		}
	}
	/**
	 * @param array top数组
	 * @param from 开始
	 * @param len 数组长度
	 * @param pos 当前节点index
	 * */
	public static void shift(int[] array, int from, int len, int pos) {
		// 保存该节点的值 
		int tmp = array[from + pos];
		//System.out.println("--------------tmp:"+tmp+"********"+pos);

		int index = pos * 2 + 1;// 得到当前pos节点的左节点
		/**
		 * 
		 * 构建最大堆，   每个节点的值都大于等于它的左右节点
		 * 
		 */
		while (index < len)//  存在左节点
		{
			
			if(index + 1 < len && array[from +index] < array[from +index+1]) {// 如果存在右节点
				// 如果右边节点比左边节点大，就和右边的比较
				index +=1;
			}
			
			if(tmp < array[from + index]) {
				array[from + pos]  = array[from + index];
				pos = index;
				index = index * 2 +1 ;
			}else {
				break;
			}
			
		}
		// 最终全部置换完毕后 ，把临时变量赋给最后的节点
		array[from + pos] = tmp;
		//System.out.println("=================end:");
	}
	
	/**
	 *  冒泡排序
	 * @param array
	 */
	public static void sortByMaopao(int[] array){  
		for(int i = 0 ;i< array.length -1 ; i++ ) {
			int tmp = array[i];
			/**
			 * 循环比较array[i]的位置的值与其他的值，保证每次当前循环array[i]是最大值。
			 * 每次从第一个记录开始，一、二两个记录比较，大的往后放，二三两个记录比较...依次类推, 每一趟冒泡排序后，无序序列中值最大的记录冒到序列末尾，所以称之为冒泡排序。
			 */
			
			for(int j = i+1 ;j< array.length  ; j++ ) {
				if(tmp < array[j]) {
					tmp = array[j];  
                    array[j] = array[i];  
                    array[i] = tmp;  
					}
				}
			//第二种  注意与上个for的区别，下标和判断
			/*
			for(int j = i+1 ;j< array.length  ; j++ ) {
				if(array[i] < array[j]) {
					tmp = array[i];  
                    array[i] = array[j];  
                    array[j] = tmp;  
					}
				}*/
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
				if( array[flag] < array[j]) {
					flag = j;
				}
			}
			// 相同的下标，无须交换
			if(flag != i) {
				tmp = array[flag];
				array[flag] = array[i];
				array[i] = tmp;
			}
		}
	}
	/**
	 * 
	 * 插入排序    循环，取其中下标（从1开始）的数为tmp，与之前的数对比，大或者小，换位置，
	 * @param array
	 */
	public static void sortByInsert(int[] array) {
		//System.out.println("===="+Arrays.toString(array));
		for(int i=1;i<array.length; i++) {
			int tmp = array[i];
			for(int j=i-1;j>=0;j--) {
				//System.out.println("i:"+i+"  j:"+j);
				if(tmp>array[j]) {
					array[j+1] = array[j]; 
					array[j] = tmp;
				}
				//System.out.println(Arrays.toString(array));
			}
		}
	}
	
	
	public static void sortByGuiBing(int[] array) {
		
			
		
	}
	
	//int[] top = new int[] {5,9,100,35,75};
}
