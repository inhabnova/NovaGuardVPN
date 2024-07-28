import UIKit

enum SpeedTestLocalization: String, Localizable {
    case speed
    case test
}

extension SpeedTestViewController {
    func locale(_ value: SpeedTestLocalization) -> String {
        value.localized
    }
}

