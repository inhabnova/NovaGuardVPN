import UIKit

enum SettingsLocalization: String, Localizable {
    case q
}

extension SettingsViewController {
    func locale(_ value: SettingsLocalization) -> String {
        value.localized
    }
}

