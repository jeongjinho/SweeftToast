//
//  ViewController.swift
//  Toast
//
//  Created by jeongjinho on 15/02/2019.
//  Copyright © 2019 jeongjinho. All rights reserved.
//

import UIKit
import SweeftToast
class ViewController: UIViewController {
    let toastButton: UIButton = UIButton.init(type: .custom)
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
    }

    
    private func setupUI() {
        toastButton.setTitle("show my Toast", for: .normal)
        toastButton.setTitleColor(UIColor.black, for: .normal)
        toastButton.addTarget(self, action: #selector(touchUpInsideToastButton), for: .touchUpInside)
        self.view.addSubview(toastButton)
    }
    
    private func setupConstraints() {
        toastButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        toastButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        toastButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        toastButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        toastButton.translatesAutoresizingMaskIntoConstraints = false
     
    }
    
    @objc func touchUpInsideToastButton() {
     
       
        
    }
}

