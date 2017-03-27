//
//  MediaContentModel.swift
//  FortgroupTest
//
//  Created by Dmitry Rybochkin on 25.03.17.
//  Copyright © 2017 Dmitry Rybochkin. All rights reserved.
//

import Foundation
import RealmSwift
import Realm
import ObjectMapper

class MediaContentModel: SerializableObject {
    dynamic var type: String = ""
    var content: List<ContentModel> = List<ContentModel>()

    required public init() {
        super.init()
    }

    required public init(value: Any) {
        super.init(value: value)
    }

    required public init(value: Any, schema: RLMSchema) {
        var tempValue = value
        if value is [String: Any] {
            if let objDict = value as? [String: Any] {
                if objDict.keys.contains("type") {
                    if let mediaType = objDict["type"] as? String {
                        if mediaType == "text" {
                            if let stringContent = objDict["content"] as? String {
                                tempValue = ["type": "text", "content": [["text": stringContent]]]
                            }
                        }
                    }
                }
            }
        }

        super.init(value: tempValue, schema: schema)
    }

    required public init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }

    required convenience public init?(map: Map) {
        self.init()
    }

    override func mapping(map: Map) {
    }

    // Specify properties to ignore (Realm won't persist these)

    //override static func ignoredProperties() -> [String] {
    //    return []
    //}
}
