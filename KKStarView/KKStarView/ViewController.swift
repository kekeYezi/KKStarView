//
//  ViewController.swift
//  KKStarView
//
//  Created by Daniel on 17/5/13.
//  Copyright © 2017年 kekeYezi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let starview = StartView.init(frame: self.view.frame)
        self.view.addSubview(starview)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

