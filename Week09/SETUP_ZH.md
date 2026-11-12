# Week09 配置与提交步骤

选择的是 Option 1：MakeItSo。无需再做 Option 2 的 MoLobby fork 和姓名分支。

## 1. 创建自己的 Firebase 项目
打开 https://console.firebase.google.com/ ，使用你的 Google 账号登录。
创建一个新项目，名称可以是 Christy Week09。记录控制台实际生成的 Project ID。
此作业不需要 Google Analytics，可以不启用。也不需要 Cloud Storage 或付费升级。

## 2. 注册 iOS App
在项目中添加 Apple / iOS App，填写：
- Bundle ID：com.christyliu.ColorWalkTasksWeek09
- 昵称：Color Walk Tasks
- App Store ID：留空

下载该 App 的 GoogleService-Info.plist。
在 Finder 中将它放入本作业的 **Week09/MakeItSo/** 文件夹，与 MakeItSoApp.swift 同级。
项目已包含该文件引用；不要添加第二个同名文件，不要使用课堂示例的配置。

## 3. 启用匿名登录
Firebase 控制台 → Authentication → Get started → Sign-in method。
启用 **Anonymous（匿名）** 并保存。此版本用匿名 UID 区分数据，没有注册邮箱或跨设备登录。

## 4. 创建 Firestore
进入 Firestore Database，创建默认数据库，选择 Standard edition（如有版本选项）。
选择合适的地区并记录它；不要随意复用老师数据库。
以 Production mode 开始，然后在 Rules 页面粘贴本文件夹的 **firestore.rules** 内容并 Publish。

规则对应路径：users / 当前匿名用户 UID / reminders / 文档 ID。
不要把规则改为 allow read, write: if true。其他用户的 UID 路径应拒绝访问。

## 5. 在 Xcode 打开
双击 MakeItSo.xcodeproj，等待 Firebase 包解析完成。
项目已经指定 Firebase **10.29.0**，与课堂锁定文件一致，无需手动添加最新版。
选择 MakeItSo scheme 和 iPhone 模拟器，按 Command–R。
如果在真机运行，到 Signing & Capabilities 选择自己的 Team。

首次运行会匿名登录，然后显示 Color Walk Tasks。
如果出现配置缺失错误，检查第 2 步文件位置。
如果登录失败，检查 Anonymous 是否启用、网络和配置是否属于你创建的项目。
如果出现 Missing or insufficient permissions，检查规则是否发布以及路径/UID 是否匹配。
如果 SDK 编译报错，请保留第一条错误截图；不要直接升级 SDK 来掩盖版本差异。

## 6. 验证真正的云端保存
添加 “Find a yellow object”，去 Firebase Firestore 控制台确认对应文档出现。
修改任务、勾选完成，检查控制台字段变化。
在控制台改同一文档的 title，观察 App 是否更新。
关闭并重新打开 App，检查记录；注意仅凭重新打开还不能证明云端保存，因为 Firestore 有本地缓存。
删除任务，检查控制台也删除。
第二个模拟器会有不同匿名 UID，因此不应看到第一台的任务。
匿名身份不是永久账号：删除 App 或清理认证状态后，可能无法再访问原 UID 的数据。

## 7. 提交
将整个 Week09 文件夹复制到你的 molab-2026-itp-Christy 仓库根目录。
GitHub Desktop 检查 Changes，只提交这次 Week09 的文件，Summary 填：
Add Week09 MakeItSo adaptation and proposal
点击 Commit，然后 Push origin。
GoogleService-Info.plist 已在 .gitignore 中排除；它不是管理员密钥，但每位运行者应配置自己的项目。不要上传服务账号私钥。

个人 Wiki：加入 FINAL_PROJECT_PROPOSAL.md 和 WIKI_WEEK09.md 的内容，按真实情况更新测试状态。
课程 Wiki Week09：首页添加项目文件夹链接：
https://github.com/ChristyLiu557/molab-2026-itp-Christy/tree/main/Week09

## 官方参考
- Firebase iOS 配置：https://firebase.google.com/docs/ios/setup
- 匿名认证：https://firebase.google.com/docs/auth/ios/anonymous-auth
- Firestore 规则：https://firebase.google.com/docs/firestore/security/rules-conditions

官方安装页面默认描述当前 SDK；本作业版本以课堂锁定的 10.29.0 为准。

