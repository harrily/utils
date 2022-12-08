package LeetCode;
/**
 * 最长公共序列 
 * 
 * 计算两个序列的最长公共子序列长度
	[1, 3, 5, 9, 10] 和 [1, 4, 9, 10] 的最长公共子序列是 [1, 9, 10]，长度为 3
	
	一个字符串的 子序列 是指这样一个新的字符串：它是由原字符串在不改变字符的相对顺序的情况下删除某些字符（也可以不删除任何字符）后组成的新字符串。
	例如，"ace" 是 "abcde" 的子序列，但 "aec" 不是 "abcde" 的子序列。
	来源：力扣（LeetCode）
	链接：https://leetcode.cn/problems/longest-common-subsequence
	著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 * @author wang.ying.nan
 */
public class LongSequence {
	
	public static int getLongSeq(int[] s1,int [] s2) {
		int num = 0;
		for(int i = 0 ;i<s1.length;i++) {
			for(int j = 0 ;j<s2.length;j++) {
				if(s1[i] == s2[j]) {
					num++;
					break;
				}
			}
		}
		return num;
	}
	
	
	public static int getLongSeq2(int[] s1,int [] s2) {
		int num = 0;
//		int flag = 0;
		int type = 0;
		for(int i = 0 ;i<s1.length;i++) {
			for(int j = type ;j<s2.length;j++) {
				if(s1[i] == s2[j]) {
//					if(flag > j ) {
//						break;
//					}
					type = j+1;
					num++;
//					flag = j;
					break;
				}
			}
		}
		return num;
	}
	
	/**
	 * 解题思路
		Q1：为什么想到二维dp？
		A1：因为涉及到两个字符串的比较，通常我们的做法都是设置两个指针进行遍历操作；而两个指针当前走到哪以及当前已经记录的公共子序列长度，我们可以采取一个二维dp记录
		Q2：为什么是DP？
		A2：
		最优子结构：text.subString(0,i)和text2.subString(0,j)子问题的最优解之间互不影响，且原问题的解可以由子问题的解推出来；符合最优子结构
		重叠子问题：存在
		状态转移方程：
		若当前i，j指向的字符相同，则一定在LCS中，指针i，j同时移动，即有：dp[i][j] = dp[i-1][j-1]+1;
		若当前i，j指向的字符不相同，则i，j指向的字符至少有一个不在LCS中，获取前面子问题的最大解：dp[i][j] = max{dp[i-1][j],dp[i][j-1]}
		注：由状态转移方程我们看的出来，新的状态只和前面相邻的状态相关，因此我们可以采取状态压缩的方法将二维数组压缩成一维dp记录状态
			 * 
	  1. 状态定义
		比如对于本题而言，可以定义 dp[i][j] 表示 text1[0:i-1] 和 text2[0:j-1] 的最长公共子序列。 （注：text1[0:i-1] 表示的是 text1 的 第 0 个元素到第 i - 1 个元素，两端都包含）
		之所以 dp[i][j] 的定义不是 text1[0:i] 和 text2[0:j] ，是为了方便当 i = 0 或者 j = 0 的时候，dp[i][j]表示的为空字符串和另外一个字符串的匹配，这样 dp[i][j] 可以初始化为 0.
		
		2. 状态转移方程
		知道状态定义之后，我们开始写状态转移方程。
		
		当 text1[i - 1] == text2[j - 1] 时，说明两个子字符串的最后一位相等，所以最长公共子序列又增加了 1，所以 dp[i][j] = dp[i - 1][j - 1] + 1；
				举个例子，比如对于 ac 和 bc 而言，他们的最长公共子序列的长度等于 a 和 b 的最长公共子序列长度 0 + 1 = 1。
		当 text1[i - 1] != text2[j - 1] 时，说明两个子字符串的最后一位不相等，那么此时的状态 dp[i][j] 应该是 dp[i - 1][j] 和 dp[i][j - 1] 的最大值。
				举个例子，比如对于 ace 和 bc 而言，他们的最长公共子序列的长度等于 ① ace 和 b 的最长公共子序列长度0 与 ② ac 和 bc 的最长公共子序列长度1 的最大值，即 1
		
		作者：fuxuemingzhu
		链接：https://leetcode.cn/problems/longest-common-subsequence/solution/fu-xue-ming-zhu-er-wei-dong-tai-gui-hua-r5ez6/
		来源：力扣（LeetCode）
		著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。 * 
	 * @param arr1
	 * @param arr2
	 * @return
	 */
	//定义一个方法接收两个数组，返回两个数组的最长公共子序列
		static int getLCS(int[] arr1, int[] arr2) {
			//过滤掉不合理的值
			if (arr1 == null || arr2 == null || arr1.length == 0 || arr2.length == 0) {
				return 0;
			}
			//准备二维一个数组记录下子问题的解，使用递推方式自下而上计算
			int[][] dp = new int[arr1.length + 1][arr2.length + 1];
			for (int i = 1; i <= arr1.length; i++) {
				for (int j = 1; j <= arr2.length; j++) {
					//判断是否相等
					if (arr1[i - 1] == arr2[j - 1]) {
						dp[i][j] = dp[i - 1][j - 1] + 1;
						System.out.println("===dp[i - 1][j - 1]:"+dp[i - 1][j - 1]);
					} else {
						dp[i][j] = Math.max(dp[i - 1][j], dp[i][j - 1]);
						System.out.println("i-1:"+(i-1)+",j:"+j+",dp[i - 1][j]:"+dp[i - 1][j]);
						System.out.println("dp[i][j - 1]:"+dp[i][j - 1]);
					}
//					System.out.println("i:"+i +",j:"+j + ",dp[i][j]:"+dp[i][j]);
				}	
			}
			return dp[arr1.length][arr2.length];
		}
		
