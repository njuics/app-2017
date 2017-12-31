

# 视图

---

## 视图


![](https://developer.apple.com/library/content/documentation/General/Conceptual/DevPedia-CocoaCore/Art/model_view_controller_2x.png) <!-- .element height="40%" width="50%" -->


可视内容

---

## 概念

- **窗口**和**视图**是在iOS设备**屏幕**上用以展示App内容的部件
  + 屏幕是iOS设备所具有的显示装置，一般而言每个iOS设备具有至少一个（主）屏幕
  + 窗口提供了一个基本的视图的容器，窗口本身并不具有可视内容，一般而言每个应用具有一个窗口
  + 视图占据窗口的部分区域用以显示交互界面内容，一般而言每个应用至少具有一个视图用以展示其交互界面


---

## 窗口

- 每个iOS应用都需要至少一个窗口
- 窗口用以显示应用的可视界面内容
- 窗口对象是UIWindow类型的一个实例
- 窗口负责将系统中发生的touch事件传递到你的视图和其他应用对象以供处理
- 如果发生设备朝向（orientation）变化事件，窗口对象和应用的视图控制器对象对进行协作


---

## 创建窗口

使用StoryBoard则系统会自动创建和管理窗口对象

或者

可通过编程方式手工创建和管理窗口

```swift
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.window = UIWindow(frame: UIScreen.main.bounds)
        return true
    }
```

---

## 参考


[Windows and Screens
](https://developer.apple.com/documentation/uikit/windows_and_screens)

---

## 视图

- 应用中所需要显示的可视内容一般通过视图对象定义
- 每个视图对象都是 `UIView` 的子类
- 一个视图对象定义了在一个矩形区域范围内的可视内容和这些内容在屏幕上的绘制过程，并负责处理该矩形区域内发生的用户交互（触碰）事件


---

## UIKit

- 系统中UIKit和其他一些框架提供了预先定义好的视图和控件以供你的应用所使用
  + 预定义的视图和控件包括简单的按钮、文本标签和复杂的表格视图（Table View）、选取器（Picker View）、滚动视图（Scroll View）等
- 如果预定义的这些视图并不能满足你的要求，也可以自己定义个性化视图和控件，包括对视图绘制和事件处理的定制


---

## 参考

[Views and Controls](https://developer.apple.com/documentation/uikit/views_and_controls)


---

## 视图层次

![](https://developer.apple.com/library/content/documentation/WindowsViews/Conceptual/ViewPG_iPhoneOS/Art/windowlayers.jpg)

---

## Interface Builder

![](http://help.apple.com/xcode/mac/9.0/en.lproj/Art/IB_overview.png)   <!-- .element height="50%" width="60%" -->


[Interface Builder](http://help.apple.com/xcode/mac/9.0/#/dev31645f17f)


---

## 自动布局

![](http://help.apple.com/xcode/mac/9.0/en.lproj/Art/ib_al_about_auto_layout.png)<!-- .element height="50%" width="60%" -->

[Auto Layout and Layout Constraints](http://help.apple.com/xcode/mac/9.0/#/devc5759ad6f)

---

## 参考

[Auto Layout Guide](https://developer.apple.com/library/content/documentation/UserExperience/Conceptual/AutolayoutPG/index.html)


---

## 编程管理视图

``` swift
class ViewController: UIViewController {

    override func loadView() {
        super.loadView()
        let myView = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        myView.backgroundColor = UIColor.green
        self.view.addSubview(myView)
    }
   
}
```

```
    override func loadView() {
        super.loadView()
        let myView = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        myView.backgroundColor = UIColor.green
        self.view = myView
    }
```
---

> … If a view controller is owned by a window object, it acts as the window’s root view controller. The view controller’s root view is added as a subview of the window and resized to fill the window. If the view controller is owned by another view controller, then the parent view controller determines when and how the child view controller’s contents are displayed. ..

<small>https://developer.apple.com/library/ios/documentation/UIKit/Reference/UIViewController_Class/index.html</small>
---

## 编写代码管理视图层次

``` swift
    override func loadView() {
        super.loadView()
        let myView = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        myView.backgroundColor = UIColor.green
        let myLabel = UILabel(frame: CGRect(x: 50, y: 50, width: 50, height: 50))
        myLabel.backgroundColor = UIColor.red
        myView.addSubview(myLabel)
        let myButton = UIButton(frame: CGRect(x: 10, y: 10, width: 30, height: 30))
        myButton.backgroundColor = UIColor.white
        myLabel.addSubview(myButton)
        self.view = myView
    }
    
```

---

## 编程实现自定义视图

``` swift
import UIKit

class MyView: UIView {
    override func draw(_ rect: CGRect) {
        if let context = UIGraphicsGetCurrentContext() {
            let myFrame = self.bounds
            context.setLineWidth(10.0)
            myFrame.insetBy(dx: 15, dy: 15)
            UIColor.blue.set()
            UIRectFrame(myFrame)
        }
    }
}
```

---

## 此外

变形、缩放、旋转

<small>https://developer.apple.com/documentation/coregraphics</small>

---

## 旋转


``` swift
    override func loadView() {
        super.loadView()
        let myView = MyView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        myView.backgroundColor = UIColor.green
       
        myView.transform = CGAffineTransform.init(rotationAngle:  CGFloat(Double.pi/4))
        
        self.view.backgroundColor = UIColor.gray
        self.view.addSubview(myView)
    }
    
    
```

---
## 参考

[Quartz 2D Programming Guide](https://developer.apple.com/library/content/documentation/GraphicsImaging/Conceptual/drawingwithquartz2d/Introduction/Introduction.html)



---

## 动画

``` swift
    override func loadView() {
        super.loadView()
        let myView = MyView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        myView.backgroundColor = UIColor.green
       
        UIView.animate(withDuration: 3){
            myView.transform = CGAffineTransform.init(rotationAngle:  CGFloat(Double.pi/4))
        }
        
        self.view.backgroundColor = UIColor.gray
        self.view.addSubview(myView)
    }
    
```

---

## 参考

[Core Animation Programming Guide](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/CoreAnimation_guide/Introduction/Introduction.html)

[Animating SceneKit Content](https://developer.apple.com/documentation/scenekit/animation/animating_scenekit_content)




---

## The End