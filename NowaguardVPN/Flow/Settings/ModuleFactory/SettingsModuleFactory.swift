import Foundation

struct SettingsModuleFactory {}

// MARK: - ModuleFactory

extension SettingsModuleFactory: ModuleFactory {
    
    func createModule(withCoordinator coordinator: SettingsCoordinator) -> Module<SettingsPresenter> {
        let viewController = SettingsViewController()
        viewController.presenter = SettingsPresenterImpl()
        viewController.presenter.coordinator = coordinator
        viewController.presenter.view = viewController
        return Module(view: viewController, presenter: viewController.presenter)
    }
}

