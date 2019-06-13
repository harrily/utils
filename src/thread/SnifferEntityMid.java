
package thread;

import java.io.ByteArrayInputStream;
import java.io.DataInputStream;
import java.io.IOException;
import java.nio.ByteBuffer;
import java.util.ArrayList;
import java.util.List;

/**
 * 功能描述：
 *	探针数据实体类
 */
public class SnifferEntityMid {
	private int version;
	private int header ;
	private int tos;
	private int datalength;
	private int crc;
	private String reserved;
	private String domain;
	private String gateWay_id;
	private String lan_mac;
	private String wlan_mac;
	private int mobile_num;
	private List<String> mobile_macs = new ArrayList<String>();
	private String mobile_mac ;
	private int mobile_rssi;
	private String timestamp;
	private String udpServer ;
	private String receiveTime;
	/**  探针标记 (0:(0:(0:正常 MAC，1: 虚假 MAC) */
	private int flag;
//	private static Logger logger = Logger.getLogger(SnifferEntity_mid.class);
	
	public SnifferEntityMid() {
		super();
	}
	public SnifferEntityMid(int version,int header, int tos, int datalength, int crc,
			String reserved, String domain, String gateWay_id, String lan_mac,
			String wan_mac, int mobile_num, List<String> mobile_macs,
			String mobile_mac, int mobile_rssi, String timestamp,String udpServer,String receiveTime,int flag) {
		super();
		this.version = version;
		this.header = header;
		this.tos = tos;
		this.datalength = datalength;
		this.crc = crc;
		this.reserved = reserved;
		this.domain = domain;
		this.gateWay_id = gateWay_id;
		this.lan_mac = lan_mac;
		this.wlan_mac = wan_mac;
		this.mobile_num = mobile_num;
		this.mobile_macs = mobile_macs;
		this.mobile_mac = mobile_mac;
		this.mobile_rssi = mobile_rssi;
		this.timestamp = timestamp;
		this.udpServer = udpServer;
		this.receiveTime = receiveTime;
		this.flag = flag;
	}
	/**
	 * @param byte_text
	 */
	public SnifferEntityMid(byte[] byte_text) {
		List<Integer> list = new ArrayList<Integer>();
        int start = 8;
        // get the 1st and the 2nd |
        for(int i = start ; i < byte_text.length; i ++){
        	if(list.size() < 2){
        		if(byte_text[i] == 124){
        			list.add(i);
        		}
        	}
        }
        ByteBuffer buff = null;
        buff = ByteBuffer.wrap(byte_text,start,byte_text.length - start);
        byte [] domain_byte = new byte[list.get(0) - start];
        buff.get(domain_byte);
        this.domain = new String(domain_byte).toLowerCase().trim();
        buff.position(buff.position() + 1);
        byte [] gateWay_id_byte = new byte[list.get(1) - list.get(0) - 1];
        buff.get(gateWay_id_byte);
        this.gateWay_id = new String(gateWay_id_byte).trim().toLowerCase();
        buff.position(buff.position() + 1);// 	|
        byte[] mac_byte = new byte[6];
        buff.get(mac_byte);
        this.lan_mac = ConvertUtil.bytesToHexString(mac_byte);
        buff.position(buff.position() + 1);// |
        buff.get(mac_byte);
        this.wlan_mac = ConvertUtil.bytesToHexString(mac_byte);
        buff.position(buff.position() + 1);// |
        int lastPosition = buff.position();
        int Mobile_num_byte_length = 0;
        while(buff.position() < buff.limit()){
        	if(buff.get() == 124){
        		buff.mark();
        		Mobile_num_byte_length = (int) (buff.position() - lastPosition - 1);
        		break;
        	}
        }
        buff.position(lastPosition);
        byte[] Mobile_num_byte = new byte[Mobile_num_byte_length];
        buff.get(Mobile_num_byte);
        this.mobile_num =Integer.valueOf( new String(Mobile_num_byte));
        buff.position(buff.position() + 1);
        
        for (int i = 0 ; i < mobile_num ; i ++){
        	buff.get(mac_byte);
        	String mac = ConvertUtil.bytesToHexString(mac_byte);
        	
        	lastPosition = buff.position();
        	int nextPosition = 0;
        	while(buff.position() < buff.limit()){
            	if(buff.get() == 124){
            		buff.mark();
            		nextPosition = buff.position();
            		break;
            	}
            }
        	buff.position(lastPosition);
        	//版本为1时不添加flag值，一个字节进来
        	byte[] rssi_time_byte = new byte[nextPosition - lastPosition -1];
        	buff.get(rssi_time_byte);
        	String rssi_time = new String(rssi_time_byte);
        	String mobile = mac + rssi_time;
        	this.mobile_macs.add(mobile);
        	buff.position(buff.position() + 1);
        }
	}
	
