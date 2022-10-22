import Foundation
import Favorite

protocol DetailBaseDomain {
    mutating func getDetailMovie(with id: Int, completion: @escaping (DetailBaseModel) -> Void)
    mutating func addFavorite(_ favoriteModel: FavoriteModel)
    mutating func deleteFavorite(_ id: Int)
    mutating func getFavorite(_ id: Int, completion: @escaping(Bool) -> Void)
}

final class DetailBaseUseCase: DetailBaseDomain {
    
    private var repository: DetailBaseRepository
    private var favoriteRepository: FavoriteListRepository
    
    init() {
        self.favoriteRepository = FavoriteListRepositoryData()
        self.repository = DetailBaseRepositoryData()
    }
    
    func getDetailMovie(with id: Int, completion: @escaping (DetailBaseModel) -> Void) {
        self.repository.getDetailMovie(with: id) { data in
            completion(data)
        }
    }
    
    func addFavorite(_ favoriteModel: FavoriteModel) {
        self.favoriteRepository.addFavorite(favoriteModel)
    }
    
    func deleteFavorite(_ id: Int) {
        self.favoriteRepository.deleteFavorite(id)
    }
    
    func getFavorite(_ id: Int, completion: @escaping(Bool) -> Void) {
        self.favoriteRepository.getFavorite(id) { bool in
            completion(bool)
        }
    }
}
