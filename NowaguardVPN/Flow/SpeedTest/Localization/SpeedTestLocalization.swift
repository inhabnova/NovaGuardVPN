import UIKit

enum SpeedTestLocalization: String, Localizable {
    case q
}

extension SpeedTestViewController {
    func locale(_ value: SpeedTestLocalization) -> String {
        value.localized
    }
}

