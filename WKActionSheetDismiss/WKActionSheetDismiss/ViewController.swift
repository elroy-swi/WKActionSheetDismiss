//
//  ViewController.swift
//  WKActionSheetDismiss
//
//  Created by Elroy on 2018/5/8.
//  Copyright © 2018年 swi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func pushAction() {
        let ctrl = PushAViewController()
        self.navigationController?.pushViewController(ctrl, animated: true)
    }
}

