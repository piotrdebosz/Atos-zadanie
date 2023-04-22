import UIKit

class ArticleViewController: UIViewController, Alertable {
    private let viewModel: ArticleViewModelType
    private let articleView = ArticleView()

    init(viewModel: ArticleViewModelType) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)

        self.viewModel.delegate = self
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = articleView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = viewModel.authorText

        updateUI()

        viewModel.viewDidLoad()
    }

    private func updateUI() {
        articleView.authorLabel.text = viewModel.authorText
        articleView.titleLabel.text = viewModel.titleText
        articleView.descriptionLabel.text = viewModel.descriptionText
        articleView.publishedAtLabel.text = viewModel.publishedAtText
    }
}

extension ArticleViewController: ArticleViewModelDelegate {
    func didChangeImageLoadingState(isLoading: Bool) {
        articleView.imageView.setLoading(isLoading: isLoading)
    }

    func didLoadImage(imageData: Data) {
        let image = UIImage(data: imageData)
        articleView.imageView.image = image
    }
}
