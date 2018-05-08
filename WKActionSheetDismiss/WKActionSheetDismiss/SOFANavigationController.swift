//
//  SOFANavigationController.swift
//  DApps
//
//  Created by Elroy on 2018/5/7.
//  Copyright © 2018年 DApp. All rights reserved.
//

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
//        plog(viewControllerToPresent)
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
