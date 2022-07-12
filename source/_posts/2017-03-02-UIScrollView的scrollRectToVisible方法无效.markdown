---
layout: post
title: UIScrollView的scrollRectToVisible方法无效
date: 2017-03-02 10:13:0.000000000 +09:00
---

因为之前做UIScrollView翻页是喜欢讲contentSize的height设为0，所以今天碰到了使用scrollRectToVisible无效的问题。所以以后在使用scrollRectToVisible函数前需要注意这一情况。

并且在设置好`contentSize`之后, 初次进入界面是`x axis`会有迷之`39px`的左偏移;

解决办法:


```
self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * self.dataSource.count, self.scrollView.bounds.size.height);

self.scrollView.contentOffset = CGPointMake(0, 0);

// or
// [self.scrollView scrollRectToVisible:CGRectMake(0, 0, SCREEN_WIDTH, self.scrollView.bounds.size.height) animated:YES];

```



