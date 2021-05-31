## oracle 笔记

#### 修改密码

忘记密码，修改用户名密码。当密码忘记时可以通过一下命令` sqlplus“/ as sysdba `进入oracle后台。 这种登录方式使用的是操作系统的验证方式，因此，无需输入用户名和密码即可直接登录进去。 

~~~sql
select username,password from dba_users where username = 'SYSTEM';	 # 查询密码记录
~~~

~~~sql
alter user system identified by oracle;	# 将 system 密码改为 oracle
~~~

~~~sql
connect system/oracle	# 测试用户名密码能否正常登录
~~~



**扩展：** 

~~~sql
select sysdate from dual;	# 查当前时间	
~~~



#### 关系型数据库

* 多个表数据之间存在这关系。
* 在这些表上的数据操作依赖于关系。
* 关系用来描述多个表之间的数据依存，包括一对一、一对多、多对多的关系。
* 这些关系在Orcale数据库中表现为**主键**、**外键** 这种约束条见。

![1622081026049](../web_note/pic/1622081026049.png)



#### Oracle数据库的特点：

* 支持大数据库、多用户的高性能的事务处理。
* Oracle 遵守数据存储语言、操作系统、用户接口和网络通信协议的工业标准（SQL）
* 具有可移植性、可兼容性和可连接性。
* 支持分布式数据库和分布处理
* 全球化、跨平台的数据库

#### Oracle中的主要的数据类型：

* 1、字符型。 字符型的数据对大小写敏感

~~~sql
varchar(10)  -- 定长的字符型数据	
char(2) 	-- 定长的字符型数据

varchar2 (20) -- 变长的字符型数据
~~~



* 2、数值型。

~~~sql
number(4)   -- 不带小数点的数值
number(8,2) -- 数据总长度是8位，小数点后占2位
~~~



* 3、日期型。日期型数据格式：DD-MM-YYYY （日-月-年）

~~~sql
data
~~~

~~~sql
-- 实例：
create table demo1(    
       ID                   NUMBER(4)     PRIMARY KEY,
       NAME                 VARCHAR(8),
       PASSWORD             VARCHAR2(20),
       SEX                  CHAR(2),
       BIRTHDAY             DATE,
       SAL                 NUMBER(8,2)
       
);
~~~



#### SQL语句分类

* Select 查询语句
* DML语句（数据库操作语言）

~~~sql
Insert / Update / Delete / Merge(合并)	
~~~

* DDL语句（数据定义语言）

~~~sql
Create / Alter / Drop / Truncate	
~~~

* DCL语句（数据控制语言）

~~~sql
Grant / Revoke 
~~~

* 事务控制语句

~~~sql
Commit / Rollback / Savepoint	
~~~





#### 增删改查：

创建数据表：`create table 表名()`;

~~~sql
create table demo1(    
       ID                   NUMBER(4)     PRIMARY KEY,
       NAME                 VARCHAR(8),
       PASSWORD             VARCHAR2(20),
       SEX                  CHAR(2),
       BIRTHDAY             DATE,
       SAL                 NUMBER(8,2)
       
);
~~~



删除数据表：`drop table 表名`;

查询表：`select * from 表名`;



去除单列<font size=4 color =red>重复</font>的数据`distinct`

~~~sql
select distinct SALARY FROM EMPLOYEES;
~~~

去除多列<font size=4 color =red>重复</font>的数据

~~~sql
select distinct 字段1，字段2 from 表名;
~~~

使用<font size=4 color =red> where</font>条件查询（过滤）：

* 对于**字符型**和**日期型** 的数据必须使用`''`

~~~sql
select  LAST_NAME , SALARY FROM EMPLOYEES where  LAST_NAME='De Haan' OR SALARY=17000;

SQL> select  LAST_NAME , SALARY FROM EMPLOYEES where  LAST_NAME='De Haan' OR SALARY=17000;

LAST_NAME                     SALARY
------------------------- ----------
Kochhar                     17000.00
De Haan                     17000.00
~~~





#### 扩展：

SQL 语句是不区分大小写的，包括登录用户名，密码。

~~~sql
SelEct * FrOm Demo1;	
~~~



在查询过程中，对于数值型的数据，可以执行 + ，- ，* ，/  运算。

~~~sql
SQL> select LAST_NAME,SALARY ,SALARY*2 from employees;

LAST_NAME                     SALARY   SALARY*2
------------------------- ---------- ----------
King                        24000.00      48000
Kochhar                     17000.00      34000
~~~



可以给查询字段起别名，有不同的方式，可以不用`""` ，可以使用`""` ，可以不使用`AS`

~~~sql
select LAST_NAME  姓名,SALARY AS 工资 ,SALARY/1000 "结果" from employees;

姓名                              工资         结果
------------------------- ---------- ----------
King                        24000.00         24
Kochhar                     17000.00         17
De Haan                     17000.00         17
~~~



用`||` 可以将两列或多列查询结果合并到一起。相当于`java`中的`+`

~~~sql
select LAST_NAME  || SALARY AS 工资 ,SALARY/1000 "结果" from employees;

工资                                                                      结果
----------------------------------------------------------------- ----------
King24000                                                                 24
Kochhar17000                                                              17
De Haan17000                                                              17
~~~



对于日期型的数据可以使用加、减运算符。

![1622358681012](../web_note/pic/1622358681012.png)

两个日期型的数据相减，得到的是两个两者之间相差的天数。

两个日期型的数据不能相加，日期型的数据不能进行乘除运算。

查询日期格式：

~~~sql
select * from employees where HIRE_DATE='17/6月/1987'; 		-- 由于编码格式的原因所以加上汉字 月
~~~



改变当前会话中的日期格式：`alter session set nls_date_from="YYYY-MM-DD HH:MI:SS" ` 

~~~sql
alter session set nls_date_from="YYYY-MM-DD HH:MI:SS" -- 只对当前会话有效
~~~







