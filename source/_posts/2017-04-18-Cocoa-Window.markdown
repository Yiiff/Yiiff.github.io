---
layout: post
title: Cocoa - Window
date: 2017-04-18 16:34:0.000000000 +09:00
---


> 2种创建 **模态窗口**:

**Way1: Modal window**

```
// 创建
[[NSApplication sharedApplication] runModalForWindow:self.myWindow];

// 关闭
[[NSApplication sharedApplication] stopModal];
```

**注意:**
如果用户没有点击**model**出来窗口的**关闭按钮**, 整个应用仍然处于模态，任何操作都无法得到响应。正确的做法是监听窗口关闭事件，增加结束模态的方法调用。


```
[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(windowWillClose:) name:NSWindowWillCloseNotification object:nil];

- (void)windowWillClose:(NSNotification *)notification {  
    [[NSApplication sharedApplication]stopModal];
}
```

**Way2: Modal sessions**

**Modal sessions**方式创建的**window**稍微温和一些，允许响应快捷键和系统菜单，比如字体颜色选择这些**panel**面板.


```
// 创建
NSModalSession sessionCode = [[NSApplication sharedApplication] beginModalSessionForWindow:window];

// 关闭
// 结束 Modal sessions 窗口，使用 sessionCode 做为参数来关闭 Modal sessions窗口
- (void)windowWillClose:(NSNotification *)notification {  
    if (sessionCode != 0) {
        [[NSApplication sharedApplication] endModalSession:sessionCode];
    }
}
```

### 总结:

1. 任何窗口的关闭要么通过点击左上角的系统关闭按钮，要么通过代码执行 window的 close方法关闭。
2. 对于任何一种模态窗口，关闭后还必须额外调用结束模态的方法去结束状态。如果点击了 window 左上角的关闭按钮，而没有执行结束模态的方法，整个系统仍然处于模态，其他窗口无法正常工作。``

