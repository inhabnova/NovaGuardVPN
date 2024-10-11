import Foundation

protocol MainView: AnyObject {
    
    func changeServer(ip: String, coyntry: String)
    func setupOnVPN(ip: String, coyntry: String)
    func setupOffVPN(ip: String, coyntry: String)
    func updateTimer(value: String)
    
}

