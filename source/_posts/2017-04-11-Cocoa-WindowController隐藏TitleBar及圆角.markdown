---
layout: post
title: WindowController 隐藏TitleBar及圆角
date: 2017-04-11 15:32:0.000000000 +09:00
---

> 初次接触`macOS`开发, 简单的搭了个界面, 发现`window`顶部有个`titleBar`, 觉得启动页不需要显示这行, 由此就有了这篇, 本文中使用`Swift3.0`作为编程语言.


从图上可以看得到, 顶部有一个titleBar, 并且四角是圆角

![](https://github.com/ZX-ZhouXiao/MarkDown-Photos/blob/master/14918925449616/14918936346650.jpg?raw=true)

而选中`window`时, 在右边我看到了这个`checkbox`:

![](https://github.com/ZX-ZhouXiao/MarkDown-Photos/blob/master/14918925449616/14918938123780.jpg?raw=true)

既然要隐藏, 肯定勾掉这个选项, 但是结果让我有点诧异, 不能移动窗口, 四角的圆角也没有了...

![](https://github.com/ZX-ZhouXiao/MarkDown-Photos/blob/master/14918925449616/14918939008425.jpg?raw=true)

这不是我想要的效果, 但是还有别的办法:

**Swift**

- 新建一个`WelcomeWindowController`, 继承自`NSWindowController`, 然后写入一下代码:

```
self.window?.titleVisibility = .hidden

self.window?.titlebarAppearsTransparent = true
        
self.window?.styleMask.insert(.fullSizeContentView)
```

**OC**


```

// 在AppDelegate.m中加入一下代码:
self.window.titleVisibility = NSWindowTitleHidden;

self.window.titlebarAppearsTransparent = YES;

self.window.styleMask = self.window.styleMask | NSWindowStyleMaskFullSizeContentView;
```

**效果如下:**

点击顶部可拖动哦!

![](https://github.com/ZX-ZhouXiao/MarkDown-Photos/blob/master/14918925449616/14918957091192.jpg?raw=true)


### 其实, 一开始的那种隐藏方法, 还是可以通过代码实现自定义的titleBar, 来满足既隐藏又圆角

**OC**

```
self.window.contentView.wantsLayer = YES;

self.window.contentView.layer.frame = 

self.window.contentView.frame;

self.window.contentView.layer.masksToBounds = YES;

self.window.contentView.layer.cornerRadius = 30.0;

self.window.backgroundColor = [NSColor clearColor];

self.window.contentView.layer.backgroundColor = [NSColor whiteColor].CGColor;
```


