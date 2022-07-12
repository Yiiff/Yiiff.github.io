---
layout: post
title: iOS NavagationBar Shadow
date: 2017-05-08 21:56:18.000000000 +09:00
---

> 突然发现最近好些App的导航栏开始有一种Android的风格, 在导航栏的底部加阴影, 不得不承认, 这种确实很漂亮, 其实真的是有点孤陋寡闻了(⊙o⊙)

**效果如下:**

![效果如下](https://github.com/ZX-ZhouXiao/MarkDown-Photos/blob/master/14942352743898/14942358299854.png?raw=true)


```
self.navigationController.navigationBar.layer.masksToBounds = NO;

self.navigationController.navigationBar.layer.shadowOffset = CGSizeMake(0, 2);

self.navigationController.navigationBar.layer.shadowOpacity = 0.3;

self.navigationController.navigationBar.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.navigationController.navigationBar.bounds].CGPath;
```


