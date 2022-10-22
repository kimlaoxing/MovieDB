import Declayout
import UIKit
import Components

final class TitleCollectionReusableView: UIView {
    
    var selectCallBack: (() -> Void)?
    
    private lazy var title = TwoLabelInHorizontalStack.make {
        $0.horizontalPadding(to: self, 16)
        $0.verticalPadding(to: self)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        subViews()
        configureButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func subViews() {
        addSubviews([title])
    }
    
    func setContent(with label: String) {
        self.title.titleLabel.text = label
        self.title.contentLabel.text = "See All"
    }
    
    private func configureButton() {
        self.title.selectCallBack = {
            self.selectCallBack?()
        }
    }
}
