mysql笔记

第一天

### 1、连接数据库

命令行连接

~~~sql
mysql -uroot -p123456	-- 连接数据库

update mysql.user set authentication_string=password('123456') where user='root' and Host='localhost';	-- 修改用户密码

flush privileges;	-- 刷新权限

describe 数据表;	-- 显示表中所有信息

~~~

~~~sql
create database 数据库名;	--创建数据库

--		sql 单行注释。
/*多行注释*/	
~~~



### 2、操作数据库

++++

操作数据库>操作数据库中的表>操作数据库表中的数据

##### 2.1操作数据库（了解）

1、创建数据库。

```sql
create database [if not exists] demo;	-- [] 表示可选
```

2、删除数据库。

~~~sql
drop database [if exists] sta1;
~~~

3、使用数据库。

~~~sql
use demo;

--	如果表名或者字段名是一个特殊字符，就需要带``
use `use`;
~~~

4、查看数据库。

~~~sql
show databases;	-- 查看所有的数据库。
~~~



##### 2.2、数据库的数据类型

> 数值

| 类型      |                                            | 字节数              |
| --------- | ------------------------------------------ | ------------------- |
| tinyint   | 十分小的数据                               | 1个字节             |
| smallint  | 较小的数据                                 | 2个字节             |
| mediumint | 中等大小的数据                             | 3个字节             |
| **int**   | **标准的整数**                             | **4个字节**         |
| bigint    | 较大的数据                                 | 8个字节             |
| float     | 浮点数                                     | 4个字节             |
| double    | 浮点数                                     | 8个字节（精度问题） |
| decimal   | 字符串形式的浮点数（金融计算的时候，常用） |                     |

> 字符串

| 类型        |                        | 字节数      |
| ----------- | ---------------------- | ----------- |
| char        | 固定大小的字符串       | 0~255       |
| **varchar** | **可变字符串**         | **0~65535** |
| tinytext    | 微型文本               | 2^8-1       |
| **text**    | **文本串(保存大文本)** | **2^16-1**  |

> 时间日期

| 类型         |                          |                        |
| ------------ | ------------------------ | ---------------------- |
| date         | YYY-MM-DD                | 日期格式               |
| time         | HH: mm: ss               | 时间格式               |
| **datetime** | **YYY-MM-DD HH: mm: ss** | **最常用的时间格式**   |
| timestamp    | 时间戳                   | 1970.1.1到现在的毫秒数 |
| year         | 年份表示                 |                        |

> null

null 表示没有值（空值），未知，**注意：** 不要使用 NULL 进行运算，结果为null



##### 2.3、数据库的字段属性（重点）

* Unsigned：
  * 无符号的整数
  * 声明了该列不能声明为负数

* zerfill:
  * 0填充
  * 不足的位数，使用0来填充。例如：`5 > 005`

* 自增（auto_increment）：

  * 通常理解为自增，自动在上一条记录的基础上+1（默认）

  * 通常用来设置唯一主键（index），必须是整数类型
  * 可以自定义设置主键自增的**起始值**和**步长**

* 默认：

  * 设置默认的值

##### 2.4、创建数据库表（重点）

~~~sql
-- AUTO_INCREMENT 自增
-- 注意最后一行命令后面不需要,(逗号)
-- PRIMARY KEY 主键，一般一个表只有唯一的主键

CREATE TABLE IF NOT EXISTS `student` (
`id` INT(4) NOT NULL AUTO_INCREMENT COMMENT '学号',
`name` VARCHAR(30) NOT NULL DEFAULT '匿名' COMMENT '姓名',
`pwd` VARCHAR(20) NOT NULL  DEFAULT '123456' COMMENT '密码',
PRIMARY KEY(`id`)		-- 设置主键约束
)ENGINE=INNODB DEFAULT CHARSET=utf8		-- 设置字符集
~~~

<font size=4 color=red>格式：</font>

~~~sql
CREATE TABLE [IF NOT EXISTS] `表名`(
	'字段名' 列类型 [属性] [属性] [索引] [注释]，
    '字段名' 列类型 [属性] [属性] [索引] [注释]，
     ··· ···
    '字段名' 列类型 [属性] [属性] [索引] [注释]
)[表类型] [字符集] [注释]
~~~



