import Foundation

final class UserDefaultsService {
    
    static let shared = UserDefaultsService()
    private init() {}
    
    private let defaults = UserDefaults.standard
    private let ServerKey = "selectServer"
    
    
    func getServer() -> Server? {
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
    
    func saveServer(server: Server?) {
        if let encodedData = try? JSONEncoder().encode(server) {
            defaults.set(encodedData, forKey: ServerKey)
        }
    }
}
