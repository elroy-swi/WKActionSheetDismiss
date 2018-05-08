//
//  PushAViewController.swift
//  WKActionSheetDismiss
//
//  Created by Elroy on 2018/5/8.
//  Copyright © 2018年 swi. All rights reserved.
//

import UIKit

class PushAViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white

        let presentButton = UIButton(type: .system)
        presentButton.setTitle("Present Web Controller", for: .normal)
        presentButton.frame = CGRect(x: 50, y: 260, width: 260, height: 40)
        view.addSubview(presentButton)
        presentButton.addTarget(self, action: #selector(presentAction), for: .touchUpInside)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc
    func presentAction() {
        let ctrl = SOFAWebViewController()
        let navigationController = SOFANavigationController(rootViewController: ctrl)
        
        self.present(navigationController, animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
