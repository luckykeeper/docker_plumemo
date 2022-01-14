# docker_plumemo
plumemo博客容器镜像（All in One）

【置顶】本项目不受 Apache Log4j2 远程代码执行漏洞影响，详见：https://github.com/byteblogs168/plumemo/issues/18

> 说是半成品的原因是需要手动执行一键部署脚本的命令，如果您能够完善这个镜像，欢迎提交 PR ，非常感谢！

使用指南、相关信息等，请移步[DockerHub](https://hub.docker.com/r/luckykeeper/plumemo_pre)页面

容器构建指南请参照本页面

## 容器构建指北

- 适用对象：有一定技术能力，想自行构建容器镜像的用户；已经虚拟机部署，想切换到 Docker 的用户
- 注意事项如下：

1. theme 文件夹存放你现在的主题，可以是 `theme-react-sakura` ，也可以是 `theme-vue-bluesoul` 或将来兼容的其它主题
2. 本页面的 theme 文件夹是 [LuckyBlog](http://b.luckykeeper.site/) 的主题，基于 [theme-react-sakura](https://github.com/byteblogs168/theme-react-sakura)（非 SSR 版） 做了一定改动，效果可以前往 [LuckyBlog](http://b.luckykeeper.site/) 查看
3. 自带了一部分安装文件（包括 nginx 、管理系统 、后台， mysql 和 jdk 没有内置，使用一键脚本时会自动下载），并已经拷贝至一键部署脚本要求的下载目录，节省下载时间（尤其是国内用户，但 jdk 安装包由于超过了 GitHub 的文件大小限制没有加入，国内下载困难的用户可以考虑先想办法下载好之后用 `docker cp` 命令传进去）
4. 其它疑问请自行参考 Dockerfile 文件或在 Issues 提问

感谢 plumemo 官方提供的一键脚本 [plumemo-deploy](https://github.com/byteblogs168/plumemo-deploy)

如果该项目帮助到了你，请给个 star 吧~

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
