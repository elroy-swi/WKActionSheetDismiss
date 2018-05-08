# WKActionSheetDismiss

# 模态UIViewController中WebView的H5弹出Camera/ImagePicker/ActionSheet dismiss问题

SOFAWebViewController中有一个WebView，加载了H5页面， H5页面有长按手势，长按二维码弹出了ActionSheet, 然后点击空白部分或取消按钮，程序直接退出到了 PushAViewController 页面。

ViewController push-> PushAViewController present-> SOFAWebViewController

## 如何解决？

### 使WKActionSheet找不到presentingViewController

WKActionSheet是断点调试打印出来的。如果像是调用Camera等则使用UIDocumentPickerViewController、UIImagePickerController

###### 自定义SOFANavigationController

``` swift
import UIKit

class SOFANavigationController: UINavigationController {

    var _flag = false

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override var presentingViewController: UIViewController? {
        if _flag {
            return nil
        } else {
            return super.presentingViewController
        }
    }

    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        if viewControllerToPresent.isKind(of: UIDocumentPickerViewController.self)
            || viewControllerToPresent.isKind(of: UIImagePickerController.self)
            || viewControllerToPresent.isKind(of: NSClassFromString("WKActionSheet")!) {
            _flag = true
        }

        super.present(viewControllerToPresent, animated: flag, completion: completion)
    }

    override func popToViewController(_ viewController: UIViewController, animated: Bool) -> [UIViewController]? {
        _flag = false
        return super.popToViewController(viewController, animated: animated)
    }

    override func popViewController(animated: Bool) -> UIViewController? {
        _flag = false
        return super.popViewController(animated: animated)
    }

    override func popToRootViewController(animated: Bool) -> [UIViewController]? {
        _flag = false
        return popToRootViewController(animated: animated)
    }

    override func setViewControllers(_ viewControllers: [UIViewController], animated: Bool) {
        _flag = false
        super.setViewControllers(viewControllers, animated: animated)
    }
}
```

#### 在SOFAWebViewController中：

重写该方法

```
override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        if self.presentingViewController != nil {
            super.dismiss(animated: flag, completion: completion)
        }
    }
```

关闭按钮

```
func closeAction() {

        if let navigationCtrl = self.navigationController as? SOFANavigationController {
            navigationCtrl._flag = false
        }
        dismiss(animated: true)
    }
```
