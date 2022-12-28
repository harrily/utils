package Java;
/**
 * 
 * volatile关键字增加了实例变量在多个线程之间的可见性,但是不具备原子性。
 * 
 * volatile与synchronized比较

● volatile关键字是线程同步的轻量级实现,所以volatile性能肯定比synchronized要好; volatile只能修饰变量,而synchronized可以修饰方法,代码块. 随着JDK新版本的发布,synchronized的执行效率也有较大的提升,在开发中使用sychronized的比率还是很大的。
● 多线程访问volatile变量不会发生阻塞,而synchronized可能会阻塞。
● volatile能保证数据的可见性,但是不能保证原子性; 而synchronized可以保证原子性,也可以保证可见性。
● 关键字volatile解决的是变量在多个线程之间的可见性; synchronized关键字解决多个线程之间访问公共资源的同步性。

---------------------------------------------->>>>>>>>>>>>>>>>>>>>>>>>>>>>
i++不是原子操作，原因是：
i++操作分为三个阶段(读、改、写)：
内存到寄存器
寄存器自增
写回内存
这三个阶段可以被中断分离。
List 什么是操作系统的“原子操作”
原子操作是不可分割的，在执行完毕不会被任何其它任务或事件中断，分为两种情况（两种都应该满足）

（1） 在单线程中， 能够在单条指令中完成的操作都可以认为是" 原子操作"，因为中断只能发生于指令之间。

（2） 在多线程中，不能被其它进程（线程）打断的操作就叫原子操作。

面试的时候经常问的一道题目是i++在两个线程里边分别执行100次，能得到的最大值和最小值分别是多少？（2 -200）

i++只需要执行一条指令，并不能保证多个线程i++，操作同一个i，可以得到正确的结果。因为还有寄存器的因素，多个cpu对应多个寄存器。每次要先把i从内存复制到寄存器，然后++，然后再把i复制到内存中，这需要至少3步。从这个意义上讲，说i++是原子的并不对。
 * @author wang.ying.nan
 *
 */
public class Volatile {
	 public static void main(String[] args) {
	        //在main线程中创建10个子线程
	        for (int i = 0; i < 5 ; i++) {
	            new MyThread().start();
	        }
	    }

	    static class MyThread extends Thread{
	        //volatile关键仅仅是表示所有线程从主内存读取count变量的值
	        public volatile static  int count;

	       //这段代码运行后不是线程安全的,想要线程安全,需要使用synchronized进行同步,如果使用synchronized同时,也就不需要volatile关键了  
	      public static void addCount(){
	            for (int i = 0; i < 10; i++) {
	                //count++不是原子操作
	                count++;
//	                System.out.println(Thread.currentThread().getName() + " end:" + count);
	            }
	            System.out.println(Thread.currentThread().getName() + " count=" + count);
	        }
//
//	        public synchronized static void addCount(){
//	            for (int i = 0; i < 1000; i++) {
//	                //count++不是原子操作
//	                count++;
//	            }
//	            System.out.println(Thread.currentThread().getName() + " count=" + count);
//	        }

	        @Override
	        public void run() {
	            addCount();
	        }
	    }
}
