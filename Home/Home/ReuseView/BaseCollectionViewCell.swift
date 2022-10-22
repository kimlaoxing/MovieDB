import Declayout
import Components

final class BaseCollectionViewCell: UICollectionViewCell {
    
    private lazy var baseView = BaseView.make {
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
        contentView.addSubview(baseView)
    }
    
    func setContent(with data: BaseResponse.Result) {
        baseView.setContent(with: data)
    }
}
