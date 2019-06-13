package thread;

import java.util.List;

public class SnifferHive {
	private String domain;
	private String gateWay_id;
	private String lan_mac;
	private String wlan_mac;
	private int mobile_num;
	private String mobile_mac ;
	private int mobile_rssi;
	private String timestamp;
//	private String udpServer ;
	/** the udp text parsed time，add the system time  */
//	private long parsed_time;
	/** UDP服务器接收到报文时间 */
	private String receiveTime;
	/**  探针标记 (0:(0:(0:正常 MAC�?1: 虚假 MAC) */
	private int flag;
	/**  区别来源 0：百米；20中科�?30：声牙；40：百米声�? */
	private String reserved;
	/**  帧类型中的type */
	private int type;
	/**  帧类型中的subType */
	private int subType;
	/**  GPS经度和维度以“_”（下划线）连接 ,前�?�为经度，后者为维度*/
	private String lng_lat;
	/**  基站id */
	private String station_id;
//	private static  Logger logger =  Logger.getLogger(Sniffer.class);
	private static final String SPLIT = "\t";
	//距离
	private double  distance = -1;
	//虚拟身份键�?�对
	private String virtual_identity = "";
	
	public SnifferHive() {
		super();
	}
	public SnifferHive(int version,int header, int tos, int datalength, int crc,
			String reserved, String domain, String gateWay_id, String lan_mac,
			String wan_mac, int mobile_num, List<String> mobile_macs,
			String mobile_mac, int mobile_rssi, String timestamp,String udpServer,long parsed_time) {
		super();
		this.domain = domain;
		this.gateWay_id = gateWay_id;
		this.lan_mac = lan_mac;
		this.wlan_mac = wan_mac;
		this.mobile_num = mobile_num;
		this.mobile_mac = mobile_mac;
		this.mobile_rssi = mobile_rssi;
		this.timestamp = timestamp;
//		this.udpServer = udpServer;
//		this.parsed_time = parsed_time;
	}
	
public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
	public int getSubType() {
		return subType;
	}
	public void setSubType(int subType) {
		this.subType = subType;
	}
public String getReceiveTime() {
		return receiveTime;
	}
	public void setReceiveTime(String receiveTime) {
		this.receiveTime = receiveTime;
	}
	//	public long getParsed_time() {
//		return parsed_time;
//	}
//	public void setParsed_time(long parsed_time) {
//		this.parsed_time = parsed_time;
//	}
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
	
	
	public int getFlag() {
		return flag;
	}
	public String getLng_lat() {
		return lng_lat;
	}
	public void setLng_lat(String lng_lat) {
		this.lng_lat = lng_lat;
	}
	public String getStation_id() {
		return station_id;
	}
	public void setStation_id(String station_id) {
		this.station_id = station_id;
	}
	public void setFlag(int flag) {
		this.flag = flag;
	}
	
	public String getReserved() {
		return reserved;
	}
	public void setReserved(String reserved) {
		this.reserved = reserved;
	}
	@Override
	public String toString() {
		StringBuilder sb = new StringBuilder();
		sb.append(this.domain).append(SPLIT);
		sb.append(this.gateWay_id).append(SPLIT);
		sb.append(this.lan_mac).append(SPLIT);
		sb.append(this.wlan_mac).append(SPLIT);
		sb.append(this.mobile_num).append(SPLIT);
		sb.append(this.mobile_mac).append(SPLIT);
		sb.append(this.mobile_rssi).append(SPLIT);
		sb.append(this.timestamp).append(SPLIT);
		sb.append(this.receiveTime).append(SPLIT);
		sb.append(this.reserved).append(SPLIT);
		sb.append(this.flag).append(SPLIT);
		sb.append(this.type).append(SPLIT);
		sb.append(this.subType).append(SPLIT);
		sb.append(this.lng_lat).append(SPLIT);
		sb.append(this.station_id);
		return sb.toString();
		//TODO 确定接入version4，并且给raw.sniffer表添加了新字段，再开启以下代码，增加distance、virtual_identity字段�?
/*		StringBuilder sb = new StringBuilder();
		sb.append(this.domain).append(SPLIT);
		sb.append(this.gateWay_id).append(SPLIT);
		sb.append(this.lan_mac).append(SPLIT);
		sb.append(this.wlan_mac).append(SPLIT);
		sb.append(this.mobile_num).append(SPLIT);
		sb.append(this.mobile_mac).append(SPLIT);
		sb.append(this.mobile_rssi).append(SPLIT);
		sb.append(this.timestamp).append(SPLIT);
		sb.append(this.receiveTime).append(SPLIT);
		sb.append(this.reserved).append(SPLIT);
		sb.append(this.flag).append(SPLIT);
		sb.append(this.type).append(SPLIT);
		sb.append(this.subType).append(SPLIT);
		sb.append(this.distance).append(SPLIT);
		sb.append(this.virtual_identity);
		return sb.toString();*/
	}
	public double getDistance() {
		return distance;
	}
	public void setDistance(double distance) {
		this.distance = distance;
	}
	public String getVirtual_identity() {
		return virtual_identity;
	}
	public void setVirtual_identity(String virtual_identity) {
		this.virtual_identity = virtual_identity;
	}
	
	
}
