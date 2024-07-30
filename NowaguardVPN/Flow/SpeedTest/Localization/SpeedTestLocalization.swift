import UIKit

enum SpeedTestLocalization: String, Localizable {
    case speed
    case test
    case button
    case buttonStop
    case buttonAgain
    case button1
    case button2
    case button3
    case upload
    case download
    case perSec
}

extension SpeedTestViewController {
    func locale(_ value: SpeedTestLocalization) -> String {
        value.localized
    }
}

