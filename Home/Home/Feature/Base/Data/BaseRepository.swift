import Foundation
import Favorite

protocol BaseRepository {
    func getListMovie(with page: Int, category: MovieCategory, completion: @escaping (BaseResponse) -> Void)
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
    
    func getListMovie(with page: Int, category: MovieCategory, completion: @escaping (BaseResponse) -> Void) {
        self.remoteData.getListMovie(with: page, category: category) { data in
            completion(data)
        }
    }
}
