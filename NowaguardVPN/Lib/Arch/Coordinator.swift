import Foundation

public protocol Coordinator: AnyObject {
    var parentCoordinator: Coordinator? { get set }
    var childCoordinators: [Coordinator] { get set }
    
    func start()
}

// swiftlint:disable unused_setter_value
extension Coordinator {
    
    public var parentCoordinator: Coordinator? {
        get {
            return nil
        }
        set {}
    }
    
    public func addChildCoordinator(_ coordinator: Coordinator) {
        childCoordinators.append(coordinator)
    }
    
    public func removeCoordinator(_ coordinator: Coordinator) {
        childCoordinators = childCoordinators.filter { $0 !== coordinator }
    }
    
    public func removeAllCoordinators() {
        childCoordinators.removeAll()
    }
    
    public func owner(of coordinator: Coordinator) -> Coordinator? {
        
        if childCoordinators.contains(where: { $0 === coordinator }) {
            return self
        } else {
            for childCoordinator in childCoordinators {
                if let owner = childCoordinator.owner(of: coordinator) {
                    return owner
                }
            }
        }
        return nil
    }
}
