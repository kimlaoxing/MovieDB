import Foundation
import Favorite

protocol DetailBaseUseCaseProtocol {
  func getDetailMovie(with id: Int, completion: @escaping (Result<DetailBaseModel, Error>) -> Void)
  func addFavorite(_ favoriteModel: FavoriteModel)
  func deleteFavorite(_ id: Int)
  func getFavorite(_ id: Int, completion: @escaping(Bool) -> Void)
}

class DetailBaseInteractor: DetailBaseUseCaseProtocol {
    
    private let repository: DetailBaseRepositoryProtocol
    private var favoriteRepository: FavoriteListRepository
    
    required init(
        repository: DetailBaseRepositoryProtocol
    ) {
        self.repository = repository
        self.favoriteRepository = FavoriteListRepositoryData()
    }
    
    func getDetailMovie(with id: Int, completion: @escaping (Result<DetailBaseModel, Error>) -> Void) {
        self.repository.getDetailMovie(with: id) { data in
            switch data {
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                completion(.success(data))
            }
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
