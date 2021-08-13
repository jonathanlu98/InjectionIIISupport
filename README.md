# InjectionIIISupport

1. 首先 Mac App Store 下载 InjectionIII 这个软件，安装并打开。

2. 项目中的Podfile 引入即可使用，无需在项目中写入任何代码。<br />
```Ruby
pod 'InjectionIIISupport', '~> 1.2.1', :configurations => 'Debug' # 只在Debug环境下起作用
```
3. InjectionIII 菜单 Open Project 选择当前的工程目录。

4. 项目中输入代码后按 Command + S 保存 (或者 Xcode焦点移到模拟器上) 即可愉快的动态看效果。

5. 如果不需要podfile 移除此pod即可。

6. 最新版本支持项目中属性的懒加载。

注意：此软件目前只支持模拟器使用。


