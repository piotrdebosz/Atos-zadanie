import UIKit

class PrimaryButton: UIButton {
    override var intrinsicContentSize: CGSize {
        .init(width: 0, height: 48)
    }

    init() {
        super.init(frame: .zero)

        setupViews()
    }

    private func setupViews() {
        backgroundColor = .black
        setTitleColor(.white, for: .normal)
        setTitleColor(.white.withAlphaComponent(0.8), for: .highlighted)
        titleLabel?.font = .atosFont(ofSize: 14, weight: .semibold)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
