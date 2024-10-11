import Foundation

public protocol Localizable {
    var localized: String { get }
    func localized(args: CVarArg...) -> String
}

public extension Localizable where Self: RawRepresentable {
    
    var localized: String {
        getString(for: self.rawValue as! String)
    }
    
    func localized(args: CVarArg...) -> String {
        String(format: localized, args)
    }

    private func getString(for key: String) -> String {
        return Bundle.main.localizedString(forKey: key, value: nil, table: String(describing: type(of: self)))
    }
}

extension String {
    
    var localized: String {
        return NSLocalizedString(self, comment: self)
    }
    
}
