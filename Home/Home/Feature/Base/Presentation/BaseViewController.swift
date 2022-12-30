import Declayout
import Components
import RxSwift

final class BaseViewController: UIViewController {
    
    var viewModel: BaseViewModel?
    let bag = DisposeBag()
    
    private lazy var scrollView = ScrollViewContainer.make {
        $0.edges(to: view)
        $0.setSpacingBetweenItems(to: Padding.reguler)
        $0.showsVerticalScrollIndicator(false)
    }
    
    private var nowPlayingCollectionHeight: NSLayoutConstraint? {
        didSet { nowPlayingCollectionHeight?.activated() }
    }
    
    private var popularMovieCollectionHeight: NSLayoutConstraint? {
        didSet { popularMovieCollectionHeight?.activated() }
    }
    
    private var topRatedMovieHeight: NSLayoutConstraint? {
        didSet { topRatedMovieHeight?.activated() }
    }
    
    private var upComingMovieHeight: NSLayoutConstraint? {
        didSet { upComingMovieHeight?.activated() }
    }
    
    private lazy var nowPlayingCollection = DefaultCollectionView(frame: .zero)
    private lazy var popularMovieCollection = DefaultCollectionView(frame: .zero)
    private lazy var topRatedMovieCollection = DefaultCollectionView(frame: .zero)
    private lazy var upComingMovieCollection = DefaultCollectionView(frame: .zero)
    
    private lazy var titleNowPlaying = TitleCollectionReusableView.make {
        $0.setContent(with: "Now Playing")
    }
    
    private lazy var titlePopularMovie = TitleCollectionReusableView.make {
        $0.setContent(with: "Popular Movie")
    }
    
    private lazy var titleTopRatedMovie = TitleCollectionReusableView.make {
        $0.setContent(with: "Top Rated Movie")
    }
    
    private lazy var titleUpComingMovie = TitleCollectionReusableView.make {
        $0.setContent(with: "Up Coming Movie")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.viewDidLoad()
        subViews()
        bind()
        configureButton()
    }
    
    private func bind() {
        viewModel?.state.subscribe(onNext: { [weak self] state in
            self?.handleState(with: state)
        }).disposed(by: bag)
        
        viewModel?.listNowPlaying.subscribe({ _ in
            self.nowPlayingCollection.reloadData()
        }).disposed(by: bag)
        
        viewModel?.listPopularMovie.subscribe({ _ in
            self.popularMovieCollection.reloadData()
        }).disposed(by: bag)
        
        viewModel?.listTopRatedMovie.subscribe({ _ in
            self.topRatedMovieCollection.reloadData()
        }).disposed(by: bag)
        
        viewModel?.listUpComingMovie.subscribe({ _ in
            self.upComingMovieCollection.reloadData()
        }).disposed(by: bag)
    }
    
    private func subViews() {
        title = "List Movies"
        view.addSubviews([
            scrollView.addArrangedSubViews([
                titleNowPlaying,
                nowPlayingCollection,
                titlePopularMovie,
                popularMovieCollection,
                titleTopRatedMovie,
                topRatedMovieCollection,
                titleUpComingMovie,
                upComingMovieCollection
            ])
        ])
        
        nowPlayingCollectionConfigure()
        popularMovieCollectionConfigure()
        topRatedMovieCollectionConfigure()
        upComingMovieCollectionConfigure()
        disableCollectionFunc()
    }
    
    private func handleState(with state: BaseViewState) {
        switch state {
        case .loading:
            self.manageLoadingActivity(isLoading: true)
        case .normal:
            self.manageLoadingActivity(isLoading: false)
        case .empty:
            self.manageLoadingActivity(isLoading: false)
        }
        self.handleEmptyCollection()
    }

    private func configureButton() {
        self.titleNowPlaying.selectCallBack = {
            self.viewModel?.goToNowPlayingSection()
        }
        
        self.titlePopularMovie.selectCallBack = {
            self.viewModel?.goToPopularMovieSection()
        }
        
        self.titleTopRatedMovie.selectCallBack = {
            self.viewModel?.goToTopRatedSection()
        }
        
        self.titleUpComingMovie.selectCallBack = {
            self.viewModel?.goToPageUpComingSection()
        }
    }
    
