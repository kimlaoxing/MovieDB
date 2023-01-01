import Foundation
import Components
import Router
import RxRelay

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
    func popUpError()
}

protocol BaseViewModelInput {
    var listNowPlaying: BehaviorRelay<[BaseResult]> { get }
    var listPopularMovie: BehaviorRelay<[BaseResult]> { get }
    var listTopRatedMovie: BehaviorRelay<[BaseResult]> { get }
    var listUpComingMovie: BehaviorRelay<[BaseResult]> { get }
    var isLastPageNowPlaying: BehaviorRelay<Bool?> { get }
    var isLastPopularMovie: BehaviorRelay<Bool?> { get }
    var isLastPageTopRatedMovie: BehaviorRelay<Bool?> { get }
    var isLastPageUpComing: BehaviorRelay<Bool?> { get }
    var state: BehaviorRelay<BaseViewState> { get }
    var error: BehaviorRelay<String> { get }
}

protocol BaseViewModel: BaseViewModelOutput, BaseViewModelInput { }

final class DefaultBaseViewModel: BaseViewModel {
    
    let listNowPlaying: BehaviorRelay<[BaseResult]> = BehaviorRelay.init(value: [])
    let listPopularMovie: BehaviorRelay<[BaseResult]> = BehaviorRelay.init(value: [])
    let listTopRatedMovie: BehaviorRelay<[BaseResult]> = BehaviorRelay.init(value: [])
    let listUpComingMovie: BehaviorRelay<[BaseResult]> = BehaviorRelay.init(value: [])
    let error: BehaviorRelay<String> = BehaviorRelay.init(value: "")
    
    let isLastPageNowPlaying: BehaviorRelay<Bool?> = BehaviorRelay.init(value: false)
    let isLastPopularMovie: BehaviorRelay<Bool?> = BehaviorRelay.init(value: false)
    let isLastPageTopRatedMovie: BehaviorRelay<Bool?> = BehaviorRelay.init(value: false)
    let isLastPageUpComing: BehaviorRelay<Bool?> = BehaviorRelay.init(value: false)
    let state: BehaviorRelay<BaseViewState> = BehaviorRelay.init(value: .loading)
    
    private let useCase: BaseUseCaseProtocol
    
    private let router: Routes
    
    typealias Routes = HomeTabRoute
    
