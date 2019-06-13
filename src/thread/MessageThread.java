package thread;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.util.*;

import my_test.DesECBUtil;


public class MessageThread {




	/**
	 * 解析报文数据	
	 * @param message
	 * @return
	 * @throws Exception
	 */
	public static SnifferEntityMid parseMessage(byte[] message) throws Exception {
		DataInputStream  dis = null;
		
		//解析报文数据
		byte[] data = DesECBUtil.decryptByteDES(message,"!@#$%^00");
		//byte[] data = message;
		
		dis = new DataInputStream(new ByteArrayInputStream(data));
		byte version_header = (byte) dis.readUnsignedByte();
		int version = version_header >> 4;
		SnifferEntityMid sniffer = null;
		//按版本1还是版本2来解析文件
		try {
			if(version == 1){
				sniffer = new SnifferEntityMid(data);
			}else if(version == 2 ){
				sniffer = new SnifferEntityMid(data,version);
			}else if(version == 3 ){
				sniffer = new SnifferEntityMid(version,data);
			}else if(version == 4 ){
				sniffer = new SnifferEntityMid(data,version);
			}else if(version == 6 ){
				sniffer = new SnifferEntityMid(version,data);
			}else {
			}
		} catch(Exception e) {
			//解析出错，不处理这条报文
			e.printStackTrace();
			
			return null;
		}
		
		sniffer.setUdpServer("test");
		sniffer.setVersion(version_header >> 4);
		sniffer.setHeader(version_header & 0x0F);
		sniffer.setTos(dis.readUnsignedByte());
		sniffer.setDatalength(dis.readUnsignedShort());
		sniffer.setCrc(dis.readUnsignedShort());
		//解析硬件类型保留字段中的值 3.0 版本中添加，解析此字段、
	    /* if(version == 3){
			dis.skip(2);
		}
		*/
		String device_type1 = String.valueOf(dis.readUnsignedByte());
		sniffer.setReserved(device_type1);
		dis.skip(1);
		String receiveTime = new Date().getTime()/1000 + "";
		sniffer.setReceiveTime(receiveTime);

		// register 'ad_id' field for route and displace 'gateway_id'
		//updateGatewayId(sniffer); △ 

//		log.debug(sniffer.toString());
		dis.close();
		System.out.println("----- 开始解析协议头信息  -----");
		System.out.println("version:"+String.valueOf(version_header >> 4));
		System.out.println("header:"+String.valueOf(version_header & 0x0F));
		System.out.println("tos:"+sniffer.getTos());
		System.out.println("datalength:"+sniffer.getDatalength());
		System.out.println("crs:"+sniffer.getCrc());
		System.out.println("device_type:"+device_type1);
		
		return sniffer;
	}


