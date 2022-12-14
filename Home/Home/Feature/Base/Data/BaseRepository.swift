import Foundation
import Favorite

protocol BaseRepository {
    func getListMovie(with page: Int, category: MovieCategory, completion: @escaping (Result<BaseResponse, Error>) -> Void)
}

final class BaseRepositoryData: BaseRepository {
    
    private var remoteData: BaseRemoteData
    private var localDataSource: FavoriteLocalData
    
    init(
        remoteData: BaseRemoteData = BaseRemoteData(),
        localData: FavoriteLocalData = FavoriteLocalData()
    ) {
        self.remoteData = remoteData
        self.localDataSource = localData
    }
    
    func getListMovie(with page: Int, category: MovieCategory, completion: @escaping (Result<BaseResponse, Error>) -> Void) {
        self.remoteData.getListMovie(with: page, category: category) { data in
            switch data {
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                completion(.success(data))
            }
        }
    }
}
