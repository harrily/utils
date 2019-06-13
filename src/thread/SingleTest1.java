package thread;

import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
/**
 *   单例test1（懒汉式单例模型    方法中不加synchronized，则线程不安全）
 * @author Administrator
 *
 */
public class SingleTest1 {
	
	
	public static ExecutorService pool = null;
	
	public synchronized static ExecutorService getPool() {
		if(pool == null) {
			pool = Executors.newFixedThreadPool(3);
		}
		return pool;
	}
}
