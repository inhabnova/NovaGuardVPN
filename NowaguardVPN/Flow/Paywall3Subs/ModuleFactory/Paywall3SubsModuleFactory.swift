import Foundation

struct Paywall3SubsModuleFactory {}

// MARK: - ModuleFactory

extension Paywall3SubsModuleFactory: ModuleFactory {
    
    func createModule(withCoordinator coordinator: Paywall3SubsCoordinator) -> Module<Paywall3SubsPresenter> {
        let viewController = Paywall3SubsViewController()
        viewController.presenter = Paywall3SubsPresenterImpl()
        viewController.presenter.coordinator = coordinator
        viewController.presenter.view = viewController
        return Module(view: viewController, presenter: viewController.presenter)
    }
}

