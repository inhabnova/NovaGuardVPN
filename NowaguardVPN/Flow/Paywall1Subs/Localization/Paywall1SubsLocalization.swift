import UIKit

enum Paywall1SubsLocalization: String, Localizable {
    case q
}

extension Paywall1SubsViewController {
    func locale(_ value: Paywall1SubsLocalization) -> String {
        value.localized
    }
}

