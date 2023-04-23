import UIKit

class BorderedTextField: UITextField {
    private let padding = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)

    override var intrinsicContentSize: CGSize {
        return .init(width: 0, height: 48)
    }

    init() {
        super.init(frame: .zero)

        font = .atosFont(ofSize: 15, weight: .regular)

        addBorders()
    }

    private func addBorders() {
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 2
    }

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
