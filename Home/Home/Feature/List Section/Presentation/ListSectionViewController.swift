import Declayout
import UIKit
import Components

final class ListSectionViewController: UIViewController {
    
    var viewModel: BaseViewModel?
    var category: MovieCategory?
    private var data: [BaseResponse.Result]?
    
    private lazy var tableView = UITableView.make {
        $0.edges(to: view)
        $0.delegate = self
        $0.dataSource = self
        $0.register(ListSectionTableViewCell.self, forCellReuseIdentifier: "ListSectionTableViewCell")
        $0.showsVerticalScrollIndicator = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subViews()
        bind()
        loadData()
    }
    
    private func subViews() {
        view.addSubview(tableView)
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
    
    private func bind() {
        switch self.category {
        case .nowPlaying:
            viewModel?.listNowPlaying.observe(on: self) { [weak self] data in
                self?.data = data
                self?.tableView.reloadData()
            }
        case .popular:
            viewModel?.listPopularMovie.observe(on: self) { [weak self] data in
                self?.data = data
                self?.tableView.reloadData()
            }
        case .topRated:
            viewModel?.listTopRatedMovie.observe(on: self) { [weak self] data in
                self?.data = data
                self?.tableView.reloadData()
            }
        case .upComing:
            viewModel?.listUpComingMovie.observe(on: self) { [weak self] data in
                self?.data = data
                self?.tableView.reloadData()
            }
        default:
            break
        }
        
        viewModel?.state.observe(on: self) { [weak self] data in
            self?.handleState(with: data)
        }
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
    }
    
    private func loadNextPage(with index: IndexPath) {
        switch self.category {
        case .nowPlaying:
            viewModel?.loadNextPageNowPlaying(index: index.row)
        case .popular:
            viewModel?.loadNextPagePopularMovie(index: index.row)
        case .topRated:
            viewModel?.loadNextPageTopRate(index: index.row)
        case .upComing:
            viewModel?.loadNextPageUpComing(index: index.row)
        default:
            break
        }
    }
}

extension ListSectionViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListSectionTableViewCell",
                                                 for: indexPath) as! ListSectionTableViewCell
        if let data = self.data?[indexPath.row] {
            cell.setContent(with: data)
            self.loadNextPage(with: indexPath)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let id = self.data?[indexPath.row].id {
            self.viewModel?.goToMovie(id: id)
        }
    }
}
