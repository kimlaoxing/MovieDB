import Declayout
import IGListKit
import Components

final class IGListKitViewController: UIViewController {
    
    var viewModel: IGListKitViewModel?
    var category: MovieCategory?
    private var data: [IGListKitModel]?
    
    private lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self)
    }()
    
    private let collectionView = DefaultCollectionView(frame: .zero)
    private let layout = UICollectionViewFlowLayout()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subViews()
        bind()
        loadData()
        adapter.collectionView = collectionView
        adapter.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
    private func loadData() {
        switch self.category {
        case .nowPlaying:
            viewModel?.getNowPlaying()
            title = "Now Playing List"
        case .popular:
            viewModel?.getPopular()
            title = "Popular Movie List"
        case .topRated:
            viewModel?.getTopRatedMovie()
            title = "Top Rated Movie List"
        case .upComing:
            viewModel?.getUpComing()
            title = "Up Coming Movie List"
        default:
            break
        }
    }
    
    
    private func subViews() {
        title = "Section List"
        view.addSubview(collectionView)
        collectionView.collectionViewLayout = layout
    }
    
    private func bind() {
        switch self.category {
        case .nowPlaying:
            viewModel?.listNowPlaying.observe(on: self) { [weak self] data in
                self?.data = data
                print("your data is \(data)")
                self?.adapter.performUpdates(animated: true)
            }
        case .popular:
            viewModel?.listPopularMovie.observe(on: self) { [weak self] data in
                self?.data = data
                self?.adapter.performUpdates(animated: true)
            }
        case .topRated:
            viewModel?.listTopRatedMovie.observe(on: self) { [weak self] data in
                self?.data = data
                self?.adapter.performUpdates(animated: true)
            }
        case .upComing:
            viewModel?.listUpComingMovie.observe(on: self) { [weak self] data in
                self?.data = data
                self?.adapter.performUpdates(animated: true)
            }
        default:
            break
        }
    }
}


extension IGListKitViewController: ListAdapterDataSource {
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return data ?? []
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        let sectionController = IGListKitSectionViewController()
        sectionController.delegate = self
        return sectionController
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
}

extension IGListKitViewController: IGListKitSectionViewControllerProtocol {
    func didSelectRow(with index: Int) {
        self.viewModel?.goToDetailMovie(id: index)
    }
}
