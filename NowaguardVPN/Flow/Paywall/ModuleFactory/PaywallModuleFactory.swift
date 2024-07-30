import Foundation

struct PaywallModuleFactory {}

// MARK: - ModuleFactory

extension PaywallModuleFactory: ModuleFactory {
    
    func createModule(withCoordinator coordinator: PaywallCoordinator) -> Module<PaywallPresenter> {
        let viewController = PaywallViewController()
        viewController.presenter = PaywallPresenterImpl()
        viewController.presenter.coordinator = coordinator
        viewController.presenter.view = viewController
        return Module(view: viewController, presenter: viewController.presenter)
    }
}

