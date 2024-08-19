protocol SelectCountryPresenter {
    var view: SelectCountryView! { get set }
    var coordinator: SelectCountryCoordinator! { get set }
    
    var servers: [Server] { get }
    var selectedServer: Server { get set }
    func close()
}

final class SelectCountryPresenterImpl {
    
    // MARK: - Public Properties
    
    weak var view: SelectCountryView!
    weak var coordinator: SelectCountryCoordinator!
    
    var selectedServer: Server = UserDefaultsService.shared.getCurrentServer() ?? .mock
    var servers: [Server] = UserDefaultsService.shared.getAllServers()
}

// MARK: - SelectCountryPresenter

extension SelectCountryPresenterImpl: SelectCountryPresenter {

    func close() {
        UserDefaultsService.shared.saveCurrentServer(server: selectedServer) 
        coordinator.close()
    }
    
}

