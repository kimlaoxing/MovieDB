import Foundation

protocol FavoriteListUseCaseProtocol {
    func getListFavorite(_ completion: @escaping ([FavoriteResult]) -> Void)
    func deleteGame(with id: Int)
}

class FavoriteListInteractor: FavoriteListUseCaseProtocol {
    
    private let repository: FavoriteListRepositoryProtocol
    
    required init(
        repository: FavoriteListRepositoryProtocol
    ) {
        self.repository = repository
    }
    
    func getListFavorite(_ completion: @escaping ([FavoriteResult]) -> Void) {
        self.repository.getAllFavoriteGame { data in
            completion(data)
        }
    }
    
    func deleteGame(with id: Int) {
        self.repository.deleteFavorite(id)
    }
}
