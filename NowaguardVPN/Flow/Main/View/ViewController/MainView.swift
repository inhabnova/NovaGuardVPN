import Foundation

protocol MainView: AnyObject {
    
    func setupOnVPN(ip: String, coyntry: String, timer: String)
    func setupOffVPN(ip: String, coyntry: String)
    
}

