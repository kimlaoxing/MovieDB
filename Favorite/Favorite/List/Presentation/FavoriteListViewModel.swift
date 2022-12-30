import Foundation
import Components
import Router

protocol FavoriteListViewModelInput {
    func getListFavorite()
    func deleteGame(with id: Int)
    func toDetailGame(with id: Int)
}

protocol FavoriteListViewModelOutput {
    var gameListFavorite: Observable<[FavoriteModel]?> { get }
    var state: Observable<BaseViewState> { get }
}

protocol FavoriteListViewModel: FavoriteListViewModelOutput, FavoriteListViewModelInput {}

final class DefaultFavoriteListViewModel: FavoriteListViewModel {
    
    let gameListFavorite: Observable<[FavoriteModel]?> = Observable(nil)
    let state: Observable<BaseViewState> = Observable(.loading)
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
                self.state.value = .empty
            } else {
                self.gameListFavorite.value = data
                self.state.value = .normal
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
