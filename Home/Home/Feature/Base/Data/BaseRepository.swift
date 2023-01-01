import Foundation
import Favorite

protocol BaseRepositoryProtocol {
    func getListMovie(with page: Int, category: MovieCategory, completion: @escaping (Result<[BaseResult], Error>) -> Void)
}

final class BaseRepository: NSObject {
    typealias BaseInstance = (BaseRemoteDataSource) -> BaseRepository
    
    fileprivate let remote: BaseRemoteDataSource
    
    private init(remote: BaseRemoteDataSource) {
        self.remote = remote
    }
    
    static let sharedInstance: BaseInstance = { remoteRepo in
        return BaseRepository(remote: remoteRepo)
    }
}

extension BaseRepository: BaseRepositoryProtocol {
    func getListMovie(with page: Int, category: MovieCategory, completion: @escaping (Result<[BaseResult], Error>) -> Void) {
        self.remote.getListMovie(with: page, category: category) { data in
            switch data {
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                completion(.success(BaseResponseMapper.baseResponseMapper(result: data.results ?? [], response: data)))
            }
        }
    }
}