    private func popularMovieCollectionConfigure() {
        popularMovieCollection.register(BaseCollectionViewCell.self, forCellWithReuseIdentifier: "BaseCollectionViewCell")
        popularMovieCollection.delegate = self
        popularMovieCollection.dataSource = self
        popularMovieCollectionHeight = popularMovieCollection.heightAnchor.constraint(equalToConstant: ScreenSize.heightPerItem)
        let layout = UICollectionViewFlowLayout()
        popularMovieCollection.collectionViewLayout = layout
        popularMovieCollection.decelerationRate = UIScrollView.DecelerationRate.fast
        layout.scrollDirection = .horizontal
    }
    
    private func topRatedMovieCollectionConfigure() {
        topRatedMovieCollection.register(BaseCollectionViewCell.self, forCellWithReuseIdentifier: "BaseCollectionViewCell")
        topRatedMovieCollection.delegate = self
        topRatedMovieCollection.dataSource = self
        topRatedMovieHeight = topRatedMovieCollection.heightAnchor.constraint(equalToConstant: ScreenSize.heightPerItem)
        let layout = UICollectionViewFlowLayout()
        topRatedMovieCollection.collectionViewLayout = layout
        topRatedMovieCollection.decelerationRate = UIScrollView.DecelerationRate.fast
        layout.scrollDirection = .horizontal
    }
    
    private func upComingMovieCollectionConfigure() {
        upComingMovieCollection.register(BaseCollectionViewCell.self, forCellWithReuseIdentifier: "BaseCollectionViewCell")
        upComingMovieCollection.delegate = self
        upComingMovieCollection.dataSource = self
        upComingMovieHeight = upComingMovieCollection.heightAnchor.constraint(equalToConstant: ScreenSize.heightPerItem)
        let layout = UICollectionViewFlowLayout()
        upComingMovieCollection.collectionViewLayout = layout
        upComingMovieCollection.decelerationRate = UIScrollView.DecelerationRate.fast
        layout.scrollDirection = .horizontal
    }
    
    private func nowPlayingCollectionConfigure() {
        nowPlayingCollection.register(BaseCollectionViewCell.self, forCellWithReuseIdentifier: "BaseCollectionViewCell")
        nowPlayingCollection.delegate = self
        nowPlayingCollection.dataSource = self
        nowPlayingCollectionHeight = nowPlayingCollection.heightAnchor.constraint(equalToConstant: ScreenSize.heightPerItem)
        let layout = UICollectionViewFlowLayout()
        nowPlayingCollection.collectionViewLayout = layout
        nowPlayingCollection.decelerationRate = UIScrollView.DecelerationRate.fast
        layout.scrollDirection = .horizontal
    }
    
    private func disableCollectionFunc() {
        upComingMovieCollection.allowsMultipleSelection = false
        upComingMovieCollection.showsHorizontalScrollIndicator = false
        upComingMovieCollection.isBouncesVertical = false
        
        nowPlayingCollection.showsHorizontalScrollIndicator = false
        nowPlayingCollection.allowsMultipleSelection = false
        nowPlayingCollection.isBouncesVertical = false
        
        topRatedMovieCollection.showsHorizontalScrollIndicator = false
        topRatedMovieCollection.allowsMultipleSelection = false
        topRatedMovieCollection.isBouncesVertical = false
        
        popularMovieCollection.showsHorizontalScrollIndicator = false
        popularMovieCollection.allowsMultipleSelection = false
        popularMovieCollection.isBouncesVertical = false
    }
    
