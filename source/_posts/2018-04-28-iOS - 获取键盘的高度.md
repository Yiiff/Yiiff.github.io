---
layout: post

title: iOS - 获取键盘的高度

date: 2018-04-28 21:56:00
---

> 应用场景：处理输入的时候，需要提供自定义工具条或者类似邮箱地址后缀提示条，要求浮在键盘的上方。

**解决办法：**

1. 注册键盘弹出的通知
2. 键盘弹出后，计算键盘在当前设备的高度
3. 拿到高度值后，处理自定义视图的位置

```objective-c
/// 注册键盘弹出的通知
- (void)registerForKeyboardNotifications {
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
}

/// 计算高度
- (void)keyboardWasShown:(NSNotification*)aNotification {
    NSDictionary* info = [aNotification userInfo];
    CGSize *size = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;//
    NSLog(@"hight:%f",size.height);
}

/// 移除通知中心
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
```

