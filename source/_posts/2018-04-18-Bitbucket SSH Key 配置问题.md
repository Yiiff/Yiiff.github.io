---
layout: post
title: Bitbucket SSH Key 配置问题
date: 2018-04-18 14:37:0.000000000 +09:00
---

> Bitbucket的私有库用起来还是很舒坦的. 但是最近遇到一个很奇怪的问题, 虽然解决了, 但是还是觉得记上一笔.

#### 情景如下: 

1. git fetch 之后, 执行了pull操作, merge仓库的代码到本地
2. 一番修改之后, 执行push操作, 然而失败了

![image-20180418142130429](https://github.com/ZX-ZhouXiao/MarkDown-Photos/blob/master/image-20180418142130429.png?raw=true)

这就很迷了, 明明配过ssh key, why??



经过不懈的努力(Google Search), 了解到Bitbucket有2个地方可以添加ssh key:

1. Repository Settings: deployment key
2. Manage Account: account key

说白了一个是给库配置, 另一个是给账号配置.

而我push失败的原因就是将我的ssh key配置到了库上, 生成了deployment key, 但账号地下却没有配置. deployment key 是 read-only. 因此通过ssh push的时候被拒绝了, 必须配置 account key.



#### 解决办法:

删除deployment key, 再将ssh key添加到account key中.

如果在添加account key的时候, 提示:

```objective-c
Someone has already registered this as an deployment SSH key.
```

你可以在shell中输入`ssh -T git@bitbucket.org`, 就能看到哪些库设置了deployment key, 之后去库中删除即可.