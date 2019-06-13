package thread;

import java.util.concurrent.ExecutorService;
import java.util.concurrent.TimeUnit;

public class ExecuteThreadTest implements Runnable {

	@Override
	public void run() {
		// TODO Auto-generated method stub
		System.out.println("threadName= "+Thread.currentThread().getName());
		try {
			Thread.currentThread().sleep(3000);
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	
	public static void main(String[] args) {
		
		ExecutorService pool = SingleTest1.getPool();
		for(int i = 0 ; i<5;i++) {
			pool.execute(new ExecuteThreadTest());
		}
				
		pool.shutdown();
		//pool.shutdownNow();//代码中的sleep会报错，interrupt异常，直接退出，
		try {
			while (!pool.awaitTermination(2L, TimeUnit.SECONDS)) {
				System.out.println("线程池未关闭完，2秒后再检查线程池!");
			}
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
		
		/*
		 * pool.execute(new ExecuteThreadTest()); pool.execute(new ExecuteThreadTest());
		 * pool.execute(new ExecuteThreadTest()); pool.execute(new ExecuteThreadTest());
		 * pool.execute(new ExecuteThreadTest()); pool.execute(new ExecuteThreadTest());
		 * pool.execute(new ExecuteThreadTest()); pool.execute(new ExecuteThreadTest());
		 */
	}
}
