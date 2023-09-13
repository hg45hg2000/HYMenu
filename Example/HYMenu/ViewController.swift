//
//  ViewController.swift
//  HYMenu
//
//  Created by HENRY on 02/12/2022.
//  Copyright (c) 2022 HENRY. All rights reserved.
//

import UIKit
import HYMenu
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "left", style: .plain, target: self, action: #selector(leftBarButtonPress))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "right", style: .plain, target: self, action: #selector(rightBarButtonPress))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc func leftBarButtonPress(){
        HYMenuViewController.shared.openSideMenu(edges: .left)
    }
    @objc func rightBarButtonPress(){
        HYMenuViewController.shared.openSideMenu(edges: .right)
    }
}

