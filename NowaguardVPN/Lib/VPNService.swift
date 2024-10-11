import Foundation
import NetworkExtension
import KeychainSwift
import Security
import UIKit

protocol VPNServiceDelegate: AnyObject {
    func didObserveVPNStatus(status: NEVPNStatus)
    func didGetError(error: Error?)
}

final class VPNService {
    // MARK: - Properties
    static let shared: VPNService = {
        let instance = VPNService()
        instance.setup()
        return instance
    }()

    weak var delegate: VPNServiceDelegate?

    private let vpnManager = NEVPNManager.shared()
    private var serverModel: Server?

    func buildConnection(server: Server) {
        serverModel = server
        
        self.connect { errorString in
            print(errorString)
        }
//        saveAndConnect()

        // MARK: - Observe state


    }
    
    func loadProfile(callback: ((Bool)->Void)?) {
        vpnManager.protocolConfiguration = nil
        vpnManager.loadFromPreferences { error in
            if let error = error {
                NSLog("Failed to load preferences: \(error.localizedDescription)")
                callback?(false)
            } else {
                print("status - \(self.vpnManager.connection.status.rawValue)")
                callback?(self.vpnManager.protocolConfiguration != nil)
            }
        }
    }
    
    private func startVPNTunnel() -> Bool {
        do {
            try self.vpnManager.connection.startVPNTunnel()
            return true
        } catch NEVPNError.configurationInvalid {
            NSLog("Failed to start tunnel (configuration invalid)")
        } catch NEVPNError.configurationDisabled {
            NSLog("Failed to start tunnel (configuration disabled)")
        } catch {
            NSLog("Failed to start tunnel (other error)")
        }
        return false
    }

//    func connectVPN() {
//        vpnManager.loadFromPreferences { [weak self] error in
//            if let error {
//                print("connectVPN: \(error.localizedDescription)")
//                return
//            }
//
//            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(100), execute: { [weak self] in
//                do {
//                    try self?.vpnManager.connection.startVPNTunnel()
//                } catch let error {
//                    print("Error starting VPN Connection \(error.localizedDescription)")
//                }
//            })
////            self?.setupVPNConnection()
//        }
//    }
    
    private func saveProfile(callback: ((Bool)->Void)?) {
        vpnManager.saveToPreferences { error in
            self.vpnManager.saveToPreferences { error in
                if let error = error {
                    NSLog("Failed to save profile: \(error.localizedDescription)")
                    callback?(false)
                } else {
                    callback?(true)
                }
            }
//            if let error = error {
//                NSLog("Failed to save profile: \(error.localizedDescription)")
//                callback?(false)
//            } else {
//                callback?(true)
//            }
        }
    }
    
//    func saveAndConnect() {
//        self.setupVPNConnection(completion: { [weak self] in
//            self?.connectVPN()
//        })
//    }

    func disconnectVPN() {
        vpnManager.connection.stopVPNTunnel()
    }

    func connect(completion: ((String?) -> Void)?) {
        guard let server = serverModel else {
            return
        }

        let vpnSettings = NEVPNProtocolIKEv2()

        vpnSettings.remoteIdentifier = server.ip
        vpnSettings.serverAddress = server.ip
        vpnSettings.username = server.login
        vpnSettings.authenticationMethod = .sharedSecret
        
        let service = KeychainServiceVPN()
        service.save(key: "shared", value: server.psk)
        service.save(key: "vpn_password", value: server.password)

        vpnSettings.sharedSecretReference = service.load(key: "shared")
        vpnSettings.passwordReference = service.load(key: "vpn_password")

        vpnSettings.useExtendedAuthentication = false
        vpnSettings.disconnectOnSleep = false

        vpnManager.protocolConfiguration = vpnSettings
        vpnManager.isEnabled = true

        loadProfile { status in
            self.vpnManager.protocolConfiguration = vpnSettings
//            if vpnSettings.onDemand {
//                let onDemandRule = NEOnDemandRuleConnect()
//                self.manager.onDemandRules = [onDemandRule]
//                self.manager.isOnDemandEnabled = true
//            }
            self.vpnManager.isEnabled = true
            self.saveProfile { success in
                if !success {
                    completion?("Unable To Save VPN Profile")
                    return
                }
                
                self.loadProfile() { success in
                    if !success {
                        completion?("Unable To Load Profile")
                        return
                    }
                    let result = self.startVPNTunnel()
                    if !result {
                        completion?("Can't connect")
                    } else {
                        completion?(nil)
                    }
                }
            }
        }
    }
    
