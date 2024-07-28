import UIKit

final class SettingsViewController: UIViewController {

    // MARK: - UI Elements

    // MARK: - Public Properties
    
    var presenter: SettingsPresenter!
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutSetup()
        setupConstraints()
    }
}

// MARK: - SettingsView

extension SettingsViewController: SettingsView {

}

// MARK: - Layout Setup

private extension SettingsViewController {
    func layoutSetup() {
    
    }
}

// MARK: - Setup Constraints

private extension SettingsViewController {
    func setupConstraints() {
    
    }
}


