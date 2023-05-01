---
title: ':memo: [WEB REQUESTS] HyperText Transfer Protocol (HTTP)-1680980212'
date: 2023-04-09 02:56:53
tags: BugBounty
---

HyperText Transfer Protocol (HTTP) 是一种用于在Web上传输数据的协议。它是Web应用程序通信的基础，支持客户端与服务器之间的数据传输。在本课中，您将学习HTTP协议的基本概念和实现，以及如何使用Python库发出HTTP请求并分析响应。

以下是一些课程中的关键概念和代码示例，以帮助您更好地理解HTTP协议和Python库的使用：

### HTTP协议的主要特点：

- 基于请求/响应模型。
- 使用URI来指定资源。
- 使用方法（例如GET，POST，PUT等）来定义操作类型。
- 使用状态码来表示响应状态。
- 可以使用标头来传输元数据。

### Python库的使用：

Python中有几个库可以用来发出HTTP请求并处理响应。以下是其中两个库的代码示例：

#### 1. 使用Requests库发出HTTP请求：

```python
import requests

response = requests.get('https://www.example.com')
print(response.status_code)
print(response.content)
```

#### 2. 使用urllib库发出HTTP请求：

```python
import urllib.request

response = urllib.request.urlopen('https://www.example.com')
print(response.status)
print(response.read())
```

在Python中，您可以使用requests或urllib库发出HTTP请求，并使用响应对象的方法和属性来处理响应数据。

### HTTP请求和响应的主要组成部分：

- 请求：请求行，请求头，消息体。
- 响应：状态行，响应头，消息体。

![url_structure](https://p.ipic.vip/ds0c00.png)

| **Component**  | **Example**          | **Description**                                              |
| -------------- | -------------------- | ------------------------------------------------------------ |
| `Scheme`       | `http://` `https://` | This is used to identify the protocol being accessed by the client, and ends with a colon and a double slash (`://`) |
| `User Info`    | `admin:password@`    | This is an optional component that contains the credentials (separated by a colon `:`) used to authenticate to the host, and is separated from the host with an at sign (`@`) |
| `Host`         | `inlanefreight.com`  | The host signifies the resource location. This can be a hostname or an IP address |
| `Port`         | `:80`                | The `Port` is separated from the `Host` by a colon (`:`). If no port is specified, `http` schemes default to port `80` and `https` default to port `443` |
| `Path`         | `/dashboard.php`     | This points to the resource being accessed, which can be a file or a folder. If there is no path specified, the server returns the default index (e.g. `index.html`). |
| `Query String` | `?login=true`        | The query string starts with a question mark (`?`), and consists of a parameter (e.g. `login`) and a value (e.g. `true`). Multiple parameters can be separated by an ampersand (`&`). |
| `Fragments`    | `#status`            | Fragments are processed by the browsers on the client-side to locate sections within the primary resource (e.g. a header or section on the page). |

并非所有组件都需要用来访问资源。其中最主要的强制性字段是方案（scheme）和主机（host），没有这两个字段，请求将没有资源可供请求。