	/**
	 * @param body
	 * @param version2
	 */
	public SnifferEntityMid(byte[] body, int version2) {
		List<Integer> list = new ArrayList<Integer>();
        int start = 8;
        // get the 1st and the 2nd |
        for(int i = start ; i < body.length; i ++){
        	if(list.size() < 2){
        		if(body[i] == 124){
        			list.add(i);
        		}
        	}
        }
        ByteBuffer buff = null;
        buff = ByteBuffer.wrap(body,start,body.length - start);
        byte [] domain_byte = new byte[list.get(0) - start];
        buff.get(domain_byte);
        this.domain = new String(domain_byte).toLowerCase().trim();
        buff.position(buff.position() + 1);
        byte [] gateWay_id_byte = new byte[list.get(1) - list.get(0) - 1];
        buff.get(gateWay_id_byte);
        this.gateWay_id = new String(gateWay_id_byte).trim().toLowerCase();
        buff.position(buff.position() + 1);// 	|
        byte[] mac_byte = new byte[6];
        buff.get(mac_byte);
        this.lan_mac = ConvertUtil.bytesToHexString(mac_byte);
        buff.position(buff.position() + 1);// |
        buff.get(mac_byte);
        this.wlan_mac = ConvertUtil.bytesToHexString(mac_byte);
        buff.position(buff.position() + 1);// |
        int lastPosition = buff.position();
        int Mobile_num_byte_length = 0;
        while(buff.position() < buff.limit()){
        	if(buff.get() == 124){
        		buff.mark();
        		Mobile_num_byte_length = (int) (buff.position() - lastPosition - 1);
        		break;
        	}
        }
        buff.position(lastPosition);
        byte[] Mobile_num_byte = new byte[Mobile_num_byte_length];
        buff.get(Mobile_num_byte);
        this.mobile_num =Integer.valueOf( new String(Mobile_num_byte));
        buff.position(buff.position() + 1);
        
        for (int i = 0 ; i < mobile_num ; i ++){
        	buff.get(mac_byte);
        	String mac = ConvertUtil.bytesToHexString(mac_byte);
        	
        	lastPosition = buff.position();
        	int nextPosition = 0;
        	while(buff.position() < buff.limit()){
            	if(buff.get() == 124){
            		buff.mark();
            		nextPosition = buff.position();
            		break;
            	}
            }
        	buff.position(lastPosition);
        	// 版本1时不添加flag值，一个字节进来
        	byte[] rssi_time_byte = new byte[nextPosition - lastPosition -2];
        	buff.get(rssi_time_byte);
        	String rssi_time = new String(rssi_time_byte);
//        	System.out.println(rssi_time);
        	 short flag_value = buff.get();
        	String mobile = mac + rssi_time + flag_value;
        	this.mobile_macs.add(mobile);
        	buff.position(buff.position() + 1);
        }
	}
	
	public static int byteArrayToInt(byte[] byteArray) {
		int n = 0;
		try {
		ByteArrayInputStream byteInput = new ByteArrayInputStream(byteArray);
		DataInputStream dataInput = new DataInputStream(byteInput);
		n = dataInput.readInt();
		System.out.println("整数为： " + n);
		} catch (IOException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
		}
		return n;
		}
	
