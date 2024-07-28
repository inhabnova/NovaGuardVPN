import UIKit

enum OnboardingLocalization: String, Localizable {
    case title1
    case title2
    case title3
    case subtitle1
    case subtitle2
    case subtitle3
    case button
}

extension OnboardingViewController {
    static func locale(_ value: OnboardingLocalization) -> String {
        value.localized
    }
}

