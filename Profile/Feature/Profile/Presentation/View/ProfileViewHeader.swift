import Declayout
import UIKit
import Components

final class ProfileViewHeader: UIView {
    
    var selectCallBackEditName: (() -> Void)?
    var selectCallBackEditEmail: (() -> Void)?
    var selectCallBackEditPhoto: (() -> Void)?
    
    private lazy var containerView = UIView.make {
        $0.verticalPadding(to: self, Padding.double)
        $0.horizontalPadding(to: self)
        $0.center(to: self)
    }
    
    private lazy var separatorOne = UIView.make {
        $0.width(ScreenSize.width)
        $0.backgroundColor = .gray
        $0.height(1)
    }
    
    private lazy var separatorTwo = UIView.make {
        $0.width(ScreenSize.width)
        $0.backgroundColor = .gray
        $0.height(1)
    }
    
    private lazy var separatorThree = UIView.make {
        $0.width(ScreenSize.width)
        $0.backgroundColor = .gray
        $0.height(1)
    }
    
    private lazy var vStack = UIStackView.make {
        $0.edges(to: containerView)
        $0.axis = .vertical
        $0.spacing = Padding.reguler
    }
    
    private lazy var profileImage = UIImageView.make {
        $0.makeRounded()
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFit
        $0.tintColor = .black
        $0.dimension(ScreenSize.height * 0.1)
        $0.image = UIImage(systemName: "house.circle.fill")
    }
    
    private lazy var editPhoto = UILabel.make {
        $0.font = .systemFont(ofSize: 12, weight: .semibold)
        $0.isUserInteractionEnabled = true
        $0.textAlignment = .center
        $0.textColor = .black
        $0.text = "Edit"
    }
    
    private lazy var nameLabel = TwoLabelInHorizontalStack.make {
        $0.horizontalPadding(to: vStack, Padding.double)
        $0.isUserInteractionEnabled = true
    }
    
    private lazy var mailLabel = TwoLabelInHorizontalStack.make {
        $0.horizontalPadding(to: vStack, Padding.double)
        $0.isUserInteractionEnabled = true
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
                    profileImage,
                    editPhoto,
                    separatorOne,
                    nameLabel,
                    separatorTwo,
                    mailLabel,
                    separatorThree
                ])
            ])
        ])
        configureButton()
    }
    
    func setContentName(with name: String) {
        self.nameLabel.titleLabel.text = "Name:"
        self.nameLabel.contentLabel.text = name
    }
    
    func setContentEmail(with email: String) {
        self.mailLabel.titleLabel.text = "Email:"
        self.mailLabel.contentLabel.text = email
    }
    
    func setContentProfile(with image: UIImage) {
        self.profileImage.image = image
    }
    
    private func configureButton() {
        let toEditName = UITapGestureRecognizer(target: self, action: #selector(goToEditName))
        let toEditMail = UITapGestureRecognizer(target: self, action: #selector(goToEditMail))
        let toEditPhoto = UITapGestureRecognizer(target: self, action: #selector(goToEditPhoto))
        self.nameLabel.addGestureRecognizer(toEditName)
        self.editPhoto.addGestureRecognizer(toEditPhoto)
        self.mailLabel.addGestureRecognizer(toEditMail)
    }
    
    @objc private func goToEditName() {
        self.selectCallBackEditName?()
    }
    
    @objc private func goToEditMail() {
        self.selectCallBackEditEmail?()
    }
    
    @objc private func goToEditPhoto() {
        self.selectCallBackEditPhoto?()
    }
}
