import Foundation

struct SpeedTestModuleFactory {}

// MARK: - ModuleFactory

extension SpeedTestModuleFactory: ModuleFactory {
    
    func createModule(withCoordinator coordinator: SpeedTestCoordinator) -> Module<SpeedTestPresenter> {
        let viewController = SpeedTestViewController()
        viewController.presenter = SpeedTestPresenterImpl()
        viewController.presenter.coordinator = coordinator
        viewController.presenter.view = viewController
        return Module(view: viewController, presenter: viewController.presenter)
    }
}

