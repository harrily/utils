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
	int[] values= {6,3,5,4,6};
	int[] weights={2,2,6,5,4};
	int capacity=10;
	
	public void sack(int[] value, int[] weight) {
		for(int i =0 ; i < value.length ; i++) {
			for(int j = 0 ; j < value.length ; j++) {
				
			}
		}
		
	}
	
	
	public static void main(String[] args) {
		
	}
}
