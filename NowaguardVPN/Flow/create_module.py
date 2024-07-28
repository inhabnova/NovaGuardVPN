import os
import subprocess
import random
import string
from datetime import datetime

def generate_random_id(length=10):
    return ''.join(random.choice(string.ascii_uppercase + string.digits) for _ in range(length))


module_name = input("Введите имя модуля: ")
current_date = datetime.now().strftime('%d.%m.%Y') 
viewController_id = generate_random_id()

file_to_folder_mapping = {
    f"{module_name}Coordinator.swift": "Coordinator",
    f"{module_name}ModuleFactory.swift": "ModuleFactory",
    f"{module_name}Presenter.swift": "Presenter",
    f"{module_name}ViewController.swift": os.path.join("View", "ViewController"),
    f"{module_name}View.swift": os.path.join("View", "ViewController"),
    f"{module_name}Localization.swift": "Localization",
    f"{module_name}Localization.strings": "Localization"
}

file_names = [
    f"{module_name}Coordinator.swift",
    f"{module_name}ModuleFactory.swift",
    f"{module_name}Presenter.swift",
    f"{module_name}ViewController.swift",
    f"{module_name}View.swift",
    f"{module_name}Localization.swift",
    f"{module_name}Localization.strings"
]

coordinator_content = f"""import UIKit

protocol {module_name}Coordinator: Coordinator {{
    var rootViewController: UIViewController {{ get }}
}}

final class {module_name}CoordinatorImpl {{

    // MARK: - Public Properties

    var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    var rootViewController: UIViewController {{
        viewController
    }}
    
    // MARK: - Private

    var viewController: UIViewController!
    
    // MARK: - Dependency

    private let moduleFactory: {module_name}ModuleFactory
    
    // MARK: - Init

    init(moduleFactory: {module_name}ModuleFactory) {{
        self.moduleFactory = moduleFactory
    }}
    
    convenience init() {{
        self.init(moduleFactory: {module_name}ModuleFactory())
    }}
}}

// MARK: - {module_name}Coordinator

extension {module_name}CoordinatorImpl: {module_name}Coordinator {{

    func start() {{
        let module = moduleFactory.createModule(withCoordinator: self)
        viewController = module.view
    }}
}}
"""

presenter_content = f"""protocol {module_name}Presenter {{
    var view: {module_name}View! {{ get set }}
    var coordinator: {module_name}Coordinator! {{ get set }}
}}

final class {module_name}PresenterImpl {{
    
    // MARK: - Public Properties
    
    weak var view: {module_name}View!
    weak var coordinator: {module_name}Coordinator!
}}

// MARK: - {module_name}Presenter

extension {module_name}PresenterImpl: {module_name}Presenter {{

    
}}

"""

moduleFactory_content = f"""import Foundation

struct {module_name}ModuleFactory {{}}

// MARK: - ModuleFactory

extension {module_name}ModuleFactory: ModuleFactory {{
    
    func createModule(withCoordinator coordinator: {module_name}Coordinator) -> Module<{module_name}Presenter> {{
        let viewController = {module_name}ViewController()
        viewController.presenter = {module_name}PresenterImpl()
        viewController.presenter.coordinator = coordinator
        viewController.presenter.view = viewController
        return Module(view: viewController, presenter: viewController.presenter)
    }}
}}

"""

viewController_content = f"""import UIKit

final class {module_name}ViewController: UIViewController {{

    // MARK: - UI Elements

    // MARK: - Public Properties
    
    var presenter: {module_name}Presenter!
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {{
        super.viewDidLoad()
        layoutSetup()
        setupConstraints()
    }}
}}

// MARK: - {module_name}View

extension {module_name}ViewController: {module_name}View {{

}}

// MARK: - Layout Setup

private extension {module_name}ViewController {{
    func layoutSetup() {{
    
    }}
}}

// MARK: - Setup Constraints

private extension {module_name}ViewController {{
    func setupConstraints() {{
    
    }}
}}


"""

view_content = f"""import Foundation

protocol {module_name}View: AnyObject {{
}}

"""

localization_swift_content = f"""import UIKit

enum {module_name}Localization: String, Localizable {{
}}

extension {module_name}ViewController {{
    func locale(_ value: {module_name}Localization) -> String {{
        value.localized
    }}
}}

"""

localization_string_content = f""" """

contents = {
    f"{module_name}Coordinator.swift": coordinator_content,
    f"{module_name}Presenter.swift": presenter_content,
    f"{module_name}ModuleFactory.swift": moduleFactory_content,
    f"{module_name}ViewController.swift": viewController_content,
    f"{module_name}View.swift": view_content,
    f"{module_name}Localization.swift": localization_swift_content,
    f"{module_name}Localization.strings": localization_string_content,
}

os.makedirs(module_name, exist_ok=True)
for filename, folder in file_to_folder_mapping.items():
    file_path = os.path.join(module_name, filename)
    
    if filename != f"{module_name}Coordinator.swift":
        folder_path = os.path.join(module_name, folder)
        os.makedirs(folder_path, exist_ok=True)
        file_path = os.path.join(folder_path, filename)
    
    with open(file_path, 'w') as f:
        f.write(contents.get(filename, ''))


module_folder_absolute_path = os.path.abspath(os.path.join(".", module_name))
project_path = "../../NowaguardVPN.xcodeproj"
os.system(f"ruby add_module.rb {module_name} {project_path} {module_folder_absolute_path}")
