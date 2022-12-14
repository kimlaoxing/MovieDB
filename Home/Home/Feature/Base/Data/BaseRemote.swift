import Foundation
import Components
import Alamofire

protocol BaseRemote {
    mutating func getListMovie(with page: Int, category: MovieCategory, completion: @escaping (Result<BaseResponse, Error>) -> Void)
}

struct BaseRemoteData: BaseRemote {
    mutating func getListMovie(with page: Int, category: MovieCategory, completion: @escaping (Result<BaseResponse, Error>) -> Void) {
        let endpoint = "\(APIService.basePath)\(category.rawValue)?api_key=\(APIService.apiKey)"
        let parameters: Parameters = [ "page": "\(page)" ]
        AF.request(endpoint,
                   method: .get,
                   parameters: parameters,
                   encoding: URLEncoding.queryString
        )
            .validate(statusCode: 200..<300)
            .responseDecodable(of: BaseResponse.self) { data in
                switch data.result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
