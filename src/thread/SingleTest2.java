package thread;

import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
/**
 *   单例test1（饿汉式单例模型    天生线程不安全）
 * @author Administrator
 *
 */
public class SingleTest2 {
	
	
	public static final ExecutorService pool = Executors.newFixedThreadPool(3);;
	
	public  static ExecutorService getPool() {
		return pool;
	}
}
