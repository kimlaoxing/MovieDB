import Foundation

protocol DetailBaseRepositoryProtocol {
    func getDetailMovie(with id: Int, completion: @escaping (Result<DetailBaseModel, Error>) -> Void)
}

final class DetailBaseRepository: NSObject {
    typealias DetailInstance = (DetailBaseRemoteDataSource) -> DetailBaseRepository
    
    fileprivate let remote: DetailBaseRemoteDataSource
    
    private init(remote: DetailBaseRemoteDataSource) {
        self.remote = remote
    }
    
    static let sharedInstance: DetailInstance = { remoteRepo in
        return DetailBaseRepository(remote: remoteRepo)
    }
}

extension DetailBaseRepository: DetailBaseRepositoryProtocol {
    func getDetailMovie(with id: Int, completion: @escaping (Result<DetailBaseModel, Error>) -> Void) {
        self.remote.getDetailMovie(with: id) { data in
            switch data {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
