import Foundation
import Components
import Router

protocol IGListKitViewModelOutput {
    func getNowPlaying()
    func getPopular()
    func getTopRatedMovie()
    func getUpComing()
    func viewDidLoad()
    func loadNextPageNowPlaying(index: Int)
    func loadNextPagePopularMovie(index: Int)
    func loadNextPageTopRate(index: Int)
    func loadNextPageUpComing(index: Int)
    func goToDetailMovie(id: Int)
    func goToNowPlayingSection()
    func goToPopularMovieSection()
    func goToTopRatedSection()
    func goToPageUpComingSection()
    func popUpError()
    func loadNextPage(with index: Int)
    func getTitle() -> String
}

protocol IGListKitViewModelInput {
    var listNowPlaying: Observable<[IGListKitModel]> { get }
    var listPopularMovie: Observable<[IGListKitModel]> { get }
    var listTopRatedMovie: Observable<[IGListKitModel]> { get }
    var listUpComingMovie: Observable<[IGListKitModel]> { get }
    var isLastPageNowPlaying: Observable<Bool?> { get }
    var isLastPopularMovie: Observable<Bool?> { get }
    var isLastPageTopRatedMovie: Observable<Bool?> { get }
    var isLastPageUpComing: Observable<Bool?> { get }
    var state: Observable<BaseViewState> { get }
    var error: Observable<String> { get }
    var category: MovieCategory { get }
}

protocol IGListKitViewModel: IGListKitViewModelInput, IGListKitViewModelOutput { }

final class DefaultIGListKitViewModel: IGListKitViewModel {
    
    let listNowPlaying: Observable<[IGListKitModel]> = Observable([])
    let listPopularMovie: Observable<[IGListKitModel]> = Observable([])
    let listTopRatedMovie: Observable<[IGListKitModel]> = Observable([])
    let listUpComingMovie: Observable<[IGListKitModel]> = Observable([])
    let error: Observable<String> = Observable("")
    
    let isLastPageNowPlaying: Observable<Bool?> = Observable(false)
    let isLastPopularMovie: Observable<Bool?> = Observable(false)
    let isLastPageTopRatedMovie: Observable<Bool?> = Observable(false)
    let isLastPageUpComing: Observable<Bool?> = Observable(false)
    let state: Observable<BaseViewState> = Observable(.loading)
    let category: MovieCategory
    
    private let useCase = BaseUseCase()
    
    private let router: Routes
    
    typealias Routes = HomeTabRoute
    
    init(router: Routes,
         category: MovieCategory
    ) {
        self.category = category
        self.router = router
    }
    
    private var pageNowPlaying = 1
    private var pagePopularMovie = 1
    private var pageTopRated = 1
    private var pageUpComing = 1
    private var totalPageNowPlaying = 1
    private var totalPagePopularMovie = 1
    private var totalPageTopRated = 1
    private var totalPageUpComing = 1
    private var isLoadNextPageNowPlaying = false
    private var isLoadNextPopularMovie = false
    private var isLoadNextTopRatedMovie = false
    private var isLoadNextUpComingMovie = false
    
    internal func viewDidLoad() {
        switch category {
        case .popular:
            getPopular()
        case .nowPlaying:
            getNowPlaying()
        case .topRated:
            getTopRatedMovie()
        case .upComing:
            getUpComing()
        }
    }
    
    internal func goToDetailMovie(id: Int) {
        self.router.toDetailMovie(id: id)
    }
    
    func getTitle() -> String {
        switch category {
        case .nowPlaying:
            return "Now Playing List"
        case .popular:
            return "Popular Movie List"
        case .topRated:
            return "Top Rated Movie List"
        case .upComing:
            return "Up Coming Movie List"
        }
    }
    
    func goToNowPlayingSection() {
        self.router.toNowPlayingSection()
    }
    
    func goToPopularMovieSection() {
        self.router.toPopularMovieSection()
    }
    
    func goToTopRatedSection() {
        self.router.toTopRatedSection()
    }
    
    func goToPageUpComingSection() {
        self.router.toPageUpComingSection()
    }
    
    func popUpError() {
        self.router.popUpError(with: self.error.value)
    }
}

extension DefaultIGListKitViewModel {
    
    func loadNextPage(with index: Int) {
        switch category {
        case .nowPlaying:
            loadNextPageNowPlaying(index: index)
        case .popular:
            loadNextPagePopularMovie(index: index)
        case .topRated:
            loadNextPageTopRate(index: index)
        case .upComing:
            loadNextPageUpComing(index: index)
        }
    }

    func loadNextPageNowPlaying(index: Int) {
        if pageNowPlaying <= totalPageNowPlaying {
            if !isLoadNextPageNowPlaying {
                let lastIndex = (listNowPlaying.value.count) - 2
                if lastIndex == index {
                    getNowPlaying()
                }
            }
        }
    }
    
    func loadNextPagePopularMovie(index: Int) {
        if pagePopularMovie <= totalPagePopularMovie {
            if !isLoadNextPopularMovie {
                let lastIndex = (listPopularMovie.value.count) - 2
                if lastIndex == index {
                    getPopular()
                }
            }
        }
    }
    
