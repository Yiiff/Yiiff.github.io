---
layout: post
title: Service-Side Swift
date: 2017-03-29 10:44:0.000000000 +09:00
---

> 随着`Swift 3.0`的发布, 用Swift开发Service成为了可能, 其中`Percect.org`提供了一套较为完善的解决方案

目标如下

- 如何创建和运行一个HTTP/HTTPS服务器，将Perfect运转起来
- 安装运行Perfect之前，无论是OS X还是Ubuntu Linux系统都需要安装的必要软件
- 如何为Swift项目编译、测试和管理依存关系
- 如何将Perfect部署到其它环境中，比如Heroku、Amazon Web Services、Docker、Microsoft Azure、Google Cloud、IBM Bluemix CloudFoundry，以及IBM Bluemix Docker


### Build by Perfect Assistant

**main.swift 的代码如下:**


```
import PerfectLib
import PerfectHTTP
import PerfectHTTPServer

let service = HTTPServer()
service.serverPort = 8080;

var routes = Routes()

routes.add(method: .get, uri: "/") { (request, responese) in
    responese.setBody(string: "Hello World!")
    .completed()
}

service.addRoutes(routes)

do {
    try service.start()
} catch PerfectError.networkError(let err, let msg) {
    print("Network error throw: \(err) \(msg)")
}
```

