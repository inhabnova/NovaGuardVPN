import UIKit

enum MainLocalization: String, Localizable {
    case label1on
    case label1off
    case label2
    case label3on
    case label3off
    case label4on
    case label4off
}

extension MainViewController {
    func locale(_ value: MainLocalization) -> String {
        value.localized
    }
}

