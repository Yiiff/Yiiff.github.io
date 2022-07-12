---
layout: post
title: Cocoa - Button 颜色设置
date: 2017-04-18 10:32:0.000000000 +09:00
---

**重写此方法, 可以修改NSButton的颜色和其他样式:**

```
- (NSRect)drawTitle:(NSAttributedString *)title withFrame:(NSRect)frame inView:(NSView *)controlView
{
    NSSize titleSize =  [title size];
    
    //居中显示
    CGFloat titleY = frame.origin.y + (frame.size.height - titleSize.height)/2;
    NSRect rectTitle = frame;
    
    rectTitle.origin.y = titleY;
    
    NSMutableAttributedString *titleStr =[[NSMutableAttributedString alloc]
                                          initWithAttributedString:title];
    [titleStr addAttribute:NSForegroundColorAttributeName value:CNKIColor(25, 135, 211, 1.0)
                     range:NSMakeRange(0, titleStr.length)];
    [titleStr drawInRect:rectTitle];
    
    return frame;
}
```


