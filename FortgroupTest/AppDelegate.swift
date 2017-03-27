//
//  AppDelegate.swift
//  FortgroupTest
//
//  Created by Dmitry Rybochkin on 25.03.17.
//  Copyright © 2017 Dmitry Rybochkin. All rights reserved.
//

/*
 Необходимо создать iOS-приложение, которое на основе данных из JSON файлов:
 http://fgsoft.ru/upload/api/materialjson/file_1.json
 http://fgsoft.ru/upload/api/materialjson/file_2.json и т.д.
 Последний файл http://fgsoft.ru/upload/api/materialjson/file_10.json
 
 Будет:
 1. Забирать с сервера списки;
 2. Кешировать (работа в офлайн режиме);
 3. Выводить (Пример контакты в приложении Телеграмм: элемент списка с картинкой, заголовок, кнопка, 
    элемент списка состоящий из трёх кнопок каждая занимает 1/3 от ширины экрана);
 4. Проверять обновление;
 
 По желанию:
 5. Динамическая подгрузка списка, при прокрутке до конца экрана
 
 */

import UIKit

/*Периодичность проверки обновлений*/
let timeItervalCheckews = 1000

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var timer: Timer?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        _ = DataManager.sharedManager

        timer = Timer.init(timeInterval: TimeInterval(timeItervalCheckews), repeats: true, block: { (_: Timer) in
            print("send timer load data")
            NotificationCenter.default.post(name: Notification.Name.FortgroupTestDataLoad, object: nil)
        })
        RunLoop.main.add(timer!, forMode: RunLoopMode.commonModes)
        timer?.fire()

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }

}
