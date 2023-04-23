import Foundation

protocol LoginViewModelType: AnyObject {
    var delegate: LoginViewModelDelegate? { get set }

    func userPressedLoginButton(login: String, password: String)
}
