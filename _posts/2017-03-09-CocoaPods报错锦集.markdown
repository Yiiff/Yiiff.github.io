---
layout: post
title: CocoaPods报错锦集
date: 2017-03-09 17:27:18.000000000 +09:00
---
 
 ---
 
 - `no use in any target`
 
 由于Mac重装系统, 导致用了很久的CocoaPods也从头装了一遍, 但装好了之后一直没用, 今天突然要更新一个项目, 发现控制台一直报错:
 
 ```
 The dependency `AFNetworking ` is not used in any concrete target
 ``` 
 
 原来是项目中使用的库没有指定`target`, 导致CocoaPods不知道用在了哪里, 什么时候CocoaPods这么笨了, 鉴于此, 我去[CocoaPods](https://cocoapods.org/)瞅了一眼
 
 官网是这样推荐的:
 
 在创建Podfile的时候, 使用以下两种格式:
 
```
platform :ios, '8.0'

target 'MyApp' do
  	pod 'AFNetworking', '~> 2.6'
  	pod 'ORStackView', '~> 3.0'
  	pod 'SwiftyJSON', '~> 2.3'
end
 
platform :ios, '8.0'

def pods
  	pod 'AFNetworking', '~> 2.6'
  	pod 'ORStackView', '~> 3.0'
  	pod 'SwiftyJSON', '~> 2.3'
end
target 'MyApp' do
  	pods
end
```

---

- `CocoaPods not last version`

更新下CocoaPods即可:

```
sudo gem install cocoapods --pre
```



