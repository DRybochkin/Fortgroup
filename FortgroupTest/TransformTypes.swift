//
//  TransformTypes.swift
//  FortgroupTest
//
//  Created by Dmitry Rybochkin on 25.03.17.
//  Copyright © 2017 Dmitry Rybochkin. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift

open class CustomDateTransform: TransformType {
    public typealias Object = Date
    public typealias JSON = Double

    public init() {}

    open func transformFromJSON(_ value: Any?) -> Date? {
        if let timeInt = value as? Double {
            return Date(timeIntervalSince1970: TimeInterval(timeInt))
        }

        if let timeStr = value as? String {
            return timeStr.toDate(format: "yyyy-MM-dd HH:mm:ss")
        }

        return nil
    }

    open func transformToJSON(_ value: Date?) -> Double? {
        if let date = value {
            return Double(date.timeIntervalSince1970)
        }
        return nil
    }
}
