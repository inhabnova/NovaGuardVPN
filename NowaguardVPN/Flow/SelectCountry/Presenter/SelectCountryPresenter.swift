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
    
    var selectedServer: Server = UserDefaultsService.shared.getServer() ?? .Germany
    var servers: [Server] = [.Germany, .Germany1, .USSR, .Germany, .Germany1, .USSR, .Germany, .Germany1, .USSR, .Germany, .Germany1, .USSR, .Germany, .Germany1, .USSR, .Germany, .Germany1, .USSR, .Germany, .Germany1, .USSR, .Germany, .Germany1, .USSR, .Germany, .Germany1, .USSR]
}

// MARK: - SelectCountryPresenter

extension SelectCountryPresenterImpl: SelectCountryPresenter {

    func close() {
        UserDefaultsService.shared.saveServer(server: selectedServer) 
        coordinator.close()
    }
    
}

