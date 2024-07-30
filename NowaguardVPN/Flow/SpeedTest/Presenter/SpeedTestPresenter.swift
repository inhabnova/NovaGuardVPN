enum SpeedTestState {
    case notTest
    case inProgress(download: String, upload: String)
    case finishTest(download: String, upload: String)
}

protocol SpeedTestPresenter {
    var view: SpeedTestView! { get set }
    var coordinator: SpeedTestCoordinator! { get set }
    
    var selectedServer: Server { get set }
//    var state: SpeedTestState { get set }
    
    func showMain()
    func showSettings()
    func buttonAction()
}

final class SpeedTestPresenterImpl {
    
    // MARK: - Public Properties
    
    weak var view: SpeedTestView!
    weak var coordinator: SpeedTestCoordinator!
    
    var selectedServer: Server = UserDefaultsService.shared.getServer() ?? .Germany
    
    private var state: SpeedTestState = .notTest
}

// MARK: - SpeedTestPresenter

extension SpeedTestPresenterImpl: SpeedTestPresenter {

    func showMain() {
        coordinator.showMain()
    }
    
    func showSettings() {
        coordinator.showSettings()
    }
    
    func buttonAction() {
        switch self.state {
        case .notTest:
            state = .inProgress(download: "20", upload: "30")
            view.updateView(state: state)
        case .inProgress(download: let download, upload: let upload):
            state = .finishTest(download: "20", upload: "30")
            view.updateView(state: state)
        case .finishTest(download: let download, upload: let upload):
            state = .inProgress(download: "20", upload: "30")
            view.updateView(state: state)
        }
    }
}

