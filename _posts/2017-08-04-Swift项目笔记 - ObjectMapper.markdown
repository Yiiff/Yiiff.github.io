---
layout: post
title: Swift项目笔记 - ObjectMapper
date: 2017-08-01 22:57:0.000000000 +09:00
---

> 关于处理请求来的数据模型, 之前写OC的时候, 一直在使用`JSONModel`, 后来朋友推荐`YYKit`下的`YYModel`, 它的效率和上手的效果着实让我神清气爽, 而在Swift的项目中, 我则推荐使用`ObjectMapper`. 下面的文字是对`ObjectMapper`的一些整理和记录, 方便日后回顾.

## ObjectMapper

> ObjectMapper is a framework written in Swift that makes it easy for you to convert your model objects (classes and structs) to and from JSON.

正如[ObjectMapper](https://github.com/Hearst-DD/ObjectMapper)上说的一样, 是一个用Swift编写的一个处理`JSON`与`Model object`转换的库.

- Model to JSON
- JSON to Model
- 嵌套(in Array or in Dictionary)

## 创建模型

### Mappable Protocal

**OM(ObjectMapper)**创建的模型对象, 需要遵循其集成的`Mappable`协议, 并且在模型中实现以下2个方法:


```
init?(map: Map)
mutating func mapping(map: Map)
```

实例:

```
import UIKit
import ObjectMapper

class CommonResult: Mappable {
    var statusMsg:  String?
    var statusCode: Int?
    // ...
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        statusMsg  <- map["statusMsg"]
        statusCode <- map["statusCode"]
    }
}
```

### 多层嵌套模型的实现

**OM**支持`class` 和 `struct`两种方式创建的JSON模型

注意: 

1. 嵌套的`Model`也是需要继承`Mappable`协议并实现相关方法的;
2. 在 `mapping:`方法中, 在指向某个字段的同时, 可以实现特殊字符的映射, 如`GoodsListDetail.goods_id`这个字段, 其`mapping:`中将原本后台给的`id`字段的内容直接映射到自定义的`goods_id`上

实例:

```
import UIKit
import ObjectMapper

struct GoodsListDetail: Mappable {
    var goods_id:        String?
    var goods_commonid:  String?
    var store_id:        String?
    var store_name:      String?
    var goods_name:      String?
    var goods_price:     String?
    var goods_image:     String?
    // ...
    
    init?(map: Map) {
    }
    mutating func mapping(map: Map) {
        goods_id        <- map["id"]
        goods_commonid  <- map["goods_commonid"]
        store_id        <- map["store_id"]
        goods_name      <- map["goods_name"]
        goods_price     <- map["goods_price"]
        goods_image     <- map["goods_image"]
        // ...
    }
}

struct Result: Mappable {
    var goods_list:  [GoodsListDetail]?
    var hasmore:     Bool?
    var page_total:  Int?
    
    init?(map: Map) {
    }
    mutating func mapping(map: Map) {
        goods_list  <- map["goods_list"]
        hasmore     <- map["hasmore"]
        page_total  <- map["page_total"]
    }
}

class GoodsListModel: Mappable {
    var result:     Result?
    var statusMsg:  String?
    var statusCode: Int?
    
    required init?(map: Map) {
    }
    func mapping(map: Map) {
        result     <- map["result"]
        statusMsg  <- map["statusMsg"]
        statusCode <- map["statusCode"]
    }
}
```


## 创建模型对象


通过网络请求获取到的json串可以创建出模型对象

```
let user = User(JSONString: JSONString)
```

实例:

这里我们采用了 `Moya + ObjectMapper + SwiftyJSON`

SwiftyJSON也能做模型转换用, 不过就个人实际使用的效果来说, OM更好, 因此`SwiftyJSON`用来处理请求来的json了.

```
func getFiltedData(paramaters: Dictionary<String, String>) {
        ServiceProvider.request(Service.filtingList(paramaters)) { (result) in
            if case let .success(response) = result {
                let json = JSON(data: response.data)
                let responModel = CommonResult(JSONString: String(describing: json))
                if responModel?.statusCode == 200 {
                    HUD.flash(.success)
                    // ...
                } else {
                    HUD.flash(.label("\(String(describing: responModel?.statusMsg))"), onView: self.view, delay: 1.0, completion: nil)
                }
                
            } else {
                HUD.flash(.label("筛选失败"), onView: self.view, delay: 1.0, completion: nil)
            }
        }
    }
```



