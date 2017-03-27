//
//  String+Date.swift
//  FortgroupTest
//
//  Created by Dmitry Rybochkin on 25.03.17.
//  Copyright © 2017 Dmitry Rybochkin. All rights reserved.
//

import Foundation

public extension String {
    func toDate(format: String) -> Date! {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format //"yyyy-MM-dd'T'HH:mm:ss.SSSSSSSZZZZZZ"
        return dateFormatter.date(from: self)!
    }
}
