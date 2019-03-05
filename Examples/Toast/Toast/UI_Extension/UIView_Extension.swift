//
//  UIView_Extension.swift
//  Toast
//
//  Created by jeongjinho on 05/03/2019.
//  Copyright © 2019 jeongjinho. All rights reserved.
//

import UIKit

extension UIView {
    func clearConstraints() {
        for subview in self.subviews {
            subview.clearConstraints()
        }
        self.removeConstraints(self.constraints)
    }
}
