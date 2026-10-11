# Week05 — Focus Bloom / Remember my duration

## 本周改了什么
在 Week04 的两页导航 App 中加入 `@AppStorage`。首页选中的时长现在会在重新启动 App 后保留。倒计时本身不会在强制关闭 App 后保留。

老师提供的作业明确把 app storage 列为例子。本项目采用这个方向；尚未核对课堂 demo 的具体源码。如果课程要求直接改编指定 demo，请将 demo 链接补充给我核对。

## 操作步骤
1. 把整个 Week05 文件夹放进 molab-2026-itp-Christy，与 Week04 同一层。
2. 关闭之前的 Xcode 工程窗口，打开本文件夹里的 FocusBloom.xcodeproj。
3. 选择 FocusBloom scheme 和上次的 iPhone 模拟器，按 Command + R。
4. 首页选择 10 min，点 Open timer，确认第二页显示 10:00。
5. 点击 Xcode 左上角 Stop 停止 App，再按 Command + R。
6. 检查首页是否仍选中 10 min。这是本周新增功能的关键测试。
7. 改成 25 min，再重复停止和启动，确认显示新的选择。
8. 测试 10 秒 demo 的开始、暂停、继续、重置和完成提示。
9. 截图并记录实际结果，更新 WIKI_WEEK05.md，再提交 GitHub。

Week05 使用独立的 Bundle Identifier，手机名称为 Focus Bloom 05。首次运行默认选择 5 min；不会继承 Week04 的数据。若更换模拟器或卸载 App，保存的选择可能重置。

## 代码理解
原来：
```swift
@State private var minutes = 5
```
现在：
```swift
@AppStorage("focusDurationMinutes") private var minutes = 5
```
- `minutes`：代码使用的变量名。
- `focusDurationMinutes`：持久保存时使用的 key。
- `5`：第一次运行且没有存储值时的默认值。
- Picker 继续绑定 `$minutes`；用户选中新的时长时，值会被保存。
- AppStorage 用于小型偏好设置；这里仅保存选择的分钟数。

Apple reference: https://developer.apple.com/documentation/swiftui/appstorage

## 文件
- FocusBloom/: SwiftUI 源码
- FocusBloom.xcodeproj/: Xcode 工程
- WIKI_WEEK05.md: 英文周报草稿，含 progress / problems / plans / questions
- FundamentalsPractice.swift: 独立练习，不加入 App target
- CHECKLIST.md: 课程要求与待办
- SUBMISSION_LINK.md: 班级 wiki 链接格式

## 验证状态
已检查新增 AppStorage 的绑定和工程文件结构；本环境没有 Xcode，尚未编译或测试 Week05。Week04 的功能由你在模拟器中测试通过，但 Week05 的持久保存需要重新验证。

## 提交
GitHub Desktop 选择课程仓库，检查 Week05 新增文件，Summary 填写 `Add Week05 AppStorage persistence`，Commit 后 Push origin。在 GitHub 打开 Week05 文件夹，复制链接，添加到班级 Week05 wiki，并更新个人 wiki。
