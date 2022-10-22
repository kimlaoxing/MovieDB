import Foundation
import Components
import Favorite

protocol DetailBaseViewModelOutput {
    func addFavorite(_ favoriteModel: FavoriteModel)
    func getDetailMovie(with id: Int)
    func deleteFavorite(_ id: Int)
    func getFavorite(_ id: Int)
}

protocol DetailBaseViewModelInput {
    var baseDetailModel: Observable<DetailBaseModel?> { get }
    var state: Observable<BaseViewState> { get }
    var buttonState: Observable<DetailBaseButtonMode> { get }
}

protocol DetailBaseViewModel: DetailBaseViewModelInput, DetailBaseViewModelOutput { }

final class DefaultDetailBaseViewModel: DetailBaseViewModel {
    
    let baseDetailModel: Observable<DetailBaseModel?> = Observable(nil)
    let state: Observable<BaseViewState> = Observable(.loading)
    let buttonState: Observable<DetailBaseButtonMode>  = Observable(.notSaved)
    private let useCase = DetailBaseUseCase()
    
    init(id: Int) {
        getDetailMovie(with: id)
        getFavorite(id)
    }
    
    func getDetailMovie(with id: Int) {
        self.state.value = .loading
        self.buttonState.value = .notSaved
        self.useCase.getDetailMovie(with: id) { data in
            self.state.value = .normal
            self.baseDetailModel.value = data
        }
    }
    
    func addFavorite(_ favoriteModel: FavoriteModel) {
        self.state.value = .loading
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.useCase.addFavorite(favoriteModel)
            self.buttonState.value = .isSaved
            self.state.value = .normal
        }
    }
    
    func deleteFavorite(_ id: Int) {
        self.state.value = .loading
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.useCase.deleteFavorite(id)
            self.buttonState.value = .notSaved
            self.state.value = .normal
        }
    }
    
    func getFavorite(_ id: Int) {
        self.useCase.getFavorite(id) { bool in
            if bool {
                self.buttonState.value = .isSaved
            } else {
                self.buttonState.value = .notSaved
            }
        }
    }
}
