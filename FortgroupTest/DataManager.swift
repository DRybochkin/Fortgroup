//
//  DataManager.swift
//  FortgroupTest
//
//  Created by Dmitry Rybochkin on 18/01/2017.
//  Copyright © 2017 Dmitry Rybochkin. All rights reserved.
//

import Foundation
import RealmSwift

public class DataManager {
    public let realm: Realm

    public static let sharedManager = DataManager()

    private init() {
        let config = Realm.Configuration(
            schemaVersion: 0,
            migrationBlock: { _, _ in
            }
        )
        Realm.Configuration.defaultConfiguration = config

        realm = try! Realm()

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(loadFilesDataFromNetwork),
                                               name: NSNotification.Name.FortgroupTestDataLoad, object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    func add(_ item: Object) -> Bool {
        do {
            try realm.write {
                realm.add(item, update: true)
            }
            return true
        } catch {
            return false
        }
    }

    func add(_ items: [Object]) -> Bool {
        do {
            try realm.write {
                for item in items {
                    realm.add(item, update: true)
                }
            }
            return true
        } catch {
            return false
        }
    }

    func getItem<T: Object>(_:T.Type, itemId: String) -> T? {
        return realm.object(ofType:T.self, forPrimaryKey:"\(itemId)")
    }

    func getItem<T: Object>(_:T.Type, itemId: Int) -> T? {
        return realm.object(ofType:T.self, forPrimaryKey: itemId)
    }

    func getItems<T: Object>(_:T.Type) -> [T] {
        return Array(realm.objects(T.self))
    }

    func delete<T: Object>(objects ofType: T.Type, _ predicate: NSPredicate) {
        try? realm.write {
            realm.delete(realm.objects(ofType).filter(predicate))
        }
    }

    func delete<T: Object>(objects: List<T>) {
        try? realm.write {
            realm.delete(objects)
        }
    }

    func delete<T: Object>(objects: List<T>, _ predicate: NSPredicate) {
        try? realm.write {
            realm.delete(objects.filter(predicate))
        }
    }

    @objc func loadFilesDataFromNetwork(forceUpdate: Bool = false) {
        print("start loading")
        NotificationCenter.default.post(name: Notification.Name.FortgroupTestDataWillLoad, object: nil)
        let fileIds = ["1", "2", "10"]
        let fileLoadGroup = DispatchGroup()
        print("start load files")
        var loadedItems: [NewsModel] = []
        for fileId in fileIds {
            fileLoadGroup.enter()
            _ = ServiceClient.getFileRequest(fileId).send({ succeed, result, error in
                if let wtomitw: [NewsModel] = result?.serialize(NewsModel.self) {
                    loadedItems.append(contentsOf: wtomitw)
                } else {
                    print("\(succeed), \(result), \(error)")
                }
                fileLoadGroup.leave()
            })
        }

        fileLoadGroup.notify(queue: .main, execute: {
            print("files loaded")
            print("start update local database")
            var itemsToUpdate: [Int: NewsModel] = [:]
            for item in loadedItems {
                if itemsToUpdate.keys.contains(item.id) {
                    if let oldItem = itemsToUpdate[item.id] {
                        if item.lastUpdate > oldItem.lastUpdate {
                            itemsToUpdate[item.id] = item
                        }
                    }
                } else {
                    if let oldItem = self.getItem(NewsModel.self, itemId: item.id) {
                        if (forceUpdate) || (item.lastUpdate > oldItem.lastUpdate) {
                            for subItem in oldItem.json {
                                self.delete(objects: subItem.content)
                            }
                            self.delete(objects: oldItem.json)
                            itemsToUpdate[item.id] = item
                        }
                    } else {
                        itemsToUpdate[item.id] = item
                    }
                }
            }
            print("local database has to update \(itemsToUpdate.keys.count) items")
            if itemsToUpdate.keys.count > 0 {
                _ = self.add(Array(itemsToUpdate.values))
            }
            print("local database updated")
            NotificationCenter.default.post(name: Notification.Name.FortgroupTestDataDidLoad,
                                            object: itemsToUpdate.keys.count > 0)
        })
    }
}
