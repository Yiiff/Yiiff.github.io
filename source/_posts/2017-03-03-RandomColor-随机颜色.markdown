---
layout: post
title: Random Color - 随机颜色
date: 2017-03-03 10:27:0.000000000 +09:00
---

```
CGFloat red = (CGFloat)random()/(CGFloat)RAND_MAX;
CGFloat green = (CGFloat)random()/(CGFloat)RAND_MAX;
CGFloat blue = (CGFloat)random()/(CGFloat)RAND_MAX;

UIView *view = [[UIView alloc] init];
view.frame = CGRectMake(10, 10, 100, 100);
view.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:0.8];
```

