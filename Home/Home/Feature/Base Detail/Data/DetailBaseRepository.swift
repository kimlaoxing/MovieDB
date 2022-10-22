import Foundation

protocol DetailBaseRepository {
    func getDetailMovie(with id: Int, completion: @escaping (DetailBaseModel) -> Void)
}

final class DetailBaseRepositoryData: DetailBaseRepository {
    
    private var remoteData: DetailBaseRemoteData
    
    init(remoteData: DetailBaseRemoteData = DetailBaseRemoteData()) {
        self.remoteData = remoteData
    }
    
    func getDetailMovie(with id: Int, completion: @escaping (DetailBaseModel) -> Void) {
        self.remoteData.getDetailMovie(with: id) { data in
            completion(data)
        }
    }
}
