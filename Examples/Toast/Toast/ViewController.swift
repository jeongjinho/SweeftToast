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
    let toastafterTypeButton: UIButton = UIButton.init(type: .custom)
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
        
        toastafterTypeButton.setTitle("show my AfterToast", for: .normal)
        toastafterTypeButton.setTitleColor(UIColor.black, for: .normal)
        toastafterTypeButton.addTarget(self, action: #selector(touchUpInsideToastAfterButton), for: .touchUpInside)
        self.view.addSubview(toastafterTypeButton)
    }
    
    private func setupConstraints() {
        toastButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        toastButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        toastButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        toastButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        toastButton.translatesAutoresizingMaskIntoConstraints = false
        
        toastafterTypeButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        toastafterTypeButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 60).isActive = true
        toastafterTypeButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        toastafterTypeButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        toastafterTypeButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    @objc func touchUpInsideToastButton() {
        let toast = Toast(self,"hihi")
        toast.startToastView(duration: 3.0)
    }
    
    @objc func touchUpInsideToastAfterButton() {
       Toast(self, "toast is shown") { (toast) in
            toast.toastButton.setTitle("cancel", for: .normal)
        }.tapOnButton {
            print("button in Toast clicked")
        }.startToastView(duration: 3.0) {
            print("Toast is hidden")
        }
    }
}
