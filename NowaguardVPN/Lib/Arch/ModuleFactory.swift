import Foundation

public protocol ModuleFactory {
    associatedtype CoordinatorFlow
    associatedtype ModuleType
    
    func createModule(withCoordinator coordinator: CoordinatorFlow) -> Module<ModuleType>
}
