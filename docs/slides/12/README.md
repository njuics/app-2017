

# 摄像、定位和地图

---

## 摄像

- iOS中拍照和视频开发相关技术
  - UIImagePickerController：常用于简单场景，例如拍摄一张照片等
  - AVFoundation：常用于较为复杂的场景，特别是需要对输入输出设备进行控制、混合视频音频、对输出文件进行复杂编辑等场景

---

## UIImagePickerController

用户创建一个UIImagePickerController对象来从媒体库获取照片/视频

![](https://developer.apple.com/library/content/documentation/AudioVideo/Conceptual/CameraAndPhotoLib_TopicsForIOS/Art/UIImagePickerController.jpg)


<small>提供基础功能，能够对获取的照片/视频提供简单的编辑功能</small>

---


使用UIImagePickerController拍摄

- 所有摄像头程序必须要做的三件事
  - 检查运行APP的设备是否有摄像头
  - 检查摄像头是否可以被APP使用
    - 即使设备有摄像头，也可能被其他应用程序占用
  - 实现一个Delegate对象处理用户的交互

---

示例

https://github.com/idupclub/VideoPlayRecord


---

## 参考文档

[Camera Programming Topics for iOS](https://developer.apple.com/library/content/documentation/AudioVideo/Conceptual/CameraAndPhotoLib_TopicsForIOS/Articles/TakingPicturesAndMovies.html)

---

## AVFoundation

![](https://developer.apple.com/library/content/documentation/AudioVideo/Conceptual/AVFoundationPG/Art/frameworksBlockDiagram_2x.png) <!-- .element height="50%" width="50%" --> 

---

## 参考

http://www.jianshu.com/p/ccc687578ca1

---

# 位置与地图

---

## 位置服务与地图

- 在应用中使用位置信息是一个将用户与周围物理试卷联系在一起的非常有效的方法
  - 位置服务通过Core Location 框架提供, 提供接口让应用获取用户当前位置和朝向
  - 地图在Map Kit框架中提供，支持地图的显示和地图标记

---

## 概览 


- 定位服务（Location Services）提供地理位置信息
  - iBeacon技术增强了用户定位（室内定位）
  - Heading 信息显示用户当前朝向
  - 地图支持导航和地理位置相关信息显示
  - 本地搜索


---

## 获取用户当前位置

- 可使用多种服务
  - 地理位置显着变化服务：提供了一种低功耗的方式来获得当前位置，并在发生重大变化时通知。
  - 标准位置服务：提供了一个高度可配置的获得当前位置和追踪位置变化的服务。
  - 区域监测：监测是否出入定义的地理位置区域和蓝牙低功耗信标（Beacon）地区。

---

## 首先：判断定位服务是否可用
- 不可用情况
  - 用户禁用定位功能
  - 设备处于飞行模式或无法启动某硬件
  - 用户拒绝了应用的定位权限授权

<small>因此需要在尝试获取标准或显著变化位置服务前，首先调用`CLLocationManager` 的`locationServicesEnabled`方法</small>

---

## 示例

https://github.com/idupclub/WhereAmI

---

能耗考虑

- 确保`pausesLocationUpdatesAutomatically` 属性设为`YES`
- 指定合适的精度要求 
- 任何可能的时刻都调用`allowDeferredLocationUpdatesUntilTraveled:timeout:` 方法以延迟更新数据传送

---

## 显示地图


- Map Kit 框架让开发者可以在应用中潜入一个功能完整的地图

- 使用MapKit需要在Xcode工程中打开“Maps能力（capability）


---

## MKMapView
- 显示地图数据
- 管理用户交互
- 显示应用定制的内容


---

## Map Delegate

- 提供响应Map视图事件的方法
  - 地图可视区域的改变事件
  - 从网络上下载地图内容块（tiles）的事件
  - 用户位置变化事件
  - 与地图标注和层相关的变化事件


---

## 参考文档

[Location and Maps Programming Guide](https://developer.apple.com/library/ios/documentation/UserExperience/Conceptual/LocationAwarenessPG/Introduction/Introduction.html)

---
## The End