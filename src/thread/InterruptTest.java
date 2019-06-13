package thread;

public class InterruptTest implements Runnable {

	@Override
	public void run() {
		// TODO Auto-generated method stub
		while(true){
            if(!Thread.currentThread().isInterrupted()){
                System.out.println("Yes,I am interruted,but I am still running");
            }
        }
	}

	
	 public static void main(String[] args) throws InterruptedException {
		 Thread testThread = new Thread(new InterruptTest(),"InterruptionInJava");
		 testThread.start();
		 testThread.interrupt();
		 System.out.println("main end");
	}
}
