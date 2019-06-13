package my_test;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.DataInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Arrays;

import thread.MessageThread;
import thread.SnifferEntityMid;

public class ByteConvertSilian {

	/**
	 * 将int转为高字节在前，低字节在后的byte数组
	 */
	public static byte[] intToByteArray(int integer) {
		int byteNum = (40 - Integer.numberOfLeadingZeros(integer < 0 ? ~integer : integer)) / 8;
		byte[] byteArray = new byte[4];

		for (int n = 0; n < byteNum; n++)
			byteArray[3 - n] = (byte) (integer >>> (n * 8));

		return byteArray;
	}

	/**
	 * 将int转为低字节在前，高字节在后的byte数组
	 */
	public static byte[] tolh(int n) {
		byte[] b = new byte[1];
		b[0] = (byte) (n & 0xff);
		/*
		 * b[1] = (byte) (n >> 8 & 0xff); b[2] = (byte) (n >> 16 & 0xff); b[3] = (byte)
		 * (n >> 24 & 0xff);
		 */
		return b;
	}
	 /** 
     * 获得指定文件的byte数组 
     */  
    public static  byte[] getBytes(String filePath){  
        byte[] buffer = null;  
        try {  
            File file = new File(filePath);  
            FileInputStream fis = new FileInputStream(file);  
            ByteArrayOutputStream bos = new ByteArrayOutputStream(1000);  
            byte[] b = new byte[1000];  
            int n;  
            while ((n = fis.read(b)) != -1) {  
                bos.write(b, 0, n);  
            }  
            fis.close();  
            bos.close();  
            buffer = bos.toByteArray();  
        } catch (FileNotFoundException e) {  
            e.printStackTrace();  
        } catch (IOException e) {  
            e.printStackTrace();  
        }  
        return buffer;  
    }
    /**
	 * 校验和的计算/校验
	 * 计算时返回0为正确
	 * 校验时返回的值即为CRC
	 * @param decryDatas
	 * @return
	 */
	public static int checkSum(byte[] decryDatas) {


	    if (decryDatas == null) return 0;

	    try {
			DataInputStream  dis = null;
			//解析报文数据
//			byte[] decryDatas = DesECBUtil.decryptByteDES(datas, Constant.UDP_KEY);
			dis = new DataInputStream(new ByteArrayInputStream(decryDatas));
			
	
			int cksum = 0;
		    int size = decryDatas.length;
		    while (size > 1) {
		        cksum +=  dis.readUnsignedShort();
		        size -= 2;
		    }
	
		    if (size > 0) {
		        cksum += dis.readUnsignedByte();
		    }
	
		    cksum = (cksum >> 16) + (cksum & 0xffff);
		    cksum += (cksum >> 16);
	
		    return (short)~cksum;
	    } catch(Exception e) {
	    	e.printStackTrace();
	    	return 0;
	    }

	}
	public static void main(String[] args) throws Exception {
		
		byte[] bytesByFile = getBytes("C:\\Users\\Administrator\\Documents\\WeChat Files\\nan2628020\\FileStorage\\File\\2019-04\\wifiprobe.dat");
		SnifferEntityMid parseMessage2 = MessageThread.parseMessage(bytesByFile);
		
		/**
		 *  校验checkSum是否正确 
		 *    重构字节的长度（因为加密之后长度边长）
		 * */
		byte[] data2 = DesECBUtil.decryptByteDES(bytesByFile,"!@#$%^00");
		byte[] copyOf = Arrays.copyOf(data2, data2.length -16);
		int crc_check = checkSum(copyOf);
		System.out.println("重构之后的crc_check:"+crc_check);
		
		
		/**
		 * null字符串拼接
		StringBuilder sb = new StringBuilder();
		String lng_lat = "";
		String station_id = "";
		sb.append("123").append("\t");
		sb.append(lng_lat).append("\t");
		sb.append(station_id);
		System.out.println("#"+sb+"#");
		**/
		
		
		
		/**
		 * byte[] intToByteArray = intToByteArray(6);
		 * System.out.println("length:"+intToByteArray.length); byte[] tolh = tolh(6);
		 * 
		 * DataInputStream dis = new DataInputStream(new
		 * ByteArrayInputStream(intToByteArray)); //int read = dis.readInt();
		 * 
		 * byte version_header = (byte) dis.readUnsignedByte(); int version =
		 * version_header >> 4; int version2 = (int)version_header;
		 * 
		 * 
		 * System.out.println("version:"+version2);
		

		byte[] data = new byte[2048];// 自己定义一下数据包的长度

		byte parseByte = Byte.parseByte("-90");
		byte[] bytes = "-90".getBytes();  //[45, 57, 48]
		data[0] = parseByte;
System.out.println(parseByte); */
		/**
		 * 构建version & header
		 */
		/*
		 * //byte version_header = 0x68; // 通过十六进制构建前8位的数。 [ 0110 1000
		 * 合起来就是01101000，十六进制就是68 ] // 68=2位16进制数=8位二进数 //byte version_header = 104;
		 * //通过十进制构建前8位的数 byte version_header = 0b01101000; //通过二进制构建前8位的数,
		 * （01101000），即十进制的104 16进制的68 [且都是占用1个字节都是8位。比较发现还是16进制的形式可以形象看到前4位与后4位的数字]
		 * 
		 * 
		 *//**
			 * java中int类型可以占4个字节 ，最多32位。
			 * 
			 * 十进制 0 15 16 256 65535 二进制 0 1111 10000 100000000 10000000000000000 占位 4 4 8
			 * 12 16
			 *//*
				 * data[0] = version_header; DataInputStream dis = new DataInputStream(new
				 * ByteArrayInputStream(data)); byte version_header_resolve = (byte)
				 * dis.readUnsignedByte(); int version1 = version_header_resolve >> 4; //
				 * 获取前8位的前四位 int header1 = version_header_resolve & 0x0F; // 获取前8位的后四位
				 * System.out.println("version:"+version1); //6
				 * System.out.println("header:"+header1); //8
				 */

	}
}
