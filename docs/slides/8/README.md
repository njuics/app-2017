

# 并发编程

---

## 程序性能

- 早期计算机中CPU的时钟频率决定其性能指标，但最大时钟频率存在物理原则上的限制
- 多核架构的CPU成为当前提高性能的主要技术手段
- 应用应尽量有效使用计算核以提高其性能和效率


---

## 并发编程

- “并发”是同一时间执行多个任务的概念
- 单CPU被分时共享实现“伪并发”
- 多CPU或单CPU多核可实现“真并发”

---

## 进程

- 进程是指在系统中正在运行的一个应用程序
  - 每个进程之间是独立的
  - 每个进程都是运行在其专用且受保护的内存空间内
  - 每个进程下至少有一条线程，可以有多条线程


---

## 线程

- 线程是是进程的基本执行单元，一个进程（程序）的所有代码都必须在线程中执行
  - 线程是进程中的一个实体，是被系统独立调度和分派的基本单位
  - 一个线程同一时间只能执行一个机器指令
  - 线程自己不拥有系统资源，但是它可以与同属一个进程的其他线程共享进程所拥有的全部资源

如果存在多个核（core）则多个线程可以同时执行，从而减少一个任务的总执行时间


---

## iOS并发编程机制

- Pthread／Thread
- Dispatch Queue
- Operation Queue


--- 

## Pthread

POSIX线程（POSIX threads），简称Pthreads，是线程的POSIX标准。该标准定义了创建和操纵线程的一整套API。在类Unix操作系统（Unix、Linux、Mac OS X等）中，都使用Pthreads作为操作系统的线程。

``` c
#import <pthread.h>

pthread_t thread;

//创建一个线程并自动执行
pthread_create(&thread, NULL, start, NULL);

void *start(void *data) {
    NSLog(@"%@", [NSThread currentThread]);

    return NULL;
}

```
---

## NSThread/Thread

Pthread的面向对象封装。可以直接操控线程对象，直观和方便。但是生命周期需要手动管理。


<small>https://developer.apple.com/documentation/foundation/thread</small>


---

## Swift Thread

``` swift
let thread = Thread.init(target: self, selector: Selector("run"), object: nil)
thread.name = "Thread A"
thread.start()

func run() {
        let thread = NSThread.currentThread()
        print("run--\(thread.name)-\(thread)")
}
```

---

## 问题

- 活跃线程的数量可能会呈指数级增长，因为应用代码和底层框架代码都可能在不断创建新的线程 
  - 例如，应用代码根据当前CPU核数（8）创建8个线程，但这些代码会调用系统框架代码，这些代码又创建了若干线程（而应用并不知道） 
  - 局部的优化不等于全局优化

[The Move Away from Threads](https://developer.apple.com/library/content/documentation/General/Conceptual/ConcurrencyProgrammingGuide/ConcurrencyandApplicationDesign/ConcurrencyandApplicationDesign.html)

---

## 正确的设计方法

Dispatch Queue & Operation Queues

---

## Grand Central Dispatch

- Grand Central Dispatch (GCD) 是 Apple 开发的一个多核编程的解决方法,该方法在 Mac OS X 10.6 雪豹中首次推出，并随后被引入到了 iOS4.0 中
- GCD让程序创建的线程进行排队，根据可用的处理资源，安排他们在任何可用的处理器核心上执行任务
- GCD中的FIFO队列称为dispatch queue，它可以保证先进来的任务先得到执行

---

## 优势

- GCD会自动利用更多的CPU内核（比如双核、四核）
- GCD会自动管理线程的生命周期（创建线程、调度任务、销毁线程）
- 程序员只需要告诉GCD想要执行什么任务，不需要编写任何线程管理代码

---

## 两个核心概念

- 任务：执行什么操作
- 队列：用来存放任务

---

## 任务

[Blocks](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/ProgrammingWithObjectiveC/WorkingwithBlocks/WorkingwithBlocks.html) (Objectigve-C) & [Closures](https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Closures.html) (Swift)


---

## Closure

Closures are self-contained blocks of functionality that can be passed around and used in your code. Closures in Swift are similar to blocks in C and Objective-C and to lambdas in other programming languages.

---

## 任务执行方式

- 任务有两种执行方式： 同步执行和异步执行。 同步（sync）和异步（async）的主要区别在于会不会阻塞当前线程，直到任务执行完毕。
  - 如果是 同步（sync）操作，它会阻塞当前线程并等待 Block 中的任务执行完毕，然后当前线程才会继续往下运行。
  - 如果是 异步（async）操作，当前线程会直接往下执行，它不会阻塞当前线程。

---

## 队列

- 队列存放任务，分为串行队列和并行队列
  - 放到串行队列的任务，GCD 会 FIFO（先进先出） 地取出来一个，执行一个，然后取下一个，这样一个一个的执行。
  - 放到并行队列的任务，GCD 也会 FIFO的取出来，但不同的是，它取出来一个就会放到别的线程，然后再取出来一个又放到另一个的线程。这样由于取的动作很快，忽略不计，看起来，所有的任务都是一起执行的。不过需要注意，GCD 会根据系统资源控制并行的数量，所以如果任务很多，它并不会让所有任务同时执行。



---

## GCD 队列

![GCD Queues](https://www.objc.io/images/issue-2/gcd-queues@2x-82965db9.png)

---


## Demo

https://github.com/appcoda/GCDSamples

---

## Tutorial

![](https://koenig-media.raywenderlich.com/uploads/2016/12/after_background_task_2-284x500.png) <!-- .element height="50%" width="22%" --> 

<small>https://www.raywenderlich.com/148513/grand-central-dispatch-tutorial-swift-3-part-1</small>
<small>https://www.raywenderlich.com/148513/grand-central-dispatch-tutorial-swift-3-part-2</small>



---

## Operation Queue

- [OperationQueue](https://developer.apple.com/documentation/foundation/operationqueue)是对GCD队列模型的一个抽象
  - 相比GCD，OperationQueue实现为更方便实用的一组API
- OperationQueue定义了两种类型的队列: 主队列和定制队列.
  - 主队列（main queue）运作在主线程，定制队列（custom queues）在后台（非主线程）处理
- 在队列中处理的任务抽象为[Operation](https://developer.apple.com/documentation/foundation/operation)	


---

## Operation

An abstract class that represents the code and data associated with a single task.


<small>https://developer.apple.com/documentation/foundation/operation</small>

[NSInvocationOperation](https://developer.apple.com/documentation/foundation/nsinvocationoperation) & [BlockOperation](https://developer.apple.com/documentation/foundation/blockoperation)

---

## Demo



---

## Tutorial

![](https://koenig-media.raywenderlich.com/uploads/2014/07/classicphotos-stalled-screenshot.png) <!-- .element height="50%" width="22%" -->

<small>https://www.raywenderlich.com/76341/use-nsoperation-nsoperationqueue-swift</small>


---

## The End