//
//  ViewController.swift
//  Swizzling
//
//  Created by Sergey Pugach on 10/6/17.
//  Copyright © 2017 Sergey Pugach. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let label = UILabel(frame: CGRect(x: 50, y: 50, width: 200, height: 30))
        label.text = "Hello world!"
        label.backgroundColor = .orange
        label.font = UIFont.systemFont(ofSize: 35, weight: UIFont.Weight.ultraLight)
        
        view.addSubview(label)
        
        let button = UIButton(frame: CGRect(x: 50, y: 250, width: 30, height: 30))
        button.setTitle("OK", for: .normal)

        view.addSubview(button)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

