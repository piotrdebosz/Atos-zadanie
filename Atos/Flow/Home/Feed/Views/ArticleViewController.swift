import UIKit

// TODO: change name to ArticleDetail
class ArticleViewController: UIViewController, CastView, Alertable {
    typealias CastView = ArticleView

    private let viewModel: ArticleViewModelType

    init(viewModel: ArticleViewModelType) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)

        self.viewModel.delegate = self
    }

    override func loadView() {
        view = ArticleView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = viewModel.authorText

        updateUI()

        viewModel.viewDidLoad()
    }

    private func updateUI() {
        castView.authorLabel.text = viewModel.authorText
        castView.titleLabel.text = viewModel.titleText
        castView.descriptionLabel.text = viewModel.descriptionText
        castView.publishedAtLabel.text = viewModel.publishedAtText
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ArticleViewController: ArticleViewModelDelegate {
    func didChangeImageLoadingState(isLoading: Bool) {
        castView.imageView.setLoading(isLoading: isLoading)
    }

    func didLoadImage(imageData: Data) {
        let image = UIImage(data: imageData)
        castView.imageView.image = image
    }
}
