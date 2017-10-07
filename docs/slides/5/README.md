

# 视图控制器

---

## 视图控制器

![](https://developer.apple.com/library/content/documentation/General/Conceptual/DevPedia-CocoaCore/Art/model_view_controller_2x.png) <!-- .element height="80%" width="80%" --> 


---

## 核心职责

- 视图管理
- 交互处理
- 数据传送
- 界面切换

---

## 视图管理

![](https://developer.apple.com/library/content/featuredarticles/ViewControllerPGforiPhoneOS/Art/VCPG_ControllerHierarchy_fig_1-1_2x.png) <!-- .element height="50%" width="50%" --> 

每个视图控制器有（且仅有）一个根视图对象引用，可通过其访问到这个视图对象的所有子视图对象。一般使用[Outlet](https://developer.apple.com/library/ios/documentation/General/Conceptual/Devpedia-CocoaApp/Outlet.html)保存对视图对象的引用。


---

## 视图管理

- 每个控制器管理一个视图（及其子视图）
- 当你希望把某个视图显示出来时，应该将此视图对应的控制器作为应用窗口的根控制器（`rootViewController`），该视图控制器会自动将视图添加到窗口中并显示在屏幕上。
  + ⚠️ 永远不要尝试通过将视图赋予窗口对象的方法去显示其内容
- 视图控制器会在必要的时候加载并视图对象并显示其内容，同样，它会在合适的条件下自动释放视图（因此，视图控制器在应用中还起到管理资源的核心作用）


---

## 交互处理

控制器负责处理视图中产生的事件

- 当视图中某个按钮被按动，视图对象会获取该事件并报送给某个相关联的委托对象（delegte）或目标对象（target），一般而言，这个对象就是某个视图控制器对象
- 视图本身并不知晓这个事件将会引发的结果，按钮按动的含义和相应的反应是调用该视图控制器的某个方法（`IBAction`）
- 在获得这个事件发生的通知后，控制器可以执行更新数据或改变视图属性等操作，甚至将另一个视图控制器对应的视图内容展示在屏幕上


---

## Target-Action

![](https://developer.apple.com/library/content/documentation/General/Conceptual/Devpedia-CocoaApp/Art/target_action.jpg)

[Target-Action](https://developer.apple.com/library/content/documentation/General/Conceptual/Devpedia-CocoaApp/TargetAction.html)


---

## IBOutlet和IBAction

![](http://help.apple.com/xcode/mac/9.0/en.lproj/Art/gs_connection_drag.png)

[Connect objects to code](http://help.apple.com/xcode/mac/9.0/#/devc06f7ee11)


---

## 数据传送

![](https://developer.apple.com/library/content/featuredarticles/ViewControllerPGforiPhoneOS/Art/VCPG_CustomSubclasses_fig_1-3_2x.png) <!-- .element height="50%" width="50%" --> 

一般过程：交互事件触发控制器方法调用；方法执行过程中从数据对象获得数据；再通过视图对象引用（Outlet）操纵视图内容。

---

## 多场景设计

- OS设备是移动设备，屏幕空间非常有限（哪怕是iPad pro）
- 应用一般会有比较丰富的信息需要显示，但屏幕不能一次性显示所有内容，因此在用户与应用交互开始时应用仅会显示部分内容，并在以后过程中不断显示或隐藏其他内容
- 在此过程中视图控制器提供设施实现这一内容显示／隐藏的协同过程
- 通过不同控制器和对应的视图对应用进行分割，整个应用的用户界面被以较小的单位进行管理


---

## StoryBoard中定义多场景

- 一个场景（scene）代表在屏幕上显示的由一个控制器管理的内容区域，即一个视图控制器即其所管理的视图层次
- 可在同一个Storyboard中的两个场景间建立一个关系
  + 包容（Containment）：两个场景的父子关系，前者一般对应一个容器控制器
  + 延续（Segue）：从一个场景到另一个场景的转换（迁移）

---

## segue


- Push segue[ˈsegweɪ]：将目标视图控制器压入导航控制器所管理的控制器栈中
- Modal segue 将目标视图控制器呈现出来
- Popover segue 将目标视图控制器在一个弹出窗口（popover）中显示出来
- Custom segue允许你自行设计所需的展示目标视图控制器的切换过程


---


## 使用Segue

![](https://developer.apple.com/library/content/featuredarticles/ViewControllerPGforiPhoneOS/Art/segue_defined_2x.png)

---

## Unwind Segue


![](https://developer.apple.com/library/content/featuredarticles/ViewControllerPGforiPhoneOS/Art/segue_unwind_linking_2x.png)


You must define an unwind action method in one of your view controllers before trying to create the corresponding unwind segue in Interface Builder.


---

## unwind action method

```swift
@IBAction func myUnwindAction(unwindSegue: UIStoryboardSegue)
```

---

##特定的分割-并列


![](https://docs-assets.developer.apple.com/published/6ffdd16259/a4c30adf-176b-4020-ae69-f228edb9e621.png)

---


## 特定的分割-递进

![](https://docs-assets.developer.apple.com/published/83ef757907/navigation_interface_2x_8f059f7f-2e2f-4c86-8468-7402b7b3cfe0.png)

---

## 控制器分类

内容控制器（Content View Controllers）

 v.s. 
 
 容器控制器（Container View Controllers）


---


## 内容视图控制器

- 内容视图控制器负责显示可视内容
  + 将数据展示给用户
  + 从用户处收集数据
  + 执行特定操作
  + 等

---

## 容器视图控制器

- 容器视图控制器负责组织内容控制器
  + 容器视图控制器包含其他视图控制器所管理的内容
  + 被管理的视图控制器被显式地指定为容器视图控制器的子控制器 
  + 容器控制器可嵌套：它可作为其他容器控制器的子控制器，也可作为其他控制器的父控制器 
  + 通过这种形式控制器可形成层次结构（但跟视图层次不对应）


---

## 例：导航控制器

![](https://developer.apple.com/library/content/documentation/WindowsViews/Conceptual/ViewControllerCatalog/Art/photos_app.jpg)

---

## 例：分栏控制器
![](https://developer.apple.com/library/content/documentation/WindowsViews/Conceptual/ViewControllerCatalog/Art/vc-radio-interface.jpg)

---

## 例：Split View Controller


![](https://developer.apple.com/library/content/documentation/WindowsViews/Conceptual/ViewControllerCatalog/Art/splitview_master.png)

---

## 控制器内容（视图）显示


- 有多种方式可以通过控制器显示其相应的视图
  + 将某个控制器作为窗口对象的根视图控制器（上节已介绍）
  + 将视图控制器作为加入一个容器控制器
  + 让另一个控制器将其呈现（present）出来

---

## 作为根视图控制器

![](https://developer.apple.com/library/content/featuredarticles/ViewControllerPGforiPhoneOS/Art/VCPG-root-view-controller_2-1_2x.png) <!-- .element height="50%" width="50%" --> 


---

## 使用容器控制器为根视图控制器

![](https://developer.apple.com/library/content/featuredarticles/ViewControllerPGforiPhoneOS/Art/VCPG-container-acting-as-root-view-controller_2-2_2x.png) <!-- .element height="50%" width="50%" --> 


---

## 由另一个控制器将其呈现

![](https://developer.apple.com/library/content/featuredarticles/ViewControllerPGforiPhoneOS/Art/VCPG-presented-view-controllers_2-3_2x.png) <!-- .element height="50%" width="50%" --> 

---

## 或者更复杂

![](https://developer.apple.com/library/content/featuredarticles/ViewControllerPGforiPhoneOS/Art/VCPG-container-and-presented-view-controller_2-4_2x.png) <!-- .element height="50%" width="50%" --> 

---

## 参考

[View Controller Programming Guide for iOS](https://developer.apple.com/library/content/featuredarticles/ViewControllerPGforiPhoneOS)



---

## The End