	private static List<SnifferHive> converstToSnifferHive(
			SnifferEntityMid snifferEntityMid) {
		List<SnifferHive> sniffers = new ArrayList<SnifferHive>();
			for(String mac_rssi_time : snifferEntityMid.getMobile_macs()){
				SnifferHive sniffer = new SnifferHive();
				sniffer.setDomain(snifferEntityMid.getDomain());
				sniffer.setGateWay_id(snifferEntityMid.getGateWay_id());
				sniffer.setLan_mac(snifferEntityMid.getLan_mac());
				sniffer.setWlan_mac(snifferEntityMid.getWlan_mac());
				sniffer.setMobile_num(snifferEntityMid.getMobile_num());
				String[] mac_rssi_times = mac_rssi_time.split(":");
				if(snifferEntityMid.getVersion() == 1){
					if(3 == mac_rssi_times.length){
						sniffer.setMobile_mac(mac_rssi_times[0]);
						sniffer.setMobile_rssi(Integer.valueOf(mac_rssi_times[1].replaceAll("-", "")));
						sniffer.setTimestamp(mac_rssi_times[2]);
					}
				}else if(snifferEntityMid.getVersion() == 2) {
					if(4 == mac_rssi_times.length){
						sniffer.setMobile_mac(mac_rssi_times[0]);
						sniffer.setMobile_rssi(Integer.valueOf(mac_rssi_times[1].replaceAll("-", "")));
						sniffer.setTimestamp(mac_rssi_times[2]);
						sniffer.setFlag(Integer.valueOf(mac_rssi_times[3]));
					}
				}else if(snifferEntityMid.getVersion() == 3){
					if(6 == mac_rssi_times.length){
						sniffer.setMobile_mac(mac_rssi_times[0]);
						sniffer.setMobile_rssi(Integer.valueOf(mac_rssi_times[1].replaceAll("-", "")));
						sniffer.setTimestamp(mac_rssi_times[2]);
						sniffer.setFlag(Integer.valueOf(mac_rssi_times[3]));
						sniffer.setType(Integer.valueOf(mac_rssi_times[4]));
						sniffer.setSubType(Integer.valueOf(mac_rssi_times[5]));
					}
				}else if(snifferEntityMid.getVersion() == 6){
					if(8 == mac_rssi_times.length){
						sniffer.setMobile_mac(mac_rssi_times[0]);
						sniffer.setMobile_rssi(Integer.valueOf(mac_rssi_times[1].replaceAll("-", "")));
						sniffer.setTimestamp(mac_rssi_times[2]);
						sniffer.setFlag(Integer.valueOf(mac_rssi_times[3]));
						sniffer.setType(Integer.valueOf(mac_rssi_times[4]));
						sniffer.setSubType(Integer.valueOf(mac_rssi_times[5]));
						sniffer.setLng_lat(mac_rssi_times[6]);
						sniffer.setStation_id(mac_rssi_times[7]);
					}
				}else if(snifferEntityMid.getVersion() == 4){
					if(5 <= mac_rssi_times.length){
						sniffer.setMobile_mac(mac_rssi_times[0]);
						sniffer.setMobile_rssi(Integer.valueOf(mac_rssi_times[1].replaceAll("-", "")));
						sniffer.setTimestamp(mac_rssi_times[2]);
						sniffer.setDistance(Double.valueOf(mac_rssi_times[3]));
						if (mac_rssi_times[4].length() > 1) {
							String virtualId_flag = mac_rssi_time.split(":", 5)[4];
							String virtualId = virtualId_flag.substring(0,virtualId_flag.lastIndexOf(":"));
							String flag = virtualId_flag.substring(virtualId_flag.lastIndexOf(":")+1);
							
							sniffer.setVirtual_identity(virtualId);
							sniffer.setFlag(Integer.valueOf(flag));
						} else{
							sniffer.setFlag(Integer.valueOf(mac_rssi_times[mac_rssi_times.length-1]));
						}
					}
				}
				// 增加UDP服务器接收数据时间字段
				sniffer.setReceiveTime(snifferEntityMid.getReceiveTime());
				sniffer.setReserved(snifferEntityMid.getReserved());
				//保留设备类型字段
				sniffers.add(sniffer);
				
				if (snifferEntityMid.getVersion() == 4) {
					System.out.println(sniffer);
				}
			}
		return sniffers;
	}
	
	/**
	 * 根据对象重组报文
	 * @param snifferEntityMid
	 * @return
	 */
	public byte[] updateMessage(SnifferEntityMid snifferEntityMid) {
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
					byte test2 = (byte) ((Integer.parseInt(arr[4]) << 4) + (Integer.parseInt(arr[5]) | 0x0F));
					dos.writeByte(test2);
				}
				dos.writeBytes("|");
				
			}

			dos.flush();
			dos.close();

			byte[] dataBytes = bos.toByteArray();
			
			//协议头在最后添加，字段长度和CRC需要在最后计算 
			byte[] headBytes = assembleHeader(snifferEntityMid.getVersion(), snifferEntityMid.getHeader(), snifferEntityMid.getTos(), 
					dataBytes.length, 0, Integer.parseInt(snifferEntityMid.getReserved()), 0);
			headBytes = Arrays.copyOf(headBytes, dataBytes.length + headBytes.length);
			System.arraycopy(dataBytes, 0, headBytes, headBytes.length - dataBytes.length, dataBytes.length);
			
			//计算CRC
			int crc = checkSum(headBytes);
			//重新构建Head
			headBytes = assembleHeader(snifferEntityMid.getVersion(), snifferEntityMid.getHeader(), snifferEntityMid.getTos(), 
					dataBytes.length, crc, Integer.parseInt(snifferEntityMid.getReserved()), 0);

			headBytes = Arrays.copyOf(headBytes, dataBytes.length + headBytes.length);
			System.arraycopy(dataBytes, 0, headBytes, headBytes.length - dataBytes.length, dataBytes.length);

			//加密
			return DesECBUtil.encryptDES(headBytes, "");
			
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
	
	public byte[] assembleHeader(int version, int headLen, int tops, int dataLen, int crc, int deviceType, int reserved) {

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
			if(version == 1) {
				dos.writeByte(deviceType);
			}
			dos.writeByte(deviceType);
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
	 * 校验和的计算/校验
	 * 计算时返回0为正确
	 * 校验时返回的值即为CRC
	 * @param decryDatas
	 * @return
	 */
	public int checkSum(byte[] decryDatas) {


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
	
}
