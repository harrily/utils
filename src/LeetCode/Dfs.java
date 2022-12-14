package LeetCode;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashSet;
import java.util.List;

/**
 * 	DFS 深度优先搜索算法
 * @since 2022-12-08
 * @author wang.ying.nan
 * 
 * 参考资料：https://blog.csdn.net/weixin_33246767/article/details/114227715
 */
public class Dfs {
	/**
		 给定一个整数a，输出一个a位数，总共有多少种方法？输入格式：输入一个整数a。
		输出格式：输出所有排列方案，每个方案占一行。
		数据范围：1≤a≤10
		输入样例：3
		输出样例：
			1 2 3
			1 3 2
			2 1 3
			2 3 1
			3 1 2
			3 2 1
	 * @param num
	 * @return
	 */
	
	// 生硬的多层for循环实现
	static List<ArrayList<Integer>> getByMutiFor(int num){
		for(int i=1;i<=num;i++) {
			for(int j=1;j<=num;j++) {
				for(int n=1;n<=num;n++) {
					if(i!=j && j!=n && i!=n) {
						System.out.println("i:"+i+",j:"+j+",n:"+n);
					}
				}
			}
		}
		return null;
	}
	
	
	/**
	 * @category for + recurison
	 * @author wangyingnan 
[1, 1, 1]  --第一层，i=1, 递归赋值，越界退出，, 退出最后一次递归
[1, 1, 2]  -- 更新最内层value值 = 2 【array[3-1] = i =  2;】，返回上一层递归
[1, 1, 3]  -- 更新最内层value值 = 3 【array[3-1] = i = 3;】，返回上一层递归
[1, 2, 1]  -- 返回第二层 。。
[1, 2, 2]
[1, 2, 3]
[1, 3, 1]
[1, 3, 2]
[1, 3, 3]
[2, 1, 1]-- 返回第1层 。。  i=2开始 for循环
[2, 1, 2]
[2, 1, 3]
[2, 2, 1]
[2, 2, 2]
[2, 2, 3]
[2, 3, 1]
[2, 3, 2]
[2, 3, 3]
[3, 1, 1]
[3, 1, 2]
[3, 1, 3]
[3, 2, 1]
[3, 2, 2]
[3, 2, 3]
[3, 3, 1]
[3, 3, 2]
[3, 3, 3]
	 */
	static int nums = 3;  // 整数=3
	static int[] array = new int[3];//  定义存储每次数据的数组（每次覆盖）
	static void getByDfs(int step){
		if(step > nums) {//定义出口 ， 递归层数（step值代表是第几次递归，1除外）
//			if(array[0]!=array[1] && array[1]!=array[2] && array[0]!=array[2]) {   //去重
//				System.out.println(Arrays.toString(array)); //打印当前内层每一次for循环的值。
//			}
			HashSet<Integer> set = new HashSet<Integer>();
			for(int j=0 ;j<array.length;j++) { 
				set.add(array[j]); 
			}
			if(set.size() == array.length  ) {  // 所有元素不相等，打印数组
				System.out.println(Arrays.toString(array)); //打印当前内层每一次for循环的值。
			}
			return;
		}
		for(int i=1;i<=nums;i++) {
			array[step-1] = i; //  for循环定义循环赋值，step代表更新第几层数据，step=1，只更新第一层数据，同理类推。
			getByDfs(step+1);  // 进入下一层for循环赋值。  
		}
	}
	/**
	  * 深度优先算法  ，  去重放前面
	 * @param step
	 */
	static int[] result = new int[3];// 判断是否重复
	static void getByDfs2(int step){
		if(step > nums) {//定义出口 ， 递归层数（step值代表是第几次递归，1除外）
			System.out.println(Arrays.toString(array)); //打印当前内层每一次for循环的值。
			return;
		}
		for(int i=1;i<=nums;i++) {
			if (result[i-1] == 0) { // 如果当前数没有被全排xc
				result[i-1] = 1; // 标记当前数已经全排
				array[step-1] = i; //  for循环定义循环赋值，step代表更新第几层数据，step=1，只更新第一层数据，同理类推。
				getByDfs2(step+1);  // 进入下一层for循环赋值。  
				result[i-1] = 0;  // 当前递归/for循环 --   执行完毕，替换result[i-1]的值 ，
			} 
		}
	}
	/**
	 *i=1  ，step=1 ,	[1,0,0],result[0] == 1 ,  
	 *		getByDfs2(2); 
	 *			i=2，step=2,	[1,2,0] ,result[1] == 1 ,  
	 * 				getByDfs2(3); 
	 * 					i=3，step=3,	[1,2,3] ,result[2] == 1 ,
	 * 						getByDfs2(4);打印 return ; 
	 * 						result[3-1]= result[2] = 0;  |||  递归执行完毕，，替换result[i-1]的值 ，
	 * 			result[2-1]= result[1]= 0;  |||||  for循环执行完毕，  ，替换result[i-1]的值 ，
	 * 			i=3 ,step=2,[1,3,3] ,result[2] == 1 ,
	 * 				getByDfs2(3);   
	 * 					i=2， step=3,	[1,3,2] ,result[1] == 1 ,
	 * 						getByDfs2(4);打印 return ; 
	 * 						result[2-1]= result[1] = 0;
	 * 			result[3-1]= result[2]= 0;		
	 * result[1-1]= result[0]= 0;【result=[0, 0, 0]】
	 * 
	 * 			
	 * [1, 2, 3]  之后 result[2] = 0 ;  返回上一层  ，step=2 ，i = 3    result[2] = 1 
	 */
	
	
	/**
	 * 
	 * demo  , for + 递归
	 *
	 */
	static int[] arr = new int[5];
	static int step_total = 5;
	static int count = 0;
	public static void full(int step){
		if (step >= step_total) { // 出口;当下标超出
			int[] result = new int[5];// 判断是否重复
	
			boolean flag = true;
	
			for (int i = 1; i < step_total; i++) {
				result[arr[i]] += 1;
				if (result[arr[i]] > 1) flag = false; // 判断当前数字是否重复出现
			}
	
			if (flag) { // 所有的数字出现
				System.out.println(arr[1] + "" + arr[2] + "" + arr[3] + "" + arr[4]);
				count++;
			}
			return;
		}
		// 重复内容

		for (int i = 1; i < step_total; i++) {
			arr[step] = i; // 第step下标位置 放i
			full(step + 1);
		}

	}
	public static void main(String[] args) {
//		getByMutiFor(3);
		
//		getByDfs(1);
		getByDfs2(1);
		
//		full(1); // 1开始
//		System.out.println("total count:" + count);
	}


		
}
