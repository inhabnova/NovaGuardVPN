import UIKit

enum SettingsLocalization: String, Localizable {
    case app
    case settings
    
    case button1
    case button2
    case button3
    case button4
    case button5
    case policy
    case contentTextPrivacy
}

extension SettingsViewController {
    func locale(_ value: SettingsLocalization) -> String {
        value.localized
    }
}

