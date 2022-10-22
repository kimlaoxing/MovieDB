import Declayout
import UIKit

public final class TwoLabelInHorizontalStack: UIView {
    
    public var selectCallBack: (() -> Void)?
    
    private lazy var hStack = UIStackView.make {
        $0.axis = .horizontal
        $0.edges(to: self)
    }
    
    public lazy var titleLabel = UILabel.make {
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 12, weight: .semibold)
        $0.numberOfLines = 1
        $0.textAlignment = .left
        $0.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .horizontal)
        $0.setContentCompressionResistancePriority(UILayoutPriority.defaultHigh, for: .horizontal)
    }
    
    public lazy var contentLabel = UILabel.make {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(toSection))
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 12, weight: .regular)
        $0.numberOfLines = 0
        $0.textAlignment = .right
        $0.setContentHuggingPriority(UILayoutPriority.defaultLow, for: .horizontal)
        $0.setContentCompressionResistancePriority(UILayoutPriority.defaultLow, for: .horizontal)
        $0.isUserInteractionEnabled = true
        $0.addGestureRecognizer(gesture)
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        subView()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    @objc private func toSection() {
        self.selectCallBack?()
    }
    
    private func subView() {
        addSubviews([
            hStack.addArrangedSubviews([
                titleLabel,
                contentLabel
            ])
        ])
    }
}
