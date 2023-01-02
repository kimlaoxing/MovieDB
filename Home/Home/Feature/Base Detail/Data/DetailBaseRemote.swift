import Foundation
import Alamofire
import Components

protocol DetailBaseRemoteDataSourceProtocol: AnyObject {
    func getDetailMovie(with id: Int, completion: @escaping (Result<DetailBaseResponse, Error>) -> Void)
}

final class DetailBaseRemoteDataSource: NSObject {
    private override init () {}
    
    static let sharedInstance: DetailBaseRemoteDataSource = DetailBaseRemoteDataSource()
}

extension DetailBaseRemoteDataSource: DetailBaseRemoteDataSourceProtocol {
    func getDetailMovie(with id: Int, completion: @escaping (Result<DetailBaseResponse, Error>) -> Void) {
        let endpoint = "\(APIService.detailBasePath)/\(id)?api_key=\(APIService.apiKey)"
        AF.request(endpoint,
                   method: .get,
                   encoding: JSONEncoding.default
        )
            .validate(statusCode: 200..<300)
            .responseDecodable(of: DetailBaseResponse.self) { data in
                switch data.result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
