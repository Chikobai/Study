//
//  StorageManager.swift
//  Jiber
//
//  Created by I on 9/5/19.
//  Copyright © 2019 Shyngys. All rights reserved.
//

import Foundation
import Cache

class StoreManager: NSObject {

    //MARK: - Variables

    private var storage : Storage?  //Cache manager

    // MARK: - Public functions

    class func shared() -> StoreManager {
        return sharedManager
    }

    private static var sharedManager: StoreManager = {
        let manager = StoreManager()
        return manager
    }()

    //MARK: - Init

    private override init() {
        super.init()
        self.setupStorage()
    }

    func cleanCache() {
        try? self.storage?.removeAll()
    }

    //MARK: - Private functions

    private func setupStorage() {

        let disk = DiskConfig(name: AppKey.Storage.diskConfigurationKey)
        let memory = MemoryConfig(expiry: .never, countLimit: 0, totalCostLimit: 0)
        storage = try! Storage(diskConfig: disk, memoryConfig: memory)
    }

    func token() -> String? {

        return try? self.storage?.object(ofType: String.self, forKey: AppKey.Storage.token)
    }

    func setToken(with value: String?) -> Void {

        try? self.storage?.setObject(value, forKey: AppKey.Storage.token)
    }

    func notification() -> Bool {

        if let value = try? self.storage?.object(ofType: Bool.self, forKey: AppKey.Storage.notification) {
            return  value
        }
        return false
    }

    func setNotification(with value: Bool) -> Void {

        try? self.storage?.setObject(value, forKey: AppKey.Storage.notification)
    }

    func notificationTime() -> String {

        if let value = try? self.storage?.object(ofType: String.self, forKey: AppKey.Storage.notificationTime) {
            return  value
        }
        return "09:00"
    }

    func setNotificationTime(with value: String) -> Void {

        try? self.storage?.setObject(value, forKey: AppKey.Storage.notificationTime)
    }
}
