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
	
	// 自测，双数组
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
	 * 					（即  计算2个物品，最大容量为j的时候， 参考 1个物品，最大容量为j的  ，  
	 * 					根据新增的物品weight和j作对比， 如果j小，则取i-1，j的dp值
	 * 					反之， 则取  [则取i-1，j的dp] 与   当前 [新增元素的value值+ i-1, j-新增weight的dp值]。 两者中的最大值）
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
	
		/**
		 * 
		 *  单 数组优化解决
		 *  1、双数组通过i来存储，元素个数 
		 *  2、单数组，通过capacity从右到左来约束元素个数。	
		 *  	1-、约束内层循环，每次j从j>weight[i-1]开始。 保证记录取到值的情况
		 *  	2-、i从1开始，j从大到小， 这样可以保证，内层j循环，  计算 dp[j - weights[i-1]] + values[i-1]时，保证j不会重复计算
		 *  		比如： i=1 外层
		 *  			内层：
		 *  			j:10,dp[j:]3
						j:9,dp[j:]3
						j:8,dp[j:]3
						j:7,dp[j:]3
						j:6,dp[j:]3
						j:5,dp[j:]3
						j:4,dp[j:]3
						j:3,dp[j:]3
						j:2,dp[j:]3
					即当j=9是， 计算最大值，  dp[j - weights[i-1]] = dp[9 - 2 ] = dp[7] , 此时dp[7] = 0 , 
							dp[7]+ values[i-1] = 3  ， 不会重复计算dp[7].
						如果内层是正向循环， 此时dp[7]已经=3 ，  dp[7]+ values[i-1]  = 6 ， 违反， i=1的前提。
						【双层数组，可以正向循环，是因为，此时dp[i-1][j - weights[i-1]] + values[i-1]   ， 此时dp[i-1] = dp[0] = 0 ,保证前提】
		 *  	
		 *  	对比，longSequence， 转化为1维数组，可以正向的原因， 因为它求的	
		 *  	dp[j] = Math.max(dp[j], dp[j - 1]); dp[j]的值，只与dp[j] 和dp[j-1] ,有关，只对比+1， 不是计算求和。。
		 * @param args
		 */
		public static int  getMax(int[] values, int[] weights, int capacity) {
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
				int[] dp = new int[capacity + 1]; //数组初始化默认值就是0
				for (int i = 1; i <= values.length; i++) {
					System.out.println("\\\\=");
					// 从右往左，  capacity从大到小，直至 weight最小值， 记录i=1~lenth的值。 比较择优
					for (int j = capacity; j >= weights[i-1]; j--) {
						dp[j] = Math.max(dp[j] , dp[j - weights[i-1]] + values[i-1]);
						System.out.println("j:"+j+",dp[j:]"+dp[j]);
				    }
					/**
					 * try {
						for (int j = capacity; j >= 1; j--) {
							System.out.println("\\\\;"+j);
							dp[j] = Math.max(dp[j] , dp[j - weights[i-1]] + values[i-1]);
							System.out.println(j+"----"+dp[j]);
					    }
					} catch (Exception e) {
						// TODO: handle exception
					} 
					*/
					
				}
				return dp[capacity];
		  }
	
	
		/**
		 * 
		 * 
		 * @param args
		 */
		
		
//		static int getMaxValByoneArr(int[] values, int[] weights, int capacity) {
//			//过滤掉不合理的值
//			if (values == null || values.length == 0) {
//				return 0;
//			}
//			if (weights == null || weights.length == 0) {
//				return 0;
//			}
//			if (capacity < 0) {
//				return 0;
//			}
//			//使用递推方式:dp(i,j):最大承重为j,有前i件物品可选时的最大总价值
//			int[] dp = new int[capacity + 1]; //数组初始化默认值就是0
//			//遍历
//				for (int i = 1; i <= values.length; i++) {
//					for (int j = 1; j <= capacity; j++) {
//					//翻译状态转移方程
//					if (j < weights[i - 1]) {
//						dp[j] = dp[j - 1];
//					} else {
//						dp[j] = Math.max(dp[j-1], dp[j - weights[i - 1]] + values[i - 1]);
//					}
//					System.out.println("dp[j]:"+dp[j] + ",j:"+j);
//				 }
//				}
//				return dp[capacity];
//			}
		
	public static void main(String[] args) {
//		static int[] values= {3,6,5,4,6};
//		static int[] weights={2,2,6,5,4};
//		static int capacity=10;
//		System.out.println(getMaxVal(values, weights, capacity));
//		System.out.println(sack(values, weights));
		System.out.println(getMax(values, weights, capacity));
	}
}