    func setup() {
        NotificationCenter.default.addObserver(
            forName: .NEVPNStatusDidChange,
            object: vpnManager.connection,
            queue: nil
        ) { _ in
            self.delegate?.didObserveVPNStatus(status: self.vpnManager.connection.status)
        }
        
        vpnManager.protocolConfiguration = nil
        vpnManager.loadFromPreferences { error in
            if let error = error {
                NSLog("Failed to load preferences: \(error.localizedDescription)")
            } else {
                print("status - \(self.vpnManager.connection.status.rawValue)")
            }
        }
        
    }
    
}


// Identifiers
fileprivate let serviceIdentifier = "MySerivice"
fileprivate let userAccount = "authenticatedUser"
fileprivate let accessGroup = "MySerivice"

// Arguments for the keychain queries
fileprivate var kSecAttrAccessGroupSwift = NSString(format: kSecClass)

fileprivate let kSecClassValue = kSecClass as CFString
fileprivate let kSecAttrAccountValue = kSecAttrAccount as CFString
fileprivate let kSecValueDataValue = kSecValueData as CFString
fileprivate let kSecClassGenericPasswordValue = kSecClassGenericPassword as CFString
fileprivate let kSecAttrServiceValue = kSecAttrService as CFString
fileprivate let kSecMatchLimitValue = kSecMatchLimit as CFString
fileprivate let kSecReturnDataValue = kSecReturnData as CFString
fileprivate let kSecMatchLimitOneValue = kSecMatchLimitOne as CFString
fileprivate let kSecAttrGenericValue = kSecAttrGeneric as CFString
fileprivate let kSecAttrAccessibleValue = kSecAttrAccessible as CFString

final class KeychainServiceVPN: NSObject {
    fileprivate func save(key: String, value: String) {
        let keyData: Data = key.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue), allowLossyConversion: false)!
        let valueData: Data = value.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue), allowLossyConversion: false)!

        let keychainQuery = NSMutableDictionary()
        keychainQuery[kSecClassValue as! NSCopying] = kSecClassGenericPasswordValue
        keychainQuery[kSecAttrGenericValue as! NSCopying] = keyData
        keychainQuery[kSecAttrAccountValue as! NSCopying] = keyData
        keychainQuery[kSecAttrServiceValue as! NSCopying] = "VPN"
        keychainQuery[kSecAttrAccessibleValue as! NSCopying] = kSecAttrAccessibleAlwaysThisDeviceOnly
        keychainQuery[kSecValueData as! NSCopying] = valueData
        // Delete any existing items
        SecItemDelete(keychainQuery as CFDictionary)
        SecItemAdd(keychainQuery as CFDictionary, nil)
    }

    fileprivate func load(key: String) -> Data {
        let keyData: Data = key.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue), allowLossyConversion: false)!
        let keychainQuery = NSMutableDictionary()
        keychainQuery[kSecClassValue as! NSCopying] = kSecClassGenericPasswordValue
        keychainQuery[kSecAttrGenericValue as! NSCopying] = keyData
        keychainQuery[kSecAttrAccountValue as! NSCopying] = keyData
        keychainQuery[kSecAttrServiceValue as! NSCopying] = "VPN"
        keychainQuery[kSecAttrAccessibleValue as! NSCopying] = kSecAttrAccessibleAlwaysThisDeviceOnly
        keychainQuery[kSecMatchLimit] = kSecMatchLimitOne
        keychainQuery[kSecReturnPersistentRef] = kCFBooleanTrue

        var result: AnyObject?
        let status = withUnsafeMutablePointer(to: &result) { SecItemCopyMatching(keychainQuery, UnsafeMutablePointer($0)) }

        if status == errSecSuccess {
            if let data = result as! NSData? {
                if let value = NSString(data: data as Data, encoding: String.Encoding.utf8.rawValue) {
                }
                return data as Data
            }
        }
        return "".data(using: .utf8)!
    }
}
