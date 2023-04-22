import UIKit

class AccountViewController: UIViewController {
    private let accountView = AccountView()
    private let viewModel: AccountViewModelType

    override func loadView() {
        view = accountView
    }

    init(viewModel: AccountViewModelType) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = viewModel.userName
        navigationController?.navigationBar.applyAtosStyling()

        accountView.avatarImageView.image = UIImage(named: viewModel.avatarName)
        accountView.usernameLabel.text = viewModel.userName
        accountView.lastLoginLabel.text = viewModel.lastLogin
    }
}
