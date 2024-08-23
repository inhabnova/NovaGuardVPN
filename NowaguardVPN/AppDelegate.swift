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
            appCoordinator.idPurchaseAfterOnboarding = await loadIdPurchaseAfterOnboarding()
            appCoordinator.allIdPuechase = await loadIdPurchases()
            
            for id in appCoordinator.allIdPuechase ?? [] {
                if await checkSubscriptionStatus(productID: id) {
                    appCoordinator.isPremium = true
                }
            }
            
            // Инициализация Branch SDK
            Branch.getInstance().initSession(launchOptions: launchOptions) { (params, error) in
                if let error = error {
                    print("Branch initialization error: \(error.localizedDescription)")
//                    self.appCoordinator.start()
                    return
                }
                if self.appCoordinator.isFirstLaunch {
                    NetworkManager.shared.sendEvent(event: .install, productId: nil, afData: params as? [String: String]) { result in
                        switch result {
                        case .success(let success):
                            print(success)
                        case .failure(let failure):
                            print(failure)
                        }
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
                            return
                        }
                        
                    } else {
                        self.appCoordinator.start()
                        return
                    }
                    
                }
            }
        }
        
                
//        if appCoordinator.isFirstLaunch {
            NetworkManager.shared.getServers { result in
                switch result {
                case .success(let success):
                    UserDefaultsService.shared.saveAllServer(server: success)
                case .failure(let failure):
                    print(failure)
                }
            }
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
    
    @MainActor
    func loadIdPurchaseAfterOnboarding() async -> String? {
        do {
            let remoteConfig = RemoteConfig.remoteConfig()
            let status = try await remoteConfig.fetch(withExpirationDuration: 0)
            
            if status == .success {
                try await remoteConfig.activate()
                
                let delay = remoteConfig.configValue(forKey: "idPurchaseAfterOnboarding").stringValue
                return delay
            }
        } catch {
            print("error load remote")
        }
        return nil
    }
    
    @MainActor
    func loadIdPurchases() async -> [String]? {
        do {
            let remoteConfig = RemoteConfig.remoteConfig()
            let status = try await remoteConfig.fetch(withExpirationDuration: 0)
            
            if status == .success {
                try await remoteConfig.activate()
                
                guard let data = remoteConfig.configValue(forKey: "purshases").jsonValue as? [String: Any] else {
                    return []
                }
                var purshasesID: [String?] = [nil, nil, nil]
                
                for purshase in data {
                    if let dict = purshase.value as? [String: Any],
                       let id = dict["Product ID"] as? String {
                        switch purshase.key {
                        case "week":
                            purshasesID[0] = id
                        case "month":
                            purshasesID[1] = id
                        case "year":
                            purshasesID[2] = id
                        default:
                            break
                        }
                    }
                    
                }
                
                return purshasesID.compactMap { $0 }
            }
        } catch {
            print("error load remote")
        }
        return nil
    }
    
    func checkSubscriptionStatus(productID: String) async -> Bool {
        do {
            // Получаем последнюю транзакцию для указанного продукта
            if let transaction = try await Transaction.latest(for: productID) {
                // Проверяем, если транзакция верифицирована и подписка активна
                if case .verified(let verifiedTransaction) = transaction {
                    if let expirationDate = verifiedTransaction.expirationDate {
                        return expirationDate > Date()
                    }
                }
            }
            return false // Подписка не активна или транзакция не найдена
        } catch {
            print("Ошибка при проверке статуса подписки: \(error.localizedDescription)")
            return false
        }
    }
}
