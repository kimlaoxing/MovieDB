import Declayout
import Components

final class IGListKitCollectionCell: UICollectionViewCell {
    
    private lazy var containerView = IGListKitView.make {
        $0.edges(to: contentView)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        subViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func subViews() {
        contentView.addSubview(containerView)
    }
    
    func setContent(with data: IGListKitModel) {
        containerView.setContent(with: data)
    }
}
