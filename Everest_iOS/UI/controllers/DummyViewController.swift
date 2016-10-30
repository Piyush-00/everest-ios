//
//  DummyViewController.swift
//  Everest_iOS
//
//  Created by Sebastian Kolosa on 2016-10-29.
//  Copyright © 2016 Everest. All rights reserved.
//

import UIKit

class DummyViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let button = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        button.backgroundColor = UIColor.red
        button.addTarget(self, action: #selector(buttonListener), for: .touchUpInside)
        view.addSubview(button)
        view.backgroundColor = UIColor.white
    }
    
    func buttonListener(sender: UIButton) {
        if let navigationController = (UIApplication.shared.delegate as! AppDelegate).navigationController {
                let createEventViewController = CreateEventViewController()
                navigationController.pushViewController(createEventViewController, withAnimation: .fromRight)
        }
    }
}