    func loadNextPageTopRate(index: Int) {
        if pageTopRated <= totalPageTopRated {
            if !isLoadNextTopRatedMovie {
                let lastIndex = (listTopRatedMovie.value.count) - 2
                if lastIndex == index {
                    getTopRatedMovie()
                }
            }
        }
    }
    
    func loadNextPageUpComing(index: Int) {
        if pageUpComing <= totalPageUpComing {
            if !isLoadNextUpComingMovie {
                let lastIndex = (listUpComingMovie.value.count) - 2
                if lastIndex == index {
                    getUpComing()
                }
            }
        }
    }
}

extension DefaultIGListKitViewModel {
    
    func getNowPlaying() {
        self.state.value = .loading
        self.useCase.getNowPlaying(with: self.pageNowPlaying) { data in
            switch data {
            case .failure(let error):
                self.error.value = "\(error)"
                self.popUpError()
            case .success(let data):
                self.totalPageNowPlaying = data.total_pages ?? 0
                if self.pageNowPlaying == 1 {
                    self.isLastPageNowPlaying.value = self.pageNowPlaying == self.totalPageNowPlaying
                    self.pageNowPlaying += 1
                    self.listNowPlaying.value = IGListKitDataMapper.BaseResponseToIGListKitModel(result: data.results ?? [], response: data)
                } else {
                    self.isLastPageNowPlaying.value = self.pageNowPlaying == self.totalPageNowPlaying
                    self.pageNowPlaying += 1
                    var newData: [IGListKitModel] = []
                    newData.append(contentsOf: self.listNowPlaying.value)
                    newData.append(contentsOf: IGListKitDataMapper.BaseResponseToIGListKitModel(result: data.results ?? [], response: data))
                    self.listNowPlaying.value = newData
                }
                self.state.value = .normal
            }
        }
    }
    
    func getPopular() {
        self.state.value = .loading
        self.useCase.getPopular(with: self.pagePopularMovie) { data in
            switch data {
            case .success(let data):
                self.totalPagePopularMovie = data.total_results ?? 0
                if self.pagePopularMovie == 1 {
                    self.isLastPopularMovie.value = self.pagePopularMovie == self.totalPagePopularMovie
                    self.pagePopularMovie += 1
                    self.listPopularMovie.value = IGListKitDataMapper.BaseResponseToIGListKitModel(result: data.results ?? [], response: data)
                } else {
                    self.isLastPopularMovie.value = self.pagePopularMovie == self.totalPagePopularMovie
                    self.pagePopularMovie += 1
                    var newData: [IGListKitModel] = []
                    newData.append(contentsOf: self.listPopularMovie.value)
                    newData.append(contentsOf: IGListKitDataMapper.BaseResponseToIGListKitModel(result: data.results ?? [], response: data))
                    self.listPopularMovie.value = newData
                }
                self.state.value = .normal
            case .failure(let error):
                self.error.value = "\(error)"
                self.popUpError()
            }
        }
    }
    
    func getTopRatedMovie() {
        self.state.value = .loading
        self.useCase.getTopRated(with: self.pageTopRated) { data in
            switch data {
            case .failure(let error):
                self.error.value = "\(error)"
                self.popUpError()
            case .success(let data):
                self.totalPageTopRated = data.total_results ?? 0
                if self.pageTopRated == 1 {
                    self.isLastPageTopRatedMovie.value = self.pageTopRated == self.totalPageTopRated
                    self.pageTopRated += 1
                    self.listTopRatedMovie.value = IGListKitDataMapper.BaseResponseToIGListKitModel(result: data.results ?? [], response: data)
                } else {
                    self.isLastPageTopRatedMovie.value = self.pageTopRated == self.totalPageTopRated
                    self.pageTopRated += 1
                    var newData: [IGListKitModel] = []
                    newData.append(contentsOf: self.listTopRatedMovie.value)
                    newData.append(contentsOf: IGListKitDataMapper.BaseResponseToIGListKitModel(result: data.results ?? [], response: data))
                    self.listTopRatedMovie.value = newData
                }
                self.state.value = .normal
            }
        }
    }
    
    func getUpComing() {
        self.state.value = .loading
        self.useCase.getUpComing(with: self.pageUpComing) { data in
            switch data {
            case .success(let data):
                self.totalPageUpComing = data.total_results ?? 0
                if self.pageUpComing == 1 {
                    self.isLastPageUpComing.value = self.pageUpComing == self.totalPageUpComing
                    self.pageUpComing += 1
                    self.listUpComingMovie.value = IGListKitDataMapper.BaseResponseToIGListKitModel(result: data.results ?? [], response: data)
                } else {
                    self.isLastPageUpComing.value = self.pageUpComing == self.totalPageUpComing
                    self.pageUpComing += 1
                    var newData: [IGListKitModel] = []
                    newData.append(contentsOf: self.listUpComingMovie.value)
                    newData.append(contentsOf: IGListKitDataMapper.BaseResponseToIGListKitModel(result: data.results ?? [], response: data))
                    self.listUpComingMovie.value = newData
                }
                self.state.value = .normal
            case .failure(let error):
                self.error.value = "\(error)"
                self.popUpError()
            }
        }
    }
}
