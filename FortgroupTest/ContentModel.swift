//
//  ContentModel.swift
//  FortgroupTest
//
//  Created by Dmitry Rybochkin on 25.03.17.
//  Copyright © 2017 Dmitry Rybochkin. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

class ContentModel: SerializableObject {
    dynamic var text: String = ""
    dynamic var url: String = ""
    dynamic var source: String = ""
    dynamic var poster: String = ""

    convenience public init(text: String) {
        self.init()
        self.text = text
    }

    required public init() {
        super.init()
    }

    required public init(value: Any) {
        super.init(value: value)
    }

    required public init(value: Any, schema: RLMSchema) {
        super.init(value:value, schema:schema)
    }

    required public init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
   }

    // Specify properties to ignore (Realm won't persist these)

    //  override static func ignoredProperties() -> [String] {
    //    return []
    //  }
}
