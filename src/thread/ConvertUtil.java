package thread;
import java.io.ByteArrayInputStream;  
import java.io.ByteArrayOutputStream;  
import java.io.IOException;  
import java.io.ObjectInputStream;  
import java.io.ObjectOutputStream;  
import java.io.Serializable;  
import java.nio.ByteBuffer;
import java.security.MessageDigest;  
import java.security.NoSuchAlgorithmException;  
  
/*** 
 * 转码   MD5工具�? 
 * @author lwd
 * 
 */  
public final class ConvertUtil {  
  
    public final static char[] BToA = "0123456789abcdef".toCharArray();  
    private static ByteBuffer buffer = ByteBuffer.allocate(8);  
    private ConvertUtil() {  
  
    }  
  
    /** 
     * �?16进制字符串转换成字节数组 
     *  
     * @param hex 
     * @return 
     */  
    public static byte[] hexStringToByte(String hex) {  
        int len = (hex.length() / 2);  
        byte[] result = new byte[len];  
        char[] achar = hex.toCharArray();  
        for (int i = 0; i < len; i++) {  
            int pos = i * 2;  
            result[i] = (byte) (toByte(achar[pos]) << 4 | toByte(achar[pos + 1]));  
        }  
        return result;  
    }  
  
    private static byte toByte(char c) {  
        byte b = (byte) "0123456789ABCDEF".indexOf(c);  
        return b;  
    }  
  
    /** 
     * 把字节数组转换成16进制字符�? 
     *  
     * @param bArray 
     * @return 
     */  
    public static final String bytesToHexString(byte[] bArray) {  
        if(bArray == null )  
        {  
            return "";  
        }  
        StringBuffer sb = new StringBuffer(bArray.length);  
        String sTemp;  
        for (int i = 0; i < bArray.length; i++) {  
            sTemp = Integer.toHexString(0xFF & bArray[i]);  
            if (sTemp.length() < 2)  
                sb.append(0);  
            sb.append(sTemp.toUpperCase());  
        }  
        return sb.toString();  
    }  
  
    /** 
     * 把字节数组转换为对象 
     *  
     * @param bytes 
     * @return 
     * @throws IOException 
     * @throws ClassNotFoundException 
     */  
    public static final Object bytesToObject(byte[] bytes) throws IOException,  
            ClassNotFoundException {  
        ByteArrayInputStream in = new ByteArrayInputStream(bytes);  
        ObjectInputStream oi = new ObjectInputStream(in);  
        Object o = oi.readObject();  
        oi.close();  
        return o;  
    }  
  
    /** 
     * 把可序列化对象转换成字节数组 
     *  
     * @param s 
     * @return 
     * @throws IOException 
     */  
    public static final byte[] objectToBytes(Serializable s) throws IOException {  
        ByteArrayOutputStream out = new ByteArrayOutputStream();  
        ObjectOutputStream ot = new ObjectOutputStream(out);  
        ot.writeObject(s);  
        ot.flush();  
        ot.close();  
        return out.toByteArray();  
    }  
  
    public static final String objectToHexString(Serializable s)  
            throws IOException {  
        return bytesToHexString(objectToBytes(s));  
    }  
  
    public static final Object hexStringToObject(String hex)  
            throws IOException, ClassNotFoundException {  
        return bytesToObject(hexStringToByte(hex));  
    }  
  
    /** 
     * @函数功能: BCD码转�?10进制�?(阿拉伯数�?) 
     * @输入参数: BCD�? 
     * @输出结果: 10进制�? 
     */  
    public static String bcd2Str(byte[] bytes) {  
        StringBuffer temp = new StringBuffer(bytes.length * 2);  
  
        for (int i = 0; i < bytes.length; i++) {  
            temp.append((byte) ((bytes[i] & 0xf0) >>> 4));  
            temp.append((byte) (bytes[i] & 0x0f));  
        }  
        return temp.toString().substring(0, 1).equalsIgnoreCase("0") ? temp  
                .toString().substring(1) : temp.toString();  
    }  
  
