//
//  UIButton+Title.swift
//  FortgroupTest
//
//  Created by Dmitry Rybochkin on 26.03.17.
//  Copyright © 2017 Dmitry Rybochkin. All rights reserved.
//

import Foundation
import UIKit

public extension UIButton {
    func setTitle(_ title: String) {
        self.setTitle(title, for: .normal)
        self.setTitle(title, for: .highlighted)
        self.setTitle(title, for: .disabled)
        self.setTitle(title, for: .focused)
        self.setTitle(title, for: .selected)
   }
}
