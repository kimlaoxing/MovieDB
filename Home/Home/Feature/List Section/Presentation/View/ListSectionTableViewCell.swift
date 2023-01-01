import Declayout
import Components

final class ListSectionTableViewCell: UITableViewCell {
    
    private lazy var containerView = UIStackView.make {
        $0.axis = .horizontal
        $0.distribution = .equalSpacing
        $0.horizontalPadding(to: contentView, Padding.double)
        $0.verticalPadding(to: contentView, Padding.reguler)
    }
    
    private lazy var hStack = UIStackView.make {
        $0.axis = .horizontal
        $0.spacing = Padding.half
    }
    
    private lazy var backgroundImage = UIImageView.make {
        $0.clipsToBounds = true
        $0.makeRounded()
        $0.contentMode = .scaleAspectFit
        $0.dimension(40)
    }
    
    private lazy var title = UILabel.make {
        $0.numberOfLines = 1
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 12, weight: .semibold)
        $0.textAlignment = .left
    }
    
    private lazy var releaseDateValue = UILabel.make {
        $0.numberOfLines = 1
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 10, weight: .regular)
        $0.textAlignment = .left
    }
    
    private lazy var ratingStack = UIStackView.make {
        $0.axis = .vertical
    }
    
    private lazy var releasedStack = UIStackView.make {
        $0.axis = .vertical
    }
    
    private lazy var labelStack = UIStackView.make {
        $0.axis = .vertical
        $0.spacing = Padding.half
    }
    
    private lazy var ratinImage = UIImageView.make {
        $0.clipsToBounds = true
        $0.tintColor = .black
        $0.contentMode = .scaleAspectFit
        $0.height(10)
    }
    
    private lazy var releaseDateTitle = UILabel.make {
        $0.numberOfLines = 1
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 9, weight: .regular)
        $0.textAlignment = .left
    }
    
    private lazy var ratingLabel = UILabel.make {
        $0.numberOfLines = 1
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 12, weight: .regular)
        $0.textAlignment = .center
    }
     
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        subViews()
    }
    
    required init?(coder Decoder: NSCoder) {
        super.init(coder: Decoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    private func subViews() {
        contentView.addSubviews([
            containerView.addArrangedSubviews([
                hStack.addArrangedSubviews([
                    backgroundImage,
                    labelStack.addArrangedSubviews([
                        title,
                        releasedStack.addArrangedSubviews([
                            releaseDateTitle,
                            releaseDateValue
                        ])
                    ])
                ]),
                ratingStack.addArrangedSubviews([
                    ratinImage,
                    ratingLabel
                ])
            ])
        ])
    }
    
    func setContent(with data: BaseResult) {
        self.title.text = data.title
        self.backgroundImage.downloaded(from: data.poster_path)
        self.releaseDateTitle.text = "Release Date"
        self.releaseDateValue.text = data.release_date
        self.ratinImage.image = UIImage(systemName: "star.fill")
        self.ratinImage.tintColor = .black
        self.ratingLabel.text = "\(Int(data.popularity) / 100)"
    }
}
