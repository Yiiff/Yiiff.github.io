---
layout: post
title: CocoaPods安装
date: 2017-03-09 17:29:44.000000000 +09:00
---

> 电脑突然瞎了, 被逼无奈, 重装了系统, CocoaPods也没了, 记得上次安装还是在15年初, 但是稀里糊涂的, 索性这次就写点什么


当你开发iOS应用时，会经常使用到很多第三方开源类库，比如JSONKit，AFNetWorking等等。可能某个类库又用到其他类库，所以要使用它，必须得另外下载其他类库，而其他类库又用到其他类库，“子子孙孙无穷尽也”，这也许是比较特殊的情况。总之小编的意思就是，手动一个个去下载所需类库十分麻烦。另外一种常见情况是，你项目中用到的类库有更新，你必须得重新下载新版本，重新加入到项目中，十分麻烦。如果能有什么工具能解决这些恼人的问题，那将“善莫大焉”。所以，你需要 CocoaPods。 

CocoaPods应该是iOS最常用最有名的类库管理工具了，上述两个烦人的问题，通过cocoaPods，只需要一行命令就可以完全解决，当然前提是你必须正确设置它。重要的是，绝大部分有名的开源类库，都支持CocoaPods。所以，作为iOS程序员的我们，掌握CocoaPods的使用是必不可少的基本技能了。


## Step 1 : RVM

**确认当前 Mac 的`Ruby` 版本** 

```
$ ruby -v

ruby 1.8.7
```

针对于CocoaPods, Ruby的版本最好大于 2.2.0, 因此, 若发现当前系统的Ruby版本号低于CocoaPods所需求的最低版本号, 就需要我们升级Ruby, 所以, 我们需要安装 `RVM`(Ruby Version Manager), `Ruby`版本管理器, 包括`Ruby`的版本管理和`Gem`库管理(gemset).

**1. 安装 RVM**

```
$ curl -L get.rvm.io | bash -s stable
```
等待一段时间后就可以成功安装好 RVM

```
$ source ~/.bashrc
$ source ~/.bash_profile
```

测试是否安装正常

```
rvm -v
```

若能显示出当前 rvm 版本号, 则表示安装成功.

**2. 升级Ruby**

查看当前Ruby版本

```
$ ruby -v
ruby 1.8.7
```

列出已知的Ruby版本

```
$ rvm list known
```

安装 Ruby 2.3.0

```
$ rvm install 2.3.0
```

安装成功之后通过 `ruby -v` 查看是否安装成功.

## Step 2 : CocoaPods

**1. 安装CocoaPods**

```
$ sudo gem install cocoapods
```

虽然命令就这么一条, 但是在我大天朝, 速度堪比乌龟, 因此, 我们需要做一些处理:换源

**2. 换源**

```
$ gem sources --remove https://rubygems.org/

//等有反应之后再敲入以下命令
$ gem sources -a http://ruby.taobao.org/
```

为了验证你的Ruby镜像是并且仅是taobao，可以用以下命令查看：

```
$ gem sources -l
```
只有在终端中出现下面文字才表明你上面的命令是成功的：

```
*** CURRENT SOURCES ***

http://ruby.taobao.org/
```

换过源之后, **再次执行安装命令**

等上十几秒钟，CocoaPods就可以在你本地下载并且安装好了，不再需要其他设置.

---

## How to use Cocoapods ?

这里已 `AFNetworking` 为例

AFNetworking类库在GitHub地址是：<https://github.com/AFNetworking/AFNetworking>

### Way 1 : CocoaPods 插件, 需要配置GEM_PATH

若通过插件来使用 CocoaPods 安装时报出一下错误:

```
env: ruby_executable_hooks: No such file or directory
```

可以推断出是cocopods插件的GEM_PATH路径写错了，通过查资料发现
在终端输入命令：

```
$ gem env

- /Users/user/.rvm/gems/ruby-2.2.4/bin
 - /Users/user/.rvm/gems/ruby-2.2.4@global/bin
 - /Users/user/.rvm/rubies/ruby-2.2.4/bin
 - /usr/bin
 - /bin
 - /usr/sbin
 - /sbin
 - /usr/local/bin
 - /Users/user/.rvm/bin
 
```

将其路径设置为：

```
/Users/user/.rvm/rubies/ruby-2.2.4/bin
```
如果上面方案仍没有解决问题，那么将GEM_PATH里写入 /usr/local/bin 执行cocoapods安装命令:

```
 $ sudo gem install -n /usr/local/bin cocoa pods
```

附查看安装清单命令，可查看已安装应用及插件：

```
$ gem list
```

**1. 新建 Podfile 文件**

**2. 在 Podfile 中写入需要导入的框架**

**3. 在插件中选择 install **


### Way 2 : VIM
为了确定AFNetworking是否支持CocoaPods，可以用CocoaPods的搜索功能验证一下。在终端中输入

```
$ pod search AFNetworking
```

利用vim创建Podfile，运行:

```
$ vim Podfile
```

然后在Podfile文件中输入以下文字：

```
platform :ios, '9.0'
        pod "AFNetworking", "~> 3.1"
```

以上内容可以在AFNetworking的github页面找到。这两句文字的意思是，当前AFNetworking支持的iOS最高版本是iOS 7.0, 要下载的AFNetworking版本是2.0.

保存退出。vim环境下，保存退出命令是：

```
:wq
```

这时候，你会发现你的项目目录中，出现一个名字为Podfile的文件，而且文件内容就是你刚刚输入的内容。注意，Podfile文件应该和你的工程文件.xcodeproj在同一个目录下。

这时候，你就可以利用CocoPods下载AFNetworking类库了。还是在终端中的当前项目目录下，运行以下命令：

```
$ pod install
```

因为是在你的项目中导入AFNetworking，这就是为什么这个命令需要你进入你的项目所在目录中运行。

运行上述命令之后，小编的终端出现以下信息：

```
Nul'sMacBook-Pro:CocoaPodsDemo ericwang$ pod install
        Analyzing dependencies
        Downloading dependencies
        Installing AFNetworking (3.0)
        Generating Pods project
        Integrating client project

        [!] From now on use `CocoaPodsDemo.xcworkspace`.
```

就此, AFNetwoking已经成功导入项目了.