    /** 
     * @函数功能: 10进制串转为BCD�? 
     * @输入参数: 10进制�? 
     * @输出结果: BCD�? 
     */  
    public static byte[] str2Bcd(String asc) {  
        int len = asc.length();  
        int mod = len % 2;  
  
        if (mod != 0) {  
            asc = "0" + asc;  
            len = asc.length();  
        }  
  
        byte abt[] = new byte[len];  
        if (len >= 2) {  
            len = len / 2;  
        }  
  
        byte bbt[] = new byte[len];  
        abt = asc.getBytes();  
        int j, k;  
  
        for (int p = 0; p < asc.length() / 2; p++) {  
            if ((abt[2 * p] >= '0') && (abt[2 * p] <= '9')) {  
                j = abt[2 * p] - '0';  
            } else if ((abt[2 * p] >= 'a') && (abt[2 * p] <= 'z')) {  
                j = abt[2 * p] - 'a' + 0x0a;  
            } else {  
                j = abt[2 * p] - 'A' + 0x0a;  
            }  
  
            if ((abt[2 * p + 1] >= '0') && (abt[2 * p + 1] <= '9')) {  
                k = abt[2 * p + 1] - '0';  
            } else if ((abt[2 * p + 1] >= 'a') && (abt[2 * p + 1] <= 'z')) {  
                k = abt[2 * p + 1] - 'a' + 0x0a;  
            } else {  
                k = abt[2 * p + 1] - 'A' + 0x0a;  
            }  
  
            int a = (j << 4) + k;  
            byte b = (byte) a;  
            bbt[p] = b;  
        }  
        return bbt;  
    }  
  
    public static String BCD2ASC(byte[] bytes) {  
        StringBuffer temp = new StringBuffer(bytes.length * 2);  
  
        for (int i = 0; i < bytes.length; i++) {  
            int h = ((bytes[i] & 0xf0) >>> 4);  
            int l = (bytes[i] & 0x0f);  
            temp.append(BToA[h]).append(BToA[l]);  
        }  
        return temp.toString();  
    }  
  
    /** 
     * 两字符数组异�? 
     */  
    public static byte[] byteArrXor(byte[] arr1, byte[] arr2, int len){  
        byte[] dest = new byte[len];  
          
        if((arr1.length < len) || (arr2.length < len)){  
            return null;  
        }  
          
        for(int i = 0;i < len;i++){  
            dest[i] = (byte)(arr1[i] ^ arr2[i]);  
        }  
          
        return dest;  
    }  
      
  
    /** 
     * MD5加密字符串，返回加密后的16进制字符�? 
     * @param origin 
     * @return 
     */  
    public static String MD5EncodeToHex(String origin) {  
        return bytesToHexString(MD5Encode(origin));  
    }  
  
    /** 
     * MD5加密字符串，返回加密后的字节数组 
     *  
     * @param origin 
     * @return 
     */  
    public static byte[] MD5Encode(String origin) {  
        return MD5Encode(origin.getBytes());  
    }  
  
    /** 
     * MD5加密字节数组，返回加密后的字节数�? 
     *  
     * @param bytes 
     * @return 
     */  
    public static byte[] MD5Encode(byte[] bytes) {  
        MessageDigest md = null;  
        try {  
            md = MessageDigest.getInstance("MD5");  
            return md.digest(bytes);  
        } catch (NoSuchAlgorithmException e) {  
            e.printStackTrace();  
            return new byte[0];  
        }  
  
    }  
  //byte 数组�? int 的相互转�?  
    public static int byteArrayToInt(byte[] b) {  
        return   b[3] & 0xFF |  
                (b[2] & 0xFF) << 8 |  
                (b[1] & 0xFF) << 16 |  
                (b[0] & 0xFF) << 24;  
    }  
      
    public static byte[] intToByteArray(int a) {  
        return new byte[] {  
            (byte) ((a >> 24) & 0xFF),  
            (byte) ((a >> 16) & 0xFF),     
            (byte) ((a >> 8) & 0xFF),     
            (byte) (a & 0xFF)  
        };  
    }  
  //byte 数组�? long 的相互转�?  
    public static byte[] longToBytes(long x) {  
        buffer.putLong(0, x);  
        return buffer.array();  
    }  
   
    public static long bytesToLong(byte[] bytes) {  
        buffer.put(bytes, 0, bytes.length);  
        buffer.flip();//need flip   
        return buffer.getLong();  
    } 
  //byte �? int 的相互转�?  
    public static byte intToByte(int x) {  
        return (byte) x;  
    }  
      
    public static int byteToInt(byte b) {  
        //Java 总是�? byte 当做有符处理；我们可以�?�过将其�? 0xFF 进行二进制与得到它的无符�?  
        return b & 0xFF;  
    }
    /** 
     * 通过byte数组取到short 
     *  
     * @param b 
     * @param index 
     *            第几位开始取 
     * @return 
     */  
    public static short getShort(byte[] b, int index) {  
        return (short) (((b[index + 1] << 8) | b[index + 0] & 0xff));  
    }

	/**
	 * @param header
	 * @param i
	 * @return
	 */
	public static int getInt(byte[] bb, int index) {
		return (int) ((((bb[index + 3] & 0xff) << 24)  
                | ((bb[index + 2] & 0xff) << 16)  
                | ((bb[index + 1] & 0xff) << 8) | ((bb[index + 0] & 0xff) << 0))); 
	}  
}  