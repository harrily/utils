package LeetCode;
/**
 动态规划 --DP
 
假设有25分、20分、5分、1分的硬币，现要找给客户41分的零钱，如何办到硬币个数最少？
此前贪心策略求解结果是5枚硬币，并非是最优解！！
leetcode_322_零钱兑换：https://leetcode-cn.com/problems/coin-change/
思路：
定义状态
dp(n):凑到 n 分需要的最少硬币个数
设定初始状态
dp(25)=dp(20)=dp(5)=dp(1)=1
确定状态转移方程
如果第 1 次选择了 25 分的硬币，那么 dp(n) = dp(n – 25) + 1
如果第 1 次选择了 20 分的硬币，那么 dp(n) = dp(n – 20) + 1
如果第 1 次选择了 5 分的硬币，那么 dp(n) = dp(n – 5) + 1
如果第 1 次选择了 1 分的硬币，那么 dp(n) = dp(n – 1) + 1
所以 dp(n) = min { dp(n – 25), dp(n – 20), dp(n – 5), dp(n – 1) } + 1

 * @author wang.ying.nan
 *
 */
public class Coins {
		//1 定义一个状态，方法,凑够n分的最少硬币个数
		//dp(n):凑够n分的最少硬币个数
		static int coinChange(int n){
		//递归基
		if(n <1){ return Integer.MAX_VALUE;}
		//2 确定初始状态
		if(n==1||n==5||n==20|n==25){ return 1;}
		//3、确定状态的转移方程：dp(n)与dp(n-1)的关系，
		/**
		* 如果第一次选择了1分；coinChange(n)=coinChange(n-1)+1
		* 如果第一次选择了5分；coinChange(n)=coinChange(n-5)+1
		* 如果第一次选择了20分；coinChange(n)=coinChange(n-20)+1
		* 如果第一次选择了25分；coinChange(n)=coinChange(n-25)+1
		* 以上四种情况选择哪一种呢？应该选择的是硬币个数最少的这种
		*/
		final int min1 = Math.min(coinChange(n - 1), coinChange(n - 5));
		final int min2 = Math.min(coinChange(n - 20), coinChange(n - 25));
		return Math.min(min1, min2) + 1;
	}
	
	public static void main(String[] args) {
		System.out.println(coinChange(41));
	}

}

/**
0,0  1,0   2,0  3,0  4,0
0,1  1,1   2,1  3,1  4,1
0,2  1,2   2,2  3,2  4,2
0,3  1,3   2,3  3,3  4,3
0,4  1,4   2,4  3,4  4,4
**/