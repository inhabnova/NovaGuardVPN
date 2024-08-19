import Foundation

final class UserDefaultsService {
    
    static let shared = UserDefaultsService()
    private init() {}
    
    private let defaults = UserDefaults.standard
    private let ServerKey = "selectServer"
    private let allServerKey = "allServerKey"
    
    func getCurrentServer() -> Server? {
        if let data = defaults.data(forKey: ServerKey) {
            do {
                let decodedData = try JSONDecoder().decode(Server.self, from: data)
                return decodedData
            } catch {
                print(error)
                return nil
            }
        } else {
            return nil
        }
    }
    
    func saveAllServer(server: [Server]) {
        if let encodedData = try? JSONEncoder().encode(server) {
            defaults.set(encodedData, forKey: allServerKey)
        }
    }
    
    func getAllServers() -> [Server] {
        if let data = defaults.data(forKey: allServerKey) {
            do {
                let decodedData = try JSONDecoder().decode([Server].self, from: data)
                return decodedData
            } catch {
                print(error)
                return []
            }
        } else {
            return []
        }
    }
    
    func saveCurrentServer(server: Server?) {
        if let encodedData = try? JSONEncoder().encode(server) {
            defaults.set(encodedData, forKey: ServerKey)
        }
    }
}
