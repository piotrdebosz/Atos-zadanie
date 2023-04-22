import Foundation

protocol LoginViewModelDelegate: AnyObject {
    func loginDidFail()
    func loginSuccessful()
}
