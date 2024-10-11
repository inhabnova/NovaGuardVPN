
import Foundation

struct Localize {
    struct AlertSale {
        static let title = NSLocalizedString("Special Offer!🎁", comment: "")
        static let subtitle = NSLocalizedString("To get full access to the vpn you need to subscribe", comment: "")
        static let cancel = NSLocalizedString("Cancel", comment: "")
        static let get = NSLocalizedString("Get", comment: "")
    }
    
    struct Error {
        struct TryAgain {
            static let title =  NSLocalizedString("The device is not protected", comment: "")
            static let subtitle =  NSLocalizedString("Enable protection", comment: "")
            static let okButton =  NSLocalizedString("Try Again", comment: "")
        }
    }
    
    static let userComment = NSLocalizedString("This VPN is for people like me for simple safe connection to unknown and public wifi no other weird and confusing buttons. The connection is very fast and i have no problem using it. 👍 👍 👍", comment: "")
}

struct ProtectionError: LocalizedError {
    let title: String
    let subtitle: String
    let buttonTitle: String

    var errorDescription: String? {
        return subtitle
    }

    var failureReason: String? {
        return title
    }

    var recoverySuggestion: String? {
        return buttonTitle
    }
}
