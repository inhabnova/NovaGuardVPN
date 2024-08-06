import Foundation


protocol VorDelegate: AnyObject {
    func didFinish()
}

final class VorPresenter {
    var delegate: VorDelegate
    
    init(delegate: VorDelegate) {
        self.delegate = delegate
    }
}
