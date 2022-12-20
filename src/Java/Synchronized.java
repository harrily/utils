package Java;

public class Synchronized {


	public static void main(String[] args) {
		/**
		 *  -- 同步代码块 ， this锁对象
		 * @param args
		 */
//		Synchronized name = new Synchronized();
//		new Thread(new Runnable() {
//			@Override
//			public void run() {
//				// TODO Auto-generated method stub
//				name.sysoByThis();
//			}
//		}).start();
//		
		/**
		 *  synchronized同步代码块
		 * 	 如果线程的锁不同, 不能实现同步
		 * 		 想要同步必须使用同一个锁对象 (即this的对象要保持一致。)
		 * 
		 * 结果： 方法里面的循环 交替执行
		 * 	Thread-0 --> 1    
			Thread-0 --> 2
			Thread-0 --> 3
			Thread-0 --> 4
			Thread-1 --> 1
		 */
		Synchronized name1 = new Synchronized();
		Synchronized name2 = new Synchronized();
//		new Thread(new Runnable() {
//			@Override
//			public void run() {
//				// TODO Auto-generated method stub
//				name1.sysoByThis();
//			}
//		}).start();
//		
//		new Thread(new Runnable() {
//			@Override
//			public void run() {
//				// TODO Auto-generated method stub
//				name2.sysoByThis();
//			}
//		}).start();
		

			/**
			 * synchronized同步代码块
			 * 	使用一个常量对象作为锁对象
			 * 
			 * 	线程0的方法循环 执行完毕， 执行1 
			 */
//		new Thread(new Runnable() {
//			@Override
//			public void run() {
//				// TODO Auto-generated method stub
//				name1.sysoByChang();
//			}
//		}).start();
//		
//		new Thread(new Runnable() {
//			@Override
//			public void run() {
//				// TODO Auto-generated method stub
//				name2.sysoByChang();
//			}
//		}).start();
		
		/**
		 * synchronized同步代码块
		 * 使用一个常量对象作为锁对象,不同方法中 的同步代码块也可以同步
		 */
		new Thread(new Runnable() {
			@Override
			public void run() {
				// TODO Auto-generated method stub
				name1.sysoByChang();
			}
		}).start();
		
		new Thread(new Runnable() {
			@Override
			public void run() {
				// TODO Auto-generated method stub
				name2.sysoByChang();
			}
		}).start();
		
		  //第三个线程调用静态方法
		new Thread(new Runnable() {
			@Override
			public void run() {
				// TODO Auto-generated method stub
				sysoByChang2();
			}
		}).start();
		
	}    
	
	  //定义方法,打印100行字符串
	public void sysoByThis(){
        synchronized ( this ) {     //经常使用this当前对象作为锁对象
            for (int i = 1; i <= 100; i++) {
                System.out.println(Thread.currentThread().getName() + " --> " + i);
            }
        }
	}
	
	public static final  Object OBJ = new Object();     //定义一个常量,
	public void sysoByChang(){
        synchronized ( OBJ ) {     //经常使用this当前对象作为锁对象
            for (int i = 1; i <= 100; i++) {
                System.out.println(Thread.currentThread().getName() + " --> " + i);
            }
        }
	}
	
	public static void sysoByChang2(){
        synchronized ( OBJ ) {     //经常使用this当前对象作为锁对象
            for (int i = 1; i <= 100; i++) {
                System.out.println(Thread.currentThread().getName() + " --> " + i);
            }
        }
	}
	        
}
