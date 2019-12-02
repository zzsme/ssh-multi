# ssh-multi
一个次管理多个ssh窗口

### 前提

必须安装`tmux`，了解tmux的简单使用方法

```
➜ ~ tmux -V
tmux 2.9a
```

#### 使用方法
```
➜ ~ git clone https://github.com/zzsme/ssh-multi.git
➜ ~ cp ssh-multi.sh /usr/local/bin/ssh-multi
➜ ~ chmod +x /usr/local/bin/ssh-multi
➜ ~ tmux
➜ ~ ssh-multi "host1 host2 host3 host4 host5 host6 host7 host8 ..."
```

![demo1](/img/demo1.png)
