import UIKit

enum SelectCountryLocalization: String, Localizable {
    case select
    case country
}

extension SelectCountryViewController {
    func locale(_ value: SelectCountryLocalization) -> String {
        value.localized
    }
}

