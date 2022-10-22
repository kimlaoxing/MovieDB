import Foundation

protocol BaseDomain {
    mutating func getNowPlaying(with page: Int, completion: @escaping (BaseResponse) -> Void)
    mutating func getPopular(with page: Int, completion: @escaping (BaseResponse) -> Void)
    mutating func getTopRated(with page: Int, completion: @escaping (BaseResponse) -> Void)
    mutating func getUpComing(with page: Int, completion: @escaping (BaseResponse) -> Void)
}

final class BaseUseCase: BaseDomain {
    
    private var repository: BaseRepository
    
    init() {
        self.repository = BaseRepositoryData()
    }
    
    func getNowPlaying(with page: Int, completion: @escaping (BaseResponse) -> Void) {
        self.repository.getListMovie(with: page, category: .nowPlaying) { data in
            completion(data)
        }
    }
    
    func getPopular(with page: Int, completion: @escaping (BaseResponse) -> Void) {
        self.repository.getListMovie(with: page, category: .popular) { data in
            completion(data)
        }
    }
    
    func getTopRated(with page: Int, completion: @escaping (BaseResponse) -> Void) {
        self.repository.getListMovie(with: page, category: .topRated) { data in
            completion(data)
        }
    }
    
    func getUpComing(with page: Int, completion: @escaping (BaseResponse) -> Void) {
        self.repository.getListMovie(with: page, category: .upComing) { data in
            completion(data)
        }
    }
}
