//
//  AppDelegate.swift
//  NowaguardVPN
//
//  Created by Иван Климов on 26.07.2024.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    // MARK: - Private Properties
    
    private lazy var appCoordinator: ApplicationCoordinator = {
        window = UIWindow()
        let coordinator = ApplicationCoordinatorImpl(window: window)
        return coordinator
    }()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
        if false {
            appCoordinator.showVor1()
        } else if true {
            appCoordinator.showVor2()
        } else {
            appCoordinator.start()
        }

        
        return true
    }
}

