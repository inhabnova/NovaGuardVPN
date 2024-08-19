import Foundation

struct Server: Codable {
    let id: Int
    let country, name, ip, login: String
    let password, psk: String
    let premium: Bool
    
    static let mock: Server = .init(id: -1, country: "Mock", name: "Mock", ip: "12345676", login: "", password: "", psk: "", premium: false)
}

extension Server: Equatable { }
