- [中文](#中文)
  - [介绍](#介绍)
  - [使用说明](#使用说明)
  - [文件结构 \& 编译说明](#文件结构--编译说明)
- [English](#english)
  - [Introduction](#introduction)
  - [Usage](#usage)
  - [File Structure \& Compilation Notes](#file-structure--compilation-notes)


# 中文
## 介绍

![icon](./sublime_text.ico)

基于 [Gist](https://gist.github.com/cipherknight/bd3c7c8786f056e83490482696921245) 自动化破解sublime4


## 使用说明

- 仅支持 Windows 操作系统
- 安装 Sublime4（正式版）
- 以下任意方式执行补丁：
  > 下载仓库内所有文件 $\to$ 双击 `.bat` 文件

  或者

  > 直接从[release](https://github.com/taozhiyu/sublime-auto4/releases/latest)下载打包好的exe $\to$ 双击

## 文件结构 & 编译说明

| 文件名                  | 说明                                                         |
| :---------------------- | :----------------------------------------------------------- |
| sublime_auto.bat  | 主程序<br />读取系统语言，多语言输出<br />调用其他内容       |
| sublime_text.ico        | 就是一个图标。。。                                           |
| getcode.js              | bat没有稳定的获取html内容的方法，<br />调用系统JScript解析器 |
| xxd.exe && msys-2.0.dll | 通过bat修改二进制组件及其依赖                                |

理论上可以直接下载并执行 `bat` 文件，但是有很多依赖，因此仓库使用 `Quick Batch File Compiler 5.0.8` 打包了 release 版，如有需要请自行编译


# English

## Introduction

![icon](./sublime_text.ico)

Automated patching of sublime4 based on [Gist](https://gist.github.com/cipherknight/bd3c7c8786f056e83490482696921245)

## Usage

- Windows support only
- Install Sublime4 (stable version)
- Execute the patch file in any of the following ways:
  > Download all files in this repo $\to$ Double click on the `.bat` file

  OR

  > Download the packaged exe directly from [release Page](https://github.com/taozhiyu/sublime-auto4/releases/latest) $\to$ Double click on the executable file


## File Structure & Compilation Notes

| File Name               | Description                                                  |
| :---------------------- | :----------------------------------------------------------- |
| sublime_auto.bat  | Main program reading system language and with multilingual output |
| sublime_text.ico        | Just an icon…                                                |
| getcode.js              | Bat has no stable way of getting html content, calling the system JScript parser |
| xxd.exe && msys-2.0.dll | Modifying binary components and their dependencies via bat   |

In theory it is possible to download and execute the `bat` file directly, but there are many dependencies, so this repository uses the `Quick Batch File Compiler 5.0.8` to package the release version, so please compile it yourself if you want.