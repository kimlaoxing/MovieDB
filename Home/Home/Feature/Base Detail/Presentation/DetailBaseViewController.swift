import Declayout
import UIKit
import Favorite
import Components

final class DetailBaseViewController: UIViewController {
    
    var viewModel: DetailBaseViewModel?
    private var data: DetailBaseModel?
    private var favoriteModel: FavoriteModel?
    
    private lazy var contentView = DetailBaseView()
    
    private lazy var vStack = UIStackView.make {
        $0.axis = .vertical
        $0.top(to: view, Padding.double + safeAreaInset.top + Padding.half)
        $0.bottom(to: view, Padding.double)
        $0.horizontalPadding(to: view)
    }
    
    private lazy var container = UIView.make {
        $0.height(Padding.NORMAL_CONTENT_INSET)
    }
    
    private lazy var addToFavoriteButton = UIButton.make {
        $0.verticalPadding(to: container)
        $0.horizontalPadding(to: container, Padding.reguler)
        $0.layer.cornerRadius = 15
        $0.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        subViews()
    }
    
    private func bind() {
        viewModel?.baseDetailModel.observe(on: self) { [weak self] data in
            guard let self = self, let data = data else { return }
            self.data = data
            self.updateContent(with: data)
            self.favoriteModel = FavoriteModel(id: Int32(data.id ?? 0),
                                               popularity: data.popularity ?? 0,
                                               poster_path: data.poster_path ?? "",
                                               release_date: data.release_date ?? "",
                                               title: data.title ?? "")
        }
        
        viewModel?.state.observe(on: self) { [weak self] state in
            self?.handleState(with: state)
        }
        
        viewModel?.buttonState.observe(on: self) { [weak self] state in
            self?.setButtonMode(with: state)
        }
    }
    
    private func subViews() {
        view.backgroundColor = .white
        view.addSubviews([
            vStack.addArrangedSubviews([
                contentView,
                container.addSubviews([
                    addToFavoriteButton
                ])
            ])
        ])
    }
    
    private func updateContent(with data: DetailBaseModel) {
        contentView.setContent(with: data)
        title = "\(data.title ?? "Detail Movie")"
    }
    
    private func handleState(with state: BaseViewState) {
        switch state {
        case .loading:
            self.manageLoadingActivity(isLoading: true)
            self.vStack.isHidden = true
        case .normal:
            self.manageLoadingActivity(isLoading: false)
            self.vStack.isHidden = false
        case .empty:
            self.manageLoadingActivity(isLoading: false)
        }
    }
    
    @objc private func saveButton() {
        if let data = self.favoriteModel {
            self.viewModel?.addFavorite(data)
        }
    }

    @objc private func deleteButton() {
        if let data = self.favoriteModel {
            self.viewModel?.deleteFavorite(Int(data.id ?? 0))
        }
    }
    
    private func setButtonMode(with mode: DetailBaseButtonMode) {
        switch mode {
        case .isSaved:
            addToFavoriteButton.setTitle("Saved", for: .normal)
            addToFavoriteButton.backgroundColor = .black
            addToFavoriteButton.addTarget(self, action: #selector(deleteButton), for: .touchUpInside)
        case .notSaved:
            addToFavoriteButton.setTitle("Save", for: .normal)
            addToFavoriteButton.backgroundColor = .gray
            addToFavoriteButton.addTarget(self, action: #selector(saveButton), for: .touchUpInside)
        }
    }
}
