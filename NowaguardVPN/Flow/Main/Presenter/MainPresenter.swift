protocol MainPresenter {
    var view: MainView! { get set }
    var coordinator: MainCoordinator! { get set }
    
    var selectedServer: Server { get }
    var enabledServer: Server { get }
    var isOnVPN: Bool { get set }
    
    func onViewDidLoad()
    func timer() -> String
    func showSelectCountry()
    func showSpeedTest()
    func showSettings()
}

final class MainPresenterImpl {
    
    // MARK: - Public Properties
    
    weak var view: MainView!
    weak var coordinator: MainCoordinator!
    
    var selectedServer: Server = UserDefaultsService.shared.getServer() ?? .Germany
    var enabledServer: Server = .init(hostname: "111.111.11.11", isFree: false, countryCode: "RU", location: "Russia", psk: "")
    
    var isOnVPN: Bool = false {
        didSet {
            if isOnVPN {
                view.setupOnVPN(ip: selectedServer.hostname, coyntry: selectedServer.location, timer: timer())
            } else {
                view.setupOffVPN(ip: enabledServer.hostname, coyntry: enabledServer.location)
            }
        }
    }
    
//    init(selectedServer: Server) {
//        self.selectedServer = selectedServer
//    }
}

// MARK: - MainPresenter

extension MainPresenterImpl: MainPresenter {

    func onViewDidLoad() {
        isOnVPN ? view.setupOnVPN(ip: selectedServer.hostname, coyntry: selectedServer.location, timer: timer()) :
                  view.setupOffVPN(ip: enabledServer.hostname, coyntry: enabledServer.location)
    }
    
    func timer() -> String {
        "00:01:02"
    }
    
    func showSelectCountry() {
        coordinator.showSelectCountry()
    }
    
    func showSpeedTest() {
        coordinator.showSpeedTest()
    }
    func showSettings() {
        coordinator.showSettings()
    }

}

