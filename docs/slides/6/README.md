

# 高级视图和控制器

---

## Navigation Controller

导航控制器（navigation controller）以堆栈形式管理一组（子）内容视图控制器 ，以展示层次化内容

![](https://developer.apple.com/library/content/documentation/WindowsViews/Conceptual/ViewControllerCatalog/Art/photos_app.jpg) <!-- .element height="40%" width="50%" --> 


---

## UINavigationController管理对象

![](https://developer.apple.com/library/content/documentation/WindowsViews/Conceptual/ViewControllerCatalog/Art/nav_controllers_objects.jpg) <!-- .element height="50%" width="50%" --> 

---

## 导航堆栈

![](https://developer.apple.com/library/content/documentation/WindowsViews/Conceptual/ViewControllerCatalog/Art/nav_controllers_stack.jpg) <!-- .element height="50%" width="50%" --> 

堆栈：后进先出


---

## Navigation Bar

![](https://developer.apple.com/library/content/documentation/WindowsViews/Conceptual/ViewControllerCatalog/Art/navbar_custom.jpg)



---

## Tab Bar 控制器

Tar Bar控制器可将应用中的多个操作界面以并列形式组织在一起

![](https://developer.apple.com/library/content/documentation/WindowsViews/Conceptual/ViewControllerCatalog/Art/tabbar_controllerviews.jpg) <!-- .element height="50%" width="50%" --> 

---

## Tab Bar管理对象

![](https://developer.apple.com/library/content/documentation/WindowsViews/Conceptual/ViewControllerCatalog/Art/tabbar_objects_2x.png) <!-- .element height="50%" width="50%" --> 



---

## Tab Bar项目 

![](https://developer.apple.com/library/content/documentation/WindowsViews/Conceptual/ViewControllerCatalog/Art/vc_tabbar_objects.jpg)  <!-- .element height="50%" width="50%" -->


---

## Tab Bar与Navigation组合

![](https://developer.apple.com/library/content/documentation/WindowsViews/Conceptual/ViewControllerCatalog/Art/NavigationViews_2x.png) <!-- .element height="50%" width="50%" --> 

---

## 参考文档

[View Controller Catalog for iOS](https://developer.apple.com/library/ios/documentation/WindowsViews/Conceptual/ViewControllerCatalog/Introduction.html)


---

## Scroll View

当显示的内容大于屏幕可显示区域时使用滚动视图（UIScrollView）

![](https://developer.apple.com/library/content/documentation/WindowsViews/Conceptual/UIScrollView_pg/Art/NSImageView_UIScrollView.jpg)

---

## 参考文档


[Scroll View Programming Guide for iOS](https://developer.apple.com/library/content/documentation/WindowsViews/Conceptual/UIScrollView_pg/Introduction/Introduction.html)


---


## Table View

表（Table）是一种常用的视图

![](https://developer.apple.com/library/content/documentation/UserExperience/Conceptual/TableView_iPhone/Art/types_of_table_views.jpg) <!-- .element height="50%" width="65%" --> 

---

## 参考文档


[Table View Programming Guide for iOS](https://developer.apple.com/library/content/documentation/UserExperience/Conceptual/TableView_iPhone/AboutTableViewsiPhone/AboutTableViewsiPhone.html) 



---

## TableView API

- 一个表视图是UITableView类型（UIScrollView的子类）的实例
  + 可基于UITableView的接口进行属性设置等
- UIKit提供UITableViewController作为UITableView的视图控制器
  + 可基于UITableViewController的接口进行表中选择项管理、行编辑和表格配置等操作

---

## Delegate和Data Source

- 一个Table View还需要一个Data Source和一个Delegate
  - Data source([UITableViewDataSource](https://developer.apple.com/library/ios/documentation/UIKit/Reference/UITableViewDataSource_Protocol/index.html))从数据模型中获取数据提供给表
  - Delegate([UITableViewDelegate](https://developer.apple.com/library/ios/documentation/UIKit/Reference/UITableViewDelegate_Protocol/index.html))负责管理表的外观和行为 
- 两者一般是同一个对象来实现，即你所实现的用以管理这个TableView的UITableViewController的子类

---


## 参考文档


[Table Views](https://developer.apple.com/documentation/uikit/views_and_controls/table_views)


---

## The End