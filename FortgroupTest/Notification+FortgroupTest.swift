//
//  Notification+FortgroupTest.swift
//  FortgroupTest
//
//  Created by Dmitry Rybochkin on 25.03.17.
//  Copyright © 2017 Dmitry Rybochkin. All rights reserved.
//

import Foundation

extension NSNotification.Name {
    public static var FortgroupTestDataWillLoad: NSNotification.Name = NSNotification.Name("FortgroupTestDataWillLoad")
    public static var FortgroupTestDataDidLoad: NSNotification.Name = NSNotification.Name("FortgroupTestDataDidLoad")
    public static var FortgroupTestDataLoad: NSNotification.Name = NSNotification.Name("FortgroupTestDataLoad")
}
