import UIKit

extension UIView {
    public func addSubviews(_ subviews: [UIView]) {
        subviews.forEach { addSubview($0) }
    }
}

import UIKit

extension UIStackView {
    func addArrangedSubviews(_ views: [UIView]) {
        views.forEach( { self.addArrangedSubview($0) } )
    }
}

extension UIAlertController {
    convenience init(error: LocalizedError, completion: (() -> Void)? = nil) {
        self.init(title: error.failureReason, message: error.errorDescription, preferredStyle: .alert)
        addAction(UIAlertAction(title: error.recoverySuggestion, style: .default) { _ in
            completion?()
        })
    }
}
