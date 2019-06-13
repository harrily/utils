package my_test;

import java.io.BufferedOutputStream;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import thread.ConvertUtil;
import thread.MessageThread;
import thread.SnifferEntityMid;

public class ByteConvert_null {
   
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
//				byte[] decryDatas = DesECBUtil.decryptByteDES(datas, Constant.UDP_KEY);
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
		
		
		public static byte[] assembleHeader(int version, int headLen, int tops, int dataLen, int crc, int deviceType, int reserved) {

			ByteArrayOutputStream bos = new ByteArrayOutputStream();
			DataOutputStream dos = new DataOutputStream(bos);
			try {
				//版本号 Vesion
				byte test = (byte) ((version << 4) + (headLen));
				dos.writeByte(test);
				//Tos
				dos.writeByte(tops);
				//Datalen
				dos.writeShort(dataLen);
				//CRC
				dos.writeShort(crc);
				//DeviceType
				dos.writeByte(deviceType);
				//保留字段没有值，故不作checkSum计算        移证实为错误说法。。
				if(reserved != 0) {
					System.out.println("********************************");
					dos.writeByte(reserved);
				}
				
				return bos.toByteArray();
			} catch (IOException e) {
				e.printStackTrace();
				return null;
			} finally {
				try {
					if(bos != null) {
						bos.flush();
						bos.close();
					}
					if(dos != null) {
						dos.flush();
						dos.close();
					}
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		
		public static byte[] assembleHeader2(int version, int headLen, int tops, int dataLen, int crc, int deviceType, int reserved) {

			ByteArrayOutputStream bos = new ByteArrayOutputStream();
			DataOutputStream dos = new DataOutputStream(bos);
			try {
				//版本号 Vesion
				byte test = (byte) ((version << 4) + (headLen));
				dos.writeByte(test);
				//Tos
				dos.writeByte(tops);
				//Datalen
				dos.writeShort(dataLen);
				//CRC
				dos.writeShort(crc);
				//DeviceType
				dos.writeByte(deviceType);
				//使用方法拼接时，需加上这个保留字段，因为需要保留位置。  [因为胃空，所以默认为0]
				dos.writeByte(reserved);
				
				return bos.toByteArray();
			} catch (IOException e) {
				e.printStackTrace();
				return null;
			} finally {
				try {
					if(bos != null) {
						bos.flush();
						bos.close();
					}
					if(dos != null) {
						dos.flush();
						dos.close();
					}
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		
		/**
		 * 根据对象重组报文
		 * @param snifferEntityMid
		 * @return
		 */
		public static byte[] updateMessage(SnifferEntityMid snifferEntityMid) {
			ByteArrayOutputStream bos = new ByteArrayOutputStream();
			DataOutputStream dos = new DataOutputStream(bos);
			
			try {
				byte[] data = null;

				
				dos.writeBytes(snifferEntityMid.getDomain());
				dos.writeBytes("|");

				dos.writeBytes(snifferEntityMid.getGateWay_id());
				dos.writeBytes("|");

				data = ConvertUtil.hexStringToByte(snifferEntityMid.getLan_mac());
				dos.write(data, 0, data.length);
				dos.writeBytes("|");

				data = ConvertUtil.hexStringToByte(snifferEntityMid.getWlan_mac());
				dos.write(data, 0, data.length);
				dos.writeBytes("|");

				dos.writeBytes(snifferEntityMid.getMobile_num() + "");
				dos.writeBytes("|");
				
				List<String> list = snifferEntityMid.getMobile_macs();
				//3E16B985FFD5:-99:1457938738:0:0:4:114.052872_22.668605:28655
				for(String str : list) {
					String[] arr = str.split(":");
					if(arr.length > 0 ) {
						data = ConvertUtil.hexStringToByte(arr[0]);
						dos.write(data, 0, data.length);
					}
					if(arr.length > 1 ) {
						dos.writeBytes(":");
						dos.writeBytes(arr[1]);
					}
					if(arr.length > 2 ) {
						dos.writeBytes(":");
						dos.writeBytes(arr[2]);
					}
					if(arr.length > 3 ) {
						dos.writeBytes(":");
						dos.writeByte(Short.parseShort(arr[3]));
					}
					if(arr.length > 5 ) {
						dos.writeBytes(":");
						//arr[4] = type = 0    arr[5] = subtype = 4     0x40=01000000      对应的十进制应该=64
						System.out.println("arr[4] "+ ( Integer.parseInt(arr[5]) << 4  ) );    //64
						System.out.println("arr[5] "+ ( Integer.parseInt(arr[4]) & 0x0F  ) );  //0 
						System.out.println("arr[4] + arr[5] ：  "+ ((Integer.parseInt(arr[5]) << 4) + (Integer.parseInt(arr[4]) & 0x0F)) ); //64
						/**
						 *  "|"表示的是或运算，即两个二进制数同位中，只要有一个为1则结果为1，若两个都为1其结果也为1
						 *  "&"表示的是与运算，即两个二进制数同位中，两个操作数中位都为1，结果才为1，否则结果为0
						 *  
						 *  java中有三种移位运算符
								<<      :     左移运算符，num << 1,相当于num乘以2
								>>      :     右移运算符，num >> 1,相当于num除以2
								>>>     :     无符号右移，忽略符号位，空位都以0补齐
						 *  
						 *   位运算，subtype左移四位的int值，（补全为8位） ， 再加上低位的4位（type的int值），得出8位的int值，即subtype+type组合而成的十进制数
						 *  */
						byte testOld = (byte) ((Integer.parseInt(arr[5]) << 4) + (Integer.parseInt(arr[4]) & 0x0F));
						//现在使用的逻辑，因为subtype和type合在一起为16进制。 故将此16进制数转
						dos.writeByte(testOld);
					}
					if(arr.length > 6 ) {
						dos.writeBytes(":");
						dos.writeBytes(arr[6]);
					}
					if(arr.length > 7 ) {
						dos.writeBytes(":");
						dos.writeBytes(arr[7]);
					}
					dos.writeBytes("|");
				}

				dos.flush();
				dos.close();

				byte[] dataBytes = bos.toByteArray();
				
				//协议头在最后添加，字段长度和CRC需要在最后计算  [104, 0, 0, 125, 0, 0, -75]
				byte[] headBytes = assembleHeader2(snifferEntityMid.getVersion(), snifferEntityMid.getHeader(), snifferEntityMid.getTos(), 
						dataBytes.length, 0, Integer.parseInt(snifferEntityMid.getReserved()), 0);  //8
				headBytes = Arrays.copyOf(headBytes, dataBytes.length + headBytes.length); //133
				//复制dataBytes至数组headBytes后
				System.arraycopy(dataBytes, 0, headBytes, headBytes.length - dataBytes.length, dataBytes.length);
				//计算CRC 全部报文的数据（包括头部和dataFrame）
				int crc = checkSum(headBytes); 
				/**
				 * 
				 *  -28708转化为十进制就是36828
				 *  1、取-28708的绝对值得二进制
				 *  	0111 0000 0010 0100	28708
				 *	2、-1
				 *		0111 0000 0010 0011
				 *	3、取反
				 *		1000 1111 1101 1100 
				 *		得到十进制为36828
				 *  
				 *  反过来36828对应的负数为：
				 *	1000 1111 1101 1100	36828	
				 *	0111 0000 0010 0011  取反
				 *	0111 0000 0010 0100 +1	28708
				 *  得到十进制负数为 -28708
				 */
				System.out.println("checkSum(crs):"+crc); //-28708  所对应的十进制数为36828
				//重新构建Head
				headBytes = assembleHeader2(snifferEntityMid.getVersion(), snifferEntityMid.getHeader(), snifferEntityMid.getTos(), 
						dataBytes.length, crc, Integer.parseInt(snifferEntityMid.getReserved()), 0);  //8
				//Arrays.copyOf()方法返回的数组是新的数组对象，原数组对象仍是原数组对象，不变，该拷贝不会影响原来的数组。
				headBytes = Arrays.copyOf(headBytes, dataBytes.length + headBytes.length);//133 
				System.arraycopy(dataBytes, 0, headBytes, headBytes.length - dataBytes.length, dataBytes.length);
				
				/** 校验checkSum是否正确 */
				int crc_check = checkSum(headBytes);
				System.out.println("校验checkSum是否正确:"+crc_check+"==="+headBytes.length+"||"+DesECBUtil.encryptDES(headBytes, "!@#$%^00").length);
				
				//加密
				return DesECBUtil.encryptDES(headBytes, "!@#$%^00");
				
			} catch (IOException e) {
				e.printStackTrace();
				return null;
			} catch (Exception e) {
				e.printStackTrace();
				return null;
			} finally {
				try {
					if(bos != null) {
						bos.flush();
						bos.close();
					}
					if(dos != null) {
						dos.flush();
						dos.close();
					}
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
			
		}
		
	public static void main(String[] args) throws Exception {
		
		byte[] bytes_domain = "".getBytes();  //  [119, 55, 53, 53]  即w对应的askII值（十进制）= 119 ，其余同理
		//System.out.println(bytes_domain.length);
		byte[] bytes_gateway = "".getBytes(); //[48, 55, 53, 53, 57, 57, 57, 57, 56, 56, 56, 56]
		byte[] bytes_mobileNum = "2".getBytes(); // [50]
		byte[] bytes_mobileRssi1 = "-99".getBytes(); // [45, 57, 57]
		byte[] bytes_mobileRssi2 = "-100".getBytes(); // [45, 49, 48, 48]
		byte[] bytes_timeStamp1 = "1457938738".getBytes(); // [49, 52, 53, 55, 57, 51, 56, 55, 51, 56]
		byte[] bytes_timeStamp2 = "1457938739".getBytes(); // [49, 52, 53, 55, 57, 51, 56, 55, 51, 57]
		byte[] bytes_timeGps = "114.052872_22.668605".getBytes(); // [49, 49, 52, 46, 48, 53, 50, 56, 55, 50, 95, 50, 50, 46, 54, 54, 56, 54, 48, 53]
		byte[] bytes_timeStation = "28655".getBytes(); // [50, 56, 54, 53, 53]
		
		
		byte[] data = new byte[133];//自己定义一下数据包的长度   实际应该为133.   以前为2048...
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
		 * 构建datalen        数据段（Data format）长度 ，16bit    当前测试数据长度为125  [0111 1101] 
		 */
		byte data_len1 =  0x0;  // 通过16进制构建16位的数字的前8位   0000 0000
		byte data_len2 = 0x7d;   // 通过16进制构建16位的数字 的后8位   0111 1101        合在一起的十进制 =125     
		data[2] = data_len1;  
		data[3] = data_len2;
		/** 
		 * 构建CheckSum     无符号短整型(unsigned short)，16bit，整个报文的校验和
		 */
		byte Check_sum1 =  0x00;  // 通过16进制构建16位的数字的前8位   [104, 0, 0, 125, -31, -52, -75, -75]
		byte Check_sum2 = 0x00;  // 通过16进制构建16位的数字 的后8位
		data[4] = (byte) 150;
		data[5] = (byte) 205;
		
		/** 
		 * 构建DeviceType  181:思联
		 */
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
		//data[8] = (byte) 119; 
		//data[9] = (byte) 55; 
		//data[10] = (byte) 53;
		//data[11] = (byte) 53;
		
		//  |  = 124
		data[8] = (byte) 124;  // 十进制124 = 二进制0111 1100  也即1个字节8位 
		
		/** 
		 * 构建Gateway_id    网关ID
		 * byte[] bytes_gateway = "075599998888".getBytes(); //[48, 55, 53, 53, 57, 57, 57, 57, 56, 56, 56, 56]
		 * 
		 */	
		//data[13] = (byte) 48;   
		//data[14] = (byte) 55;   
		//data[15] = (byte) 53;   
		//data[16] = (byte) 53;   
		//data[17] = (byte) 57;   
		//data[18] = (byte) 57;   
		//data[19] = (byte) 57;   
		//data[20] = (byte) 57;   
		//data[21] = (byte) 56;   
		//data[22] = (byte) 56;
		//data[23] = (byte) 56;
		//data[24] = (byte) 56;
		
		//  |  = 124
		data[9] = (byte) 124;  // 十进制124 = 二进制0111 1100  也即1个字节8位 
		
		/** 
		 * 构建Lan_mac    路由器MAC  
		 */	
		data[10] = (byte) 132;  //  8482F425F184
		data[11] = (byte) 130;  //  8482F425F184
		data[12] = (byte) 244;  //  8482F425F184
		data[13] = (byte) 37;  //  8482F425F184
		data[14] = (byte) 241;  //  8482F425F184
		data[15] = (byte) 132;  //  8482F425F184	
		
		//  |  = 124
		data[16] = (byte) 124;  // 十进制124 = 二进制0111 1100  也即1个字节8位 
		
		/** 
		 * 构建wlan_mac   无线MAC  
		 */	
		data[17] = (byte) 132;  //  8482F425F199 
		data[18] = (byte) 130;  //  8482F425F199
		data[19] = (byte) 244;  //  8482F425F199
		data[20] = (byte) 37;  //  8482F425F199
		data[21] = (byte) 241;  //  8482F425F199
		data[22] = (byte) 153;  //  8482F425F199			

		//  |  = 124
		data[23] = (byte) 124;  // 十进制124 = 二进制0111 1100  也即1个字节8位 
				
		/** 
		 * 构建Mobile_num    手机MAC数量
		 * byte[] bytes_mobileNum = "2".getBytes(); // [50]
		 */	
		data[24] = (byte) 50;
		
		//  |  = 124
		data[25] = (byte) 124;  // 十进制124 = 二进制0111 1100  也即1个字节8位 
		
		/** 
		 * 构建mobile_mac   mobile_MAC 
		 *  
		 */	
		data[26] = (byte) 62;  //  3E16B985FFD5 
		data[27] = (byte) 22;  //  3E16B985FFD5
		data[28] = (byte) 185;  //  3E16B985FFD5
		data[29] = (byte) 133;  //  3E16B985FFD5
		data[30] = (byte) 255;  //  3E16B985FFD5
		data[31] = (byte) 213;  //  3E16B985FFD5				
		
		//  :  = 58
		data[32] = (byte) 58;  // 十进制58 
		
		/** 
		 * 构建Mobile_rssi    手机wifi信号强度
		 * byte[] bytes_mobileRssi1 = "-99".getBytes(); // [45, 57, 57]
		 * 
		 */	
		data[33] = (byte) 45; 
		data[34] = (byte) 57;
		data[35] = (byte) 57;
		
		//  :  = 58
		data[36] = (byte) 58;  // 十进制58 
				
		/** 
		 * 构建Time_stamp   采集时间，Unix时间戳
		 * byte[] bytes_timeStamp1 = "1457938738".getBytes(); // [49, 52, 53, 55, 57, 51, 56, 55, 51, 56]
		 */	
		data[37] = (byte) 49;
		data[38] = (byte) 52; 
		data[39] = (byte) 53; 
		data[40] = (byte) 55; 
		data[41] = (byte) 57; 
		data[42] = (byte) 51; 
		data[43] = (byte) 56; 
		data[44] = (byte) 55; 
		data[45] = (byte) 51; 
		data[46] = (byte) 56; 
		
		
		//  :  = 58
		data[47] = (byte) 58;  // 十进制58 
		
		/** 
		 * 构建Is_virtual   Mobile_mac标记(0:正常MAC，1:虚假MAC)
		 */	
		data[48] = 0x00;  // 二进制 00001000  = 十进制的17 
		
		//  :  = 58
		data[49] = (byte) 58;  // 十进制58 		

		/** 
		 * 构建Frame_flag   帧类型(由subtype和type各4bit组成，前4bit为subtype，后4bit为type)。
		 */	
		data[50] = 0x40; // 通过16进制构建8位的数字。 [ 0011 0111  合起来就是11 0111， 十进制是55 ]      // 68=2位16进制数=8位二进数
		
		//  :  = 58
		data[51] = (byte) 58;  // 十进制58 
		
		/** 
		 * 构建GPS    
		 * byte[] bytes_timeGps = "114.052872_22.668605".getBytes(); 
		 * // [49, 49, 52, 46, 48, 53, 50, 56, 55, 50, 95, 50, 50, 46, 54, 54, 56, 54, 48, 53]
		 */	
		data[52] = (byte) 49;
		data[53] = (byte) 49;
		data[54] = (byte) 52;
		data[55] = (byte) 46;
		data[56] = (byte) 48;
		data[57] = (byte) 53;
		data[58] = (byte) 50;
		data[59] = (byte) 56;
		data[60] = (byte) 55;
		data[61] = (byte) 50;
		data[62] = (byte) 95;
		data[63] = (byte) 50;
		data[64] = (byte) 50;
		data[65] = (byte) 46;
		data[66] = (byte) 54;
		data[67] = (byte) 54;
		data[68] = (byte) 56;
		data[69] = (byte) 54;
		data[70] = (byte) 48;
		data[71] = (byte) 53;
		
		//  :  = 58
		data[72] = (byte) 58;  // 十进制58	
		/** 
		 * 构建station_id   
		 * byte[] bytes_timeStation = "28655".getBytes(); // [50, 56, 54, 53, 53]
		 */	
		data[73] = (byte) 50;
		data[74] = (byte) 56; 
		data[75] = (byte) 54; 
		data[76] = (byte) 53; 
		data[77] = (byte) 53; 
		
		//  |  = 124
		data[78] = (byte) 124;  // 十进制124 = 二进制0111 1100  也即1个字节8位 
		
		/** 
		 * 构建第二个  mobile_mac   mobile_MAC  
		 */	
		data[79] = (byte) 62;  //  3E16B985FFD8 
		data[80] = (byte) 22;  //  3E16B985FFD8
		data[81] = (byte) 185;  //  3E16B985FFD8
		data[82] = (byte) 133;  //  3E16B985FFD8
		data[83] = (byte) 255;  //  3E16B985FFD8
		data[84] = (byte) 216;  //  3E16B985FFD8				
		
		//  :  = 58
		data[85] = (byte) 58;  // 十进制58 
		
		/** 
		 * 构建Mobile_rssi    手机wifi信号强度
		 * byte[] bytes_mobileRssi2 = "-100".getBytes(); // [45, 49, 48, 48]
		 */	
		data[86] = (byte) 45;  
		data[87] = (byte) 49;
		data[88] = (byte) 48;
		data[89] = (byte) 48;
		
		//  :  = 58
		data[90] = (byte) 58;  // 十进制58 
				
		/** 
		 * 构建Time_stamp   采集时间，Unix时间戳
		 * byte[] bytes_timeStamp2 = "1457938739".getBytes(); // [49, 52, 53, 55, 57, 51, 56, 55, 51, 57]
		 */	
		data[91] = (byte) 49;
		data[92] = (byte) 52; 
		data[93] = (byte) 53; 
		data[94] = (byte) 55; 
		data[95] = (byte) 57; 
		data[96] = (byte) 51; 
		data[97] = (byte) 56; 
		data[98] = (byte) 55; 
		data[99] = (byte) 51; 
		data[100] = (byte) 57; 
		
		//  :  = 58
		data[101] = (byte) 58;  // 十进制58 
		
		/** 
		 * 构建Is_virtual   Mobile_mac标记(0:正常MAC，1:虚假MAC)
		 */	
		data[102] = 0x01;  // 二进制 00001000  = 十进制的17 
		
		//  :  = 58
		data[103] = (byte) 58;  // 十进制58 		

		/** 
		 * 构建Frame_flag   帧类型(由subtype和type各4bit组成，前4bit为subtype，后4bit为type)。
		 */	
		data[104] = 0x40; // 通过16进制构建8位的数字。 [ 0011 0111  合起来就是11 0111， 十进制是55  ]      // 68=2位16进制数=8位二进数
		
		//  :  = 58
		data[105] = (byte) 58;  // 十进制58 
		
		/** 
		 * 构建GPS    
		 */	
		data[106] = (byte) 49;
		data[107] = (byte) 49;
		data[108] = (byte) 52;
		data[109] = (byte) 46;
		data[110] = (byte) 48;
		data[111] = (byte) 53;
		data[112] = (byte) 50;
		data[113] = (byte) 56;
		data[114] = (byte) 55;
		data[115] = (byte) 50;
		data[116] = (byte) 95;
		data[117] = (byte) 50;
		data[118] = (byte) 50;
		data[119] = (byte) 46;
		data[120] = (byte) 54;
		data[121] = (byte) 54;
		data[122] = (byte) 56;
		data[123] = (byte) 54;
		data[124] = (byte) 48;
		data[125] = (byte) 53;
		
		
		
		//  :  = 58
		data[126] = (byte) 58;  // 十进制58	
		/** 
		 * 构建station_id   
		 */	
		data[127] = (byte) 50;
		data[128] = (byte) 56; 
		data[129] = (byte) 54; 
		data[130] = (byte) 53; 
		data[131] = (byte) 53; 
		
		//  |  = 124
		data[132] = (byte) 124;  // 十进制124 = 二进制0111 1100  也即1个字节8位 
		
		byte[] encryptDES = DesECBUtil.encryptDES(data, "!@#$%^00");
		System.out.println("=============="+data.length);
		//saveFile(encryptDES, "E:\\note\\20190221_工作交接\\探针对接思联\\byte_array_backup", "encryptDES.txt");
		byte[] bytesByFile = getBytes("E:\\note\\20190221_工作交接\\探针对接思联\\byte_array_backup\\encryptDES.txt");
		//byte[] bytesByFile2 = getBytes("C:\\Users\\Administrator\\Desktop\\encryptDES.txt");
		SnifferEntityMid parseMessage = MessageThread.parseMessage(encryptDES);
		
		
		boolean equals = Arrays.equals(encryptDES, bytesByFile);
		System.out.println(equals);
		
		
		
		//构建初始化报文头数组
		
		//计算checkSum 。  因reserved暂无值，此保留字段不作checksum计算  【 当前checksum = -26931 ，是计算错误结果，不仅仅是对头进行，全部报文都需要加入计算====】
		byte[] assembleHeader = assembleHeader(6, 8, 0, 125, 0, 181, 0);  //[104, 0, 0, 125, 0, 0, -75]
		int checkSum = checkSum(assembleHeader); 
		System.out.println("-----checkSum------:"+checkSum);  //-26931
		
		//校验checkSum 
		byte[] assembleHeader2 = assembleHeader(6, 8, 0, 125, checkSum, 181, 0); //[104, 0, 0, 125, -106, -51, -75] 
		int checkSum2 = checkSum(assembleHeader2);
		System.out.println("-----checkSum2------:"+checkSum2);	// 0
		/**
		 * 
		 * 
		 * 提供给思联的checkSum值。（实际计算方式不正确， 此种方法是利用协议头的前7位得出的checkSum）
		 * checkSum = -26931 [所对应的十进制数为38605]
		 * 实际十进制值为38605,在字节数组中可以由以下两个整数表示150、205
		 * 150[-106] 10010110
		 * 205[-51] 11001101
		 * crs=38605
		 * 
		 * 
		 * 
		 * 正确计算checkSum[是有所有的报文（协议头+DataFormat）计算得出]   → 见方法updateMessage(sem);
		 * checkSum = -28708  [所对应的十进制数为36828]
		 * crs=36828
		 * 
		 * 
		 */
	
		
		/**
		 * 使用DataOutputStream、ByteArrayOutputStream 构造byte字节数组  
		 * 3E16B985FFD5:-99:1457938738:0:0:4:114.052872_22.668605:28655  
		 * 
		 * */
		SnifferEntityMid sem = new SnifferEntityMid();
		sem.setVersion(6);
		sem.setHeader(8);
		sem.setTos(0);
		sem.setReserved("181");	
		sem.setDomain("");
		sem.setGateWay_id("");
		sem.setLan_mac("8482F425F184");
		sem.setWlan_mac("8482F425F199");
		sem.setMobile_num(2);
		
		List<String> mobile_macs = new ArrayList<String>();
		//type = 0 subtype =4   ,字段中 subtype在前。  = 0x40
		mobile_macs.add("3E16B985FFD5:-99:1457938738:0:0:4:114.052872_22.668605:28655");
		mobile_macs.add("3E16B985FFD8:-100:1457938739:1:0:4:114.052872_22.668605:28655");
		sem.setMobile_macs(mobile_macs);
		System.out.println("\n\n\n\n");
		byte[] updateMessage = updateMessage(sem);
		//saveFile(updateMessage, "E:\\note\\20190221_工作交接\\探针对接思联\\byte_array_backup", "encryptDES_byDOS_crs=-28708.txt");
		//boolean equals2 = Arrays.equals(bytesByFile, updateMessage);
		//System.out.println(equals2);
		SnifferEntityMid parseMessage2 = MessageThread.parseMessage(updateMessage);
		
		/** 
		 * 校验头crs
		 *   重构字节的长度。
		 * 
		 * */
		byte[] data2 = DesECBUtil.decryptByteDES(updateMessage,"!@#$%^00");
		byte[] copyOf = Arrays.copyOf(data2, data2.length -3);
		int crc_check = checkSum(copyOf);
		System.out.println("&&&&&&&&&&&&&&:"+crc_check+"===="+data2.length+"||"+updateMessage.length);
	}
}
