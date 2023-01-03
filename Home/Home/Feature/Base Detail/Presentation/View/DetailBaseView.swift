import Declayout
import UIKit
import Components

final class DetailBaseView: UIView {
    
    private lazy var scrollView = ScrollViewContainer.make {
        $0.edges(to: self, Padding.reguler)
        $0.showsVerticalScrollIndicator = false
    }
    
    private lazy var header = UIView.make {
        $0.width(ScreenSize.width)
        $0.height(ScreenSize.height * 0.3)
    }
    
    private lazy var vStack = UIStackView.make {
        $0.axis = .vertical
        $0.spacing = Padding.reguler
        $0.verticalPadding(to: scrollView, Padding.reguler)
    }
    
    private lazy var backgroundImage = UIImageView.make {
        $0.clipsToBounds = true
        $0.contentMode = .scaleToFill
        $0.layer.cornerRadius = 15
        $0.edges(to: header)
    }
    
    private lazy var hStack = UIStackView.make {
        $0.axis = .horizontal
        $0.alignment = .center
        $0.distribution = .equalSpacing
    }
    
    private lazy var releasedDateStack = UIStackView.make {
        $0.axis = .vertical
        $0.spacing = Padding.half
    }
    
    private lazy var gendreStack = UIStackView.make {
        $0.axis = .vertical
        $0.spacing = Padding.half
    }
    
    private lazy var productionCompanyStack = UIStackView.make {
        $0.axis = .vertical
        $0.spacing = Padding.half
    }
    
    private lazy var languageStack = UIStackView.make {
        $0.axis = .vertical
        $0.spacing = Padding.half
    }
    
    private lazy var favoriteStack = UIStackView.make {
        $0.axis = .horizontal
        $0.spacing = Padding.half
    }
    
    private lazy var releaseTitle = UILabel.make {
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 12, weight: .semibold)
        $0.textAlignment = .left
        $0.numberOfLines = 1
    }
    
    private lazy var releaseValue = UILabel.make {
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 12, weight: .regular)
        $0.textAlignment = .left
        $0.numberOfLines = 1
    }
    
    private lazy var gendreTitle = UILabel.make {
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 12, weight: .semibold)
        $0.textAlignment = .left
        $0.numberOfLines = 1
    }
    
    private lazy var gendreValue = UILabel.make {
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 12, weight: .regular)
        $0.textAlignment = .left
        $0.numberOfLines = 0
    }
    
    private lazy var productionCompanyTitle = UILabel.make {
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 12, weight: .semibold)
        $0.textAlignment = .left
        $0.numberOfLines = 1
    }
    
    private lazy var productionCompanyValue = UILabel.make {
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 12, weight: .regular)
        $0.textAlignment = .left
        $0.numberOfLines = 0
    }
    
    private lazy var favoriteIcon = UIImageView.make {
        $0.clipsToBounds = true
        $0.image = UIImage(systemName: "star.fill")
        $0.tintColor = .black
        $0.width(10)
        $0.contentMode = .scaleAspectFit
    }
    
    private lazy var favoriteValue = UILabel.make {
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 12, weight: .regular)
        $0.textAlignment = .right
        $0.numberOfLines = 1
    }
    
    private lazy var descriptionTitle = UILabel.make {
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 12, weight: .semibold)
        $0.textAlignment = .left
        $0.numberOfLines = 1
    }
    
    private lazy var decriptionValue = UILabel.make {
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 12, weight: .regular)
        $0.textAlignment = .justified
        $0.numberOfLines = 0
    }
    
    private lazy var languageTitle = UILabel.make {
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 12, weight: .semibold)
        $0.textAlignment = .left
        $0.numberOfLines = 1
    }
    
    private lazy var languageValue = UILabel.make {
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 12, weight: .regular)
        $0.textAlignment = .justified
        $0.numberOfLines = 0
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configureSubviews() {
        backgroundColor = .clear
        addSubviews([
            scrollView.addArrangedSubViews([
                vStack.addArrangedSubviews([
                    header.addSubviews([
                        backgroundImage
                    ]),
                    hStack.addArrangedSubviews([
                        releasedDateStack.addArrangedSubviews([
                            releaseTitle,
                            releaseValue
                        ]),
                        favoriteStack.addArrangedSubviews([
                            favoriteIcon,
                            favoriteValue
                        ])
                    ]),
                    descriptionTitle,
                    decriptionValue,
                    gendreStack.addArrangedSubviews([
                        gendreTitle,
                        gendreValue
                    ]),
                    productionCompanyStack.addArrangedSubviews([
                        productionCompanyTitle,
                        productionCompanyValue
                    ]),
                    languageStack.addArrangedSubviews([
                        languageTitle,
                        languageValue
                    ])
                ])
            ])
        ])
    }
    
    private func setGendre(with data: DetailBaseResult) {
        gendreTitle.text = "Gendre:"
        gendreValue.text = data.gendreName
    }
    
    private func setProductionCompany(with data: DetailBaseResult) {
        productionCompanyTitle.text = "Production Company:"
        productionCompanyValue.text = data.production_companies
    }
    
    private func setLanguage(with data: DetailBaseResult) {
        languageTitle.text = "Languages:"
        languageValue.text = data.spokenLanguageName
    }
    
    private func setReleaseDate(with data: DetailBaseResult) {
        releaseValue.text = data.release_date
        releaseTitle.text = "Realesed Date:"
    }
    
    private func setDescription(with data: DetailBaseResult) {
        descriptionTitle.text = "Description:"
        decriptionValue.text = data.overview
    }
    
    private func setFavoriteValue(with data: DetailBaseResult) {
        favoriteValue.text = "\(Int(data.popularity) / 100)"
    }
    
    func setContent(with data: DetailBaseResult) {
        backgroundImage.downloaded(from: data.backdrop_path)
        self.setReleaseDate(with: data)
        self.setGendre(with: data)
        self.setProductionCompany(with: data)
        self.setLanguage(with: data)
        self.setDescription(with: data)
        self.setFavoriteValue(with: data)
        self.scrollView.layoutIfNeeded()
    }
}
