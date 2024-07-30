import UIKit

enum PaywallLocalization: String, Localizable {
    case title_3white
    case title_3green
    case title_1white
    case title_1green
    case subTitle1_3
    case subTitle1_1
    case button
    case pp
    case tou
    case week
    case month
    case year
    case then
    case info1_1
    case info2_1
    case info3_1
    case daysFree
}

extension PaywallViewController {
    func locale(_ value: PaywallLocalization) -> String {
        value.localized
    }
}

