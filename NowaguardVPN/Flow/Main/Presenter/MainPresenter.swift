import NetworkExtension
protocol MainPresenter: VPNServiceDelegate {
    var view: MainView! { get set }
    var coordinator: MainCoordinator! { get set }
    
    var selectedServer: Server { get }
    var vpnService: VPNService { get }
    
    func buttonAction()
    func onViewDidLoad()
    func showSelectCountry()
    func showSpeedTest()
    func showSettings()
}

final class MainPresenterImpl {
    
    // MARK: - Public Properties
    
    weak var view: MainView!
    weak var coordinator: MainCoordinator!
    
    var selectedServer: Server = UserDefaultsService.shared.getCurrentServer() ?? .mock
    var vpnService: VPNService = .shared
    
    private var isOnVPN: Bool = false {
        didSet {
            if isOnVPN {
                view.setupOnVPN(ip: selectedServer.ip, coyntry: selectedServer.name)

                startTimer()
            } else {
                view.setupOffVPN(ip: selectedServer.ip, coyntry: selectedServer.name)
                stopTimer()
            }
        }
    }
    
    private func startTimer() {
        TimerService.shared.startTimer(timeString: "00:00:00") { [weak self] result in
            switch result {
            case .error(let string):
                print(string)
            case .inProgress(let string):
                self?.view.updateTimer(value: string)
            case .finish:
                break
            }
        }
    }
    
    private func stopTimer() {
        TimerService.shared.stopTimer()
    }
    
    init() {
        vpnService.delegate = self
    }
}

// MARK: - MainPresenter

extension MainPresenterImpl: MainPresenter {
    
    func buttonAction() {
        vpnService.buildConnection(server: selectedServer)
    }

    func onViewDidLoad() {
        isOnVPN ? view.setupOnVPN(ip: selectedServer.ip, coyntry: selectedServer.name) :
                  view.setupOffVPN(ip: selectedServer.ip, coyntry: selectedServer.name)
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

// MARK: - VPNServiceDelegate

extension MainPresenterImpl: VPNServiceDelegate {
    
    func didObserveVPNStatus(status: NEVPNStatus) {
        switch status {
        case .connected:
            isOnVPN = true
        default:
            isOnVPN = false
        }
    }
    
    func didGetError(error: (any Error)?) {
        isOnVPN = false
        print(" didGetError: " + "\(error)")
    }
}
