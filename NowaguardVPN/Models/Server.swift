import Foundation

struct Server: Codable {
    let id: Int
    let country, name, ip, login: String
    let password, psk: String
    var premium: Bool
    
//    static let mock: Server = .init(id: -1, country: "Mock", name: "Mock", ip: "12345676", login: "", password: "", psk: "", premium: false)
//    static let mock1: Server = .init(id: -2, country: "Mock1", name: "Mock1", ip: "qqqqqqqqqqqq", login: "", password: "", psk: "", premium: true)
}

extension Server: Equatable { }
