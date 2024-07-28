import Foundation

struct SelectCountryModuleFactory {}

// MARK: - ModuleFactory

extension SelectCountryModuleFactory: ModuleFactory {
    
    func createModule(withCoordinator coordinator: SelectCountryCoordinator) -> Module<SelectCountryPresenter> {
        let viewController = SelectCountryViewController()
        viewController.presenter = SelectCountryPresenterImpl()
        viewController.presenter.coordinator = coordinator
        viewController.presenter.view = viewController
        return Module(view: viewController, presenter: viewController.presenter)
    }
}