	/**
	 * @param version3 or version6
	 * 根据参数version 处理版本3或者版本6的数据
	 * @param body
	 * @throws IOException 
	 */
	public SnifferEntityMid(int version, byte[] body) throws IOException {

		List<Integer> list = new ArrayList<Integer>();
        int start = 8;
        // get the 1st and the 2nd |
        for(int i = start ; i < body.length; i ++){
        	if(list.size() < 2){
        		if(body[i] == 124){ //  | = 124
        			list.add(i);
        		}
        	}
        }
        ByteBuffer buff = null;
        buff = ByteBuffer.wrap(body,start,body.length - start);
        byte [] domain_byte = new byte[list.get(0) - start];
        buff.get(domain_byte);
        //this.domain = new String(domain_byte).toLowerCase().trim();
        this.domain = new String(domain_byte);
        
        buff.position(buff.position() + 1);
        byte [] gateWay_id_byte = new byte[list.get(1) - list.get(0) - 1];
        buff.get(gateWay_id_byte);
        //this.gateWay_id = new String(gateWay_id_byte).trim().toLowerCase();
        this.gateWay_id = new String(gateWay_id_byte);
        
        buff.position(buff.position() + 1);// 	|
        byte[] mac_byte = new byte[6];
        buff.get(mac_byte);
        this.lan_mac = ConvertUtil.bytesToHexString(mac_byte);
        buff.position(buff.position() + 1);// |
        buff.get(mac_byte);
        this.wlan_mac = ConvertUtil.bytesToHexString(mac_byte);
        buff.position(buff.position() + 1);// |
        int lastPosition = buff.position();
        int Mobile_num_byte_length = 0;
        while(buff.position() < buff.limit()){
        	if(buff.get() == 124){ //buff.get() position +1
        		buff.mark();
        		Mobile_num_byte_length = (int) (buff.position() - lastPosition - 1);
        		break;
        	}
        }
        buff.position(lastPosition);
        byte[] Mobile_num_byte = new byte[Mobile_num_byte_length];
        buff.get(Mobile_num_byte); //get之前26 ，之后27
        System.out.println("--------------> 开始解析数据段信息 <-----------------");
        System.out.println("domain:"+ this.domain+"#");
        System.out.println("gateWay_id:"+ this.gateWay_id+"#");
        System.out.println("lan_mac:"+ this.lan_mac);
        System.out.println("wlan_mac:"+ this.wlan_mac);
        System.out.println("Mobile_num_byte:"+ new String(Mobile_num_byte));
        this.mobile_num =Integer.valueOf( new String(Mobile_num_byte));
        //this.mobile_num =  byteArrayToInt(Mobile_num_byte);
        //this.mobile_num = 2;
        //System.out.println("version:"+version+"   mobile_num:"+ this.mobile_num);
        buff.position(buff.position() + 1); //27 +1 = 28
        System.out.println("--------------->开始处理每个mobile_mac<------------------");
        if( version == 3 ){        	 
	        for (int i = 0 ; i < mobile_num ; i ++){
	        	buff.get(mac_byte);
	        	String mac = ConvertUtil.bytesToHexString(mac_byte);
	        	
	        	lastPosition = buff.position();
	        	int nextPosition = 0;
	        	while(buff.position() < buff.limit()){
	            	if(buff.get() == 124){  
	            		buff.mark();
	            		nextPosition = buff.position();
	            		break;
	            	}
	            }
	        	buff.position(lastPosition);
	        	// 版本3时添加type与subType
	        	byte[] rssi_time_byte = new byte[nextPosition - lastPosition - 4];
	        	buff.get(rssi_time_byte);
	        	String rssi_time = new String(rssi_time_byte);
	        	
	        	short flag_value = buff.get();
	        	buff.position(buff.position() + 1);
	        	byte[] frame_bytes = new byte[1];
	        	buff.get(frame_bytes);
	        	String output  = ConvertUtil.bytesToHexString(frame_bytes);
	        	int subType = Integer.parseInt(output.substring(0, 1), 16);
	        	int type = Integer.parseInt(output.substring(1, 2), 16);
	        	// rssi_time = :rssi:timestamp:
	         	System.out.println("rssi_time>"+rssi_time);
	        	System.out.println("flag_value>"+flag_value);
	        	System.out.println("type>"+type);
	        	System.out.println("subType>"+subType);
				String mobile = mac + rssi_time + flag_value + ":" + type + ":" + subType;
				System.out.println("version 3 old mobile is --->"+mobile);
				this.mobile_macs.add(mobile);
	        	buff.position(buff.position() + 1);
	        }
        }
        
        if( version == 6 ){        	 
	        for (int i = 0 ; i < mobile_num ; i ++){
	        	buff.get(mac_byte);//get 之前28  之后34
	        	String mac = ConvertUtil.bytesToHexString(mac_byte);
	        	lastPosition = buff.position();	  // 34   :   	
	            int thrid_colon = 0; // thrid_colon = 38    第三个冒号的下标 ：
	            // get the 3st : position
	            int count = 0;
	            for(int j = lastPosition ; j < body.length; j ++){
            		if(body[j] == 58){ //  : = 58
            			count++;
            			if(count == 3){
                			thrid_colon = j;
                			break;
                		}
            		}
	            }
	        	buff.position(lastPosition); //34
	        	// 版本3时添加type与subType
	        	byte[] rssi_time_byte = new byte[thrid_colon - lastPosition + 1  ];  // 
	        	
	        	buff.get(rssi_time_byte); // get之前34  之后 39      
	        	String rssi_time = new String(rssi_time_byte);
	        	
	        	short flag_value = buff.get(); //get之前39  之后 40
	        	buff.position(buff.position() + 1); //40+1=41
	        	byte[] frame_bytes = new byte[1];
	        	buff.get(frame_bytes); //get之前41  之后 42
	        	String output  = ConvertUtil.bytesToHexString(frame_bytes);
	        	System.out.println("***original****subtype******:"+output.substring(0, 1));
	        	System.out.println("***original****type******:"+output.substring(1, 2));
	        	int subType = Integer.parseInt(output.substring(0, 1), 16);
	        	int type = Integer.parseInt(output.substring(1, 2), 16);
				buff.position(buff.position() + 1);	//42+1  = 43			
				lastPosition = buff.position();  // 43
	        	int nextPosition = 0; //47  [  | 位置  的下标为：46 。  因为for循环中,buff.get() = 124之后   位置+1  ,故nextPosition = 46+1 = 47]
	        	while(buff.position() < buff.limit()){
	            	if(buff.get() == 124){  
	            		buff.mark();
	            		nextPosition = buff.position();
	            		break;
	            	}
	            }
	        	buff.position(lastPosition);  //43
	        	// 版本6时添加Lng_lat与Station_id
	        	byte[] gps_station_byte = new byte[nextPosition - lastPosition - 1];  
	        	buff.get(gps_station_byte); //get之前43 之后46
	        	//gps_station = :Lng_lat:Station_id
	        	String gps_station = new String(gps_station_byte);//46
	        	// rssi_time = :rssi:timestamp:
	        	System.out.println("rssi_time>"+rssi_time);
	        	System.out.println("flag_value>"+flag_value);
	        	System.out.println("type>"+type);
	        	System.out.println("subType>"+subType);
	        	System.out.println("gps_station>"+gps_station);
	        	String mobile = mac + rssi_time + flag_value + ":" + type + ":" + subType +":"+ gps_station;   //◇
				System.out.println("mobile is --->"+mobile);
				this.mobile_macs.add(mobile);
	        	buff.position(buff.position() + 1);  // 46+1=47
	        }
        }
		// TODO Auto-generated constructor stub
	}
	public int getVersion() {
		return version;
	}
	public void setVersion(int version) {
		this.version = version;
	}
	public int getHeader() {
		return header;
	}
	public void setHeader(int header) {
		this.header = header;
	}
	public int getTos() {
		return tos;
	}
	public void setTos(int tos) {
		this.tos = tos;
	}
	public int getDatalength() {
		return datalength;
	}
	public void setDatalength(int datalength) {
		this.datalength = datalength;
	}
	public int getCrc() {
		return crc;
	}
	public void setCrc(int crc) {
		this.crc = crc;
	}
	public String getReserved() {
		return reserved;
	}
	public void setReserved(String reserved) {
		this.reserved = reserved;
	}
	public String getDomain() {
		return domain;
	}
	public void setDomain(String domain) {
		this.domain = domain;
	}
	public String getGateWay_id() {
		return gateWay_id;
	}
	public void setGateWay_id(String gateWay_id) {
		this.gateWay_id = gateWay_id;
	}
	public String getLan_mac() {
		return lan_mac;
	}
	public void setLan_mac(String lan_mac) {
		this.lan_mac = lan_mac;
	}
	public String getWlan_mac() {
		return wlan_mac;
	}
	public void setWlan_mac(String wan_mac) {
		this.wlan_mac = wan_mac;
	}
	public int getMobile_num() {
		return mobile_num;
	}
	public void setMobile_num(int mobile_num) {
		this.mobile_num = mobile_num;
	}
	public List<String> getMobile_macs() {
		return mobile_macs;
	}
	public void setMobile_macs(List<String> mobile_macs) {
		this.mobile_macs = mobile_macs;
	}
	public String getMobile_mac() {
		return mobile_mac;
	}
	public void setMobile_mac(String mobile_mac) {
		this.mobile_mac = mobile_mac;
	}
	public int getMobile_rssi() {
		return mobile_rssi;
	}
	public void setMobile_rssi(int mobile_rssi) {
		this.mobile_rssi = mobile_rssi;
	}
	public String getTimestamp() {
		return timestamp;
	}
	public void setTimestamp(String timestamp) {
		this.timestamp = timestamp;
	}
	
	
	public String getUdpServer() {
		return udpServer;
	}
	public void setUdpServer(String udpServer) {
		this.udpServer = udpServer;
	}
	
	public String getReceiveTime() {
		return receiveTime;
	}
	public void setReceiveTime(String receiveTime) {
		this.receiveTime = receiveTime;
	}
	
	public int getFlag() {
		return flag;
	}
	public void setFlag(int flag) {
		this.flag = flag;
	}
	@Override
	public String toString() {
		return "SnifferEntity_mid [version=" + version + ", header=" + header
				+ ", tos=" + tos + ", datalength=" + datalength + ", crc="
				+ crc + ", reserved=" + reserved + ", domain=" + domain
				+ ", gateWay_id=" + gateWay_id + ", lan_mac=" + lan_mac
				+ ", wlan_mac=" + wlan_mac + ", mobile_num=" + mobile_num
				+ ", mobile_macs=" + mobile_macs + ", mobile_mac=" + mobile_mac
				+ ", mobile_rssi=" + mobile_rssi + ", timestamp=" + timestamp
				+ ", udpServer=" + udpServer + ", receiveTime=" + receiveTime
				+ "]";
	}

	
}
