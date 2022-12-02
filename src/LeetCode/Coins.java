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
		static int flag = 0 ;
		static int coinChange(int n){
			flag++;
//			System.out.println("----:"+n);
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
		* 
		* 输入41执行顺序
		* 			<B>先执行  coinChange(n - 1)   ，  41...26  ， n=26 ，return 1  
			*        		执行 coinChange(n - 5) ，n=26-5=21  开始执行 ，return 1 
*        						执行  coinChange(n - 1)   ，21,return 1  
*        						             执行 coinChange(n - 5) ，n=21-5=16 开始执行 ，
*        								<A> 执行  coinChange(n - 1)   16,15,...6 return 1 
	*        								执行 coinChange(n - 5) ，n=6 开始执行 ，return 1  
	*        								执行min1 = 1
	*        								n=6
	*       								执行coinChange(n - 20), n=-14 , return Integer.MAX_VALUE
			*     							执行coinChange(n - 25), n=-19 , return Integer.MAX_VALUE
			*     							执行min2 = 【2147483647】Integer.MAX_VALUE
	*        								return Math.min(min1, min2) + 1 = 2
*        								 回溯到 <A> 此时n =7 
*        									执行 coinChange(n - 5),
*        										执行  coinChange(n - 1)  传入 n=2    return 1 
*        											 执行 coinChange(n - 5) ，传入n=2 ,，return Integer.MAX_VALUE
*        											执行min1 = 1 
*        										n=2
*        										执行coinChange(n - 20), n=-18 , return Integer.MAX_VALUE
			*     								执行coinChange(n - 25), n=-23 , return Integer.MAX_VALUE
			*     								min2:2147483647
			*     								return Math.min(min1, min2) + 1 = 2
			*     							执行min1 = 2
			*     							n=7
			*     							执行coinChange(n - 20), n=-13 , return Integer.MAX_VALUE
			*     							执行coinChange(n - 25), n=-18 , return Integer.MAX_VALUE
			*     							min2:2147483647
			*     							return Math.min(min1, min2) + 1 = 3
			*     						回溯到 <A> 此时n =8
			*     							.....
		*/	
		final int min1 = Math.min(coinChange(n - 1), coinChange(n - 5));
//		System.out.println("min1:"+min1);
		final int min2 = Math.min(coinChange(n - 20), coinChange(n - 25));
//		System.out.println("min2:"+min2);
		return Math.min(min1, min2) + 1;
	}
	
		
		
		/**
		* 定义找零钱方法
		*/
		static int coins(int n){
			//过滤不合理的值
			if(n <1){ return -1;}
			//定义一个数组保存子问题的解，dp(n)...dp(2),dp(1)
			int[] dp=new int[n+1]; //数组索引从0开始，只是为了与dp(n)位置对应,数组初始化值都是0
			//初始状态准备好
			dp[1]=dp[5]=dp[20]=dp[25]=1;
			return coins(n,dp); //调用coins(n,dp)
		}
		static int coins(int n, int[] dp) {
			flag ++;
			//缺少递归基
			if(n <1){ return Integer.MAX_VALUE;}
			/**
			* 子问题的解保存在dp数组中，如果已经计算过则直接取出，否则需要计算，并最终保存到dp数组中
			*/
			if(dp[n]==0){
			//说明dp(n)没有被计算，需要计算
			int min1 = Math.min(coins(n - 1,dp), coins(n - 5,dp));
			int min2 = Math.min(coins(n - 20,dp), coins(n - 25,dp));
			dp[n]= Math.min(min1, min2) + 1;
			System.out.println("n:"+n+" value:"+dp[n]);
			}
			
			return dp[n];
		}

	
	public static void main(String[] args) {
//		System.out.println(coinChange(41));
		System.out.println(coins(26));
		System.out.println(flag);
	}

}

/**
0,0  1,0   2,0  3,0  4,0
0,1  1,1   2,1  3,1  4,1
0,2  1,2   2,2  3,2  4,2
0,3  1,3   2,3  3,3  4,3
0,4  1,4   2,4  3,4  4,4
**/