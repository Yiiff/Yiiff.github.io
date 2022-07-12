---
layout: post
title: iOS - TableView 重用机制
date: 2017-04-13 10:14:0.000000000 +09:00
---

> 重新复习下这个点

这种机制下系统默认有一个可变数组`NSMutableArray*  visiableCells`,用来保存当前显示的`cell`.一个可变字典`NSMutableDictnery* reusableTableCells`,用来保存可重复利用的`cell`.(之所以用字典是因为可重用的`cell`有不止一种样式,我们需要根据它的`reuseIdentifier`,也就是所谓的重用标示符来查找是否有可重用的该样式的`cell`).
重用的写法如下:

```
// 设置单元格  indexPath :单元格当前所在位置 -- 哪个分区哪一行等
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath //UITableViewDataSource
{
    static NSString *identifier = @"cell" ;
    //相当于从集合中找寻完全出屏幕的单元格.
    // identifier : 因为一个表视图中可能存在多种样式的单元格,咱们把相同样式的单元格放到同一个集合里面,为这个集合加标示符,当我们需要用到某种样式的单元格的时候,根据不同的标示符,从不同的集合中找寻单元格.
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier] ;
    // 如果从集合中未找到单元格,也就是集合中还没有单元格,也就是还没有单元格出屏幕,那么我们就需要创建单元格
    if (!cell)
    {
        // 创建cell的时候需要标示符(Identifier)是因为,当该cell出屏幕的时候需要根据标示符放到对应的集合中.
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"] ;
    return cell ;
}
```

系统第一次执行`- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath`这个方法的时候, `reusableTableCells`为空,`[tableView dequeueReusableCellWithIdentifier:identifier]`的返回值为nil,我们需要通过`[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier: identifier]`方式来创建.

当我们的数据过多,整个屏幕的`cell`显示不完全时,这个方法的执行情况是 :

1. 先执行`[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier: identifier]`创建整个屏幕能显示的`cell`数**+1**的`cell`(当我们拖动`UITableView`的时候,第一个`cell`没有移出屏幕,最下面的`cell`就已经存在),并指定相同或者不同的标示符`identifier`.把创建出的屏幕能显示的cell全部都加入到`visiableCells`数组中(最后一个创建的先不加入数组)，`reusableTableCells`为空.

2. 当我们拖动屏幕时,顶端的`cell`移出屏幕并加入到`reusableTableCells`字典中,键为`identifier` ,并把之前已经创建的但是没有加入到`visiableCells`的`cell`加入到`visiableCells`数组中.

3. 当我们接着拖动的时候,因为`reusableTableCells`中已经有值，所以，当需要显示新的`cell`，`cellForRowAtIndexPath`再次被调用，执行`[tableView dequeueReusableCellWithIdentifier: identifier]`，返回一个标示符为`identifier`的`cell`。该`cell`移出`reusableTableCells`之后加入到`visiableCells`；顶端的`cell`移出`visiableCells`并加入到`reusableTableCells`.如果`visiableCells`数组中没有找到`identifier`类型的`cell`,则再次重新`alloc`一个.

**在iOS6之后系统加入了一种单元格注册的方法**

```
[self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier: identifier] ;
```

这个方法的作用是,当我们从重用队列中取cell的时候,如果没有,系统会帮我们创建我们给定类型的cell,如果有,则直接重用. 这种方式cell的样式为系统默认样式.

在设置cell的方法中只需要:

```
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 重用队列中取单元格 由于上面已经注册过单元格,系统会帮我们做判断,不用再次手动判断单元格是否存在
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: identifier forIndexPath:indexPath] ;
    return cell ;
}
```

