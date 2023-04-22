import UIKit

// This protocol allows to easily show alert in any viewController
// that implements it
//
protocol Alertable: AnyObject {
    func showAlertWithMessage(title: String?, message: String?)
    func showAlertWithError(_ error: Error)
}

extension Alertable where Self: UIViewController {
    func showAlertWithMessage(title: String?, message: String?) {
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)

        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )

        alertController.addAction(okAction)

        present(alertController, animated: true, completion: nil)
    }

    func showAlertWithError(_ error: Error) {
        showAlertWithMessage(title: "Error", message: error.localizedDescription)
    }
}
