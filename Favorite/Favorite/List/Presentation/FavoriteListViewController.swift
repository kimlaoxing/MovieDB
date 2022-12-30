import Declayout
import Components
import RxSwift

final class FavoriteListViewController: UIViewController {
    
    var viewModel: FavoriteListViewModel?
    private let bag = DisposeBag()
    
    private lazy var emptyView = EmptyDataView.make {
        $0.center(to: view)
        $0.title.text = "Favorite is Empty."
        $0.title.font = .systemFont(ofSize: 12, weight: .bold)
        $0.title.numberOfLines = 0
        $0.button.isHidden = true
        $0.image.image = UIImage(systemName: "nosign")
        $0.image.width(100)
        $0.image.tintColor = .black
    }
    
    private lazy var tableView = UITableView.make {
        $0.edges(to: view)
        $0.delegate = self
        $0.dataSource = self
        $0.register(FavoriteTableViewCell.self, forCellReuseIdentifier: "FavoriteTableViewCell")
        $0.allowsMultipleSelectionDuringEditing = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subViews()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.getListFavorite()
    }
    
    private func subViews() {
        title = "Favorite List"
        view.addSubviews([tableView])
        view.addSubviews([emptyView])
    }
    
    private func bind() {
        viewModel?.gameListFavorite.observe(on: self) { [weak self] data in
            guard let self = self else { return }
            self.tableView.reloadData()
            if data?.count == 0 {
                self.emptyView.isHidden = false
            }
        }
        
        viewModel?.state.subscribe(onNext: { [weak self] state in
            guard let self = self else { return }
            self.handleState(with: state)
        }).disposed(by: bag)
    }
    
    private func handleState(with state: BaseViewState) {
        switch state {
        case .loading:
            self.tableView.isHidden = true
            self.emptyView.isHidden = true
        case .normal:
            self.tableView.isHidden = false
            self.emptyView.isHidden = true
        case .empty:
            self.tableView.isHidden = true
            self.emptyView.isHidden = false
        }
    }
    
    private func goToDetailGame(with indexPath: IndexPath) {
        let data = viewModel?.gameListFavorite.value
        let id = data?[indexPath.row].id ?? 0
        viewModel?.toDetailGame(with: Int(id))
    }
}

extension FavoriteListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.gameListFavorite.value?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteTableViewCell",
                                                 for: indexPath) as! FavoriteTableViewCell
        if let data = viewModel?.gameListFavorite.value?[indexPath.row] {
            cell.setContent(with: data)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let data = viewModel?.gameListFavorite.value
        guard let id = data?[indexPath.row].id else { return }
        if editingStyle == .delete {
            tableView.beginUpdates()
            self.viewModel?.gameListFavorite.value?.remove(at: indexPath.row)
            self.viewModel?.deleteGame(with: Int(id))
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.goToDetailGame(with: indexPath)
    }
}
