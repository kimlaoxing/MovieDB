import Foundation
import Components
import Router
import RxRelay

protocol FavoriteListViewModelInput {
    func getListFavorite()
    func deleteGame(with id: Int)
    func toDetailGame(with id: Int)
}

protocol FavoriteListViewModelOutput {
    var gameListFavorite: Observable<[FavoriteModel]?> { get }
    var state: BehaviorRelay<BaseViewState> { get }
}

protocol FavoriteListViewModel: FavoriteListViewModelOutput, FavoriteListViewModelInput {}

final class DefaultFavoriteListViewModel: FavoriteListViewModel {
    
    let gameListFavorite: Observable<[FavoriteModel]?> = Observable([])
    let state: BehaviorRelay<BaseViewState> = BehaviorRelay.init(value: .loading)
    private let router: Routes
    private let useCase: FavoriteListUseCaseProtocol
    typealias Routes = HomeTabRoute
    
    init(
        useCase: FavoriteListUseCaseProtocol,
        router: Routes
    ) {
        self.useCase = useCase
        self.router = router
    }
    
    func getListFavorite() {
        self.useCase.getListFavorite { data in
            if data.isEmpty {
                self.state.accept(.empty)
            } else {
                self.gameListFavorite.value = data
                self.state.accept(.normal)
            }
        }
    }
    
    func deleteGame(with id: Int) {
        DispatchQueue.main.async {
            self.useCase.deleteGame(with: id)
        }
    }
    
    func toDetailGame(with id: Int) {
        self.router.toDetailMovie(id: id)
    }
}
