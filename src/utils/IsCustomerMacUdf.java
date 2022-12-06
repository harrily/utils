//package utils;
//
//import java.util.Arrays;
//import java.util.List;
//
//public class IsCustomerMacUdf {
//    //判断二进制mac的第41位，若为1则为虚假mac
//    static List<Character> oui41Char = Arrays.asList(new Character[]{'0','4','8','c'});
//
//    public IsCustomerMacUdf() {
//    }
//
//    public static boolean evaluate(String mac) {
//        String simpleMac = MacUtil.getSimpleMac(mac);
//        if(simpleMac == null) {
//            return false;
//        } else {
//            boolean isOuiMac = isOuiMac(simpleMac);
////            boolean isOuiMac = CacheUtil.isOuiMac(simpleMac);
//			/*
//			 * boolean isRouteMac = CacheUtil.isRouteMac(simpleMac); return isOuiMac &&
//			 * !isRouteMac;
//			 */
//            return isOuiMac;
//        }
//    }
//
//    public static boolean evaluate2(String mac) {
//        String simpleMac = MacUtil.getSimpleMac(mac);
//        if(simpleMac == null) {
//            return false;
//        } else {
//            boolean isOuiMac = StrToBinstr(simpleMac);
//			/*
//			 * boolean isRouteMac = CacheUtil.isRouteMac(simpleMac); return isOuiMac &&
//			 * !isRouteMac;
//			 */
//            return isOuiMac;
//        }
//    }
//    
//    public static boolean evaluate3(String mac) {
//        String simpleMac = MacUtil.getSimpleMac(mac);
//        if(simpleMac == null) {
//            return false;
//        } else {
//            boolean isOuiMac = MacToBinstr(simpleMac);
//			/*
//			 * boolean isRouteMac = CacheUtil.isRouteMac(simpleMac); return isOuiMac &&
//			 * !isRouteMac;
//			 */
//            return isOuiMac;
//        }
//    }
//    
//    
//
//    //取mac二进制的41位
//    public static boolean StrToBinstr(String str) {
//        char[] strChar=str.toCharArray();
//        String result="";
//        for(int i=0;i<strChar.length;i++){
//        	//int parseUnsignedInt = Integer.parseUnsignedInt(String.valueOf(strChar[i]), 2);
//        	String binstr = Integer.toBinaryString(strChar[i]);
//        	//java中char是2个字节 = 16位
//        	int numALl = 8;
//        	if(binstr.length() < numALl) {
//        		int num = numALl - binstr.length();
//        		for(int i1=0 ;i1 <num;i1++) {
//        			binstr = "0" + binstr;
//        		}
//        	}
//            result += binstr+ "";
//        }
//        System.out.println("Binary:"+result);
//        //System.out.println("Binary40 :"+result.charAt(41));
//        if("1".equals(String.valueOf(result.charAt(46)))){
//        	return false;
//        }
//        return true;
//    }
//    
//    //判断mac的二进制的第6位数值，为0则真实，为1则虚假
//    public static boolean MacToBinstr(String str) {
//    	 int index = 6;
//    	 String parseHexStr2Byte = bytes2BinaryStr(parseHexStr2Byte(str));
//    	 System.out.println("---: "+parseHexStr2Byte.length()+ " 下标是七的数为： "+parseHexStr2Byte.charAt(7));
//    	 if("1".equals(String.valueOf(parseHexStr2Byte.charAt(index)))){
//         	return false;
//         }
//		return true;
//    }
//    
//    
//    private static boolean isOuiMac(String simpleMac) {
//        return oui41Char.contains(simpleMac.charAt(1));
//    }
//
//    
//
//    
//    public static String evaluate(String mac, String defauleTrue, String defauleFalse) {
//        String simpleMac = MacUtil.getSimpleMac(mac);
//        if(simpleMac == null) {
//            return defauleFalse;
//        } else {
//            boolean isOuiMac = CacheUtil.isOuiMac(simpleMac);
//            boolean isRouteMac = CacheUtil.isRouteMac(simpleMac);
//            return isOuiMac && !isRouteMac?defauleTrue:defauleFalse;
//        }
//    }
//    
//    
//    
//    /**
//     * @description 将16进制转换为二进制
//     * 
//     * @param hexStr
//     * @return
//     */
//    public static byte[] parseHexStr2Byte(String hexStr) {
//        if (hexStr.length() < 1)
//            return null;
//            byte[] result = new byte[hexStr.length() / 2];
//            for (int i = 0; i < hexStr.length() / 2; i++) {
//                int high = Integer.parseInt(hexStr.substring(i * 2, i * 2 + 1), 16);
//                int low = Integer.parseInt(hexStr.substring(i * 2 + 1, i * 2 + 2), 16);
//                result[i] = (byte) (high * 16 + low);
//            }
//            return result;
//        }
//    
//    private static String hexStr =  "0123456789ABCDEF";
//    private static String[] binaryArray =   
//        {"0000","0001","0010","0011",  
//        "0100","0101","0110","0111",  
//        "1000","1001","1010","1011",  
//        "1100","1101","1110","1111"};  
//    /** 
//     *  
//     * @param bytes 
//     * @return 将二进制转换为十六进制字符输出 
//     */  
//    public static String BinaryToHexString(byte[] bytes){  
//        
//        String result = "";  
//        String hex = "";  
//        for(int i=0;i<bytes.length;i++){  
//            //字节高4位  
//            hex = String.valueOf(hexStr.charAt((bytes[i]&0xF0)>>4));  
//            //字节低4位  
//            hex += String.valueOf(hexStr.charAt(bytes[i]&0x0F));  
//            result +=hex+" ";  
//        }  
//        return result;  
//    }  
//    
//    
//    /** 
//     *  
//     * @param str 
//     * @return byte[] 转换为二进制字符串 
//     */  
//    public static String bytes2BinaryStr(byte[] bArray){  
//          
//        String outStr = "";  
//        int pos = 0;  
//        for(byte b:bArray){  
//            //高四位  
//            pos = (b&0xF0)>>4;  
//            outStr+=binaryArray[pos];  
//            //低四位  
//            pos=b&0x0F;  
//            outStr+=binaryArray[pos];  
//        }  
//        return outStr;  
//          
//    }  
//    
//    public static void main(String[] args) {
//        IsCustomerMacUdf udf = new IsCustomerMacUdf();
//        //String[] datas = new String[]{"000000000000", "ffffffffffff", "7c1dd957dad1", "c8eea619af33", "c482F40FFF88"};
//        String[] datas = new String[]{"000000000000", "ffffffffffff", "7c1dd957dad1", "C482F40FFF88","28A1EBF3D984","DCF0909755B5","B4C7997F22F3","DAA119D0E09C","c8eea619af33","01005E0000FB","01259EEEEEEE"};
//        String[] arr$ = datas;
//        int len$ = datas.length;
//
//		
//		for(int i$ = 0; i$ < len$; ++i$) { 
//			String data = arr$[i$];
//			System.out.println(data + "==" + udf.evaluate(data));
//			System.out.println(data + "##" + udf.evaluate3(data)+"\n"); 
//		}
//		 
//        
//        // 333300000016 = 1100110011001100000000000000000000000000010110 长度为46，故 前面补位两位00
//		/*
//		 * String length = "001100110011001100000000000000000000000000010110";
//		 * System.out.println(length.length());
//		 */
//		
//        //System.out.println(length.charAt(41));//  下标为41 【从后向前查】
//        /**
//		         * 通过设置地址的第一个八位字节的第二最低有效位[即下标为6] 来区分通用管理和本地管理的地址。该位也称为U / L位，是Universal / Local的缩写，用于标识地址的管理方式。
//		         * 如果该位为0，则通用地管理该地址。如果是1，则在本地管理地址。
//		         * 在示例地址06-00-00-00-00-00中，第一个八位字节是06（十六进制），其二进制形式是00000110，其中第二个最低有效位是1.因此，它是本地管理的地址。
//         */
//		/*
//		 * System.out.println(length.charAt(6)); // 下标为6 【从前向后查】 String parseHexStr2Byte
//		 * = bytes2BinaryStr(parseHexStr2Byte("333300000016"));
//		 * System.out.println(parseHexStr2Byte);
//		 */
//    }
//}
