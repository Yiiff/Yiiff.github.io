---
layout: post
title: Cocoa - NSView backgroundcolor
date: 2017-04-11 11:47:0.000000000 +09:00
---

> 学习过`iOS`开发的同学对于如何设置一个控件的`backgroundColor`是在熟悉不过的了, 但是相对于`macOS`开发中, `NSView`的属性中并没有发现`color`相关的属性, 那么如何设置呢?

- macOS中, 将 `NSView` 的 `backgroundColor` 放到了 `layer` 中:


```
@IBOutlet var dragcontentView: NSView!

self.dragcontentView.layer?.backgroundColor = NSColor.clear.cgColor;
```

**B&R**后发现并没有改变颜色, 因为我们未设置时候允许`NSView`的`wantsLayer`属性:


```
@IBOutlet var dragcontentView: NSView!

self.dragcontentView.wantsLayer = true;

self.dragcontentView.layer?.backgroundColor = NSColor.clear.cgColor;
```

**搞定!**


