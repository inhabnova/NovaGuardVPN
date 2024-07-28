import Foundation

struct Server: Codable {
    let hostname: String
    let isFree: Bool
    let countryCode: String
    let location: String
    let psk: String
    
    static let Germany = Server(hostname: "123.123.1231.23", isFree: true, countryCode: "DE", location: "Germany", psk: "s443HqGRVqkvE6ZxUcbkjPYjH")
    static let Germany1 = Server(hostname: "123.123.1231.23", isFree: false, countryCode: "DE", location: "Germany", psk: "s443HqGRVqkvE6ZxUcbkjPYjH")
}

extension Server: Equatable {
    
}
