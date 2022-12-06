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
	
	public static void main(String[] args) {
		int[] s1 = {1, 1,3, 5,10, 9,11};
		int[] s2 = {1, 4,1,9,10,11};
		int longSeq = getLongSeq(s1, s2);
		System.out.println(longSeq);
	}
	
}
