package LeetCode;

import java.util.Arrays;

public class FlipAndInvertImage {
	
	public static void main(String[] args) {
//		int b[] = {1,2,3};
//		System.out.println(Arrays.toString(	b)	);
		
//		int [][] A ={{1,1,0},{1,0,1},{0,0,0}};
		int [][] A ={{1,0,0,1}};
		for (int [] a : flipAndInvertImage2(A)){
			  System.out.println(Arrays.toString(a)	);
		}
	}
	/**
	 * 
	 执行结果：通过显示详情执行用时：1 ms, 在所有 Java 提交中击败了49.57%的用户
内存消耗：38.8 MB, 在所有 Java 提交中击败了77.82%的用户

	 * 
	 * 
	 * @param A
	 * @return
	 */
	  public static int[][] flipAndInvertImage(int[][] A) {
		  int [][] B = new int[A.length][ A[0].length];
          for(int i = 0; i < A.length;i++){
        	  int[] a1 = A[i] ;
        	  int[] b1 = new int [a1.length];
        	  int num = 0;
        	  for(int j = a1.length-1; j >=0;j--) {
        		  if(a1[j] == 0) {
        			  a1[j] = 1; 
        		  }else{
        			  a1[j] = 0;
        		  }
        		  b1[num]  = a1[j];
        		  num++;
        	  }
        	  B[i] = b1;
          }
		return B;
  }
	  /**
	   *   
	  位异或运算（^）
	  运算规则是：两个数转为二进制，然后从高位开始比较，如果相同则为0，不相同则为1。
	   * @param A
	   * @return
	   */
	  public static int[][] flipAndInvertImage2(int[][] A) {
          for(int i = 0; i < A.length;i++){
        	  for(int j = A[i].length-1; j >= (A[i].length )/2;j--) {
        		  int tmp = A[i][j] ^1;
        		  A[i][j] = A[i][A[i].length - j -1  ]^1;
        		  A[i][A[i].length - j -1  ] = tmp;
        	  }
          }
		return A;
  }
	  /**
	   * for循环中i++与++i的区别（根本区别）
在for循环中++i与i++到底有没有区别，只放在for循环里，区别不大，但是要明白他们的区别i++是先用后加，
++i是先加后用，所以区别就是。。。看下面代码你就懂啦。
//模拟a=i++;
temp=i;
i=i+1;
a=temp;
 
//模拟a=++i;
i=i+1;
a=i;

i++需要多一个临时存储空间，操作上也要多一步赋值，所以效率上，++i要更快一些。
参考资料：https://blog.csdn.net/weixin_44343282/article/details/104577393?utm_medium=distribute.pc_relevant_t0.none-task-blog-BlogCommendFromMachineLearnPai2-1.compare&depth_1-utm_source=distribute.pc_relevant_t0.none-task-blog-BlogCommendFromMachineLearnPai2-1.compare
	   * 
	   * @param A
	   * @return
	   */
	  public static int[][] flipAndInvertImage3(int[][] A) {
		  int C = A[0].length;
	        for (int[] row: A)
	            for (int i = 0; i < (C + 1) / 2; ++i) {
	                int tmp = row[i] ^ 1;
	                row[i] = row[C - 1 - i] ^ 1;
	                row[C - 1 - i] = tmp;
	            }

	        return A;
  }
	
}
