import UIKit
import BranchSDK
import FirebaseCore
import FirebaseRemoteConfigInternal

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
        
        FirebaseApp.configure()
        Task {
            let keys = await loadKeys()
            appCoordinator.delayCross = await loadDelayCross()
            
            // Инициализация Branch SDK
            Branch.getInstance().initSession(launchOptions: launchOptions) { (params, error) in
                if let error = error {
                    print("Branch initialization error: \(error.localizedDescription)")
                    self.appCoordinator.start()
                    return
                }
                
                NetworkManager.shared.sendEvent(event: .install, productId: nil, afData: params as? [String: String]) { result in
                    switch result {
                    case .success(let success):
                        print(success)
                    case .failure(let failure):
                        print(failure)
                        self.appCoordinator.start()
                    }
                }
                
                if let params = params as? [String: AnyObject] {
                    // получениe данных из params
                    if let referrer = params["appkey"] as? String {
                        print("Referrer: \(referrer)")
                        
                        if referrer == keys[1] {
                            self.appCoordinator.showVor1()
                        } else if referrer == keys[2] {
                            self.appCoordinator.showVor2()
                        } else {
                            self.appCoordinator.start()
                        }
                        
                    } else {
                        self.appCoordinator.start()
                    }
                    
                }
            }
        }
        
                
        if appCoordinator.isFirstLaunch {
            NetworkManager.shared.getServers { [weak self] result in
                switch result {
                case .success(let success):
                    UserDefaultsService.shared.saveAllServer(server: success)
                case .failure(let failure):
                    print(failure)
                }
            }
        }
        
//        if false {
//            appCoordinator.showVor1()
//        } else if true {
//            appCoordinator.showVor2()
//        } else {
//            appCoordinator.start()
//        }

        
        return true
    }
}

private extension AppDelegate {
    @MainActor
    func loadKeys() async -> [String] {
        do {
            let remoteConfig = RemoteConfig.remoteConfig()
            let status = try await remoteConfig.fetch(withExpirationDuration: 0)
            
            if status == .success {
                try await remoteConfig.activate()
                
                let key1 = remoteConfig.configValue(forKey: "appkey1").stringValue
                let key2 = remoteConfig.configValue(forKey: "appkey2").stringValue
                return [key1, key2]
            }
        } catch {
            print("error load remote")
        }
        return []
    }
    
    @MainActor
    func loadDelayCross() async -> Int? {
        do {
            let remoteConfig = RemoteConfig.remoteConfig()
            let status = try await remoteConfig.fetch(withExpirationDuration: 0)
            
            if status == .success {
                try await remoteConfig.activate()
                
                let delay = remoteConfig.configValue(forKey: "crossDelay").numberValue as? Int
                return delay
            }
        } catch {
            print("error load remote")
        }
        return nil
    }
}
