---
layout: post
title: Unity Official Tutorials - Input GetAxis
date: 2018-02-20 13:50:0.000000000 +09:00
---

> 返回值类型: Float

### Axis影响因素

1. Gravity(重力)
	- 其值影响`return to 0`的速度，`Gravity`越大，恢复速度越`快`;
2. Sensitivity(灵敏度)
	- 与`Gravity`相反，其值影响`response to 1/-1`的速度，`Sensitivity`越大，响应速度越`快`;
3. Dead(死区)
	- Size of the analog dead zone. All analog device values within this range map to netural.
	- 当我们使用操纵杆🕹️（Joystick）来表示我们的Axis时，我们并不想因为摇杆很小范围的移动来影响我们的Axis，为了避免这种情况，我们可以设定`Dead`，其值越大，`Dead Zone 越大`;
4. Snap
	- Allow to return to 0, if both `positive button` and `negative button` was held;

以水平（Horizontal）为例：

```
/// 返回值是一个 -1 ～ 1闭区间中的某个值
Input.GetAxis("Horizontal");

/// 返回值是 -1、0、1，常用在2D游戏中
Input.GetAxisRow("Horizontal");
```