    init(router: Routes,
         useCase: BaseUseCaseProtocol
    ) {
        self.useCase = useCase
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
    
    func popUpError() {
        self.router.popUpError(with: self.error.value)
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
//        self.state.value = .loading
        self.state.accept(.loading)
        self.useCase.getNowPlaying(with: self.pageNowPlaying) { data in
            switch data {
            case .failure(let error):
//                self.error.value = "\(error)"
                self.error.accept("\(error)")
                self.popUpError()
            case .success(let data):
                self.totalPageNowPlaying = data[0].total_pages
                if self.pageNowPlaying == 1 {
//                    self.isLastPageNowPlaying.value = self.pageNowPlaying == self.totalPageNowPlaying
                    self.isLastPageNowPlaying.accept(self.pageNowPlaying == self.totalPageNowPlaying)
                    self.pageNowPlaying += 1
//                    self.listNowPlaying.value = data.results ?? []
                    self.listNowPlaying.accept(data)
                } else {
//                    self.isLastPageNowPlaying.value = self.pageNowPlaying == self.totalPageNowPlaying
                    self.isLastPageNowPlaying.accept(self.pageNowPlaying == self.totalPageNowPlaying)
                    self.pageNowPlaying += 1
                    var newData: [BaseResult] = []
                    newData.append(contentsOf: self.listNowPlaying.value)
                    newData.append(contentsOf: data)
                    self.listNowPlaying.accept(newData)
                }
//                self.state.value = .normal
                self.state.accept(.normal)
            }
        }
    }
    
    func getPopular() {
//        self.state.value = .loading
        self.state.accept(.loading)
        self.useCase.getPopular(with: self.pagePopularMovie) { data in
            switch data {
            case .success(let data):
                self.totalPagePopularMovie = data[0].total_pages
                if self.pagePopularMovie == 1 {
//                    self.isLastPopularMovie.value = self.pagePopularMovie == self.totalPagePopularMovie
                    self.isLastPopularMovie.accept(self.pagePopularMovie == self.totalPagePopularMovie)
                    self.pagePopularMovie += 1
//                    self.listPopularMovie.value = data.results ?? []
                    self.listPopularMovie.accept(data)
                } else {
//                    self.isLastPopularMovie.value = self.pagePopularMovie == self.totalPagePopularMovie
                    self.isLastPopularMovie.accept(self.pagePopularMovie == self.totalPagePopularMovie)
                    self.pagePopularMovie += 1
                    var newData: [BaseResult] = []
                    newData.append(contentsOf: self.listPopularMovie.value)
                    newData.append(contentsOf: data)
//                    self.listPopularMovie.value = newData
                    self.listPopularMovie.accept(newData)
                }
//                self.state.value = .normal
                self.state.accept(.normal)
            case .failure(let error):
//                self.error.value = "\(error)"
                self.error.accept("\(error)")
                self.popUpError()
            }
        }
    }
    
    func getTopRatedMovie() {
//        self.state.value = .loading
        self.state.accept(.loading)
        self.useCase.getTopRated(with: self.pageTopRated) { data in
            switch data {
            case .failure(let error):
//                self.error.value = "\(error)"
                self.error.accept("\(error)")
                self.popUpError()
            case .success(let data):
                self.totalPageTopRated = data[0].total_pages
                if self.pageTopRated == 1 {
//                    self.isLastPageTopRatedMovie.value = self.pageTopRated == self.totalPageTopRated
                    self.isLastPageTopRatedMovie.accept(self.pageTopRated == self.totalPageTopRated)
                    self.pageTopRated += 1
//                    self.listTopRatedMovie.value = data.results ?? []
                    self.listTopRatedMovie.accept(data)
                } else {
//                    self.isLastPageTopRatedMovie.value = self.pageTopRated == self.totalPageTopRated
                    self.isLastPageTopRatedMovie.accept(self.pageTopRated == self.totalPageTopRated)
                    self.pageTopRated += 1
                    var newData: [BaseResult] = []
                    newData.append(contentsOf: self.listTopRatedMovie.value)
                    newData.append(contentsOf: data)
//                    self.listTopRatedMovie.value = newData
                    self.listTopRatedMovie.accept(newData)
                }
//                self.state.value = .normal
                self.state.accept(.normal)
            }
        }
    }
    
    func getUpComing() {
//        self.state.value = .loading
        self.state.accept(.loading)
        self.useCase.getUpComing(with: self.pageUpComing) { data in
            switch data {
            case .success(let data):
                self.totalPageUpComing = data[0].total_pages
                if self.pageUpComing == 1 {
//                    self.isLastPageUpComing.value = self.pageUpComing == self.totalPageUpComing
                    self.isLastPageUpComing.accept(self.pageUpComing == self.totalPageUpComing)
                    self.pageUpComing += 1
//                    self.listUpComingMovie.value = data.results ?? []
                    self.listUpComingMovie.accept(data)
                } else {
//                    self.isLastPageUpComing.value = self.pageUpComing == self.totalPageUpComing
                    self.isLastPageUpComing.accept(self.pageUpComing == self.totalPageUpComing)
                    self.pageUpComing += 1
                    var newData: [BaseResult] = []
                    newData.append(contentsOf: self.listUpComingMovie.value)
                    newData.append(contentsOf: data)
//                    self.listUpComingMovie.value = newData
                    self.listUpComingMovie.accept(newData)
                }
//                self.state.value = .normal
                self.state.accept(.normal)
            case .failure(let error):
//                self.error.value = "\(error)"
                self.error.accept("\(error)")
                self.popUpError()
            }
        }
    }
}
