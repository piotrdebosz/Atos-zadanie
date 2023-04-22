import UIKit

// CastView is used to easily call custom view in UIViewController
// without the need to cast to the right type everytime
//
protocol CastView {
    associatedtype CastView: UIView

    var castView: CastView { get }
}

extension CastView where Self: UIViewController {
    var castView: CastView {
        guard let castView = view as? CastView else {
            fatalError("Couldn't find proper view")
        }
        return castView
    }
}
