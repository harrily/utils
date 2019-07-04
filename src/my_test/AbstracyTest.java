package my_test;

public  class AbstracyTest {
  
	/** 这就是一个抽象类*/
			abstract class Animal {
				String name;
				int age;
				// 动物会叫
				public abstract void cry(); // 不确定动物怎么叫的。定义成抽象方法，来解决父类方法的不确定性。抽象方法在父类中不能实现，所以没有函数体。但在后续在继承时，要具体实现此方法。
				public abstract void aaa();
			}
			// 抽象类可以被继承
			// 当继承的父类是抽象类时，需要将抽象类中的所有抽象方法全部实现。
			class cat extends Animal {
				// 实现父类的cry抽象方法
				public void cry() {
					System.out.println("猫叫:");
				}

				@Override
				public void aaa() {
					// TODO Auto-generated method stub
					
				}
			}
			
			
			  /** 这就是一个接口类*/
			 interface Animal2 {
					// 动物会叫
					public  void  cry(); // 不确定动物怎么叫的。定义成抽象方法，来解决父类方法的不确定性。抽象方法在父类中不能实现，所以没有函数体。但在后续在继承时，要具体实现此方法。
					public  void  aaa();
				}
				// 抽象类可以被继承
				// 当继承的父类是抽象类时，需要将抽象类中的所有抽象方法全部实现。
				class cat2 implements Animal2 {

					@Override
					public void cry() {
						// TODO Auto-generated method stub
						
					}

					@Override
					public void aaa() {
						// TODO Auto-generated method stub
						
					}
					
				}
}
