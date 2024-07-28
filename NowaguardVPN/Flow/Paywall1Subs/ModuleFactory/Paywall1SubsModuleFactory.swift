import Foundation

struct Paywall1SubsModuleFactory {}

// MARK: - ModuleFactory

extension Paywall1SubsModuleFactory: ModuleFactory {
    
    func createModule(withCoordinator coordinator: Paywall1SubsCoordinator) -> Module<Paywall1SubsPresenter> {
        let viewController = Paywall1SubsViewController()
        viewController.presenter = Paywall1SubsPresenterImpl()
        viewController.presenter.coordinator = coordinator
        viewController.presenter.view = viewController
        return Module(view: viewController, presenter: viewController.presenter)
    }
}