    private func handleEmptyCollection() {
        if viewModel?.listNowPlaying.value == nil {
            self.nowPlayingCollection.isHidden = true
            self.titleNowPlaying.isHidden = true
        } else {
            self.nowPlayingCollection.isHidden = false
            self.titleNowPlaying.isHidden = false
        }
        
        if viewModel?.listPopularMovie.value == nil {
            self.popularMovieCollection.isHidden = true
            self.titlePopularMovie.isHidden = true
        } else {
            self.popularMovieCollection.isHidden = false
            self.titlePopularMovie.isHidden = false
        }
        
        if viewModel?.listTopRatedMovie.value == nil {
            self.topRatedMovieCollection.isHidden = true
            self.titleTopRatedMovie.isHidden = true
        } else {
            self.topRatedMovieCollection.isHidden = false
            self.titleTopRatedMovie.isHidden = false
        }

        if viewModel?.listUpComingMovie.value == nil {
            self.upComingMovieCollection.isHidden = true
            self.titleUpComingMovie.isHidden = true
        } else {
            self.upComingMovieCollection.isHidden = false
            self.titleUpComingMovie.isHidden = false
        }
    }
}

extension BaseViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        for cell in nowPlayingCollection.visibleCells {
            let indexPath = nowPlayingCollection.indexPath(for: cell)
            viewModel?.loadNextPageNowPlaying(index: indexPath?.row ?? 0)
        }
        
        for cell in popularMovieCollection.visibleCells {
            let indexPath = popularMovieCollection.indexPath(for: cell)
            viewModel?.loadNextPagePopularMovie(index: indexPath?.row ?? 0)
        }
        
        for cell in topRatedMovieCollection.visibleCells {
            let indexPath = topRatedMovieCollection.indexPath(for: cell)
            viewModel?.loadNextPageTopRate(index: indexPath?.row ?? 0)
        }
        
        for cell in upComingMovieCollection.visibleCells {
            let indexPath = upComingMovieCollection.indexPath(for: cell)
            viewModel?.loadNextPageUpComing(index: indexPath?.row ?? 0)
        }

    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case nowPlayingCollection:
            return viewModel?.listNowPlaying.value.count ?? 0
        case popularMovieCollection:
            return viewModel?.listPopularMovie.value.count ?? 0
        case topRatedMovieCollection:
            return viewModel?.listTopRatedMovie.value.count ?? 0
        case upComingMovieCollection:
            return viewModel?.listUpComingMovie.value.count ?? 0
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case nowPlayingCollection:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BaseCollectionViewCell",
                                                          for: indexPath) as! BaseCollectionViewCell
            if let data = viewModel?.listNowPlaying.value[indexPath.row] {
                cell.setContent(with: data)
            }
            return cell
        case popularMovieCollection:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BaseCollectionViewCell",
                                                          for: indexPath) as! BaseCollectionViewCell
            if let data = viewModel?.listPopularMovie.value[indexPath.row] {
                cell.setContent(with: data)
            }
            return cell
        case topRatedMovieCollection:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BaseCollectionViewCell",
                                                          for: indexPath) as! BaseCollectionViewCell
            if let data = viewModel?.listTopRatedMovie.value[indexPath.row] {
                cell.setContent(with: data)
            }
            return cell
        case upComingMovieCollection:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BaseCollectionViewCell",
                                                          for: indexPath) as! BaseCollectionViewCell
            if let data = viewModel?.listUpComingMovie.value[indexPath.row] {
                cell.setContent(with: data)
            }
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return UICollectionViewTwoItemPerWidth()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: Padding.reguler, left: Padding.double, bottom: Padding.reguler, right: Padding.double)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case nowPlayingCollection:
            if let id = viewModel?.listNowPlaying.value[indexPath.row].id {
                viewModel?.goToMovie(id: id)
            }
        case popularMovieCollection:
            if let id = viewModel?.listPopularMovie.value[indexPath.row].id {
                viewModel?.goToMovie(id: id)
            }
        case topRatedMovieCollection:
            if let id = viewModel?.listTopRatedMovie.value[indexPath.row].id {
                viewModel?.goToMovie(id: id)
            }
        case upComingMovieCollection:
            if let id = viewModel?.listUpComingMovie.value[indexPath.row].id {
                viewModel?.goToMovie(id: id)
            }
        default:
            break
        }
    }
}
