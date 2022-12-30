import Foundation

protocol BaseUseCaseProtocol {
   func getNowPlaying(with page: Int, completion: @escaping (Result<BaseResponse, Error>) -> Void)
   func getPopular(with page: Int, completion: @escaping (Result<BaseResponse, Error>) -> Void)
   func getTopRated(with page: Int, completion: @escaping (Result<BaseResponse, Error>) -> Void)
   func getUpComing(with page: Int, completion: @escaping (Result<BaseResponse, Error>) -> Void)
}

class BaseInteractor: BaseUseCaseProtocol {
    private let repository: BaseRepositoryProtocol
    
    required init(repository: BaseRepositoryProtocol) {
        self.repository = repository
    }
    
    func getNowPlaying(with page: Int, completion: @escaping (Result<BaseResponse, Error>) -> Void) {
        self.repository.getListMovie(with: page, category: .nowPlaying) { data in
            switch data {
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                completion(.success(data))
            }
        }
    }
    
    func getPopular(with page: Int, completion: @escaping (Result<BaseResponse, Error>) -> Void) {
        self.repository.getListMovie(with: page, category: .popular) { data in
            switch data {
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                completion(.success(data))
            }
        }
    }
    
    func getTopRated(with page: Int, completion: @escaping (Result<BaseResponse, Error>) -> Void) {
        self.repository.getListMovie(with: page, category: .topRated) { data in
            switch data {
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                completion(.success(data))
            }
        }
    }
    
    func getUpComing(with page: Int, completion: @escaping (Result<BaseResponse, Error>) -> Void) {
        self.repository.getListMovie(with: page, category: .upComing) { data in
            switch data {
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                completion(.success(data))
            }
        }
    }
}
