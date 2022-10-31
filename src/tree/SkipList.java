package tree;

import java.util.Random;
import java.util.Stack;

/**
 * 跳跃表
 * @author wang.ying.nan
 *
 */
//class SkipNode<T>
//{
//    int key;
//    T value;
//    SkipNode right,down;//左右上下四个方向的指针
//    public SkipNode (int key,T value) {
//        this.key=key;
//        this.value=value;
//    }
//
//}
public class SkipList<T> {

	class SkipNode<T> {
		T value;
		int key;
		SkipNode right,down;
		SkipNode(int key,T value){
			this.value = value;
			this.key = key;
		}
	}
	
	SkipNode headNode;
	int highLevel ;
	Random random;
	final int MAX_LEVEL = 32 ; // 最大层
	
	SkipList(){
		random = new Random();
	    headNode=new SkipNode(Integer.MIN_VALUE,null);
        highLevel=0;
	}
	/**
	 *   查询数据
	 * @param key
	 * @return
	 */
	public SkipNode search(int key) {
		SkipNode team = headNode;
		while(team != null) {
			if(team.key == key) {
				return team;
			}else if( team.right != null){
				if( key > team.right.key ) {
					team = team.right;
				}else {
					team = team.down;
				}
			}else {
					team = team.down;
			}
		}
		return null;
	}
	/**
	 * 删除数据
	 * @param key
	 * @return
	 */
	public boolean delete(int key) {
		SkipNode team = headNode;
		while(team != null) {
			if(team.right != null) {
				if(team.right.key == key) {
					team.right = team.right.right; //删除当前层，改进节点值
					team = team.down; //向下继续检索
					return true;
				}else if(key > team.right.key){
					team = team.right;  // 节点还在右侧，继续
				}else {
					team = team.down;  // 右侧不存在，向下检索。
				}
			}else {   // 右侧为null,向下检索
				team = team.down;
			}
		}
		return false;
	}
	
	/**
	 * 插入数据 
	 * @param key
	 * @return
	 */
	public boolean insert(SkipNode node) {
		int key = node.key;
		// 判断是否存在，key存在更新value值
		SkipNode search = search(node.key);
		if(search != null) {
			search.value = node.value;
			return true;
		}
		SkipNode team = headNode;
		// 压栈 ，存放向下的Node
		Stack<SkipNode> stack = new Stack<SkipNode>();
		if(team.right != null) {
		    if(key > team.right.key){
				team = team.right;  // 节点还在右侧，继续
			}else  {
				SkipNode right = team.right;
				team.right = node;// 右侧不存在，赋值。
				node.right = right;
				stack.add(team);   // 栈 赋值 向下的节点
				team = team.down;  //继续向下检索
			}
		}else {   // 右侧为null,赋值
			team.right = new SkipNode<T>(key, null);
			stack.add(team);  // 栈赋值 向下的节点
			team = team.down;
		}
		
		int level = 1 ;// 当前层数，从1开始
		SkipNode downNode = null ;// 向下的节点，初识为null
		while(!stack.isEmpty()) {
			SkipNode pop = stack.pop();
			pop.right.down = downNode;
			downNode = pop.right;
			
			  //考虑是否需要向上
	        if(level>MAX_LEVEL)//已经到达最高级的节点啦
	            break;
	        double num=random.nextDouble();//[0-1]随机数
	        if(num>0.5)//运气不好结束
	            break;
	        level++;
	        if(level>highLevel)//比当前最大高度要高但是依然在允许范围内 需要改变head节点
	        {
	            highLevel=level;
	            //需要创建一个新的节点
	            SkipNode highHeadNode=new SkipNode(Integer.MIN_VALUE, null);
	            highHeadNode.down=headNode;
	            headNode=highHeadNode;//改变head
	            stack.add(headNode);//下次抛出head
	        }
		}
		return true;
	}
	
	  public void printList() {
	        SkipNode teamNode=headNode;
	        int index=1;
	        SkipNode last=teamNode;
	        while (last.down!=null){
	            last=last.down;
	        }
	        while (teamNode!=null) {
	            SkipNode enumNode=teamNode.right;
	            SkipNode enumLast=last.right;
	            System.out.printf("%-8s","head->");
	            while (enumLast!=null&&enumNode!=null) {
	                if(enumLast.key==enumNode.key)
	                {
	                    System.out.printf("%-5s",enumLast.key+"->");
	                    enumLast=enumLast.right;
	                    enumNode=enumNode.right;
	                }
	                else{
	                    enumLast=enumLast.right;
	                    System.out.printf("%-5s","");
	                }

	            }
	            teamNode=teamNode.down;
	            index++;
	            System.out.println();
	        }
	    }
	    public static void main(String[] args) {
	    	new SkipNode<T>(0, null);
	        SkipList<Integer>list=new SkipList<Integer>();
	        for(int i=1;i<20;i++)
	        {
//	            list.add(new SkipNode<T>(i, 555));
	        }
	        list.printList();
	        list.delete(4);
	        list.delete(8);
	        list.printList();
	    }
	
	
}
