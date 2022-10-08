package LeetCode;

public class MiddleNum {

	 public static  double findMedianSortedArrays(int[] nums1, int[] nums2) {
		 int[] nums = new int[nums1.length + nums2.length];
		 for(int j = 0 ; j < nums1.length ;j++) {
			 nums[j ] = nums1[j];
		 }
		 for(int j = 0 ; j < nums2.length ;j++) {
			 nums[nums1.length + j  ] = nums2[j];
		 }
		 
		 
		 	for(int i = 0 ;i < nums.length ;i++ ) {
		 		for(int j = 0 ; j < nums.length ;j++) {
	 				if( nums[i] < nums[j]) {
	 					int tmp = nums[i];
	 					nums[i] = nums[j];
	 					nums[j] = tmp;
//	 					System.out.println(nums[i]);
//	 					 for(int n = 0;n<nums.length;n++) {
//	 						 System.out.println(nums[n]);
//	 					 }
	 				}
//	 				 System.out.println("===========");
		 		}
		 	}
//		 for(int i = 0;i<nums.length;i++) {
//			 System.out.println(nums[i]+"---");
//		 }
		 		int n = nums.length / 2 ;
		 		System.out.println( nums.length);
		 		 if( nums.length % 2 != 0) {
//		 			 System.out.println( (double)nums[n]);
		 			 return (double)nums[n];
		 		 }else {
//		 			 System.out.println( ((float)(nums[n] + nums[n-1] ) / 2 ));
		 			 return ((float)(nums[n] + nums[n-1] ) / 2 );
		 		 }
		 
	    }
		public static void main(String[] args) {
			 int[] nums1 = new int[] {4,1};
			 int[] nums2 = new int[] {2,3,5,7};
			findMedianSortedArrays(nums1, nums2);
		}
}