			// 一维数组实现。
			/**
			 * 一维数组和二维比较：解析
			 *   原本二维数组记录数据 方式  dp[i][j]
			 *   		dp[1][1] dp[1][2] dp[1][3] 
			 * 			dp[2][1] dp[2][2] dp[2][3] 
			 * 			dp[3][1] dp[3][2] dp[3][3] 
			 * 			dp[4][1] dp[4][2] dp[4][3] 
			 * 返回 dp[4][3]的值。
			 * 		替换为一维数组时，相当于 dp[i][j]的值，不管i怎么变，dp[j]都会覆盖之前dp[i][j]的值。
			 *   例如：dp[1][1]， dp[2][1] 在一维数组中， dp[1] 肯定前面两者的最大值。相当于覆盖。 
			 *   		示例 ： 当i=1,  j = 1  此时元素相等
			 *   		二维数组  ，dp[i][j] = dp[i - 1][j - 1] + 1   = 1 
			 *   		一维数组， dp[j] = leftTop + 1 = 1  
			 * 		只需要关注j的值即可，返回
			 * 				当i=1,  j = 2  此时元素不相等
			 * 			二维数组  ，dp[i][j] = Math.max(dp[i - 1][j], dp[i][j - 1])  
			 * 					其中dp[i - 1][j]=0  ，dp[i][j - 1]=1  ，最大值为1
			 *   		一维数组， dp[j] = Math.max(dp[j], dp[j - 1]);  
			 *   				dp[j]=1,dp[j-1]=1    ，最大值为1
			 *   		通过示例可以验证 《dp[j]都会覆盖之前dp[i][j]的值》
			 *   		既然求最大值，故满足
			 */			
			static int getOneArray(int[] arr1, int[] arr2) {
				//过滤掉不合理的值
				if (arr1 == null || arr2 == null || arr1.length == 0 || arr2.length == 0) {
					return 0;
				}
				int[] dp = new int[arr1.length + 1];
				for (int i = 1; i <= arr1.length; i++) {
					int tmp=0;
					for (int j = 1; j <= arr2.length; j++) {
						/**
						 * 相当于 tmp赋值给left先用 ，用完后覆盖tmp=dp[j]，供内层下次循环使用
						 */
						int leftTop=tmp;// i =1 ,2 ,3 。。 时， 第一次的leftTop都固定从0开始
						tmp=dp[j];
						//判断是否相等
						if (arr1[i - 1] == arr2[j - 1]) {
							// 二维数组=dp[i][j] = dp[i - 1][j - 1] + 1;
							// 替换为1维数组时 ，每次使用dp[j-1] + 1 替换即可 ， 此时 leftTop = dp[j-1]
							dp[j] = leftTop + 1;
							System.out.println("==leftTop"+leftTop);
						} else {
							//因为取值的时候是，参考 双数组，  取dp[i-1][j]或者 dp[i][j-1]最大。   
							//换算过来就是 ， dp[i-1][j]  = dp[j] ,  dp[i][j-1] =  dp[j - 1]
							// 即 一维数组只保存j的值（每次遍历i， 都会重新更新j的值，  ） 此时二位数组中决定数据的值，相当于只关注j值即可。  
							dp[j] = Math.max(dp[j], dp[j - 1]);  
							System.out.println("dp[j]:"+dp[j] +",dp[j-1]:"+dp[j - 1]);
						}
//						System.out.println("i:"+i +",j:"+j +",dp:"+dp[j] +",tmp:"+tmp  + ",leftTop:" + leftTop);
					}

				}
				return dp[arr2.length];
			}
	
//			System.out.println((i - 1)+","+j + "]++[" +i+","+ (j-1));
			
			
			/**
			 * 	
			 * 	不能正序， 因为内层循环正序，  字符串比较顺序反了。
			 * 
			 * @param arr1
			 * @param arr2
			 * @return
			
			static int getOneArrayByZhengxu(int[] arr1, int[] arr2) {
				//过滤掉不合理的值
				if (arr1 == null || arr2 == null || arr1.length == 0 || arr2.length == 0) {
					return 0;
				}
				int[] dp = new int[arr1.length + 1];
				for (int i = 1; i <= arr1.length; i++) {
					int tmp=0;
					for (int j = arr2.length; j >= 1; j--) {
						int leftTop=tmp;// i =1 ,2 ,3 。。 时， 第一次的leftTop都固定从0开始
						tmp=dp[j];
						if (arr1[i - 1] == arr2[j - 1]) {
							dp[j] = leftTop + 1;
						} else {
							dp[j] = Math.max(dp[j], dp[j + 1]);  
						}
					}
					
				}
				return dp[1];
			}
	 */
	
