package LeetCode;

import java.util.ArrayList;
import java.util.List;

/**
 * 	DFS 深度优先搜索算法
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
	static List<ArrayList<Integer>> getDfs(int num){
		ArrayList<Integer> list = new ArrayList<Integer>();
		for(int i=1;i<=num;i++) {
			list.add(i);
			
		}
		
		return null;
	}
	
	public static void main(String[] args) {
		int num = 3;
		getDfs(num);
	}
}
