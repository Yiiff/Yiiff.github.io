---
layout: post
title: Unity Official Tutorials - Input GetButton and GetKey 
date: 2018-02-06 13:35:0.000000000 +09:00
---

> 这里以**Keyboard**为例任意一个, 键盘上任意一个按键按下, 会有几种不同的状态, 通过判断这些状态, 就能拿到准确的按键状态.

## U3D提供了2套`API`供我们判断按键的状态:

### GetButton/Down/Up

```
bool down = Input.GetButtonDown("Jump");

bool held = Input.GetButton("Jump");

bool up = Input.GetButtonUp("Jump");

```

### GetKey/Down/Up

```
bool down = Input.GetKeyDown(KeyCode.Space);

bool held = Input.GetKey(KeyCode.Space);

bool up = Input.GetKeyUp(KeyCode.Space);
```


**状态分析:**

1. 弹起状态
	- GetKeyDown: **False**
	- GetKey: **False**
	- GetKeyUp : **False**
2. 按下瞬间
	- GetKeyDown: **True**
	- GetKey: **True**
	- GetKeyUp : **False**
3. 按住未弹起
	- GetKeyDown: **False**
	- GetKey: **True**
	- GetKeyUp : **False**
4. 弹起瞬间
	- GetKeyDown: **False**
	- GetKey: **False**
	- GetKeyUp : **True**