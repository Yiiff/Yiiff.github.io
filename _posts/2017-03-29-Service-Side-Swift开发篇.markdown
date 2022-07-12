---
layout: post
title: Service-Side Swift 开发篇
date: 2017-03-29 10:54:0.000000000 +09:00
---

> 已下记录着目前在开发中已经遇到的`bug`和`diff`

- 设置`routes`时对于`badRequest`等异常情况提示信息的返回


```
// Old Way
routes.add(method: .get, uri: "/beers/{num_beers}") { (request, response) in
    guard let  numBeersString = request.urlVariables["num_beers"],
        let numBeersInt = Int(numBeersString) else {
            response.completed(status: .badRequest) // 旧版的completed
            return
    }
    returnJSONMessage(message: "Take one down, pass it around, \(numBeersInt - 1) bottles of beer on the wall...", response: response)
}

// New Way
routes.add(method: .get, uri: "/beers/{num_beers}") { (request, response) in
    guard let  numBeersString = request.urlVariables["num_beers"],
        let numBeersInt = Int(numBeersString) else {
            // 需要先设置status, 再在body中展示
            response.status = .badRequest
            response.setBody(string: "Error handling request \(response.status)")
            response.completed()
            return
    }
    returnJSONMessage(message: "Take one down, pass it around, \(numBeersInt - 1) bottles of beer on the wall...", response: response)
}

```


