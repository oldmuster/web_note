#### 常用DOS命令

###### 隐藏文件`attrib`

~~~makefile
attrib +h 文件名.扩展名
~~~



###### 创建指定大小的空文件

~~~makefile
fsutil file createNew 路径\文件名 指定文件大小（字节）
~~~

~~~makefile
fsutil file createnew  c:\Users\123.text 20480000000			恶意占用空间
~~~



#### 批处理编写（脚本）

