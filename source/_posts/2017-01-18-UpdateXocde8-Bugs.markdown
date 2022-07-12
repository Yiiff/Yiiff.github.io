---
layout: post
title: Update Xocde8 Bugs
date: 2017-01-18 09:41:0.000000000 +09:00
---

**1. Undefined symbols for architecture armv7**

`Undefined symbols for architecture armv7:
  "_OBJC_CLASS_$_FYSDKComPlatform", referenced from:
      objc-class-ref in AppDelegate.o
  "_OBJC_CLASS_$_FYSDKInitConfigure", referenced from:
      objc-class-ref in AppDelegate.o
ld: symbol(s) not found for architecture armv7
clang: error: linker command failed with exit code 1 (use -v to see invocation)`

**solve:**

Build Settings -Build Active Architecture Only 中的Debug改为YES

---

**2. ld: library not found for - IQKeyboardManager**
![2015-08-10-CocoaPodsErrorFix](https://github.com/ZX-ZhouXiao/MarkDown-Photos/blob/master/14847036876081/2015-08-10-CocoaPodsErrorFix.png?raw=true)




