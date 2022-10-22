import Declayout
import Components

final class BaseView: UIView {
    
    private lazy var vStack = UIStackView.make {
        $0.axis = .vertical
        $0.distribution = .equalSpacing
        $0.horizontalPadding(to: containerView)
        $0.verticalPadding(to: containerView, Padding.reguler)
    }
    
    private lazy var containerView = UIView.make {
        $0.edges(to: self)
        $0.borderWidth = 1
        $0.borderColor = .black
        $0.layer.cornerRadius = 15
    }
    
    private lazy var label = UILabel.make {
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 12, weight: .semibold)
        $0.textAlignment = .center
        $0.numberOfLines = 0
        $0.horizontalPadding(to: vStack, Padding.half)
    }
    
    private lazy var backgroundImage = UIImageView.make {
        $0.contentMode = .scaleToFill
        $0.clipsToBounds = false
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        subViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func subViews() {
        backgroundColor = .clear
        addSubviews([
            containerView.addSubviews([
                vStack.addArrangedSubviews([
                    backgroundImage,
                    label
                ])
            ])
        ])
    }
    
    func setContent(with data: BaseResponse.Result) {
        label.text = data.title
        backgroundImage.downloaded(from: data.poster_path ?? "")
    }
}
