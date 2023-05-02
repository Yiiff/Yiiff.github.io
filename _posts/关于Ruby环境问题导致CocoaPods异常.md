---
title: 关于Ruby环境问题导致CocoaPods异常
date: 2022-07-13 15:05:53
tags:
  - iOS
  - CocoaPods
---

## 问题描述

原因：brew导致mac下ruby环境错了，无法正常识别可用的版本。

```shell
$ pod install
/Library/Ruby/Site/2.6.0/rubygems.rb:281:in `find_spec_for_exe': can't find gem cocoapods (>= 0.a) with executable pod (Gem::GemNotFoundException)
	from /Library/Ruby/Site/2.6.0/rubygems.rb:300:in `activate_bin_path'
	from /usr/local/bin/pod:23:in `<main>'
```

## 解决

列出所有安装的`ruby`版本，运行结果可以看到有2个版本，我的目标是升级到`3.1.2`，当前为`2.3.1`, 因此先删除`2.3.8`版本的。

```shell
$ rvm list

=* ruby-2.3.1 [ x86_64 ]
   ruby-2.3.8 [ x86_64 ]

# => - current
# =* - current && default
#  * - default
```

因为没有特别的需求，所以我将本地的2个`ruby`删了，准备重新安装最新版本的`ruby`，命令如下：

```shell
$ rvm remove ruby-2.3.8
```

安装`3.1.2`版本

```shell
$ rvm install 3.1.2
Searching for binary rubies, this might take some time.
No binary rubies available for: osx/12.0/x86_64/ruby-3.1.2.
Continuing with compilation. Please read 'rvm help mount' to get more information on binary rubies.
Checking requirements for osx.
Certificates bundle '/usr/local/etc/openssl@1.1/cert.pem' is already up to date.
Requirements installation successful.
Installing Ruby from source to: /Users/xx/.rvm/rubies/ruby-3.1.2, this may take a while depending on your cpu(s)...
ruby-3.1.2 - #downloading ruby-3.1.2, this may take a while depending on your connection...
** Resuming transfer from byte position 16965632
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100 3503k  100 3503k    0     0  3608k      0 --:--:-- --:--:-- --:--:-- 3630k
No checksum for downloaded archive, recording checksum in user configuration.
ruby-3.1.2 - #extracting ruby-3.1.2 to /Users/xx/.rvm/src/ruby-3.1.2 - please wait
ruby-3.1.2 - #configuring - please wait
ruby-3.1.2 - #post-configuration - please wait
ruby-3.1.2 - #compiling - please wait
ruby-3.1.2 - #installing - please wait
ruby-3.1.2 - #making binaries executable - please wait
Installed rubygems 3.3.7 is newer than 3.0.9 provided with installed ruby, skipping installation, use --force to force installation.
ruby-3.1.2 - #gemset created /Users/xx/.rvm/gems/ruby-3.1.2@global
ruby-3.1.2 - #importing gemset /Users/xx/.rvm/gemsets/global.gems - please wait
ruby-3.1.2 - #generating global wrappers - please wait
ruby-3.1.2 - #gemset created /Users/xx/.rvm/gems/ruby-3.1.2
ruby-3.1.2 - #importing gemsetfile /Users/xx/.rvm/gemsets/default.gems evaluated to empty gem list
ruby-3.1.2 - #generating default wrappers - please wait
ruby-3.1.2 - #adjusting #shebangs for (gem irb erb ri rdoc testrb rake).
Install of ruby-3.1.2 - #complete
```

查看安装结果

```shell
$ rvm list                                                                                                      
   ruby-2.3.1 [ x86_64 ]
=* ruby-3.1.2 [ x86_64 ]

# => - current
# =* - current && default
#  * - default
```

移除`2.3.1`

```shell
$ rvm remove ruby-2.3.1

ruby-2.3.1 - #removing rubies/ruby-2.3.1 - please wait
ruby-2.3.1 - #removing gems - please wait
Using /Users/xx/.rvm/gems/ruby-3.1.2
```

最终结果如下

```shell
$ rvm list

=* ruby-3.1.2 [ x86_64 ]

# => - current
# =* - current && default
#  * - default
```

## 重新安装CocoaPods

重新安装

```shell
$ gem install cocoapods

...

Done installing documentation for nanaimo, colored2, claide, CFPropertyList, atomos, xcodeproj, ruby-macho, nap, molinillo, gh_inspector, fourflusher, escape, cocoapods-try, netrc, cocoapods-trunk, cocoapods-search, cocoapods-plugins, cocoapods-downloader, cocoapods-deintegrate, ffi, ethon, typhoeus, public_suffix, fuzzy_match, concurrent-ruby, httpclient, algoliasearch, addressable, zeitwerk, tzinfo, i18n, activesupport, cocoapods-core, cocoapods after 19 seconds
34 gems installed
```

## 安装依赖

修复了Ruby和CocoaPods，可以继续安装Xcode依赖的了。

