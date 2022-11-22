package tree;

import java.util.Random;
import java.util.Stack;

/**
 * 跳跃表
 * 
 * 	跳表(SkipList，全称跳跃表)是用于有序元素序列快速搜索查找的一个数据结构，跳表是一个随机化的数据结构，
 *      实质就是一种可以进行二分查找的有序链表。跳表在原有的有序链表上面增加了多级索引，通过索引来实现快速查找。
 * 	跳表不仅能提高搜索性能，同时也可以提高插入和删除操作的性能。它在性能上和红黑树，AVL树不相上下，但是跳表的原理非常简单，实现也比红黑树简单很多。
 * 参考资料： https://blog.csdn.net/qq_40693171/article/details/111751992
 * @author wang.ying.nan
 *
 */
class SkipNode<T>
{
    int key;
    T value;
    SkipNode right,down;//维护右下两个方向的指针
    public SkipNode (int key,T value) {
        this.key=key;
        this.value=value;
    }

}
public class SkipList<T> {

//	class SkipNode<T> {
//		T value;
//		int key;
//		Object o;
//		SkipNode right,down;
//		SkipNode(int key,T value){
//			this.value = value;
//			this.key = key;
//		}
//	}
	
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
				}else if(key > team.right.key){
					team = team.right;  // 节点还在右侧，继续
				}else {
					team = team.down;  // 右侧不存在，向下检索。
				}
			}else {   // 右侧为null,向下检索
				team = team.down;
			}
		}
		return true;
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
		while(team != null) {
			if(team.right != null) {
			    if(key > team.right.key){
					team = team.right;  // 节点还在右侧，继续
				}else  {
					/*
					   * 此时不能复制， 要压栈之后，遍历栈从下往上赋值
					 */
//					SkipNode right = team.right;
//					team.right = node;// 右侧不存在，赋值。
//					node.right = right;
					stack.add(team);   // 栈 赋值 向下的节点
					team = team.down;  //继续向下检索
				}
			}else {  
				/*
				   * 此时不能复制， 要压栈之后，遍历栈从下往上赋值
				 */
				 // 右侧为null,赋值
//				team.right = new SkipNode<T>(key, null);
				stack.add(team);  // 栈赋值 向下的节点
				team = team.down;
			}
		}
		
		int level = 1 ;// 当前层数，从1开始
		SkipNode downNode = null ;// 向下的节点，初识为null
		// 出栈，从底层往上循环每一层， 插入key值。
		while(!stack.isEmpty()) {
			team = stack.pop();
//			if(team.right != null) {
//				team.right.down = downNode;
//				downNode = team.right;
//			}
//			else {
//				SkipNode<T> upNode = new SkipNode<T>(key, null);
//				team.right = upNode;	
//				team.right.down = downNode;
//				downNode = upNode;
//			}
			
			if(team.right != null) {
				if(team.right.right != null) {
					// 插入节点， 更新左节点的右节点，  插入节点的右节点
//					SkipNode right = team.right;
//					team.right = node;
//					node.right = right;
					node.right =team.right;
					team.right = node;
					// 更新downNode
					team.right.down = downNode;
					downNode = team.right;
				}else {
					// 更新downNode
					team.right.down = downNode;
					downNode = team.right;
				}
			}else {
				// 右侧为null,更新右节点，  
				//创建新节点（因为如果向上重新建立索引，需要新建节点，key与插入值一致，保证上面的索引和插入的一致， ），   不能直接使用Node，因为Node循环的时候已经是下层的节点了，需要新建，
				SkipNode upNode = new SkipNode(node.key, node.value);
				team.right = upNode;	
				// 更新downNode ，供下次使用。
				team.right.down = downNode;
				downNode = upNode;
			}
			
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
	
	// demo add
	public void add(SkipNode node)
    {
    
        int key=node.key;
        SkipNode findNode=search(key);
        if(findNode!=null)//如果存在这个key的节点
        {
            findNode.value=node.value;
            return;
        }

        Stack<SkipNode>stack=new Stack<SkipNode>();//存储向下的节点，这些节点可能在右侧插入节点
        SkipNode team=headNode;//查找待插入的节点   找到最底层的哪个节点。
        while (team!=null) {//进行查找操作
            if(team.right==null)//右侧没有了，只能下降
            {
                stack.add(team);//将曾经向下的节点记录一下
                team=team.down;
            }
            else if(team.right.key>key)//需要下降去寻找
            {
                stack.add(team);//将曾经向下的节点记录一下
                team=team.down;
            }
            else //向右
            {
                team=team.right;
            }
        }

        int level=1;//当前层数，从第一层添加(第一层必须添加，先添加再判断)
        SkipNode downNode=null;//保持前驱节点(即down的指向，初始为null)
        while (!stack.isEmpty()) {
            //在该层插入node
            team=stack.pop();//抛出待插入的左侧节点
            SkipNode nodeTeam=new SkipNode(node.key, node.value);//节点需要重新创建
            nodeTeam.down=downNode;//处理竖方向
            downNode=nodeTeam;//标记新的节点下次使用
            if(team.right==null) {//右侧为null 说明插入在末尾
                team.right=nodeTeam;
            }
            //水平方向处理
            else {//右侧还有节点，插入在两者之间
                nodeTeam.right=team.right;
                team.right=nodeTeam;
            }
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

    }

	 // 打印跳表
	  public void printList() {
	        SkipNode teamNode=headNode;
	        int index=1;
	        SkipNode last=teamNode;
	        // head down至最底层。
	        while (last.down!=null){
	            last=last.down;
	        }
	        // 循环打印每一行
	        while (teamNode!=null) {
	            SkipNode enumNode=teamNode.right;
	            SkipNode enumLast=last.right;
	            System.out.printf("%-8s","head->");
	            //循环每一行的node值
	            while (enumLast!=null&&enumNode!=null) {
	            	// 最底层head。down与 当前层的teamNode.right一致时，打印 Key
	                if(enumLast.key==enumNode.key)
	                {
	                    System.out.printf("%-5s",enumLast.key+"->");
	                    enumLast=enumLast.right;
	                    enumNode=enumNode.right;
	                }
	                else{
	                	// 最底层head。down与 当前层的teamNode.right不一致时，不打印
	                    enumLast=enumLast.right;
	                    System.out.printf("%-5s","");
	                }

	            }
	            // 向下一层
	            teamNode=teamNode.down;
	            index++;
	            System.out.println();
	        }
	    }
	    public static void main(String[] args) {
	        SkipList<Integer> list=new SkipList<Integer>();
	        for(int i=1;i<20;i++)
	        {
//	            list.add(new SkipNode(i, 555));
	        	list.insert(new SkipNode(i, 555));
	        }
	        list.printList();
	        list.delete(4);
	        list.delete(8);
	        list.printList();
	    }
//// 删除前
//	    head->                                          9->  
//	    head->                                          9->  
//	    head->                 4->                      9->                      14-> 
//	    head->                 4->                 8->  9->  10->                14->           17->      19-> 
//	    head->  1->  2->  3->  4->  5->  6->  7->  8->  9->  10-> 11-> 12-> 13-> 14-> 15-> 16-> 17-> 18-> 19-> 
// 删除后（4,8）：
//	    head->                                9->  
//	    head->                                9->  
//	    head->                                9->                      14-> 
//	    head->                                9->  10->                14->           17->      19-> 
//	    head->  1->  2->  3->  5->  6->  7->  9->  10-> 11-> 12-> 13-> 14-> 15-> 16-> 17-> 18-> 19-> 

	
	
}
