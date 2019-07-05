package utils;

public class RandomRoute {
	public static void main(String[] args) {
		//山东华安昆仑网络科技有限公司   winaId=1741
		int sceneId = 244;
		String sre = "A8016D" + String.format("%06x", 13 * sceneId + 1).toUpperCase();
		System.out.println(sre);
		
	}
}
