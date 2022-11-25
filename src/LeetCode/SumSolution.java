package LeetCode;

import java.util.HashMap;
import java.util.Map;

public class SumSolution {
	   public static int[] twoSum(int[] nums, int target) {
		   int[] result = new int[2];
           for (int i = 0 ;i< nums.length ;i++ ){
//               System.out.println("i="+i);
               for (int j = 0 ;j< nums.length ;j++ ){
//            	   System.out.println("j="+j);
            	  if( nums[i] + nums[j]  == target & i != j & j>i) {
//            		  System.out.println("i,j"+i+','+j);
            		  result =  new int[] {i ,j};
            	  }
               }
           }
           return result;
   }
	   
	   public static int[] twoSum2(int[] nums, int target) {
	        int n = nums.length;
	        for (int i = 0; i < n; ++i) {
	        	System.out.println("i:"+i);
	            for (int j = i + 1; j < n; ++j) {
	                if (nums[i] + nums[j] == target) {
	                	System.out.println("i,j:"+i+','+j);
	                    return new int[]{i, j};
	                }
	            }
	        }
	        return new int[0];
	    }
	   
	   /* 
	    * 	hashmap
	    * */
	   public static int[] twoSum1(int[] nums, int target) {
	        Map<Integer, Integer> hashtable = new HashMap<Integer, Integer>();
//	        for (int i = 0; i < nums.length; ++i) {
//	            if (hashtable.containsKey(target - nums[i])) {
//	                return new int[]{hashtable.get(target - nums[i]), i};
//	            }
//	            hashtable.put(nums[i], i);
//	            System.out.println("===:"+nums[i] + "===" + i);
//	        }
	        for(int i = 0 ; i < nums.length; ++i) {
	        	if(hashtable.containsKey(target - nums[i]) ) {
	        		System.out.println(hashtable.get(target - nums[i]) +"," +i);
	        		return new int [] {hashtable.get(target - nums[i]),i};
	        	}
	        	hashtable.put(nums[i], i);
//	        	System.out.println("===:"+nums[i] + "===" + i);
	        }
	        return new int[0];
	    }
/**
 * 
 * 
 给定一个字符串 s ，找到 它的第一个不重复的字符，并返回它的索引 。如果不存在，则返回 -1 。

示例 1：

输入: s = "leetcode"
输出: 0
示例 2:

输入: s = "loveleetcode"
输出: 2
示例 3:

输入: s = "aabb"
输出: -1

来源：力扣（LeetCode）
链接：https://leetcode.cn/problems/first-unique-character-in-a-string

使用Map放值，标记重复元素。取出第一个非重复元素；
 * @param s
 * @return
 */
	    public static int getIndex(String s) {
	    	char[] charArray = s.toCharArray();
	    	HashMap<Object, Object> map = new HashMap<>();
	    	for(int i = 0 ; i<charArray.length ; i++) {
	    		if(map.containsKey(charArray[i])) {
	    			map.put(charArray[i], -1);
	    		}else {
	    			map.put(charArray[i], i);
	    		}
	    	}
	    	for(int i = 0 ; i<charArray.length ; i++) {
	    		if( (int)map.get(charArray[i]) != -1) {
	    			return (int)map.get(charArray[i]);
	    		}
	    	}
			return -1;
	    }
	    
	    // 路人思路。  循环charArray  。indexOf 找出当前字符的第一次索引， lastIndexOf当前字符最后一次索引， 想等说明无重复，返回i， 循环完没有则返回-1
	    public static int getIndexDemo(String s) {
	    	  for(int i=0; i<s.length(); i++){
	              int first = s.indexOf(s.charAt(i));
	              int last = s.lastIndexOf(s.charAt(i));
	              if(first ==  last){
	                  return i;
	              }
	          }
	          return -1;
	    }
	   
	   public static void main(String[] args) {
		   int[] top = new int[] {35,75,5,9};
//		   System.out.println(twoSum(top, 14));
//		   System.out.println(twoSum2(top, 14));
		   System.out.println(twoSum1(top, 14)); 	 	
		   System.out.println(getIndexDemo("asfsadg2eqr13"));
	}
}
