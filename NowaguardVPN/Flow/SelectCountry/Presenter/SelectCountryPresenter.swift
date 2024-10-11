protocol SelectCountryPresenter {
    var view: SelectCountryView! { get set }
    var coordinator: SelectCountryCoordinator! { get set }
    
    var servers: [Server]! { get }
    var selectedServer: Server { get set }
    
    func close()
    func changeServerWithoutPremium()
}

final class SelectCountryPresenterImpl {
    
    // MARK: - Public Properties
    
    weak var view: SelectCountryView!
    weak var coordinator: SelectCountryCoordinator!
    
    var selectedServer: Server// = UserDefaultsService.shared.getCurrentServer() ?? .mock
    var servers: [Server]!
    
    init(isPremium: Bool) {
        if isPremium {
            let oldServers: [Server] = UserDefaultsService.shared.getAllServers()
            var newServers: [Server] = []
            for server in oldServers {
                var newServer = server
                newServer.premium = false
                newServers.append(newServer)
            }
            servers = newServers
        } else {
            servers = UserDefaultsService.shared.getAllServers()
        }
        
        selectedServer = UserDefaultsService.shared.getCurrentServer() ?? servers.first(where: { !$0.premium})!
    }
}

// MARK: - SelectCountryPresenter

extension SelectCountryPresenterImpl: SelectCountryPresenter {

    func close() {
        coordinator.close(server: selectedServer)
    }
    
    func changeServerWithoutPremium() {
        coordinator.showPaywall()
    }
    
}

