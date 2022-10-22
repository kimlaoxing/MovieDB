import Foundation

protocol FavoriteListDomain {
    mutating func getListFavorite(_ completion: @escaping ([FavoriteModel]) -> Void)
    mutating func deleteGame(with id: Int)
}

final class FavoriteListUseCase: FavoriteListDomain {
    
    private var repository: FavoriteListRepository
    
    init() {
        self.repository = FavoriteListRepositoryData()
    }
    
    func getListFavorite(_ completion: @escaping ([FavoriteModel]) -> Void) {
        self.repository.getAllFavoriteGame { data in
            completion(data)
        }
    }
    
    func deleteGame(with id: Int) {
        self.repository.deleteFavorite(id)
    }
}
