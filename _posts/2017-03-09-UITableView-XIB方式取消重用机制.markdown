---
layout: post
title: UITableView - XIB方式取消重用机制
date: 2017-03-09 17:01:18.000000000 +09:00
---

UITableView是iOS中最常见点控件, 对此也有不少使用技巧, 其中重用机制算是经常遇到而且令人头疼点一个问题, 下面点内容为: 使用xib设计Cell时, 如何取消重用机制:


```
// 1. 注册
[self.tableView registerNib:[UINib nibWithNibName:@"AddressTabTableViewCell" bundle:nil] forCellReuseIdentifier:@"AddressTabTableViewCell"];

// 2. 绘制Cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AddressTabTableViewCell *cell = [[[NSBundle mainBundle]loadNibNamed:@"AddressTabTableViewCell"owner:nil options:nil]lastObject];
    
    ...
    
    return cell;
}
```

