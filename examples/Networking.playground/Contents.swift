//:
//: Playground - noun: a place where people can play

import Foundation
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

//:
//: Loading data synchronously with NSURLConnection

let urlPath: String = "http://www.nju.edu.cn"
let url = URL(string: urlPath)!
let request1 = URLRequest(url: url)
let response: AutoreleasingUnsafeMutablePointer<URLResponse?>?=nil


do{
    
    let dataVal = try NSURLConnection.sendSynchronousRequest(request1, returning: response)
    
    let dataString = NSString.init(data: dataVal, encoding: String.Encoding.utf8.rawValue)
    print(response as Any)
    
    print(dataString!)
    
}catch let error as NSError
{
    print(error.localizedDescription)
}

//: Loading data asynchronously with NSURLConnection


let queue = OperationQueue()

NSURLConnection.sendAsynchronousRequest(request1, queue: queue, completionHandler:{ (response: URLResponse?, data: Data?, error: Error?) -> Void in
    
    let dataString = NSString.init(data: data!, encoding: String.Encoding.utf8.rawValue)
    
    print(response!)
    
    print(dataString!)
    
    
})

//: Loading data by delegate with NSURLConnection


class ConnectionDelegate: NSObject, NSURLConnectionDelegate, NSURLConnectionDataDelegate{
    
    var dataReceived = Data()
    
    func connection(_ connection: NSURLConnection, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func connection(_ connection: NSURLConnection, didReceive response: URLResponse) {
        print(response.description)
    }
    
    func connection(_ connection: NSURLConnection, didReceive data: Data) {
        self.dataReceived.append(data)
    }
    
    func connectionDidFinishLoading(_ connection: NSURLConnection) {
        let dataString = NSString.init(data: dataReceived, encoding: String.Encoding.utf8.rawValue)
        print(dataString!)
    }
    
    
}

let delegate = ConnectionDelegate()


var connection = NSURLConnection(request: request1, delegate: delegate, startImmediately: true)!
connection.start()



//:
//: Loading data by handler with NSURLSession

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

//: Loading data with NSURLSessionDownloadDelegate

class Downloader:NSObject, URLSessionDownloadDelegate {
    
    var session: URLSession?
    
    override init() {
        
        super.init()
        
        let imageURL = URL(string: "http://www.nju.edu.cn/_upload/tpl/01/36/310/template310/images/logo.png")!
        
        
        let session = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
        
        
        session.downloadTask(with: imageURL).resume()
        
    }
   
   
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        print("Download completed")
    }
    
   
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didResumeAtOffset fileOffset: Int64, expectedTotalBytes: Int64) {
        print("Resume downloading from \(fileOffset) , total \(expectedTotalBytes)")
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        print("Downloading \(totalBytesWritten)/\(totalBytesExpectedToWrite)")

    }
   
    
    
}

var d = Downloader()







