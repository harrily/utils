package utils;

import java.io.BufferedOutputStream;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.DataInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Arrays;

import thread.MessageThread;
import thread.SnifferEntityMid;

public class ByteConvert {
   
	/**
	 * 将int转为高字节在前，低字节在后的byte数组
	 */
	public static byte[] intToByteArray( int integer) {
		int byteNum = (40 -Integer.numberOfLeadingZeros (integer < 0 ? ~integer : integer))/ 8;
		byte[] byteArray = new byte[4];
 
		for (int n = 0; n < byteNum; n++)
		byteArray[3 - n] = (byte) (integer>>> (n * 8));
 
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
	     * 根据byte数组，生成文件
	     * filePath  文件路径
	     * fileName  文件名称（需要带后缀，如*.jpg、*.java、*.xml）
	     */
	    public static void saveFile(byte[] bfile, String filePath,String fileName) {
	        BufferedOutputStream bos = null;
	        FileOutputStream fos = null;
	        File file = null;
	        try {
	            File dir = new File(filePath);
	            if(!dir.exists()&&dir.isDirectory()){//判断文件目录是否存在
	                dir.mkdirs();
	            }
	            file = new File(filePath + File.separator + fileName);
	            fos = new FileOutputStream(file);
	            bos = new BufferedOutputStream(fos);
	            bos.write(bfile);
	        } catch (Exception e) {
	            e.printStackTrace();
	        } finally {
	            if (bos != null) {
	                try {
	                    bos.close();
	                } catch (IOException e1) {
	                    e1.printStackTrace();
	                }
	            }
	            if (fos != null) {
	                try {
	                    fos.close();
	                } catch (IOException e1) {
	                    e1.printStackTrace();
	                }
	            }
	        }
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
	    
	
	public static void main(String[] args) throws Exception {
		
		byte[] bytes_domain = "w755".getBytes();  //  [119, 55, 53, 53]  即w对应的askII值（十进制）= 119 ，其余同理
		//System.out.println(bytes_domain.length);
		byte[] bytes_gateway = "075599998888".getBytes(); //[48, 55, 53, 53, 57, 57, 57, 57, 56, 56, 56, 56]
		byte[] bytes_mobileNum = "2".getBytes(); // [50]
		byte[] bytes_mobileRssi1 = "-99".getBytes(); // [45, 57, 57]
		byte[] bytes_mobileRssi2 = "-100".getBytes(); // [45, 49, 48, 48]
		byte[] bytes_timeStamp1 = "1457938738".getBytes(); // [49, 52, 53, 55, 57, 51, 56, 55, 51, 56]
		byte[] bytes_timeStamp2 = "1457938739".getBytes(); // [49, 52, 53, 55, 57, 51, 56, 55, 51, 57]
		byte[] bytes_timeGps = "114.052872_22.668605".getBytes(); // [49, 49, 52, 46, 48, 53, 50, 56, 55, 50, 95, 50, 50, 46, 54, 54, 56, 54, 48, 53]
		byte[] bytes_timeStation = "28655".getBytes(); // [50, 56, 54, 53, 53]
		
		
		byte[] data = new byte[2048];//自己定义一下数据包的长度
		
		/** 
		 * 构建version & header     
		 */
		byte version_header = 0x68; // 通过16进制构建前8位的数字。 [ 0110 1000   合起来就是01101000，十六进制就是68 ]      // 68=2位16进制数=8位二进数
		data[0] = version_header;
		/** 
		 * 构建TOS  服务类型，二进制,unsigned char类型，8bit， 默认0表示探针数据，1表示热点数据。
		 */
		data[1] = 0x0;  //0001  0000   
		/** 
		 * 构建datalen     数据段（Data format）长度 ，16bit       
		 */
		byte data_len1 =  0x13;  // 通过16进制构建16位的数字的前8位   0001 0011
		byte data_len2 = 0x14;   // 通过16进制构建16位的数字 的后8位   0001 0100        合在一起的十进制 =4884     
		data[2] = data_len1;  
		data[3] = data_len2;
		/** 
		 * 构建CheckSum     无符号短整型(unsigned short)，16bit，整个报文的校验和
		 */
		byte Check_sum1 =  0x00;  // 通过16进制构建16位的数字的前8位 
		byte Check_sum2 = 0x00;  // 通过16进制构建16位的数字 的后8位    
		data[4] = Check_sum1;
		data[5] = Check_sum2;
		/** 
		 * 构建DeviceType  181:思联
		 */
		System.out.println(data.length);
		data[6] = (byte) 181;  // 十进制181 = 二进制 1011 0101  也即1个字节8位 
		/** 
		 * 构建Reserved     保留字段，8bit，即一个字节，暂时未使用
		 */
		//data[7] = (byte) 255;  // 十进制255 = 二进制 1111 1111  也即1个字节8位 
		
		/** 
		 * 构建Domain    域名，当前值为空字符串
		 * byte[] bytes_domain = "w755".getBytes();  //  [119, 55, 53, 53]  即w对应的askII值（十进制）= 119 ，其余同理
		 * 
		 */	
		data[8] = (byte) 119; 
		data[9] = (byte) 55; 
		data[10] = (byte) 53;
		data[11] = (byte) 53;
		
		//  |  = 124
		data[12] = (byte) 124;  // 十进制124 = 二进制0111 1100  也即1个字节8位 
		
		/** 
		 * 构建Gateway_id    网关ID
		 * byte[] bytes_gateway = "075599998888".getBytes(); //[48, 55, 53, 53, 57, 57, 57, 57, 56, 56, 56, 56]
		 * 
		 */	
		data[13] = (byte) 48;   
		data[14] = (byte) 55;   
		data[15] = (byte) 53;   
		data[16] = (byte) 53;   
		data[17] = (byte) 57;   
		data[18] = (byte) 57;   
		data[19] = (byte) 57;   
		data[20] = (byte) 57;   
		data[21] = (byte) 56;   
		data[22] = (byte) 56;
		data[23] = (byte) 56;
		data[24] = (byte) 56;
		
		//  |  = 124
		data[25] = (byte) 124;  // 十进制124 = 二进制0111 1100  也即1个字节8位 
		
		/** 
		 * 构建Lan_mac    路由器MAC  
		 */	
		data[26] = (byte) 132;  //  8482F425F184
		data[27] = (byte) 130;  //  8482F425F184
		data[28] = (byte) 244;  //  8482F425F184
		data[29] = (byte) 37;  //  8482F425F184
		data[30] = (byte) 241;  //  8482F425F184
		data[31] = (byte) 132;  //  8482F425F184	
		
		//  |  = 124
		data[32] = (byte) 124;  // 十进制124 = 二进制0111 1100  也即1个字节8位 
		
		/** 
		 * 构建wlan_mac   无线MAC  
		 */	
		data[33] = (byte) 132;  //  8482F425F199 
		data[34] = (byte) 130;  //  8482F425F199
		data[35] = (byte) 244;  //  8482F425F199
		data[36] = (byte) 37;  //  8482F425F199
		data[37] = (byte) 241;  //  8482F425F199
		data[38] = (byte) 153;  //  8482F425F199			

		//  |  = 124
		data[39] = (byte) 124;  // 十进制124 = 二进制0111 1100  也即1个字节8位 
				
		/** 
		 * 构建Mobile_num    手机MAC数量
		 * byte[] bytes_mobileNum = "2".getBytes(); // [50]
		 */	
		data[40] = (byte) 50;
		
		//  |  = 124
		data[41] = (byte) 124;  // 十进制124 = 二进制0111 1100  也即1个字节8位 
		
		/** 
		 * 构建mobile_mac   mobile_MAC 
		 *  
		 */	
		data[42] = (byte) 62;  //  3E16B985FFD5 
		data[43] = (byte) 22;  //  3E16B985FFD5
		data[44] = (byte) 185;  //  3E16B985FFD5
		data[45] = (byte) 133;  //  3E16B985FFD5
		data[46] = (byte) 255;  //  3E16B985FFD5
		data[47] = (byte) 213;  //  3E16B985FFD5				
		
		//  :  = 58
		data[48] = (byte) 58;  // 十进制58 
		
		/** 
		 * 构建Mobile_rssi    手机wifi信号强度
		 * byte[] bytes_mobileRssi1 = "-99".getBytes(); // [45, 57, 57]
		 * 
		 */	
		data[49] = (byte) 45; 
		data[50] = (byte) 57;
		data[51] = (byte) 57;
		
		//  :  = 58
		data[52] = (byte) 58;  // 十进制58 
				
		/** 
		 * 构建Time_stamp   采集时间，Unix时间戳
		 * byte[] bytes_timeStamp1 = "1457938738".getBytes(); // [49, 52, 53, 55, 57, 51, 56, 55, 51, 56]
		 */	
		data[53] = (byte) 49;
		data[54] = (byte) 52; 
		data[55] = (byte) 53; 
		data[56] = (byte) 55; 
		data[57] = (byte) 57; 
		data[58] = (byte) 51; 
		data[59] = (byte) 56; 
		data[60] = (byte) 55; 
		data[61] = (byte) 51; 
		data[62] = (byte) 56; 
		
		
		//  :  = 58
		data[63] = (byte) 58;  // 十进制58 
		
		/** 
		 * 构建Is_virtual   Mobile_mac标记(0:正常MAC，1:虚假MAC)
		 */	
		data[64] = 0x00;  // 二进制 00001000  = 十进制的17 
		
		//  :  = 58
		data[65] = (byte) 58;  // 十进制58 		

		/** 
		 * 构建Frame_flag   帧类型(由subtype和type各4bit组成，前4bit为subtype，后4bit为type)。
		 */	
		data[66] = 0x40; // 通过16进制构建8位的数字。 [ 0011 0111  合起来就是11 0111， 十进制是55 ]      // 68=2位16进制数=8位二进数
		
		//  :  = 58
		data[67] = (byte) 58;  // 十进制58 
		
		/** 
		 * 构建GPS    
		 * byte[] bytes_timeGps = "114.052872_22.668605".getBytes(); 
		 * // [49, 49, 52, 46, 48, 53, 50, 56, 55, 50, 95, 50, 50, 46, 54, 54, 56, 54, 48, 53]
		 */	
		data[68] = (byte) 49;
		data[69] = (byte) 49;
		data[70] = (byte) 52;
		data[71] = (byte) 46;
		data[72] = (byte) 48;
		data[73] = (byte) 53;
		data[74] = (byte) 50;
		data[75] = (byte) 56;
		data[76] = (byte) 55;
		data[77] = (byte) 50;
		data[78] = (byte) 95;
		data[79] = (byte) 50;
		data[80] = (byte) 50;
		data[81] = (byte) 46;
		data[82] = (byte) 54;
		data[83] = (byte) 54;
		data[84] = (byte) 56;
		data[85] = (byte) 54;
		data[86] = (byte) 48;
		data[87] = (byte) 53;
		
		//  :  = 58
		data[88] = (byte) 58;  // 十进制58	
		/** 
		 * 构建station_id   
		 * byte[] bytes_timeStation = "28655".getBytes(); // [50, 56, 54, 53, 53]
		 */	
		data[89] = (byte) 50;
		data[90] = (byte) 56; 
		data[91] = (byte) 54; 
		data[92] = (byte) 53; 
		data[93] = (byte) 53; 
		
		//  |  = 124
		data[94] = (byte) 124;  // 十进制124 = 二进制0111 1100  也即1个字节8位 
		
		/** 
		 * 构建第二个  mobile_mac   mobile_MAC  
		 */	
		data[95] = (byte) 62;  //  3E16B985FFD8 
		data[96] = (byte) 22;  //  3E16B985FFD8
		data[97] = (byte) 185;  //  3E16B985FFD8
		data[98] = (byte) 133;  //  3E16B985FFD8
		data[99] = (byte) 255;  //  3E16B985FFD8
		data[100] = (byte) 216;  //  3E16B985FFD8				
		
		//  :  = 58
		data[101] = (byte) 58;  // 十进制58 
		
		/** 
		 * 构建Mobile_rssi    手机wifi信号强度
		 * byte[] bytes_mobileRssi2 = "-100".getBytes(); // [45, 49, 48, 48]
		 */	
		data[102] = (byte) 45;  
		data[103] = (byte) 49;
		data[104] = (byte) 48;
		data[105] = (byte) 48;
		
		//  :  = 58
		data[106] = (byte) 58;  // 十进制58 
				
		/** 
		 * 构建Time_stamp   采集时间，Unix时间戳
		 * byte[] bytes_timeStamp2 = "1457938739".getBytes(); // [49, 52, 53, 55, 57, 51, 56, 55, 51, 57]
		 */	
		data[107] = (byte) 49;
		data[108] = (byte) 52; 
		data[109] = (byte) 53; 
		data[110] = (byte) 55; 
		data[111] = (byte) 57; 
		data[112] = (byte) 51; 
		data[113] = (byte) 56; 
		data[114] = (byte) 55; 
		data[115] = (byte) 51; 
		data[116] = (byte) 57; 
		
		//  :  = 58
		data[117] = (byte) 58;  // 十进制58 
		
		/** 
		 * 构建Is_virtual   Mobile_mac标记(0:正常MAC，1:虚假MAC)
		 */	
		data[118] = 0x01;  // 二进制 00001000  = 十进制的17 
		
		//  :  = 58
		data[119] = (byte) 58;  // 十进制58 		

		/** 
		 * 构建Frame_flag   帧类型(由subtype和type各4bit组成，前4bit为subtype，后4bit为type)。
		 */	
		data[120] = 0x40; // 通过16进制构建8位的数字。 [ 0011 0111  合起来就是11 0111， 十进制是55  ]      // 68=2位16进制数=8位二进数
		
		//  :  = 58
		data[121] = (byte) 58;  // 十进制58 
		
		/** 
		 * 构建GPS    
		 */	
		data[122] = (byte) 49;
		data[123] = (byte) 49;
		data[124] = (byte) 52;
		data[125] = (byte) 46;
		data[126] = (byte) 48;
		data[127] = (byte) 53;
		data[128] = (byte) 50;
		data[129] = (byte) 56;
		data[130] = (byte) 55;
		data[131] = (byte) 50;
		data[132] = (byte) 95;
		data[133] = (byte) 50;
		data[134] = (byte) 50;
		data[135] = (byte) 46;
		data[136] = (byte) 54;
		data[137] = (byte) 54;
		data[138] = (byte) 56;
		data[139] = (byte) 54;
		data[140] = (byte) 48;
		data[141] = (byte) 53;
		
		
		
		//  :  = 58
		data[142] = (byte) 58;  // 十进制58	
		/** 
		 * 构建station_id   
		 */	
		data[143] = (byte) 50;
		data[144] = (byte) 56; 
		data[145] = (byte) 54; 
		data[146] = (byte) 53; 
		data[147] = (byte) 53; 
		
		//  |  = 124
		data[148] = (byte) 124;  // 十进制124 = 二进制0111 1100  也即1个字节8位 
		
		byte[] encryptDES = DesECBUtil.encryptDES(data, "!@#$%^00");
		
		//saveFile(encryptDES, "E:\\note\\20190221_工作交接\\探针对接思联\\byte_array_backup", "encryptDES.txt");
		byte[] bytesByFile = getBytes("E:\\note\\20190221_工作交接\\探针对接思联\\byte_array_backup\\encryptDES.txt");
		//byte[] bytesByFile2 = getBytes("C:\\Users\\Administrator\\Desktop\\encryptDES.txt");
		SnifferEntityMid parseMessage = MessageThread.parseMessage(bytesByFile);
		
		
		boolean equals = Arrays.equals(encryptDES, bytesByFile);
		System.out.println(equals);
		/*
		 * DataInputStream dis = new DataInputStream(new ByteArrayInputStream(data));
		 * byte version_header_resolve = (byte) dis.readUnsignedByte(); int version =
		 * version_header_resolve >> 4; // 获取前8位的前四位 int header = version_header_resolve
		 * & 0x0F; // 获取前8位的后四位 System.out.println("version:"+version); //6
		 * System.out.println("header:"+header); //8 int tos = dis.readUnsignedByte();
		 * System.out.println("tos:"+ tos); //0 0x0 对应的十进制也为0 int dataLen =
		 * dis.readUnsignedShort(); System.out.println("dataLen:"+ dataLen); //4884
		 * 两个8位的（16进制）数构成 0x13、0x14 ，合在一起就是16位 0x1314 对应的十进制就是 4884 int CheckSum =
		 * dis.readUnsignedShort(); System.out.println("CheckSum:"+ CheckSum); //4884
		 * int device_type = dis.readUnsignedByte(); System.out.println("device_type:"+
		 * device_type); //0 0x0 对应的十进制也为0 int reserved = dis.readUnsignedByte();
		 * System.out.println("reserved:"+ reserved); //0 0x0 对应的十进制也为0
		 */		
	}
}
