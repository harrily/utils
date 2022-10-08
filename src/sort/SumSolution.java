package sort;

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

	

	   
	   public static void main(String[] args) {
		   int[] top = new int[] {35,75,5,9};
//		   System.out.println(twoSum(top, 14));
//		   System.out.println(twoSum2(top, 14));
		   System.out.println(twoSum1(top, 14));
	}
}
