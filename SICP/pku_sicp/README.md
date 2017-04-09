# PKU SICP

## extra knowledge on the ppt

* lecture11webhan.pdf  10.5 讲到了关于hash还有桶结构的问题，相较于书本上对于table查找的方法，虽然initial后占用固定空间内存，一定程度上会造成空间浪费，但是search time很大程度上得到reduce,因此能够很好的在存储空间和查找时间之间进行balance。
具体来说，ppt上的hashfunc就是通过key和size(vector 的个数)参数来确定对应vector的index，然后通过index直接获取对应vector之后，再用assoc函数进行线性搜寻，这样搜寻时间就从原本的linear time，很大程度上变成(number of data)/size。相关桶操作可以参考**Introduction to Algorithm**

			table1: make			extremely fast
				    put!			extremely fast
					get				O(n) where n is depends on the number of data which is in the table

			table2: make			depends on the size
					put!			depends on the complexity of hash fucntion
					get				time to compute hash function
									+ (number of data)/size time to search in the bucket
Therefore, table1 is actually a better choice if you are doing very few *get* compared to the *put!* operation, or if the number of data you may put in the table is small. However, when it comes to a large number of data, table2 will definitely be faster.
* lecture13webhan.pdf  31.4 关于graph的遍历问题，depth-first 和 breadth-first，以及相应的存在连通图的graph通过在数据结构中添加mark位来记录是否已经visited。
