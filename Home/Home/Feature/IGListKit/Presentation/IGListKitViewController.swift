import Declayout
import IGListKit
import Components

final class IGListKitViewController: UIViewController {
    
    var viewModel: IGListKitViewModel?
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
        viewModel?.viewDidLoad()
        adapter.collectionView = collectionView
        adapter.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
    private func subViews() {
        title = viewModel?.getTitle()
        view.addSubview(collectionView)
        collectionView.collectionViewLayout = layout
    }
    
    private func bind() {
        viewModel?.listNowPlaying.observe(on: self) { [weak self] data in
            self?.data = data
            self?.adapter.performUpdates(animated: true)
        }
        
        viewModel?.listPopularMovie.observe(on: self) { [weak self] data in
            self?.data = data
            self?.adapter.performUpdates(animated: true)
        }
        
        viewModel?.listTopRatedMovie.observe(on: self) { [weak self] data in
            self?.data = data
            self?.adapter.performUpdates(animated: true)
        }
        
        viewModel?.listUpComingMovie.observe(on: self) { [weak self] data in
            self?.data = data
            self?.adapter.performUpdates(animated: true)
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
    func didSelectRow(with id: Int) {
        self.viewModel?.goToDetailMovie(id: id)
    }
    
    func loadNextPage(with index: Int) {
        viewModel?.loadNextPage(with: index)
    }
}
