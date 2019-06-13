/**
* 文件名：DesECBUtil.java
* 创建日期： 2016年3月30日
* 作者：     lwd
* Copyright (c) 2009-2016 架构平台组
* All rights reserved.
 
* 修改记录：
* 	1.修改时间：2016年3月30日
*   修改人：lwd
*   修改内容：
*/
package my_test;

/**
 * 功能描述：
 *
 */
import java.security.Key;
import java.security.SecureRandom;

import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.DESKeySpec;
import javax.crypto.spec.SecretKeySpec;
  
  
  
/*** 
 * DES ECB对称加密 解密 
 * @author lwd 
 * 
 */  
public class DesECBUtil {  
    /** 
     * 加密数据 
     * @param encryptString  注意：这里的数据长度只能为8的倍数 
     * @param encryptKey 
     * @return 
     * @throws Exception 
     */  
	/*
	 * public static String encryptDES(String encryptString, String encryptKey)
	 * throws Exception { SecretKeySpec key = new SecretKeySpec(getKey(encryptKey),
	 * "DES"); Cipher cipher = Cipher.getInstance("DES/ECB/NoPadding");
	 * cipher.init(Cipher.ENCRYPT_MODE, key); byte[] encryptedData =
	 * cipher.doFinal(encryptString.getBytes()); return
	 * ConvertUtil.bytesToHexString(encryptedData); }
	 */
    public static byte[] encryptDES(byte[] encryptString, String encryptKey) throws Exception {  
//        SecretKeySpec key = new SecretKeySpec(getKey(encryptKey), "DES");  
//        Cipher cipher = Cipher.getInstance("DES/ECB/NoPadding");  
//        cipher.init(Cipher.ENCRYPT_MODE, key);  
//        byte[] encryptedData = cipher.doFinal(encryptString);  
//        return encryptedData;  
        

		// DES算法要求有一个可信任的随机数源
		SecureRandom sr = new SecureRandom();
		// 从原始密匙数据创建DESKeySpec对象
		DESKeySpec dks = new DESKeySpec(encryptKey.getBytes());
		// 创建一个密匙工厂，然后用它把DESKeySpec转换成
		// 一个SecretKey对象
		SecretKeyFactory keyFactory = SecretKeyFactory.getInstance("DES");
		SecretKey securekey = keyFactory.generateSecret(dks);
		// Cipher对象实际完成加密操作
		Cipher cipher = Cipher.getInstance("DES");
		// 用密匙初始化Cipher对象
		cipher.init(Cipher.ENCRYPT_MODE, securekey, sr);
		// 现在，获取数据并加密
		// 正式执行加密操作
		return cipher.doFinal(encryptString);
    }  
      
    /** 
     * 自定义一个key 
     * @param string  
     */  
    public static byte[] getKey(String keyRule) {  
        Key key = null;  
        byte[] keyByte = keyRule.getBytes();  
        // 创建一个空的八位数组,默认情况下为0  
        byte[] byteTemp = new byte[8];  
        // 将用户指定的规则转换成八位数组  
        for (int i = 0; i < byteTemp.length && i < keyByte.length; i++) {  
            byteTemp[i] = keyByte[i];  
        }  
        key = new SecretKeySpec(byteTemp, "DES");  
        return key.getEncoded();  
    }  
      
    /*** 
     * 解密数据 
     * @param decryptString 
     * @param decryptKey 
     * @return 
     * @throws Exception 
     */  
	/*
	 * public static String decryptDES(String decryptString, String decryptKey)
	 * throws Exception { SecretKeySpec key = new SecretKeySpec(getKey(decryptKey),
	 * "DES"); Cipher cipher = Cipher.getInstance("DES/ECB/NoPadding");
	 * cipher.init(Cipher.DECRYPT_MODE, key); byte decryptedData[] =
	 * cipher.doFinal(ConvertUtil.hexStringToByte(decryptString)); return new
	 * String(decryptedData); }
	 */
    public static  byte [] decryptByteDES(byte[] data, String decryptKey) throws Exception {  
        SecretKeySpec key = new SecretKeySpec(getKey(decryptKey), "DES");  
        Cipher cipher = Cipher.getInstance("DES/ECB/NoPadding");  
        cipher.init(Cipher.DECRYPT_MODE, key);  
        byte [] decryptedData = cipher.doFinal(data);  
        return decryptedData;  
    } 
}  
