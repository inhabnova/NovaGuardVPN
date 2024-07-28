protocol MainPresenter {
    var view: MainView! { get set }
    var coordinator: MainCoordinator! { get set }
    
    var selectedServer: Server { get }
    var enabledServer: Server { get }
    var isOnVPN: Bool { get set }
    
    func onViewDidLoad()
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
                view.setupOnVPN(ip: selectedServer.hostname, coyntry: selectedServer.location)
                startTimer()
            } else {
                view.setupOffVPN(ip: enabledServer.hostname, coyntry: enabledServer.location)
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
}

// MARK: - MainPresenter

extension MainPresenterImpl: MainPresenter {

    func onViewDidLoad() {
        isOnVPN ? view.setupOnVPN(ip: selectedServer.hostname, coyntry: selectedServer.location) :
                  view.setupOffVPN(ip: enabledServer.hostname, coyntry: enabledServer.location)
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

