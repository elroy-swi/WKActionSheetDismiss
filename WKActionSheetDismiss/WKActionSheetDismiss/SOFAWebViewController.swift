//
//  SOFAWebViewController.swift
//  WKActionSheetDismiss
//
//  Created by Elroy on 2018/5/8.
//  Copyright © 2018年 swi. All rights reserved.
//

import UIKit
import WebKit

class SOFAWebViewController: UIViewController {

    //WKWebview 配置文件
    private lazy var webviewConfiguration: WKWebViewConfiguration = {
        let config = WKWebViewConfiguration()
        var js = ""
        //长按 禁用
//        js += "document.documentElement.style.webkitTouchCallout='none';"
        //选择 禁用
//        js += "document.documentElement.style.webkitUserSelect='none';"
        let userScript = WKUserScript(source: js, injectionTime: .atDocumentStart, forMainFrameOnly: false)
        config.userContentController.addUserScript(userScript)
        return config
    }()

    lazy var webView: WKWebView = {
        //配置环境
        let view = WKWebView(frame: self.view.frame, configuration: self.webviewConfiguration)
        view.allowsBackForwardNavigationGestures = true
        view.scrollView.isScrollEnabled = true
        view.scrollView.keyboardDismissMode = .interactive
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    fileprivate lazy var progressView: UIProgressView = {
        let view = UIProgressView()
        view.tintColor = UIColor.blue
        view.trackTintColor = UIColor.lightGray
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "关闭", style: UIBarButtonItemStyle.plain, target: self, action: #selector(closeAction))

        webView.frame = UIScreen.main.bounds
        view.addSubview(webView)

        progressView.frame = CGRect(x: 0, y: UIApplication.shared.statusBarFrame.size.height + 44, width: UIScreen.main.bounds.size.width, height: 2)
        view.addSubview(progressView)

        let urlRequest = URLRequest(url: URL(string: "https://www.cryptokitties.co")!)
        self.webView.load(urlRequest)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        webView.removeObserver(self, forKeyPath: "estimatedProgress")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        if self.presentingViewController != nil {
            super.dismiss(animated: flag, completion: completion)
        }
    }

    /*!
     *  MARK: - 计算进度条
     */
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            let newProgress = (change![NSKeyValueChangeKey.newKey] as! NSNumber).floatValue
            progressView.alpha = 1
            progressView.setProgress(newProgress, animated: true)
            if newProgress >= 1 {
                UIView.animate(withDuration: 0.3, delay: 0.3, options: .curveEaseOut, animations: {
                    self.progressView.alpha = 0.0
                }, completion: { (finished) in
                    self.progressView.setProgress(0.0, animated: false)
                })
            }
        }
    }

    @objc
    func closeAction() {

        if let navigationCtrl = self.navigationController as? SOFANavigationController {
            navigationCtrl._flag = false
        }
        dismiss(animated: true)
    }

}
