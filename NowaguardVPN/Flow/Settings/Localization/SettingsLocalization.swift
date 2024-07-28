import UIKit

enum SettingsLocalization: String, Localizable {
    case app
    case settings
}

extension SettingsViewController {
    func locale(_ value: SettingsLocalization) -> String {
        value.localized
    }
}

