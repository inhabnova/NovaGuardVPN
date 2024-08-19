import UIKit
import FirebaseCore

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
        
        if false {
            appCoordinator.showVor1()
        } else if false {
            appCoordinator.showVor2()
        } else {
            appCoordinator.start()
        }

        
        return true
    }
}

