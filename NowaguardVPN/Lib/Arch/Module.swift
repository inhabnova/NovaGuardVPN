import UIKit

public struct Module<T> {
    public var view: UIViewController
    public var presenter: T
    public var tableDelegate: T?
    
    public init(view: UIViewController, presenter: T, tableDelegate: T? = nil) {
        self.view = view
        self.presenter = presenter
        self.tableDelegate = tableDelegate
    }
}
