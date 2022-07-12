---
layout: post
title: 由WKWebView引发的64与128的y axis问题
date: 2017-03-17 09:34:18.000000000 +09:00
---

> iOS7之前控制器的self.view的Y的0点是在Navgationbar的底部开始的. iOS7之后,苹果推行全屏布局控制器的self.view的Y的0点是屏幕顶部.

先贴Bug:

- 如果你的self.view的第一个视图是scrollView类视图. eg: 如果你把一个tableView的Y 约束设置为距离self.view.Y 为64.看起来很和谐,刚好是navgationbar 44 + 状态栏20 = 64 的距离.在storyboard上看上去一切没有问题. 当你跑起来发现tableview的里面的cell Y值多了64

![](https://github.com/ZX-ZhouXiao/MarkDown-Photos/blob/master/14905770942961/14905778451325.png?raw=true)


**代码如下:**

```
- (WKWebView *)wkWebView{
    if (!_wkWebView) {
        //设置网页的配置文件
        WKWebViewConfiguration * Configuration = [[WKWebViewConfiguration alloc]init];
        //允许视频播放
        Configuration.allowsAirPlayForMediaPlayback = YES;
        // 允许在线播放
        Configuration.allowsInlineMediaPlayback = YES;
        // 允许可以与网页交互，选择视图
        Configuration.selectionGranularity = YES;
        // web内容处理池
        Configuration.processPool = [[WKProcessPool alloc] init];
        //自定义配置,一般用于 js调用oc方法(OC拦截URL中的数据做自定义操作)
        WKUserContentController * UserContentController = [[WKUserContentController alloc]init];
        // 添加消息处理，注意：self指代的对象需要遵守WKScriptMessageHandler协议，结束时需要移除
        [UserContentController addScriptMessageHandler:self name:@"WXPay"];
        // 是否支持记忆读取
        Configuration.suppressesIncrementalRendering = YES;
        // 允许用户更改网页的设置
        Configuration.userContentController = UserContentController;
        _wkWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64) configuration:Configuration];
        _wkWebView.backgroundColor = [UIColor colorWithRed:240.0/255 green:240.0/255 blue:240.0/255 alpha:1.0];
        // 设置代理
        _wkWebView.navigationDelegate = self;
        _wkWebView.UIDelegate = self;
        //kvo 添加进度监控
        [_wkWebView addObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress)) options:0 context:WkwebBrowserContext];
        //开启手势触摸
        _wkWebView.allowsBackForwardNavigationGestures = NO;
        // 设置 可以前进 和 后退
        //适应你设定的尺寸
        [_wkWebView sizeToFit];
    }
    return _wkWebView;
}
```

这种情况导致整个页面展示起来会很别扭, 我遇到的情况是WKWebView所展示的界面无法显示全. 而且WKScrollView的`contentSize`也乱七八糟,整个页面在滑动中显得非常的古怪.

---

**原因:**

- 因为iOS7之后多了一个新特性(automaticallyAdjustsScrollViewInsets),当控制器的self.view的第一个视图是scroview类视图时. 会自动调整scrollView视图里面的子视图的的Y值往下移64点.也就是说tableview的Y值还是屏幕的顶部0点,而cell自动下调了64.想想是不是很贴心.怕你的cell的内容被navgationbar挡住了.fuck 加上之前设置的距离 64加上自动调整的64 就成了 128.
经测试storyboard设置y的约束为距离 top layout guide.bottom为0 也一样会造成上图的效果.

**解决办法如下:**

- `automaticallyAdjustsScrollViewInsets` 设为 `NO`

```
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.automaticallyAdjustsScrollViewInsets = NO;
    // ...
}
```

- 在 `storyboard` 取消

- 设置tableView.Y 距离self.view.Y 为0


---

Debug 中发现的另一个bug, [神奇的传送门.](http://www.jianshu.com/p/250938b540cc)

