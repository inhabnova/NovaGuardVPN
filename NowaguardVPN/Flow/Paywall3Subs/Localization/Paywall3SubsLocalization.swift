import UIKit

enum Paywall3SubsLocalization: String, Localizable {
    case q
}

extension Paywall3SubsViewController {
    func locale(_ value: Paywall3SubsLocalization) -> String {
        value.localized
    }
}

