import UIKit
import BranchSDK
import FirebaseCore
import FirebaseRemoteConfigInternal
import SkarbSDK

class AnalyticsValues {
    static var appKey: String?
    static var mediaSource: String?
    static var afStatus: String?
    static var isFirstLaunch: Bool?
    static var planForOnboarding: [SKProduct]?
    static var isFirstLaunchFlag: Bool?
    static var conversionInfo: [AnyHashable: Any]?
    static var planForPromo: SKProduct?
    static var planForPromoFlow: SKProduct?
    static var planForThreelong: SKProduct?
}


@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    // MARK: - Private Properties
    
    var isDeeplinkOpened: Bool = false
    var isAppActive: Bool = false
    var isDataConversionSended: Bool = false
    
    private lazy var appCoordinator: ApplicationCoordinator = {
        window = UIWindow()
        let coordinator = ApplicationCoordinatorImpl(window: window)
        return coordinator
    }()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        SkarbSDK.initialize(clientId: "nova", isObservable: true)

        Task {
            let keys = await loadKeys()
            appCoordinator.delayCross = await loadDelayCross()
            appCoordinator.funnels = await loadFunnels()
            appCoordinator.idPurchaseAfterOnboarding = await loadIdPurchaseAfterOnboarding()
            appCoordinator.allIdPuechase = await loadIdPurchases()
            
            for id in appCoordinator.allIdPuechase ?? [] {
                if await checkSubscriptionStatus(productID: id) {
                    appCoordinator.isPremium = true
                }
            }
            
            #if DEBUG
                Branch.setUseTestBranchKey(true)
                Branch.setBranchKey("key_test_jxgS2ppvSZ81cP08lvXI4dpdDwo3zAsk")
            #endif
            // Инициализация Branch SDK
            Branch.getInstance().initSession(launchOptions: launchOptions) { (params, error) in
                
                if let error = error {
                    print("Branch initialization error: \(error.localizedDescription)")
//                    self.appCoordinator.start()
                    return
                }
                
                
                if let params = params as? [String: AnyObject] {
                    let appsFlyerFormatData = SkarbSDK.convertConversionInfoToAppsFlyerFormat(params)
                    if self.isDataConversionSended == false {
                        SkarbSDK.sendSource(broker: .appsflyer, features: appsFlyerFormatData, brokerUserID: nil)
                        AnalyticsValues.conversionInfo = appsFlyerFormatData
                        self.isDataConversionSended = true
                    }
                }

                
                if self.isAppActive == true {
                    return
                }
                
                guard self.isDeeplinkOpened == false else {
                    return
                }
                                
                if self.appCoordinator.isLastLaunch == false {
                    let parameters = AnalyticsValues.conversionInfo
                    NetworkManager.shared.sendEvent(
                        event: .install,
                        productId: nil,
                        afData: parameters) { result in
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
                    var params = params
//                    params["appkey"] = "2" as AnyObject
                    
                    if let referrer = params["appkey"] as? String {
                        print("Referrer: \(referrer)")
                        
                        if keys.contains(referrer), referrer == "checkFlow", let checkFlow = self.appCoordinator.funnels?.checkFlow, UserDefaultsService.shared.isFunnelShowed == false {
                            self.isDeeplinkOpened = true
                            UserDefaultsService.shared.isFunnelShowed = true
                            self.appCoordinator.showFunnel(type: .flow1(model: checkFlow))
                            SkarbSDK.sendTest(name: "checkFlow", group: "")
                        } else if keys.contains(referrer), referrer == "scanFlow", let scanFlow = self.appCoordinator.funnels?.scanFlow, UserDefaultsService.shared.isFunnelShowed == false {
                            self.isDeeplinkOpened = true
                            UserDefaultsService.shared.isFunnelShowed = true
                            SkarbSDK.sendTest(name: "scanFlow", group: "")
                            self.appCoordinator.showFunnel(type: .flow2(model: scanFlow))
                        } else {
                            self.appCoordinator.start()
                            self.isAppActive = true
                            SkarbSDK.sendTest(name: "organic", group: "")
                            return
                        }
                        
                    } else {
                        self.appCoordinator.start()
                        self.isAppActive = true

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

struct Funnels {
    var scanFlow: FunnelModel?
    var checkFlow: FunnelModel?
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
    func loadFunnels() async -> Funnels? {
        do {
            let remoteConfig = RemoteConfig.remoteConfig()
            let status = try await remoteConfig.fetch(withExpirationDuration: 0)

            if status == .success {
                try await remoteConfig.activate()
                
                let decoder = JSONDecoder()
                let languageCode = Locale.current.languageCode ?? "en"
                
                let funnelScanFlowDataValue = remoteConfig.configValue(forKey: "scan_flow_\(languageCode)").dataValue
                let funnelCheckFlowDataValue = remoteConfig.configValue(forKey: "check_flow_\(languageCode)").dataValue
                
                let funnelScanFlow: FunnelModel? = try? decoder.decode(FunnelModel.self, from: funnelScanFlowDataValue)
                let funnelCheckFlow: FunnelModel? = try? decoder.decode(FunnelModel.self, from: funnelCheckFlowDataValue)
                
                let funnels = Funnels(scanFlow: funnelScanFlow, checkFlow: funnelCheckFlow)
                return funnels
            }

        } catch {
            print("error load remote")
        }
        
        return nil
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
