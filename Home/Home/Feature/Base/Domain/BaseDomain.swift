import Foundation

protocol BaseDomain {
    mutating func getNowPlaying(with page: Int, completion: @escaping (Result<BaseResponse, Error>) -> Void)
    mutating func getPopular(with page: Int, completion: @escaping (Result<BaseResponse, Error>) -> Void)
    mutating func getTopRated(with page: Int, completion: @escaping (Result<BaseResponse, Error>) -> Void)
    mutating func getUpComing(with page: Int, completion: @escaping (Result<BaseResponse, Error>) -> Void)
}

final class BaseUseCase: BaseDomain {
    
    private var repository: BaseRepository
    
    init() {
        self.repository = BaseRepositoryData()
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
