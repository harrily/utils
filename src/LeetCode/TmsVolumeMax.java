package LeetCode;

public class TmsVolumeMax {
	/*
	使用动态规划求解货物组合的最大占用空间(每辆车)
	*/
	//定义一个方法求解
	/**
	* 求取一辆车最大使用空间
	* @param v:货物的体积数组
	* @param capacity：车辆的容积
	* @return
	*/
	public static int getMaxVolume(int[] v ,int capacity) {
		int[][] dp = new int[v.length+1 ] [capacity+1 ];
		for (int i = 1 ; i<=v.length ; i++){
			for(int j = 1 ; j<=capacity ; j++){
				if(j<v[i-1]){
					dp[i][j] = dp[i-1][j];
				}else{
					dp[i][j] = Math.max(dp[i-1][j],dp[i-1][j-v[i-1]] + v[i-1]);
				}
			}
		}
		printGoodsInfo(dp, v, capacity);
		return dp[v.length][capacity];
	}
	
	public static void printGoodsInfo(int[][] dp, int[] v, int capacity) {
		//从后往前遍历二维数组
		int i = v.length;
		int j = capacity;
		while(i>0 && j>0) {
			try {
				if (dp[i][j] == dp[i - 1][j - v[i - 1]] + v[i - 1]) {
					//说明了volumeArr[i - 1]这件物品被选择了
					System.out.println("选择了体积为" + v[i - 1] + "货物,数组中下标记为" + (i-1));
					//j的值改变
					j = j - v[i - 1];
					//标记被选择的物品
					v[i - 1] = 0;
				} 
			} catch (Exception e) {
				// TODO: handle exception
			}
			// 当前层找到数据，返回上一层继续遍历。
			i--;
		}
		
	}
		public static void main(String[] args) {
			//准备体积数据
			int[] volumeArr={1,2,3,4,5,6};
			//容积数据
			int capacity=10;
			final int maxVolume = getMaxVolume(volumeArr, capacity);
			System.out.println(maxVolume);
		}
}
