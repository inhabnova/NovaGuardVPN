import Foundation

struct MainModuleFactory {}

// MARK: - ModuleFactory

extension MainModuleFactory: ModuleFactory {
    
    func createModule(withCoordinator coordinator: MainCoordinator) -> Module<MainPresenter> {
        let viewController = MainViewController()
        viewController.presenter = MainPresenterImpl()
        viewController.presenter.coordinator = coordinator
        viewController.presenter.view = viewController
        return Module(view: viewController, presenter: viewController.presenter)
    }
}

