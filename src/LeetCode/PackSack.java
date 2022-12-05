package LeetCode;
/**
0,0  1,0   2,0  3,0  4,0
0,1  1,1   2,1  3,1  4,1
0,2  1,2   2,2  3,2  4,2
0,3  1,3   2,3  3,3  4,3
0,4  1,4   2,4  3,4  4,4

从起点（0, 0）走到终点（4, 4）一共有多少种走法？只能向右、向下走
假设 dp(i, j) 是从（0, 0）走到（i, j）的走法
dp(i, 0) = dp(0, j) = 1
dp(i, j) = dp(i, j – 1) + dp(i – 1, j)

dp(1,1) = dp(1,0) + dp(0,1)
**/ 
public class PackSack {
	static int[] values= {3,6,5,4,6};
	static int[] weights={2,2,6,5,4};
	static int capacity=10;
	
	public static int sack(int[] value, int[] weight) {
		int[][] dp = new int[value.length+1][capacity+1];
		for(int i = 1 ; i < value.length+1 ; i++) {
			for(int j = 1 ; j < capacity+1 ; j++) {
				if(j < weights[i-1]) {
					dp[i][j] = dp[i-1][j];
				}else {
					dp[i][j] = Math.max(dp[i-1][j], dp[i-1][j - weights[i-1] ] + values[i-1]);
				}
			}
			
		}
		return dp[value.length][capacity];
	}
	
	/**
	 * 
	 *   	递推思路 
	 *   		
	 *   :dp(i,j):最大承重为j,有前i件物品可选时的最大总价值
	 *   		外层循环从 i = 1  
	 * 				内层循环从j = 1，max =  cappacity开始循环
	 * 				
	 * 				1、依次计算， i= 1 , j= 1~ max的值
	 * 					i=2  , j= 1~ max的值
	 * 						....
	 * 				然后依次达到，题目要求的，i= 5,  j=10,的时候， value的最大值。
	 * 				2、dp[i][j] 的值 依赖于  dp[i-1][j]的值做参考。
	 * 				3、要确定新加入的元素是否满足weight，然后对比择优选择dp的value值。
	 * 				4、dp元素从1开始 ，weight和value从0开始
	 * @param values
	 * @param weights
	 * @param capacity
	 * @return
	 */
	static int getMaxVal(int[] values, int[] weights, int capacity) {
		//过滤掉不合理的值
		if (values == null || values.length == 0) {
			return 0;
		}
		if (weights == null || weights.length == 0) {
			return 0;
		}
		if (capacity < 0) {
			return 0;
		}
		//使用递推方式:dp(i,j):最大承重为j,有前i件物品可选时的最大总价值
		int[][] dp = new int[values.length + 1][capacity + 1]; //数组初始化默认值就是0
		//遍历
		/**
		 * 示例：  比如此时  i=5 , j=10 
		 * 
		 *  - 对比发现，  10 >= weights[4] = 4 ,执行else
		 *     dp[i][j] = Math.max(dp[i - 1][j], dp[i - 1][j - weights[i - 1]] + values[i - 1]);
		 *		dp[i - 1][j]  = dp[4][10]  ，即 找只有4个元素的时候，总重为10的情况 dp的value =  14 
		 *		dp[i - 1][j - weights[i - 1]] + values[i - 1]) =   dp[4][6] + values[4]
		 *				即， 找到找只有4个元素的时候 ，总重-当前新加元素重量 的dp值，  然后加上当前新加入元素的value值。
		 *				=  9 + 6  =15  
		 *		求max（14，15）  ==15
		 */
		for (int i = 1; i <= values.length; i++) {
			for (int j = 1; j <= capacity; j++) {
			//翻译状态转移方程
			if (j < weights[i - 1]) {
				dp[i][j] = dp[i - 1][j];
			} else {
				// 如果在元素个数=i，且当前j可以再放元素，  则 在 i-1次的j值   与，  （i-1的j去掉当前新加的weight后dp值，加上新加入元素的value。）
				
				dp[i][j] = Math.max(dp[i - 1][j], dp[i - 1][j - weights[i - 1]] + values[i - 1]);
				System.out.println("*****"+(j - weights[i - 1]));
			}
			System.out.println(i+"==="+ j+ "---"+dp[i][j]);
		 }
		}
			return dp[values.length][capacity];
		}
	
	
	public static void main(String[] args) {
//		System.out.println(getMaxVal(values, weights, capacity));
		System.out.println(sack(values, weights));
	}
}