	public static void main(String[] args) {
		int[] arr1 = {1, 1,3, 5,10, 9,11};
		int[] arr2 = {1, 4,1,9,10,11};
//		int[] ar = {11,10,9,1,4,1};
//		int longSeq = getLongSeq(s1, s2);
//		System.out.println(longSeq);
		
//		int[] arr1 = {1, 1, 9, 5};
//		int[] arr2 = {1,5, 9};
//		System.out.println(getLCS(arr1, arr2));
		System.out.println(getOneArray(arr1, arr2));
//		System.out.println(getOneArrayByZhengxu(arr1, arr2));
	}
	
	/**
	 * 打印示例：
	 * 

示例数组：int[] arr1 = {1, 1, 9, 5};
		int[] arr2 = {1,5, 9};

==== == == == ==  1维数组打印

i:1,j:1,dp:1,tmp:0,leftTop0
i:1,j:2,dp:1,tmp:0,leftTop0
i:1,j:3,dp:1,tmp:0,leftTop0
i:2,j:1,dp:1,tmp:1,leftTop0
i:2,j:2,dp:1,tmp:1,leftTop1
i:2,j:3,dp:1,tmp:1,leftTop1
i:3,j:1,dp:1,tmp:1,leftTop0
i:3,j:2,dp:1,tmp:1,leftTop1
i:3,j:3,dp:2,tmp:1,leftTop1
i:4,j:1,dp:1,tmp:1,leftTop0
i:4,j:2,dp:2,tmp:1,leftTop1
i:4,j:3,dp:2,tmp:2,leftTop1


内层循环12此
==leftTop0

dp[j]:1,dp[j-1]:1

dp[j]:1,dp[j-1]:1

==leftTop0

dp[j]:1,dp[j-1]:1

dp[j]:1,dp[j-1]:1

dp[j]:1,dp[j-1]:0

dp[j]:1,dp[j-1]:1

==leftTop1

dp[j]:1,dp[j-1]:0

==leftTop1

dp[j]:2,dp[j-1]:2


==== == == == ==  二维数组打印
i:1,j:1,dp[i][j]:1
i:1,j:2,dp[i][j]:1
i:1,j:3,dp[i][j]:1
i:2,j:1,dp[i][j]:1
i:2,j:2,dp[i][j]:1
i:2,j:3,dp[i][j]:1
i:3,j:1,dp[i][j]:1
i:3,j:2,dp[i][j]:1
i:3,j:3,dp[i][j]:2
i:4,j:1,dp[i][j]:1
i:4,j:2,dp[i][j]:2
i:4,j:3,dp[i][j]:2



内层循环12此
===dp[i - 1][j - 1]:0

i-1:0,j:2,dp[i - 1][j]:0
dp[i][j - 1]1

i-1:0,j:3,dp[i - 1][j]:0
dp[i][j - 1]1

===dp[i - 1][j - 1]:0

i-1:1,j:2,dp[i - 1][j]:1
dp[i][j - 1]1

i-1:1,j:3,dp[i - 1][j]:1
dp[i][j - 1]1

i-1:2,j:1,dp[i - 1][j]:1
dp[i][j - 1]0

i-1:2,j:2,dp[i - 1][j]:1
dp[i][j - 1]1

===dp[i - 1][j - 1]:1

i-1:3,j:1,dp[i - 1][j]:1
dp[i][j - 1]0

===dp[i - 1][j - 1]:1

i-1:3,j:3,dp[i - 1][j]:2
dp[i][j - 1]2
2d



	 * 
	 */
}
