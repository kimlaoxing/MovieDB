import Foundation
import Components
import Favorite
import Router
import RxRelay

protocol DetailBaseViewModelOutput {
    func addFavorite(_ favoriteModel: FavoriteModel)
    func getDetailMovie(with id: Int)
    func deleteFavorite(_ id: Int)
    func getFavorite(_ id: Int)
    func popUpError()
}

protocol DetailBaseViewModelInput {
    var baseDetailModel: BehaviorRelay<DetailBaseResult?> { get }
    var state: BehaviorRelay<BaseViewState> { get }
    var buttonState: BehaviorRelay<DetailBaseButtonMode> { get }
    var error: BehaviorRelay<String> { get }
}

protocol DetailBaseViewModel: DetailBaseViewModelInput, DetailBaseViewModelOutput { }

final class DefaultDetailBaseViewModel: DetailBaseViewModel {
    
    let baseDetailModel: BehaviorRelay<DetailBaseResult?> = BehaviorRelay.init(value: nil)
    let state: BehaviorRelay<BaseViewState> = BehaviorRelay.init(value: .loading)
    let buttonState: BehaviorRelay<DetailBaseButtonMode>  = BehaviorRelay.init(value: .notSaved)
    let error: BehaviorRelay<String>  = BehaviorRelay.init(value: "")
    private let useCase: DetailBaseUseCaseProtocol
    
    private let router: Routes
    
    typealias Routes = HomeTabRoute
    
    init(
        id: Int,
        useCase: DetailBaseUseCaseProtocol,
        router: Routes
    ) {
        self.useCase = useCase
        self.router = router
        getDetailMovie(with: id)
        getFavorite(id)
    }
    
    func popUpError() {
        self.router.popUpError(with: self.error.value)
    }
    
    func getDetailMovie(with id: Int) {
        self.state.accept(.loading)
        self.buttonState.accept(.notSaved)
        self.useCase.getDetailMovie(with: id) { data in
            self.state.accept(.normal)
            switch data {
            case .success(let data):
                self.baseDetailModel.accept(data)
            case .failure(let error):
                self.error.accept("\(error)")
                self.popUpError()
            }
        }
    }
    
    func addFavorite(_ favoriteModel: FavoriteModel) {
        self.state.accept(.loading)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.useCase.addFavorite(favoriteModel)
            self.buttonState.accept(.isSaved)
            self.state.accept(.normal)
        }
    }
    
    func deleteFavorite(_ id: Int) {
        self.state.accept(.loading)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.useCase.deleteFavorite(id)
            self.buttonState.accept(.notSaved)
            self.state.accept(.normal)
        }
    }
    
    func getFavorite(_ id: Int) {
        self.useCase.getFavorite(id) { bool in
            if bool {
                self.buttonState.accept(.isSaved)
            } else {
                self.buttonState.accept(.notSaved)
            }
        }
    }
}
