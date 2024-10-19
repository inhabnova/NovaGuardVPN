import Foundation

struct PaywallModuleFactory {}

// MARK: - ModuleFactory

extension PaywallModuleFactory: ModuleFactory {
    
    func createModule(withCoordinator coordinator: PaywallCoordinator) -> Module<PaywallPresenter> {
        let viewController = PaywallViewController()
        let presenter = PaywallPresenterImpl()
        viewController.presenter = presenter
        viewController.presenter?.coordinator = coordinator
        viewController.presenter?.view = viewController
        return Module(view: viewController, presenter: presenter)
    }
}

