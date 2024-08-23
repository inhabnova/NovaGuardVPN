import KeychainSwift
import Foundation

enum KeychainService {
    
    private static let isFirstLaunchkey = "isFirstLaunch"
    
    ///при 1 запуске
    static func setIsFirstLaunch() {
        KeychainSwift().set("true", forKey: isFirstLaunchkey)
    }
    
    static func getIsFirstLaunch() -> Bool {
        if let IsFirstLaunch = KeychainSwift().get(isFirstLaunchkey) {
            return IsFirstLaunch == "true"
        } else {
            return false
        }
    }
    
//    static func reset() {
//        KeychainSwift().delete(isFirstLaunchkey)
//    }
}
