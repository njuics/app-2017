

# 网络通信

---

## 网络通信

![](https://developer.apple.com/library/content/documentation/NetworkingInternetWeb/Conceptual/NetworkingOverview/art/AboutNetworking.png)


---

## 网络通信

- Peer-to-peer网络
- <span style="color:red">访问Web服务器</span>
- 访问FTP服务器
- 网络服务发现
- 解析DNS名
- 使用Socket
- 安全加密通信

---

## 加载显示web页面

- 用`UIWebView`将Web内容嵌入应用
  - 创建一个`UIWebView`对象并放置于`window`内, 然后向其发送加载Web内容的请求
  - 可前进、后退等

---

## DEMO

<small>https://github.com/idupclub/MyWebView.git</small>

---

UIWebViewDelegate

<small>https://developer.apple.com/documentation/uikit/uiwebviewdelegate</small>



---

## 访问Web内容

- 使用NSURLSession或者NSURLConnection
  - 与NSURLConnection相比，NSURLSession最直接的改善就是提供了配置每个会话的缓存、协议、cookie和证书政策（credential policies），甚至跨应用程序共享它们的能力。


--- 

## URLConnection

- 一个URLConnection 对象让你可以加载指定URL的内容 
  - URLConnection 接口较少, 仅提供给开始、取消等 
  - 相关配置参数主要通过URL请求对象进行设置

---

## 同步请求

``` swift

let urlPath: String = "http://www.nju.edu.cn"
let url = URL(string: urlPath)!
let request1 = URLRequest(url: url)
let response: AutoreleasingUnsafeMutablePointer<URLResponse?>?=nil

do{
    let dataVal = try NSURLConnection.sendSynchronousRequest(request1, returning: response)
    let dataString = NSString.init(data: dataVal, encoding: String.Encoding.utf8.rawValue)
    print(response as Any)
    print(dataString!)
}catch let error as NSError{
    print(error.localizedDescription)
}
```

---

## 异步请求

``` swift

let urlPath: String = "http://www.nju.edu.cn"
let url = URL(string: urlPath)!
let request1 = URLRequest(url: url)

let queue = OperationQueue()
NSURLConnection.sendAsynchronousRequest(request1, queue: queue, 
      completionHandler:{ (response: URLResponse?, data: Data?, error: Error?) -> Void in
        let dataString = NSString.init(data: data!, encoding: String.Encoding.utf8.rawValue)
        print(response!)
        print(dataString!)
      }
    )

```

---

NSURLConnectionDelegate

<small>https://developer.apple.com/documentation/foundation/nsurlconnectiondelegate</small>

NSURLConnectionDataDelegate

<small>https://developer.apple.com/documentation/foundation/nsurlconnectiondatadelegate</small>

---

## NSURLSession

- 提供丰富接口支持认证，并允许在后台进行下载
- 应用可以创建一系列`NSURLSession`对象, 每个对象协调一组相关的任务进行数据传输
  - 如编写一个Web浏览器，则可为每个页面浏览Tab或窗口创建一个session，每个session内可以添加一系列任务，每个任务实际执行对某个指定URL内容的加载过程

---

## 异步执行
- `NSURLSession`是异步的 
  - 如果使用系统默认提供的delegate, 则必须提供一个completion handler来将传输结束或失败后的数据传回应用
  - 如果提供定制的delegate，则任务对象可以调用那些delegate方法已返回其传输完的数据

---

## 简单示例

``` swift
func httpGet(request: URLRequest!, callback: @escaping (String, String?) -> Void) {
    let session = URLSession.shared
    let task = session.dataTask(with: request){
        (data, response, error) -> Void in
        if error != nil {
            callback("", error!.localizedDescription)
        } else {
            let result = NSString(data: data!, encoding:
                String.Encoding.ascii.rawValue)!
            callback(result as String, nil)
        }
    }
    task.resume()
}

var request = URLRequest(url: url)

httpGet(request: request){
    (data, error) -> Void in
    if error != nil {
        print(error!)
    } else {
        print(data)
    }
}
```

---

## 三种Session类型

- Default sessions 使用持久化存储缓存数据和证书
- Ephemeral sessions 不保存任何数据到磁盘，所有缓存、证书等保存在RAM中
- Background sessions 使用一个独立进程完成所有数据传输（其它方面与default类型一致）

---

## 三种任务类型
- Data tasks 发送接收`Data`类型对象 
  - 设计为短时间、经常性的访问任务，可每次收到一个数据块即返还，或一次性将收到的完整数据交给completion handler
  - 不支持直接保存到文件，不能在background session中启动
- Download tasks 文件形式获取数据，支持后台传输
- Upload tasks （可以文件形式）发送数据，支持后台传输

---

## Playground

<small>https://github.com/njuics/app-2017f/tree/master/examples/Networking.playground</small>


---

## Demo

<small>https://www.raywenderlich.com/158106/urlsession-tutorial-getting-started</small>

---
## The End