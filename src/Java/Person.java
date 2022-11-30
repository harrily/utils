package Java;
/**
 *  多态的优点
	代码更加灵活：无论右边new的时候换成哪个子类对象，等号左边调用方法都不会变化。
	提高程序的拓展性：定义方法的时候，使用父类类型作为参数，将来使用时，使用具体的子类类型操作
 */
public class Person {
	private String name;
	public Person(String name) {
		this.name = name;
	}
	
	// getter 和 setter
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public void mission() {	
		System.out.println(name+"人要好好活着！");
	}
	
	public static void main(String[] args) {
			//向上转型（自动类型转换）
		    //程序在编译阶段只知道 p1 是 Person 类型
		    //程序在运行的时候才知道堆中实际的对象是 Student 类型	
			Person p1 = new Student("ddd",20);
			/**
			 *  1、多态的基本用法， 重写父类方法
			 * //调用的是 Student 的 mission 
			 * 
			 * 
			 * 3、动态绑定 （针对方法，属性没有）
			 *  //程序在编译时 p1 被编译器看作 Person 类型
				//因此编译阶段只能调用 Person 类型中定义的方法
				//在编译阶段，p1 引用绑定的是 Person 类型中定义的 mission 方法（静态绑定）
				//程序在运行的时候，堆中的对象实际是一个 Student 类型，而 Student 类已经重写了 mission 方法
				//因此程序在运行阶段对象中绑定的方法是 Student 类中的 mission 方法（动态绑定）
			 */
			p1.mission(); 
			/**
			 * 2、对象向下转型， 父类--> 子类  需要强转
			 */
			Student s1 = (Student)p1;
			//调用的是 Student 的 score
			s1.score();
			/**
			 * 
			 * 测试 - 向上转型的时候， 父类引用不调用子类的特有属性
			 * 
			 */
			//p1.score();    //此时编译发现p1是Person对象，没有score方法，直接编译报错。
			/**
			 * 
			 * 测试 - 向下转型的时候， 报错 
			 * 		加入instanceof 比较符，判断对象是否是后面的实例
			 * 
			 */
			if(p1 instanceof Teacher) {
				Teacher s2 = (Teacher)p1;  // java.Student cannot be cast to Java.Teacher
				// Student 类与 Teacher 类 没有继承关系 ,运行是不能转化，报错。
				s2.salary();  // 
			}
			
			/**
			 * 4、多态数组：数组的定义类型为父类类型，里面保存的实际元素类型为子类类型。
				代码示例：（循环调用基类对象，访问不同派生类的方法）
				说明：
					-、定义一个 Person 类 作为父类，定义 Student 类 和 Teacher 类 作为子类继承父类；
					-、Person 类 拥有 name(姓名) 属性 以及 mission() 方法；
					-、Student 类 和 Teacher 类 拥有各自特有的 score 和 salary 属性,，除此之外，重写父类的 mission() 方法 ；
					-、要求：最后在 main 函数中 创建一个 Person 对象 、一个 Student 对象 和 一个 Teacher 对象，统一放在数组里，并调用每个对象的 mission() 方法。
					
					demo例子中， 父类和子类都有构造方法，子类用super(name)调用父类name的构造方法、
			 */
			Person[] persons = new Person[3];
			persons[0] = new Person("张三");
			persons[1] = new Student("sili ", 100);
			persons[2] = new Teacher("王五");
			//循环遍历多态数组，调用 mission
			for(int i = 0; i < persons.length; i++) {
				//此处涉及动态绑定机制
				// Person[i] 编译类型是 Person ,运行类型根据实际情况由 JVM 判断
				persons[i].mission();
			}
			
			/**
			 * 多态参数 ： 方法定义的形参类型为父类类型，实参类型允许为子类类型。
			 */
	}
}

class Student extends Person {	
	private double score;

	public Student(String name, double score) {
		super(name);
		this.score = score;
	}

	public double getScore() {
		return score;
	}

	public void setScore(double score) {
		this.score = score;
	}
	@Override
	public void mission() {	
		super.mission();
		System.out.println(  score +"学生要好好学习！");
	}
	
	public void score() {
		System.out.println("学生得到好成绩！");
	}
}

class Teacher extends Person {
	public Teacher(String name) {
		super(name);
		// TODO Auto-generated constructor stub
	}

	@Override
	public void mission() {	
		super.mission();
		System.out.println("老师要好好教书！");
	}
	
	public void salary() {	
		System.out.println("老师得到高工资！");
	}
}


