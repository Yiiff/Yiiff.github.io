---
layout: post
title: iOS - App启动时隐藏StatusBar
date: 2018-03-06 14:30:0.000000000 +09:00
---

> 效果: App 初次启动时, LaunchScree页面不显示`StatusBar`, 待App完全启动后, 在显示出来, 使启动页能提供更好的用户体验

**步骤一**:  

项目`General`中, 勾中`Hide status bar`, 此时App启动后, 在任何界面都看不到`Status Bar`, 包含`LaunchScreen`;

![](media/15203177951264/15203179713063.jpg)


**步骤二**:

App启动后, 会优先进入`didFinishLaunchingWithOptions`函数, 在函数中加入此方法就能达到效果:

**Swift**

```
func application(_application:UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool { 
      /// 这里我们修改App全局外观中状态栏的隐藏状态
    UIApplication.shared.isStatusBarHidden = false
    
    return true 
}
```

**Obj-C**

```
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [UIApplication sharedApplication].statusBarHidden = NO;
    
    return YES;
}
```