###### 查看创建语句。

* 查看创建数据库的语句

~~~sql
SHOW CREATE DATABASE 数据库名		-- 记不得命令时可以查看其他数据库是如何创建的
~~~

* 查看数据表的定义语句

~~~sql
SHOW CREATE TABLE 表名 	-- 可以查看该表的创建命令 
~~~

* 查看表的结构

~~~sql
DESC 表名		-- 显示表的结构（以表格的形式展现）
~~~



##### 2.5、修改和删除数据表（重点）

* 修改表名：ALTER TABLE 旧表名 RENAME AS 新表名

~~~sql
ALTER TABLE student RENAME AS student1	-- 修改表名
~~~

* 增加表字段：	ALTER TABLE 表名 ADD 字段名 列属性

~~~sql
ALTER TABLE student1 ADD age INT(4) COMMENT '年龄'
~~~

* 修改表的字段（重命名，修改约束）

~~~sql
-- 字段重命名
ALTER TABLE student1 CHANGE pwd passd  COMMENT '未知'	-- 不能更改约束条件

-- 修改约束
ALTER TABLE student1 MODIFY passd VARCHAR(11) COMMENT '密码' -- 不能字段重命名
~~~

* 删除表字段	ALTER TABLE 表名 DROP 字段名

~~~sql
ALTER TABLE student1 DROP age
~~~

* 删除表	DROP TABLE [IF EXISTS] 表名

~~~sql
DROP TABLE [IF EXISTS] student1
~~~

**所有的创建和删除操作尽量加上判断，以免报错**



 ### 3、MySQL数据库管理

##### 3.1、外键（了解）

~~~sql
ALTER TABLE 表 ADD CONSTRAINT 约束名 FOREIGN KEY(作为外键约束的列) REFERENCES 那个表（那个字段）
~~~

##### 3.2、DML语言（必须记住）

DML语言：数据操作语言

######  插入语句（insert）

  格式：` insert into 表名 (字段名1，字段名2，字段名3) values（'值1'，'值2'，'值3'）`

~~~sql
INSERT INTO `student` (`name`) VALUES('张三')
~~~

注意事项：

* 字段可以省略，但后面的值必须要一一对应。
* 可以同时插入多条数据，VALUES后面的值需要逗号（ , ）隔开。`( ),( )... ...`

###### 修改（update）

~~~sql
--  修改学生姓名，带条件
UPDATE `student` SET `name`='李四' WHERE id=1		-- 将 id=1 的学生姓名改成李四
UPDATE `student` SET `name`='王五',`pwd`='admin' WHERE id=1   -- 修改多条值

--  修改学生姓名，不带条件
UPDATE `student` SET `name`='王五'	-- 将所有学生的姓名改为王五
UPDATE `student` SET `name`='王五',`pwd`='admin'
~~~

条件：where 语句，运算符，id 等于某个值，大于某个值，小于某个值，在某个区间内修改。

| 操作符              | 含义         | 范围  | 结果  |
| ------------------- | ------------ | ----- | ----- |
| =                   | 等于         | 6=9   | false |
| <> 或 !=            | 不等于       |       |       |
| >                   | 大于         |       |       |
| <                   |              |       |       |
| >=                  | 大于等于     |       |       |
| <=                  | 小于等于     |       |       |
| between ... and ... | 在某个范围内 | [2,5] |       |
| and                 | &&           |       |       |
| or                  | \|\| 或      |       |       |

语法：` update 表名 set colnum_name = value,[colnum_name = value,....] where [条件]`

注意：

*  colnum_name 是数据库的列，最好使用` `` `
* 条件如果，没有指定，则会修改所有的列
* value，是一个具体的值，也可以是一个变量。

###### 删除：（delete）

语法：`delete from 表名 [where 条件]`

~~~sql
DELETE FROM `student` WHERE id=1	-- 删除学生表中id=1的学生信息
~~~

~~~sql
TRUNCATE `student` 	-- 清空数据表, 完全清空一个数据库表，表的结构和索引，约束都不会变
~~~



> delete 和 truncate 区别

* 相同点：都能删除数据库，都不会删除数据结构
* 不同点：

    * truncate 重新设置自增列，计数器会归零。
    * truncate 不会影响事务。

### 4、DQL 查询数据（最重要）

