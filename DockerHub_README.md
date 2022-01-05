# plumemo_pre

plumemo博客容器镜像（半成品）

【置顶】本项目不受 Apache Log4j2 远程代码执行漏洞影响，详见：https://github.com/byteblogs168/plumemo/issues/18

> 说是半成品的原因是需要手动执行一键部署脚本的命令，如果您能够完善这个镜像，欢迎您前往本项目的 [GitHub](https://github.com/luckykeeper/docker_plumemo) 页面提交 PR ，非常感谢！

## 镜像内容

- sshd 服务，使用 22 标准端口
- 未安装的 nginx 服务，已预留 80 和 443 端口用于 http 与 https
- 预留了 3306 端口用于连接外部 mysql 服务器
- plumemo 一键安装脚本，来自[ plumemo 官方](https://github.com/byteblogs168/plumemo-deploy)
- plumemo 一键安装脚本所需要的部分软件包（ nginx 、 theme-react-sakura 主题、管理系统（版本 1.2.0 ）； jdk 和 mysql 没有内置）已内置，节省下载时间
- plumemo 及其一键安装脚本所需的各种依赖已全部安装
- plumemo 开机自启脚本
-  [LuckyBlog](http://b.luckykeeper.site/) 的主题，基于 [theme-react-sakura](https://github.com/byteblogs168/theme-react-sakura)（非 SSR 版） 做了一定改动，效果可以前往 [LuckyBlog](http://b.luckykeeper.site/) 查看
- `nginx.conf` nginx 网站设置文件

## 使用方法

（注：以下内容假设你使用 plumemo 一键安装脚本，并安装到了默认目录）

1. 将本镜像 pull 下来并运行，需要加参数（在镜像名称前） `-tid`
2. 使用 `docker exec` 命令进入容器并使用 `passwd` 修改 root 密码，之后可以使用 putty 等软件通过 root 账户及刚才设置的密码连接该容器
3. 使用 `./plumemo-v1.0.0.sh` 命令运行一键安装脚本，安装你需要的各种服务（如果软件下载缓慢，可提前下载到宿主机并使用 `docker cp` 命令复制到容器中（plumemo 一键安装脚本的内置软件存放目录为 /usr/local/plumemo ）
4. 安装完成，检查是否有 `nginx` 命令（在终端直接输入 `nginx`），若没有，执行以下命令

```bash
cp /usr/local/plumemo/nginx/sbin/nginx /usr/bin/nginx
```

5. 根据你的情况，修改 root 目录的 nginx.conf 文件（需要修改里面的 `server_name  localhost 177.229.25.8 blog.luckykeeper.site;` 这部分内容，改为你的容器的 ip 和你的域名 ）
6. 在 /usr/local/plumemo 目录下建立 `https` 文件夹，将 `https` 证书和密钥拷入，文件名分别是 fullchain.pem 和 privkey.pem ，如需要自动更新证书，请参考[这篇文章](https://blog.luckykeeper.site:24680/article/16)，使用定时运行 `docker cp` 的方法像该文件夹传递更新之后的证书
7. 如不需要使用 https ，只通过 http 运行，请修改 nginx.conf 文件，注释掉 SSL 部分
8. 将修改好的 `nginx.conf` 文件从 root 目录复制到 /usr/local/plumemo/nginx/conf/ 目录下，替换原 `nginx.conf` 文件
9. 如果需要使用 [LuckyBlog](http://b.luckykeeper.site/) 的主题，就将 root 目录下的 theme-react-sakura 这个文件夹替换 /usr/local/plumemo/theme/theme-react-sakura
10. 全部设置完成，对博客进行测试，首先使用 `htop` 或 `ps` 等命令查找已经存在的 nginx 进程，并使用 kill [ nginx 进程的 PID] 停止 nginx ，再切换到 root 目录，运行 blog_auto_start.sh 脚本测试自动启动，并通过查看 root 目录下  nohup 文件的日志的输出和浏览器访问检查博客运行状态，如运行正常，执行下一步的操作
11. 使用 docker commit 命令将修改好的容器重新打包成一个新的镜像，然后关闭原先的容器，使用刚刚打包出来的镜像运行容器，需要带参数（在镜像名称前） `-tid` 和附加参数（在最后面） `bash /root/blog_auto_start` 
12. 至此，全部任务完成，享受 plumemo 吧~

> ![Warning](https://cdn.jsdelivr.net/gh/luckykeeper/LuckyBlog_RS@main/2021-03-25-长期-相逢月之彼岸，故事由此再续——【旧文重写】Luckykeeper推过的gal和简评/Warning.6jc20aiv9rk0.png)特别注意：docker commit 命令打包的镜像包含个人数据（如数据库账号密码等)，请不要将其上传到公共镜像仓库之中

## plumemo介绍

以下部分是 plumemo 介绍，引自[ plumemo-deploy](https://github.com/byteblogs168/plumemo-deploy)，供对 plumemo 不了解的用户参考，[ plumemo 传送门](https://github.com/byteblogs168/plumemo)

<h1 align="center"><a href="https://github.com/byteblogs168/plumemo" target="_blank">plumemo</a></h1>

> [Plumemo](https://www.plumemo.com/) 是一个轻量、易用、前后端分离的博客系统，为了解除开发人员对后端的束缚，真正做到的一个面向接口开发的博客系统。

<p align="center">
<a href="#"><img alt="JDK" src="https://img.shields.io/badge/JDK-1.8-yellow.svg?style=flat-square"/></a>
<a href="#"><img alt="GitHub release" src="https://img.shields.io/github/release/halo-dev/halo.svg?style=flat-square"/></a>
<a href="#"><img alt="GitHub All Releases" src="https://img.shields.io/github/downloads/halo-dev/halo/total.svg?style=flat-square"></a>
<a href="#"><img alt="Docker pulls" src="https://img.shields.io/docker/pulls/ruibaby/halo?style=flat-square"></a>
</p>


------------------------------

简介

**plumemo** [plumemo]，plume（羽） + memo（备忘录）

> 基于[SpringBoot](https://spring.io/projects/spring-boot/)实现零配置让系统的配置更简单，使用了[Mybatis-Plus](https://mp.baomidou.com/)快速开发框架，在不是复杂的查询操作下，无需写sql就可以快速完成接口编写。
> 后台管理系统使用了vue中流行的[ant](https://panjiachen.github.io/vue-element-admin-site/#/)，另外前后交互使用了[JWT](https://jwt.io/)作为令牌，进行权限、登录校验。。


> [官网](https://www.plumemo.com/) | [社区](https://www.byteblogs.com) | [QQ 交流群](https://shang.qq.com/wpa/qunwpa?idkey=4f8653da80e632ef86ca1d57ccf8751602940d1036c79b04a3a5bc668adf8864) | 

## 感谢

本项目使用了 [plumemo 一键安装脚本](https://github.com/byteblogs168/plumemo-deploy) 在此提出感谢

## 问题反馈及建议

请前往本项目的 [GitHub](https://github.com/luckykeeper/docker_plumemo) 页面提交反馈及建议，如果这个项目帮助了你，请到本项目的 [GitHub](https://github.com/luckykeeper/docker_plumemo) 页面给个 `star`
