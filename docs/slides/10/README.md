

# 后台开发

---

## Node.js
![](https://gss1.bdstatic.com/-vo3dSag_xI4khGkpoWK1HF6hhy/baike/c0%3Dbaike220%2C5%2C5%2C220%2C73/sign=635ae65776d98d1062d904634056d36b/9825bc315c6034a81358c82ac1134954082376e6.jpg)<!-- .element height="50%" width="50%" --> 

[官网](https://nodejs.org/en/): Node.js® is a JavaScript runtime built on Chrome's V8 JavaScript engine.

---

## 主要用途
- 开发前端应用
- 快速搭建服务
- 架设网站

---

## npm

* 安装 Node 的时候，会同时安装 npm
```sh
$ npm -v
```
* 它是Node的模块管理器，开发Node项目的必备工具
* npm是世界上最大的开源代码库，拥有丰富的功能强大的开源模块

* 如果觉得使用npm下载模块的时候速度缓慢，可以设置npm的源为淘宝源:
```sh
$ npm config set registry https://registry.npm.taobao.org
```

---

## REST API

REST 是浏览器与服务器通信方式的一种设计风格

它的全称是“REpresentational State Transfer”

中文意为”表现层状态转换“

- Resource：资源
- Representation：表现层
- State：状态
- Transfer：转换

---

## REST 的核心概念
REST是”REpresentational State Transfer”，一种翻译是”表现层状态转移”

1. 互联网上所有可以访问的内容，都是资源
1. 服务器保存资源，客户端请求资源
1. 同一个资源，有多种表现形式
1. 协议本身不带有状态，通信时客户端必须通过参数，表示请求不同状态的资源
1. 状态转换通过HTTP动词表示

<small>简单来说，REST是所有web应用都应该遵守的架构设计指导原则，每一个URL代表一种资源，客户端通过四个HTTP动词，对服务器端资源进行操作，实现”表现层状态转化”</small>

---

## URL和查询字符
- URL 是资源的唯一识别符。
```
/company
/company/employee
```
- 查询字符串表示对所请求资源的约束条件。如果记录数量很多，服务器不可能都将它们返回给用户。API应该提供参数，过滤返回结果。
```
/company?name=baidu
/company/employee?name=baidu&year=24
```

---

## HTTP动词

| 操作      |  SQL方法   | HTTP动词   |
| -------- | :--------: | --------: |
| CREATE   | INSERT     | POST      |
| READ     | SELECT     | GET       |
| UPDATE   | UPDATE     | PUT/PATCH |
| DELETE   | DELETE     | DELETE    |

```
GET /v1/stores/1234 若要检索某个资源，应该使用 GET 方法。
PUT /v1/stores/1234 若要更改资源状态或对其进行更新，应该使用 PUT 方法。
POST /v1/stores 若要在服务器上创建资源，应该使用 POST 方法。
DELETE /v1/stores/1234 若要删除某个资源，应该使用 DELETE 方法。
```

---

## Express
Express 是最常用的 Node 框架，用来搭建 Web 应用，类似于Java里的Spring。
![](http://www.expressjs.com.cn/images/express.png)<!-- .element height="60%" width="60%" --> 

---

## 生成express初始项目

使用express-generator生成初始项目
```sh
#安装express-generator
$ npm install express-generator -g

#生成初始项目
$ express -e express-demo
```
进入express-demo文件夹，安装依赖，运行
```
$ cd express-demo
$ npm install
$ npm start
```
在浏览器中打开http://localhost:3000/ ，

查看运行结果

---

## 理解初始项目
- 该初始项目使用ejs模板，实现了一个简单的前端页面，我们主要使用express实现后台，接受请求并与数据库交互，存取数据，返回结果
- 主要代码逻辑在app.js中，启动配置则在bin/www中，监听端口为3000
- nodejs对于模块的调用，使用require加载模块
- body-parser模块的作用，是对POST、PUT、DELETE等 HTTP 方法的数据体进行解析，app.use用来将这个模块加载到当前应用

---

## get请求
```javascript
var express = require('express');
var router = express.Router();

router.get('/', function(req, res, next) {
  res.send("This is a response to get.");
});

module.exports = router;
```

---

## post请求
```javascript
router.post('/', function (req, res) {
  var task = req.body.task;
  res.json({message: 'Task is ' + task});
});
```
<small>post请求传递的参数在req.body中，以json的形式存储。</small>

---

## 数据存储
- MongoDB存储数据
  - 具有传统关系型数据库的CURD操作
  - 以json格式存储数据，更符合前端数据存储

- nodejs有完善的与mongodb交互的模块mongoose，能够方便的实现与mongodb数据库的交互
- [官网](https://www.mongodb.com/download-center#community)下载并安装mongodb

---

## 存储数据

安装mongoose模块
```
$ npm install -S mongoose
```
连接数据库
```javascript
var mongoose = require('mongoose');

mongoose.connect('mongodb://localhost/express', {useMongoClient: true},
	function(err) {
  if (err) {
    console.log('connection error', err);
  } else {
    console.log('connection successful');
  }
});
```

---

## 存储数据
创建数据的格式，即需要存储的内容，

以schema的格式定义
```javascript
var mongoose = require('mongoose');

var TaskSchema = new mongoose.Schema({
  task: String,
  create_at: {
    type: Date,
    default: Date.now
  }
});

module.exports = mongoose.model("Task", TaskSchema);
```

---

## 存储数据
修改post请求，将数据存储到数据库
```javascript
router.post('/', function(req, res, next) {
  var task = req.body.task;
  //res.json({message: 'Task is ' + task});
  Task.create({task: task}, function(err, task){
		if (err) {
			return res.status(400).send("err in post /task");
		} else {
			return res.status(200).json(task);
		}
	});
});
```

---

## 获取存储的数据
修改get请求，获取存储在数据库中的数据
```javascript
router.get('/', function(req, res, next) {
  Task.find({}, function(err, tasks){
		if(err){
			return res.status(400).send("err in get /task");
		}else{
			console.log(tasks);
			return res.status(200).json(tasks);
		}
	})
});
```

---

## 中间件
```javascript
var router = express.Router();

// 新增的代码
router.use(function(req, res, next) {
  console.log('There is a requesting.');
  next();
});

router.get('/', function(req, res) {
  // ...
```
<small>router.use的作用是加载一个函数。这个函数被称为中间件，作用是在请求被路由匹配之前，先进行一些处理。上面这个中间件起到 logging 的作用，每收到一个请求，就在命令行输出一条记录。请特别注意，这个函数内部的next()，它代表下一个中间件，表示将处理过的请求传递给下一个中间件。这个例子只有一个中间件，就进入路由匹配处理（实际上，bodyparser、router本质都是中间件，整个 Express 的设计哲学就是不断对 HTTP 请求加工，然后返回一个 HTTP 回应）</small>

---

## 参数获取的方式
* 除了req.body获取参数的方式外，还有req.query和req.params两种方式
    1. 对于URL的查询字符串,比如`/users?name=Alice`里面的name，可以用req.query.name获取
    1. 对与URL中的参数，比如`/tasks/2017-11-25`与路由`/tasks/:date`相匹配，URL中的日期可以用req.params.date获取

---

## 练习
1. 使用put和delete操作，添加修改和删除任务的api，修改和删除指定_id的task，通过req.params获取参数
1. 修改get请求，获取给定日期的task，通过req.query获取参数


---

## The End