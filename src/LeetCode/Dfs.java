package LeetCode;

import java.util.ArrayList;
import java.util.Arrays;
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
		ArrayList<Integer> list = new ArrayList<Integer>();
		for(int i=1;i<=num;i++) {
			for(int j=1;j<=num;j++) {
				for(int n=1;n<=num;n++) {
					if(i!=j && j!=n && i==n) {
						System.out.println("i:"+i+",j:"+j+",n:"+n);
					}
				}
			}
		}
		return null;
	}
	
	
	/**
	 * @category for + recurison
	 * @author wangyingnan s
	 */
	static int count1 = 1;
	static int nums = 3;
	static int[] array = new int[3];
	static void getByDfs(int step){
		if(step > nums) {
			System.out.println(Arrays.toString(array));
			return ;
		}
		for(int i=1;i<=nums;i++) {
			array[step-1] = i;
			getByDfs(step+1);
		}
	}
	
	
	/**
	 * demo  , for + 递归
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
		
		getByDfs(1);
		
//		full(1); // 1开始
//		System.out.println("total count:" + count);
	}


		
}
