//
//  NewsModel.swift
//  FortgroupTest
//
//  Created by Dmitry Rybochkin on 25.03.17.
//  Copyright © 2017 Dmitry Rybochkin. All rights reserved.
//

import ObjectMapper
import RealmSwift

class NewsModel: SerializableObject {
    dynamic var id: Int = 0
    dynamic var textId: String = ""
    dynamic var dueDate: Date = Date()
    dynamic var lastUpdate: Date = Date()
    dynamic var version: Int = 0
    dynamic var title: String = ""
    dynamic var rubric: String = ""
    dynamic var type: String = ""
    dynamic var spb: Int = 0
    var json: List<MediaContentModel> = List<MediaContentModel>()
    dynamic var link: String = ""
    dynamic var forumId: Int = 0
    dynamic var lead: String = ""
    dynamic var imageUrl: String = ""
    dynamic var imageSource: String = ""

    override class func primaryKey() -> String? {
        return "id"
    }

    required convenience init?(map: Map) {
        self.init()
    }

    override func mapping(map: Map) {
        textId <- map["text_id"]
        forumId <- map["forum_id"]
        imageUrl <- map["image_url"]
        imageSource <- map["image_source"]
        dueDate <- (map["date"], CustomDateTransform())
        lastUpdate <- (map["last_update"], CustomDateTransform())
    }

    // Specify properties to ignore (Realm won't persist these)

    //override static func ignoredProperties() -> [String] {
    //    return []
    //}
}
