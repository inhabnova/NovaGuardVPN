//
//import Foundation
//import NetworkExtension
//import KeychainSwift
//
///*
// Base reference http://blog.moatazthenervous.com/create-a-vpn-connection-with-apple-swift/
// */
//
//protocol VPNServiceDelegate: AnyObject {
//    func didObserveVPNStatus(status: NEVPNStatus)
//    func didGetError(error: Error?)
//}
//
//final class VPNService {
//    // MARK: - Properties
//    static let shared = VPNService()
//
//    weak var delegate: VPNServiceDelegate?
//
//    private let vpnManager = NEVPNManager.shared()
//    private var serverModel: Server?
//
//    func buildConnection(server: Server) {
//        serverModel = server
//
//        setupVPNConnection()
//
//        // MARK: - Observe state
//
//        NotificationCenter.default.addObserver(
//            forName: .NEVPNStatusDidChange,
//            object: vpnManager.connection,
//            queue: nil
//        ) { _ in
//            self.delegate?.didObserveVPNStatus(status: self.vpnManager.connection.status)
//        }
//    }
//
//    func connectVPN() {
//        vpnManager.loadFromPreferences { [weak self] error in
//            if let error {
//                print("connectVPN: \(error.localizedDescription)")
//                return
//            }
//
//            self?.setupVPNConnection()
//        }
//    }
//
//    func disconnectVPN() {
//        vpnManager.connection.stopVPNTunnel()
//    }
//    
//    private func setupVPNConnection() {
//        guard let server = serverModel else {
//            return
//        }
//
//        let vpnSettings = NEVPNProtocolIPSec()
//
//        vpnSettings.username = server.location
//        vpnSettings.serverAddress = server.hostname
//        vpnSettings.authenticationMethod = .certificate
//
////        let service = KeychainService()
////        service.save(key: "shared", value: server.psk)
////        service.save(key: "vpn_password", value: server.password)
//
//        vpnSettings.sharedSecretReference = Data(server.psk.utf8)
////        vpnSettings.passwordReference = server.
//
//        vpnSettings.useExtendedAuthentication = true
//        vpnSettings.disconnectOnSleep = false
//
//        vpnManager.protocolConfiguration = vpnSettings
//        vpnManager.isEnabled = true
//
//        vpnManager.saveToPreferences { [weak self] error in
//            if let error {
//                print("Could not save VPN Configurations: \(error)")
//                self?.delegate?.didObserveVPNStatus(status: .invalid)
//                return
//            }
//
//            do {
//                try self?.vpnManager.connection.startVPNTunnel()
//            } catch let error {
//                print("Error starting VPN Connection \(error.localizedDescription)")
//            }
//        }
//    }
//}
