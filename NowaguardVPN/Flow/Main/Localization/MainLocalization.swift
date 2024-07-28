import UIKit

enum MainLocalization: String, Localizable {
    case q
}

extension MainViewController {
    func locale(_ value: MainLocalization) -> String {
        value.localized
    }
}

