import Foundation
import Components
import Router

protocol BaseViewModelOutput {
    func getNowPlaying()
    func getPopular()
    func getTopRatedMovie()
    func getUpComing()
    func viewDidLoad()
    func loadNextPageNowPlaying(index: Int)
    func loadNextPagePopularMovie(index: Int)
    func loadNextPageTopRate(index: Int)
    func loadNextPageUpComing(index: Int)
    func goToMovie(id: Int)
    func goToNowPlayingSection()
    func goToPopularMovieSection()
    func goToTopRatedSection()
    func goToPageUpComingSection()
}

protocol BaseViewModelInput {
    var listNowPlaying: Observable<[BaseResponse.Result]> { get }
    var listPopularMovie: Observable<[BaseResponse.Result]> { get }
    var listTopRatedMovie: Observable<[BaseResponse.Result]> { get }
    var listUpComingMovie: Observable<[BaseResponse.Result]> { get }
    var isLastPageNowPlaying: Observable<Bool?> { get }
    var isLastPopularMovie: Observable<Bool?> { get }
    var isLastPageTopRatedMovie: Observable<Bool?> { get }
    var isLastPageUpComing: Observable<Bool?> { get }
    var state: Observable<BaseViewState> { get }
}

protocol BaseViewModel: BaseViewModelOutput, BaseViewModelInput { }

final class DefaultBaseViewModel: BaseViewModel {
    
    let listNowPlaying: Observable<[BaseResponse.Result]> = Observable([])
    let listPopularMovie: Observable<[BaseResponse.Result]> = Observable([])
    let listTopRatedMovie: Observable<[BaseResponse.Result]> = Observable([])
    let listUpComingMovie: Observable<[BaseResponse.Result]> = Observable([])
    
    let isLastPageNowPlaying: Observable<Bool?> = Observable(false)
    let isLastPopularMovie: Observable<Bool?> = Observable(false)
    let isLastPageTopRatedMovie: Observable<Bool?> = Observable(false)
    let isLastPageUpComing: Observable<Bool?> = Observable(false)
    let state: Observable<BaseViewState> = Observable(.loading)
    
    private let useCase = BaseUseCase()
    
    private let router: Routes
    
    typealias Routes = HomeTabRoute
    
    init(router: Routes) {
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
        getNowPlaying()
        getPopular()
        getTopRatedMovie()
        getUpComing()
    }
    
    internal func goToMovie(id: Int) {
        self.router.toDetailMovie(id: id)
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
}

extension DefaultBaseViewModel {

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

extension DefaultBaseViewModel {
    
    func getNowPlaying() {
        self.state.value = .loading
        self.useCase.getNowPlaying(with: self.pageNowPlaying) { data in
            self.totalPageNowPlaying = data.total_pages ?? 0
            if self.pageNowPlaying == 1 {
                self.isLastPageNowPlaying.value = self.pageNowPlaying == self.totalPageNowPlaying
                self.pageNowPlaying += 1
                self.listNowPlaying.value = data.results ?? []
            } else {
                self.isLastPageNowPlaying.value = self.pageNowPlaying == self.totalPageNowPlaying
                self.pageNowPlaying += 1
                var newData: [BaseResponse.Result] = []
                newData.append(contentsOf: self.listNowPlaying.value)
                newData.append(contentsOf: data.results ?? [])
                self.listNowPlaying.value = newData
            }
            self.state.value = .normal
        }
    }
    
    func getPopular() {
        self.state.value = .loading
        self.useCase.getPopular(with: self.pagePopularMovie) { data in
            self.totalPagePopularMovie = data.total_results ?? 0
            if self.pagePopularMovie == 1 {
                self.isLastPopularMovie.value = self.pagePopularMovie == self.totalPagePopularMovie
                self.pagePopularMovie += 1
                self.listPopularMovie.value = data.results ?? []
            } else {
                self.isLastPopularMovie.value = self.pagePopularMovie == self.totalPagePopularMovie
                self.pagePopularMovie += 1
                var newData: [BaseResponse.Result] = []
                newData.append(contentsOf: self.listPopularMovie.value)
                newData.append(contentsOf: data.results ?? [])
                self.listPopularMovie.value = newData
            }
            self.state.value = .normal
        }
    }
    
    func getTopRatedMovie() {
        self.state.value = .loading
        self.useCase.getTopRated(with: self.pageTopRated) { data in
            self.totalPageTopRated = data.total_results ?? 0
            if self.pageTopRated == 1 {
                self.isLastPageTopRatedMovie.value = self.pageTopRated == self.totalPageTopRated
                self.pageTopRated += 1
                self.listTopRatedMovie.value = data.results ?? []
            } else {
                self.isLastPageTopRatedMovie.value = self.pageTopRated == self.totalPageTopRated
                self.pageTopRated += 1
                var newData: [BaseResponse.Result] = []
                newData.append(contentsOf: self.listTopRatedMovie.value)
                newData.append(contentsOf: data.results ?? [])
                self.listTopRatedMovie.value = newData
            }
            self.state.value = .normal
        }
    }
    
    func getUpComing() {
        self.state.value = .loading
        self.useCase.getUpComing(with: self.pageUpComing) { data in
            self.totalPageUpComing = data.total_results ?? 0
            if self.pageUpComing == 1 {
                self.isLastPageUpComing.value = self.pageUpComing == self.totalPageUpComing
                self.pageUpComing += 1
                self.listUpComingMovie.value = data.results ?? []
            } else {
                self.isLastPageUpComing.value = self.pageUpComing == self.totalPageUpComing
                self.pageUpComing += 1
                var newData: [BaseResponse.Result] = []
                newData.append(contentsOf: self.listUpComingMovie.value)
                newData.append(contentsOf: data.results ?? [])
                self.listUpComingMovie.value = newData
            }
            self.state.value = .normal
        }
    }
}
